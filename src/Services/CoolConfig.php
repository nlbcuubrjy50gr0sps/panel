<?php
namespace App\Services;

use App\Models\{User, Code, Faq, Shop, Bought, Ticket, Payback, Paytake, Link, Help, Helpc};
use App\Utils\{GA, Hash, Check, Tools, URL, DatatablesHelper};
use App\Controllers\{LinkController};
use App\Services\{
    Auth,
    Mail,
    Config,
    Payment,
    BitPayment,
    Gateway\ChenPay
};
use Telegram\Bot\Api;
use App\Utils\Telegram\TelegramTools;
use Ozdemir\Datatables\Datatables;
use Exception;
use Ramsey\Uuid\Uuid;

class CoolConfig extends \App\Controllers\BaseController
{
    public static function get($key)
    {
        global $Cool_Config;
        return $Cool_Config[$key];
    }

    public static function getPublicConfig()
    {
        global $Cool_Config;
        return $Cool_Config;
    }
    
    
    /**
     *  获取用户节点筛选规则
     */
    public static function getNodeFilter($token=null, $user=null)
    {
        if ($token) {
            $link = Link::where('type', 11)->where('token', $token)->first();
        }else if ($user) {
            $link = Link::where('type', 11)->where('userid', $user->id)->first();
        }

        return $link->filter != null ? json_decode($link->filter, true) : false;
    }
    

    
    /**
     *  工单通知
     */
    public static function SendTicket($userid, $title, $content, $type, $level, $mode='add')
    {
        $new_ticket = Ticket::where('userid', $userid)->where('title', $title)->orderBy('id','desc')->first();
        $user_name  = User::where('id', $userid)->value('user_name');
        if ($mode=='update') {
            $text = '用户回复工单';
            $messageText = $text . PHP_EOL . '------------------------------' . PHP_EOL . '用户：' . $user_name . PHP_EOL . '标题：' . $title . PHP_EOL . '内容：' . $content;
            
        }else if ($mode=='add') {
            $text = 'Hi，管理员, 有新工单需要您处理';
            $messageText = $text . PHP_EOL . '------------------------------' . PHP_EOL . '用户：' . $user_name . PHP_EOL . '标题：' . $title . PHP_EOL . '内容：' . $content. PHP_EOL . '部门：' . $type. PHP_EOL . '优先级：' . $level;
            
        } else if ($mode=='restart') {
            $text = '用户重启了工单';
        }
        
        $ticketId = $new_ticket->rootid===0 ? $new_ticket->id : $new_ticket->rootid;
        $Keyboard = [
            [
                [
                    'text' => '回复工单 #' . $ticketId,
                    'url'  => $_ENV['baseUrl'] . '/admin/ticket/' . $ticketId . '/view'
                ]
            ]
        ];

        $sendAdmins = CoolConfig::get('Telegram_Admin');
        foreach ($sendAdmins as $sendAdmin) {
            $admin_telegram_id = User::where('id', $sendAdmin)->where('is_admin', '1')->value('telegram_id');
            if ($admin_telegram_id != null) {
                self::Send($messageText, $admin_telegram_id, $Keyboard);
            }
        }
    }
    
    /**
     *  用户充值 给管理员TG提醒
     */
    public static function SendPayment($user, $pl, $codeq)
    {
        if ($pl->shopid == null) {
            $type = '钱包充值';
        } else {
            $shop = Shop::where('id', $pl->shopid)->where('status', 1)->first();
            if ($shop->id != 0) {
                $shopname = Shop::where('id', $shop->id)->value('name');
                $type = '购买套餐【' . $shopname . '】';
            }else {
                $type = '钱包充值';
            }
        }
        
        $messageText = '交易提醒' . PHP_EOL . 
                        '------------------------------' . PHP_EOL . 
                        '用户名：' . $user->user_name . '  #' . $user->id . PHP_EOL . 
                        '交易类型：' . $type . PHP_EOL . 
                        '充值金额：' . $pl->total . PHP_EOL . 
                        '钱包余额：' . $user->money . PHP_EOL . 
                        '发起时间：' . date('Y-m-d H:i:s', $pl->datetime) . PHP_EOL . 
                        '到账时间：' . $codeq->usedatetime;

        $sendAdmins = CoolConfig::get('Telegram_Admin');
        foreach ($sendAdmins as $sendAdmin) {
            $admin_telegram_id = User::where('id', $sendAdmin)->where('is_admin', '1')->value('telegram_id');
            if ($admin_telegram_id != null) {
                self::Send($messageText, $admin_telegram_id);
            }
        }
    }
    
    public static function Send($messageText, $chat_id = 0, $keyboard = null)
    {
        if ($chat_id === 0) {
            $chat_id = $_ENV['telegram_chatid'];
        }
        // 发送给非群组时使用异步
        $async = ($chat_id != $_ENV['telegram_chatid']);
        $bot = new Api($_ENV['telegram_token'], $async);

        if ($keyboard !== null) {
            $reply_markup = json_encode(
                [
                    'inline_keyboard' => $keyboard
                ]
            );
        } else {
            $reply_markup = null;
        }

        $sendMessage = [
            'chat_id'                   => $chat_id,
            'text'                      => $messageText,
            'parse_mode'                => '',
            'disable_web_page_preview'  => false,
            'reply_to_message_id'       => null,
            'reply_markup'              => $reply_markup
        ];
        try {
            $bot->sendMessage($sendMessage);
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }
    
/**
   *  常见问题
*/
    public function FAQ($request, $response, $args)
    {

        $link = $_ENV['subUrl'] . $this->user->getSublink();
        
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $faq = Faq::where('id', '>',0)->orderBy('add_time', 'asc')->paginate(7, ['*'], 'page', $pageNum);
        $faq->setPath('/user/faq');
        $render = Tools::paginate_render($faq);
        
        return $this->view()
            ->assign('faq', $faq)
            ->assign('render', $render)
            ->assign('link', $link)
            ->assign('ssr_sub_token', $this->user->getSublink())
            ->assign('subUrl', $_ENV['subUrl'])
            ->assign('time', date("Y-m-d H:i:s",time()))    
            ->display('user/help/faq.tpl');
    }
    
/**
   *  帮助文档
*/
    public function Help($request, $response, $args)
    {
        $classList_L1 = Helpc::where('pageshow',1)->orderBy('sort', 'desc')->get(); 

        $link = $_ENV['subUrl'] . $this->user->getSublink();

        return $this->view()
            ->assign('classs', $classs)
            ->assign('classList_L1', $classList_L1)
            
            ->assign('link', $link)
            ->assign('ssr_sub_token', $this->user->getSublink())
            ->assign('subUrl', $_ENV['subUrl'])
            ->assign('time', date("Y-m-d H:i:s",time()))    
            ->display('user/help/help.tpl');
    }
    
    public function Help_Doc($request, $response, $args)
    {
        $opts = $request->getQueryParams();
        $id = $args['id'];
        
        $pageDoc = Help::where('class', $id)->orderBy('ontop', 'desc')->orderBy('sort', 'desc')->get();
        if ($args['doc'] != ''){
            $doc_id = Help::where('class', $id)->where('id', $args['doc'])->orderBy('ontop', 'desc')->orderBy('sort', 'desc')->get();
        }
        
        $doc_c = Helpc::where('id', $id)->value('name');
        
        $link = $_ENV['subUrl'] . $this->user->getSublink();
        return $this->view()
            ->assign('pageDoc', $pageDoc)
            ->assign('doc_id', $doc_id)
            ->assign('doc_c', $doc_c)
            ->assign('doc_t', $doc_t)
            
            ->assign('link', $link)
            ->assign('ssr_sub_token', $this->user->getSublink())
            ->assign('subUrl', $_ENV['subUrl'])
            ->display('user/help/home.tpl');
    }
    
    /**
     * 处理用户其他购买套餐 usedd 
     */
    public static function bought_usedd($user, $key, $to)
    {
        $used = Bought::where('userid', $user->id)->where('usedd', $key)->get();
        foreach ($used as $use_del) {
            $use_del->usedd = $to;
            $use_del->save();
        }
        return 0;
    }
    
/**
 * 返利
 * $form_user  邀请人
 * $to_user    被邀请人
 */
    public static function add_payback($form_user, $to_user, $price)
    {
        $check_gift = Payback::where('userid', '=', $to_user->id)->where('ref_by', '=', $form_user->id)->first();

        # 返利比例不为 0
        if ($form_user->rebate !== 0) {
            # 如果用户循环返利 || 用户不是循环循环 和 config 所有用户循环 || 用户不是循环 和 是第一次返利
            if ( ($form_user->c_rebate === 1) || ($form_user->c_rebate === 0 && CoolConfig::get('all_rebate') === true) || ($form_user->c_rebate === 0 && $check_gift == null) ) { 
                # 如果用户比例 大于 0
                if ($form_user->rebate > 0) {
                    $ref_money = bcmul($price, ($form_user->rebate/100), 2);
                # 如果用户比例小于 0
                } else if ($form_user->rebate < 0) {
                    $ref_money = bcmul($price, ($_ENV['code_payback']/100), 2);
                }
                $form_user->back_money += $ref_money;
                $form_user->save();

                $Payback = new Payback();
                $Payback->total = $price;
                $Payback->userid = $to_user->id;
                $Payback->ref_by = $form_user->id;
                $Payback->ref_get = $ref_money;
                $Payback->datetime = time();
                $Payback->save();
            }
        }
    } 
    
/**
 * 代理商
 */
    public function agent($request, $response, $args)
    {
        $Shops = Shop::where("status", 1)->orderBy("id", "asc")->get();
        
    	$table_config['total_column'] = array("id" => "ID","email"=>"邮箱", "money"=>"余额", "class" => "等级", "class_expire"=>"等级到期", "transfer_enable" => "总流量","transfer"=>"剩余流量", "op"=>"操作");
        $table_config['default_show_column'] = array("id", "email", "money", "class", "class_expire", "transfer_enable", "op");
												
        $table_config['ajax_url'] = 'agent/ajax';
        
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $boughts = Bought::where('agent_id', $this->user->id)->orderBy('id', 'asc')->paginate(8, ['*'], 'page', $pageNum);
        $boughts->setPath('/user/agent');
        $render = Tools::paginate_render($boughts);
        
        return $this->view()
          ->assign('shop_name', $Shops)
          ->assign('table_config', $table_config)
          ->assign('time', date("Y-m-d H:i:s",time()))
          ->assign('boughts', $boughts)
          ->assign('render', $render)
          ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)     // cool
          ->display('user/agent/agent.tpl');
    } 
    
    public function agent_user($request, $response, $args)
    {
        $user = $this->user;

        $id = $args['id'];
        
        $agent_user = User::where('id', $id)->where("agent_id", $user->id)->first();
        
        $Shops = Shop::where("status", 1)->orderBy("id", "asc")->get();
        
        return $this->view()
            ->assign('id', $id)
            ->assign('agent_user', $agent_user)
            ->assign('shop_name', $Shops)
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->assign('subInfo', \App\Controllers\LinkController::getSubinfo($agent_user, 0))
            ->display('user/agent/edit_user.tpl');
    }
    
    public function agent_user_save($request, $response, $args)
    {
        $user = $this->user;
        
        if ($user == null || !$user->isLogin) {
            $res['ret'] = -1;
            return $response->getBody()->write(json_encode($res));
        }
    
        $id       = $args['id'];
        $agent_user = User::where('id', $id)->where("agent_id", $user->id)->first();

        $mode      = $request->getParam('mode');
        $name      = $request->getParam('name');
        $email     = trim($request->getParam('email'));
        $email     = strtolower($email);
        $password  = $request->getParam('passwd');
        $enable    = (int) $request->getParam('enable');
        $shopid    = (int) $request->getParam('shopid');

        switch ($mode) {
            case 'edit_user': 
                // 昵称验证
                if ($name == ''){
                    $res['ret'] = 0;
                    $res['msg'] = '昵称不允许留空';
                    return $response->getBody()->write(json_encode($res));
                }
                
                if (strlen($name) > 24) {
                    $res['ret'] = 0;
                    $res['msg'] = '昵称太长了';
                    return $response->getBody()->write(json_encode($res));
                }

                // 检测邮箱
                if ($agent_user->email != $email) {
                    if ($email == '') {
                        return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '未填写邮箱']));
                    }

                    if (!Check::isEmailLegal($email)) {
                        return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '邮箱无效']));
                    }
                    
                    $checkemail = User::where('email', '=', $email)->first();
                    if ($checkemail != null) {
                        return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '此邮箱已存在']));
                    }
                }
                
                // 检测密码
                if ($password != '') {
                    if (strlen($password) < 8) {
                        $res['ret'] = 0;
                        $res['msg'] = '密码需8位以上';
                        return $response->getBody()->write(json_encode($res));
                    }
                    $agent_user->pass = Hash::passwordHash($password);
                    $agent_user->save();
                    $agent_user->clean_link();
                }

                $agent_user->user_name    = $name;
                $agent_user->email        = $email;
                $agent_user->enable       = $enable;
                $agent_user->node_speedlimit = $request->getParam('node_speedlimit');
                $agent_user->node_connector  = $request->getParam('node_connector');
                
                if (!$agent_user->save()){
                    $res['ret'] = 0;
                    $res['msg'] = '保存失败';
                    return $response->getBody()->write(json_encode($res));
                }
                
                $res['ret'] = 1;
                $res['msg'] = '保存成功';
                return $response->getBody()->write(json_encode($res));
                
            case 'buy_shop': 
                // 开通套餐
                if ($shopid > 0) {
                    
                    $shop = Shop::where("id", $shopid)->where("status", 1)->first();
                    
                    if ($shop != null) {
                        if ($user->money < $shop->price) {
                            $res['ret'] = 0;
                            $res['msg'] = '套餐开通失败，原因是您的钱包余额不足!';
                            return $response->getBody()->write(json_encode($res));
                        }
    
                        $user->money = bcsub($user->money, $shop->price, 2);
                        $user->save();
                        
                        $bought           = new Bought();
                        $bought->userid   = $agent_user->id;
                        $bought->shopid   = $shop->id;
                        $bought->datetime = time();
                        $bought->renew    = 0;
                        $bought->coupon   = '';
                        $bought->price    = $shop->price;
                        $bought->agent_id = $user->id;
                        $bought->save();
                        $shop->buy($agent_user);

                        CoolConfig::add_payback($user, $agent_user, $shop->price);
                        $res['ret'] = 1;
                        $res['msg'] = '套餐开通成功';
                        return $response->getBody()->write(json_encode($res));
                    } else {
                        $res['ret'] = 0;
                        $res['msg'] = '套餐开通失败，原因是套餐不存在!';
                        return $response->getBody()->write(json_encode($res));
                    }
                } else {
                    $res['ret'] = 1;
                    $res['msg'] = '不开通套餐无需保存';
                    return $response->getBody()->write(json_encode($res));
                }
                break;
            case 'reset_link': 
                $agent_user->clean_link();
                $res['ret'] = 1;
                $res['msg'] = '重置成功';
                return $response->getBody()->write(json_encode($res));
        }

        $res['ret'] = 0;
        $res['msg'] = '未知错误';
        return $response->getBody()->write(json_encode($res));
    }
    
    public function agentlist($request, $response, $args) 
    {
    	$id = $this->user->id;
    	
        
        $datatables = new Datatables(new DatatablesHelper());
        $datatables->query('Select id as op, id, email, u, d, money, class, class_expire, transfer_enable from user where agent_id='.$id);
      
        $datatables->edit('DT_RowId', function ($data) {
            return 'row_1_'.$data['id'];
        });
        
		$datatables->edit('op', function ($data) {
		    return '    <button class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">操作                 </button>
                        	<div class="dropdown-menu dropdown-node dropdown-menu-right" >
                                <a href="/user/agent/view/' . $data['id'] . '" class="btn"><span><i class="fa fa-edit"></i></span><span> 编辑用户</span></a><br/>
                                <a onClick="del(\''.$data["id"].'\', \''.$data["email"].'\')"' . ' class="btn"><span><i class="fa fa-trash-o"></i></span><span> 删除用户</span></a>
                        	</div>';
		});
                    
        $datatables->edit('DT_RowId', function ($data) {
            return 'row_1_'.$data['id'];
        });
        
        $datatables->edit('email', function ($data) {
            $email = $data['email'];
            return $email;
        });
        
        $datatables->edit('money', function ($data) {
        	$money = $data['money'];
            return $money;
        });
        
        $datatables->edit('transfer', function ($data) {
            $transfe = ($data['transfer_enable'] - ($data['u'] + $data['d']));
            $transfer = round(Tools::flowToGB($transfe),2);
            if ($transfer <= 0){
               return $transfer . 'GB';
            }else{
               return $transfer . 'GB';
            }
        });
        
        $datatables->edit('transfer_enable', function ($data) {
            $transfer_enable  = Tools::flowAutoShow($data['transfer_enable']);;
            return $transfer_enable;
        });
        
        $datatables->edit('class', function ($data) {
            $class  = $data['class'];
            return $class;
        });
        
        $datatables->edit('class_expire', function ($data) {
            $class_expire = $data['class_expire'];
            return $class_expire;
        });
        
        $body = $response->getBody();
        $body->write($datatables->generate());
    }
    
    public function addDelete($request, $response, $args)
    {
        $id = $request->getParam('deleteid');
        $user = User::where('id', $id)->where('money', '<=', 0)->where('is_agent', '<>', 1)->where('is_admin', '<>', 1)->first();
      
        	if ($user != null) {
        	    $user->kill_user();
        	    $res['ret'] = 1;
        	    $res['msg'] = "删除成功!";
        	  return $response->getBody()->write(json_encode($res));
        	} else {
        	    $res['ret'] = 0;
        	    $res['msg'] = "删除失败,用户不存在";
        	    return $response->getBody()->write(json_encode($res));
        	}
      
    } 
    
    //单个用户创建(代理商)
  	public function addUser($request, $response, $args)
    {
        $userName = $request->getParam('userName');
      	$email = $request->getParam('email');
        $shopId = $request->getParam('shopId');
        $issend = $request->getParam('issend');
        $shop = Shop::where("id", $shopId)->where("status", 1)->first();
        $credit = $this->user->creta;
      	$agentid = $this->user->id;

        if (!Check::isEmailLegal($email)) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱无效！";
            return $response->getBody()->write(json_encode($res));
        }

        $DbUser = User::where('email', '=', $email)->first();
      
        if ($DbUser != null) {
            $result['ret'] = 0;
            $result['msg'] = "此邮箱已经注册";
            return $response->getBody()->write(json_encode($result));
        }

        $price = $shop->price * ((100 - $credit) / 100);
      	$user = $this->user;
         if (bccomp($user->money , $price,2)==-1) {
          $res['ret'] = 0;
          $res['msg'] = '喵喵喵~ 当前余额不足，总价为' . $price . '元。</br><a href="/user/code">点击进入充值界面</a>';
          return $response->getBody()->write(json_encode($res));
        }
        $user->money = bcsub($user->money , $price,2);
        $agentid = $user->id;
      	$user->save(); 
      	
        $user                       = new User();
        $current_timestamp          = time();
        $pass                       = Tools::genRandomChar();
        $user->user_name            = $userName;
        $user->email                = $email;
        $user->pass                 = Hash::passwordHash($email);
        $user->passwd               = Tools::genRandomChar(6);
        $user->uuid                 = Uuid::uuid3(Uuid::NAMESPACE_DNS, $email . '|' . $current_timestamp);
        $user->port                 = Tools::getAvPort();
        $user->t                    = 0;
        $user->u                    = 0;
        $user->d                    = 0;
        $user->method               = Config::getconfig('Register.string.defaultMethod');
        $user->protocol             = Config::getconfig('Register.string.defaultProtocol');
        $user->protocol_param       = Config::getconfig('Register.string.defaultProtocol_param');
        $user->obfs                 = Config::getconfig('Register.string.defaultObfs');
        $user->obfs_param           = Config::getconfig('Register.string.defaultObfs_param');
        $user->forbidden_ip         = $_ENV['reg_forbidden_ip'];
        $user->forbidden_port       = $_ENV['reg_forbidden_port'];
        $user->im_type              = 2;
        $user->im_value             = $email;
        $user->is_agent             = 0;
        $user->transfer_enable      = Tools::toGB((int) Config::getconfig('Register.string.defaultTraffic'));
        $user->invite_num           = (int) Config::getconfig('Register.string.defaultInviteNum');
        $user->auto_reset_day       = $_ENV['free_user_reset_day'];
        $user->auto_reset_bandwidth = $_ENV['free_user_reset_bandwidth'];
        $user->money                = 0;
        $user->ref_by               = $agentid;
        $user->class_expire         = date('Y-m-d H:i:s', time() + (int) Config::getconfig('Register.string.defaultClass_expire') * 3600);
        $user->class                = (int) Config::getconfig('Register.string.defaultClass');
        $user->node_connector       = (int) Config::getconfig('Register.string.defaultConn');
        $user->node_speedlimit      = (int) Config::getconfig('Register.string.defaultSpeedlimit');
        $user->expire_in            = date('Y-m-d H:i:s', time() + (int) Config::getconfig('Register.string.defaultExpire_in') * 86400);
        $user->reg_date             = date('Y-m-d H:i:s');
        $user->reg_ip               = $_SERVER['REMOTE_ADDR'];
        $user->theme                = $_ENV['theme'];

        $groups = explode(',', $_ENV['random_group']);

        $user->node_group = $groups[array_rand($groups)];

        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token = $secret;
        $user->ga_enable = 0;
      	
       	$user->is_agent = 0;
        $user->agent_id = $agentid;
		$user->creta = 0;
		
        //用户注册成功之后才执行添加套餐的操作
        if ($user->save()) {
            $shopId = $request->getParam('shopId');
            $shop = Shop::where("id", $shopId)->where("status", 1)->first();
            $bought           = new Bought();
            $bought->userid   = $user->id;
            $bought->shopid   = $shop->id;
            $bought->datetime = time();
            $bought->renew    = 0;
            $bought->coupon   = '';
            $bought->price    = $shop->price;
            $bought->agent_id = $agentid;
            $bought->save();
            $shop->buy($user);
            $addsum = User::where('id', $user->id)->get();
            if ($issend == '1') {
                $subject = Config::get('appName') . '-注册通知';
                $to = $user->email;
                $text = '您好, 恭喜您成功注册本站!';
                try {
                  	Mail::send($to, $subject, 'news/warn.tpl', [
                      	'user' => $user, 'text' => $text
                  	], [
                  	]);
                } catch (Exception $e) {
                  	echo $e->getMessage();
                }
        	}
        }
      return $response->getBody()->write(json_encode($addsum));
    }

/**
 *  获取商品信息
 *  price           价格
 *
 *  bandwidth       流量GB
 *  expire          账号有效期
 *  class           等级
 *  class_expire    等级有效期天数
 *  reset           每多少天重置
 *  reset_exp       多少天内重置
 *  reset_value     重置流量为多少 G
 *  speedlimit      端口限速
 *  connector       IP限制
 * 
 */
    public function getShopInfo($shopid)
    {
        $shop = Shop::find($shopid);
    
        if ($shop === null) {
            return 0;
        }
    
        $shopinfo = [
            'name'         => $shop->name,
            'price'        => $shop->price,
            'class'        => $shop->content['class'],
            'expire'       => $shop->content['expire'],
            'reset'        => $shop->content['reset'],
            'reset_value'  => $shop->content['reset_value'],
            'bandwidth'    => $shop->content['bandwidth'],
            'class_expire' => $shop->content['class_expire'],
        ]; 
 
        return $shopinfo;
    }

/**
 * 计算套餐返还的信息
 */
    public function getConversionInfo($user, $bought)
    {
        $shopinfo = $this->getShopInfo($bought->shopid);
        $code = Code::where('code', '#'.$bought->id.' - 套餐折算')->value('id');
        if ($code != null) {
            $res = ['ret' => 0, 'msg' => '该套餐已折算过'];
            return $res;
        }
        
        /* 用户等级和套餐的不一样, 可能被管理修改过 */
        if ( $shopinfo['class'] != $user->class) {
            $res = ['ret' => 0, 'msg' => '您的等级和套餐等级不符,请联系管理处理'];
            return $res;
        }

        # 1. 用掉时间
        $shoptime = $shopinfo['class_expire'] * 86400;              // 商品等级时长
        $usedtime = time() - $bought->datetime;                     // 用了多久
        $usertime = strtotime($user->class_expire) - time();        // 用户剩余时长
        if ($usedtime >= $shoptime) {
            $res = ['ret' => 0, 'msg' => '该套餐已过期, 无法折算'];
            return $res;
        }
        if ($usertime < $shoptime - $usedtime) {
            $res = ['ret' => 0, 'msg' => '会员时长异常无法折算'];
            return $res;
        }
        $time_bi = round( $usedtime / $shoptime * 100, 2);          // 用掉的百分比

        # 2. 用掉流量
        $user_transfer = $user->transfer_enable - ($user->u + $user->d);    # 用户当前剩余的流量
        $shop_bandwidth     = $shopinfo['bandwidth']*1024*1024*1024;        # 套餐首月流量

        if ($shopinfo['reset'] != 0 && $shopinfo['reset_value'] != 0 && $shopinfo['reset_exp'] != 0) {
            $is_reset = 1;
            # 套餐有重置属性
            $day_flow           = ($shopinfo['reset_value']*1024*1024*1024) / $shopinfo['reset'];                               # 计算商品单日流量值
            $reset_cycle        = floor($shopinfo['class_expire'] / $shopinfo['reset']);                # 计算商品有多少个重置周期 (去除小数位)
            $used_cycle         = floor($usedtime / ($shopinfo['reset']*86400));                        # 计算使用了多少个周期 (去除小数位)
            $shop_reset_value   = $shopinfo['reset_value']*1024*1024*1024;                                                      # 套餐周期流量
            $shop_transfer      = ($reset_cycle <= 1 ? $shop_bandwidth : ($reset_cycle-1)*$shop_reset_value+$shop_bandwidth);   # 套餐总流量

            if ($used_cycle <= 0){
                # 第一个重置周期
                $usedflow    = ($user_transfer >= $shop_bandwidth ? 0 : ($user_transfer <= 0 ? $shop_bandwidth : $shop_bandwidth - $user_transfer));
                $kouchu_flow = $shop_bandwidth - $usedflow;                 # 扣除流量
            } elseif ($used_cycle > 0) {
                # 过了一个周期
                $cycle_flow  = ($user_transfer >= $shop_reset_value ? 0 : ($user_transfer <= 0 ? $shop_reset_value : $shop_reset_value - $user_transfer));   # 当前周期使用了流量
                $usedflow    = ($used_cycle === 1 ? $usedflow+$shop_bandwidth : ($used_cycle-1)*$shop_reset_value+$shop_bandwidth);                          # 所有周期使用了流量
                $kouchu_flow = $shop_reset_value - $cycle_flow;               # 扣除流量
            }
            $band_bi = round( $usedflow / $shop_transfer * 100, 2);         # 用掉的百分比
        } else {
            $is_reset = 0;
            # 套餐没有重置属性
            $shop_transfer  = $shopinfo['bandwidth']*1024*1024*1024;
            $usedflow       = ($user_transfer >= $shop_transfer ? 0 : ($user_transfer <= 0 ? $shop_transfer : $shop_transfer - $user_transfer));             // 用掉的流量
            $kouchu_flow    = $shop_bandwidth - $usedflow;                  # 扣除流量
            $band_bi        = round( $usedflow / $shop_transfer * 100, 2);  # 用掉的百分比
        }

        # 折算模式
        $mode = CoolConfig::get('shop_conversion_mode');
        if ($mode=='auto') {
            $mode_type = ($time_bi*100 >= $band_bi*100 ? '使用时长' : '使用流量');
            $mode_ppt = bcsub(100, ( $time_bi*100 >= $band_bi*100 ? $time_bi : $band_bi ), 2);    # 剩余百分比
        } else if ($mode=='time') {
            $mode_type = '使用时长';
            $mode_ppt = bcsub(100, $time_bi, 2);
        } else if ($mode=='flow') {
            $mode_type = '使用流量';
            $mode_ppt = bcsub(100, $band_bi, 2);
        }
        $ratio = [
            'name'  => '常规套餐',
            'type'  => $mode_type,   # 计算模式
            'ppt'   => $mode_ppt,    # 剩余百分比
            'reset' => [
                'is_reset'      => $is_reset,
                'reset_cycle'   => ($used_cycle ? : 0),
                'used_cycle'    => ($used_cycle?:0),
            ],
            'time'  => [
                'used'          => $shoptime - $usedtime,
                'used_gs'       => round(($shoptime - $usedtime)/86400, 2),
            ],
            'flow'  => [
                'used'          => $kouchu_flow,
                'used_gb'       => round($kouchu_flow/1024/1024/1024, 2),
            ],
            'used_bi'    => [
                'time'          => $time_bi,
                'band'          => $band_bi
            ],
        ];

        /* 返还金额 */
        $money_a = bcmul($bought->price, $ratio['ppt'] / 100, 2);
        /* 手续费比例 */
        $hdpr = CoolConfig::get('shop_formalities');
        /* 手续费金额 */
        $hdfe = $hdpr > 0 ? bcmul($money_a, bcdiv($hdpr, 100, 10), 2) : 0;

        $res = [
            'ret'       => 1,
            'ratio'     => $ratio,
            'name'      => $shopinfo['name'],           # 商品名称
            'type'      => $mode_type,                  # 折算模式
            'money_a'   => $money_a,                    # 返还金额
            'hdpr'      => $hdpr,                       # 手续费率
            'hdfe'      => $hdfe,                       # 手续费
            'money'     => bcsub($money_a, $hdfe, 2),   # 实际返还
        ];
        return $res;
    }

    
/**
 *  开始返还操作
 */
    public function PackageConversion_OK($user, $bought)
    {
        $info = $this->getConversionInfo($user, $bought);
        if ($info['ret'] !== 1) {
            return $res;
        }
        /* 增加 Code 表 */
        $codeq = new Code();
        $codeq->code = '#' . $bought->id . ' - 套餐折算';
        $codeq->isused = 1;
        $codeq->type = 2;
        $codeq->number = $info['money'];
        $codeq->usedatetime = date('Y-m-d H:i:s');
        $codeq->userid = $user->id;
        if (!$codeq->save()) {
            $res = ['ret' => 0, 'msg' => '创建记录失败'];
            return $res;
        }
        /* 处理 Bought 表 */
        $bought->renew = 0;
        $bought->save();

        /* 处理 User */
        $user->money            = bcadd($user->money, $info['money'], 2);
        $shengyu                = $user->transfer_enable - ($user->u + $user->d);
        $user->transfer_enable  = $user->transfer_enable - $info['ratio']['flow']['used'] - ($user->u + $user->d);
        if ($user->transfer_enable < 2*1024*1024*1024){
            $user->transfer_enable = 2*1024*1024*1024;
        }
        $user->u = 0;
        $user->d = 0;
        $user->last_day_t = 0;
        if ($info['ratio']['name'] == '常规套餐') {
            $user->class_expire = date('Y-m-d H:i:s', (strtotime($user->class_expire) - $info['ratio']['time']['used']));
            if ( (int) strtotime($user->class_expire) <= time()) {
                $user->class = 0;
            }
        }
        if ($user->save()) {
            $res = ['ret' => 1, 'msg' => $info['money'] . '元已返至余额' . PHP_EOL . '并扣除等级时长' . $info['ratio']['time']['used_gs'] . '天、' . $info['ratio']['flow']['used_gb'] . 'GB流量'];
            return $res;
        }
    }
    
}