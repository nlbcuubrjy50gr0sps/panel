<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\{
    User,
    Shop,
    Bought,
    DetectBanLog
};
use App\Services\{
    Auth,
    Mail,
    Config
};
use App\Utils\{
    GA,
    Hash,
    Tools,
    Cookie
};
use Exception;
use Ramsey\Uuid\Uuid;
use Slim\Http\{
    Request,
    Response
};

class UserController extends AdminController
{
    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function index($request, $response, $args)
    {
        $table_config['total_column'] = array(
            'op'                    => '操作',
            'querys'                => '查询',
            'id'                    => 'ID',
            'user_name'             => '用户名',
            'remark'                => '备注',
            'email'                 => '邮箱',
            'money'                 => '金钱',
            'is_agent'              => '代理商',
            'im_type'               => '联络方式类型',
            'im_value'              => '联络方式详情',
            'node_group'            => '群组',
            'expire_in'             => '账户过期时间',
            'class'                 => '等级',
            'class_expire'          => '等级过期时间',
            'passwd'                => '连接密码',
            'port'                  => '连接端口',
            'method'                => '加密方式',
            'protocol'              => '连接协议',
            'obfs'                  => '混淆方式',
            'obfs_param'            => '混淆参数',
            'online_ip_count'       => '在线IP数',
            'last_ss_time'          => '上次使用时间',
            'used_traffic'          => '已用流量/GB',
            'enable_traffic'        => '总流量/GB',
            'last_checkin_time'     => '上次签到时间',
            'today_traffic'         => '今日流量',
            'enable'                => '是否启用',
            'reg_date'              => '注册时间',
            'reg_ip'                => '注册IP',
            'auto_reset_day'        => '免费用户流量重置日',
            'auto_reset_bandwidth'  => '重置的免费流量/GB',
            'ref_by'                => '邀请人ID',
            'ref_by_user_name'      => '邀请人用户名',
            'top_up'                => '累计充值',
            'c_rebate'              => '循环返利',
            'rebate'                => '返利百分比',
        );
        $table_config['default_show_column'] = array('op', 'id', 'user_name', 'remark', 'email');
        $table_config['ajax_url'] = 'user/ajax';
        return $response->write(
            $this->view()
                ->assign('shops',        Shop::orderBy('name')->get())
                ->assign('table_config', $table_config)
                ->display('admin/user/index.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function createNewUser($request, $response, $args)
    {
        # 需要一个 userEmail
        $email = $request->getParam('userEmail');
        $email = trim($email);
        $email = strtolower($email);

        $money   = (int) trim($request->getParam('userMoney'));
        $shop_id = (int) $request->getParam('userShop');

        // not really user input
        // if (!Check::isEmailLegal($email)) {
        //     return $response->withJson([
        //         'ret' => 0,
        //         'msg' => '邮箱无效'
        //     ]);
        // }
        // check email
        $user = User::where('email', $email)->first();
        if ($user != null) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '邮箱已经被注册了'
            ]);
        }
        // do reg user
        $user                       = new User();
        $current_timestamp          = time();
        $pass                       = Tools::genRandomChar();
        $user->user_name            = $email;
        $user->email                = $email;
        $user->pass                 = Hash::passwordHash($pass);
        $user->passwd               = Tools::genRandomChar(16);
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
        $user->money                = ($money != -1 ? $money : 0);
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
        if ($user->save()) {
            $res['ret']         = 1;
            $res['msg']         = '新用户注册成功 用户名: ' . $email . ' 随机初始密码: ' . $pass;
            $res['email_error'] = 'success';
            if ($shop_id > 0) {
                $shop = Shop::find($shop_id);
                if ($shop != null) {
                    $bought           = new Bought();
                    $bought->userid   = $user->id;
                    $bought->shopid   = $shop->id;
                    $bought->datetime = time();
                    $bought->renew    = 0;
                    $bought->coupon   = '';
                    $bought->price    = $shop->price;
                    $bought->save();
                    $shop->buy($user);
                } else {
                    $res['msg'] .= '<br/>但是套餐添加失败了，原因是套餐不存在';
                }
            }
            $user->addMoneyLog($user->money);
            $subject            = $_ENV['appName'] . '-新用户注册通知';
            $to                 = $user->email;
            $text               = '您好，管理员已经为您生成账户，用户名: ' . $email . '，登录密码为：' . $pass . '，感谢您的支持。 ';
            try {
                Mail::send($to, $subject, 'newuser.tpl', [
                    'user' => $user, 'text' => $text,
                ], []);
            } catch (Exception $e) {
                $res['email_error'] = $e->getMessage();
            }
            return $response->withJson($res);
        }
        return $response->withJson([
            'ret' => 0,
            'msg' => '未知错误'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function edit($request, $response, $args)
    {
        $user = User::find($args['id']);
        return $response->write(
            $this->view()
                ->assign('edit_user', $user)
                ->display('admin/user/edit.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);

        $email1 = $user->email;

        $user->email = $request->getParam('email');

        $email2 = $request->getParam('email');

        $passwd = $request->getParam('passwd');

        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
            $user->clean_link();
        }

        $user->auto_reset_day = $request->getParam('auto_reset_day');
        $user->auto_reset_bandwidth = $request->getParam('auto_reset_bandwidth');
        $origin_port = $user->port;
        $user->port = $request->getParam('port');

        $user->addMoneyLog($request->getParam('money') - $user->money);

        $user->passwd           = $request->getParam('passwd');
        $user->protocol         = $request->getParam('protocol');
        $user->protocol_param   = $request->getParam('protocol_param');
        $user->obfs             = $request->getParam('obfs');
        $user->obfs_param       = $request->getParam('obfs_param');
        $user->is_agent         = $request->getParam('is_agent');
        $user->is_multi_user    = $request->getParam('is_multi_user');
        $user->transfer_enable  = Tools::toGB($request->getParam('transfer_enable'));
        $user->invite_num       = $request->getParam('invite_num');
        $user->method           = $request->getParam('method');
        $user->node_speedlimit  = $request->getParam('node_speedlimit');
        $user->node_connector   = $request->getParam('node_connector');
        $user->enable           = $request->getParam('enable');
        $user->is_admin         = $request->getParam('is_admin');
        $user->ga_enable        = $request->getParam('ga_enable');
        $user->node_group       = $request->getParam('group');
        $user->ref_by           = $request->getParam('ref_by');
        $user->remark           = $request->getParam('remark');
        $user->money            = $request->getParam('money');
        $user->class            = $request->getParam('class');
        $user->class_expire     = $request->getParam('class_expire');
        $user->expire_in        = $request->getParam('expire_in');
        $user->c_rebate         = $request->getParam('c_rebate');
        $user->rebate           = $request->getParam('rebate');
        $user->back_money       = $request->getParam('back_money');

        $user->forbidden_ip     = str_replace(PHP_EOL, ',', $request->getParam('forbidden_ip'));
        $user->forbidden_port   = str_replace(PHP_EOL, ',', $request->getParam('forbidden_port'));

        // 手动封禁
        $ban_time = (int) $request->getParam('ban_time');
        if ($ban_time > 0) {
            $user->enable                       = 0;
            $end_time                           = date('Y-m-d H:i:s');
            $user->last_detect_ban_time         = $end_time;
            $DetectBanLog                       = new DetectBanLog();
            $DetectBanLog->user_name            = $user->user_name;
            $DetectBanLog->user_id              = $user->id;
            $DetectBanLog->email                = $user->email;
            $DetectBanLog->detect_number        = '0';
            $DetectBanLog->ban_time             = $ban_time;
            $DetectBanLog->start_time           = strtotime('1989-06-04 00:05:00');
            $DetectBanLog->end_time             = strtotime($end_time);
            $DetectBanLog->all_detect_number    = $user->all_detect_number;
            $DetectBanLog->save();
        }
        
        $user->money != $request->getParam('money') ? $user->addMoneyLog($user->money) : null;
        
        if (!$user->save()) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '修改失败'
            ]);
        }
        return $response->withJson([
            'ret' => 1,
            'msg' => '修改成功'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function delete($request, $response, $args)
    {
        $user = User::find((int) $request->getParam('id'));
        if (!$user->kill_user()) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '删除失败'
            ]);
        }
        return $response->withJson([
            'ret' => 1,
            'msg' => '删除成功'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function changetouser($request, $response, $args)
    {
        $userid    = $request->getParam('userid');
        $adminid   = $request->getParam('adminid');
        $user      = User::find($userid);
        $admin     = User::find($adminid);
        $expire_in = time() + 60 * 60;

        if (!$admin->is_admin || !$user || !Auth::getUser()->isLogin) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '非法请求'
            ]);
        }

        Cookie::set([
            'uid'           => $user->id,
            'email'         => $user->email,
            'key'           => Hash::cookieHash($user->pass, $expire_in),
            'ip'            => md5($_SERVER['REMOTE_ADDR'] . $_ENV['key'] . $user->id . $expire_in),
            'expire_in'     => $expire_in,
            'old_uid'       => Cookie::get('uid'),
            'old_email'     => Cookie::get('email'),
            'old_key'       => Cookie::get('key'),
            'old_ip'        => Cookie::get('ip'),
            'old_expire_in' => Cookie::get('expire_in'),
            'old_local'     => $request->getParam('local'),
        ], $expire_in);

        return $response->withJson([
            'ret' => 1,
            'msg' => '切换成功'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function ajax($request, $response, $args)
    {
        $query = User::getTableDataFromAdmin(
            $request,
            static function (&$order_field) {
                if ($order_field == 'used_traffic') {
                    $order_field = 'u + d';
                } elseif ($order_field == 'enable_traffic') {
                    $order_field = 'transfer_enable';
                } elseif ($order_field == 'today_traffic') {
                    $order_field = 'u + d - last_day_t';
                } elseif ($order_field == 'querys') {
                    $order_field = 'id';
                }
            }
        );

        $data  = [];
        foreach ($query['datas'] as $value) {
            /** @var User $value */

            $tempdata['op']                     = '' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/edit">编辑</a>' .
                '<a class="btn btn-brand-accent" id="delete" href="javascript:void(0);" onClick="delete_modal_show(\'' . $value->id . '\')">删除</a>' .
                '<a class="btn btn-brand" id="changetouser" href="javascript:void(0);" onClick="changetouser_modal_show(\'' . $value->id . '\')">切换为该用户</a>';

            $tempdata['querys']                 = '' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/bought">套餐</a>' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/code">充值</a>' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/sublog">订阅</a>' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/detect">审计</a>' .
                '<a class="btn btn-brand" href="/admin/user/' . $value->id . '/login">登录</a>';

            $tempdata['id']                     = $value->id;
            $tempdata['user_name']              = $value->user_name;
            $tempdata['remark']                 = $value->remark;
            $tempdata['email']                  = $value->email;
            $tempdata['money']                  = $value->money;
            $tempdata['im_type']                = $value->im_type();
            $tempdata['im_value']               = $value->im_value();
            $tempdata['is_agent']               = $value->is_agent;  // cool
            $tempdata['node_group']             = $value->node_group;
            $tempdata['expire_in']              = $value->expire_in;
            $tempdata['class']                  = $value->class;
            $tempdata['class_expire']           = $value->class_expire;
            $tempdata['passwd']                 = $value->passwd;
            $tempdata['port']                   = $value->port;
            $tempdata['method']                 = $value->method;
            $tempdata['protocol']               = $value->protocol;
            $tempdata['obfs']                   = $value->obfs;
            $tempdata['obfs_param']             = $value->obfs_param;
            $tempdata['online_ip_count']        = $value->online_ip_count();
            $tempdata['last_ss_time']           = $value->lastSsTime();
            $tempdata['used_traffic']           = Tools::flowToGB($value->u + $value->d);
            $tempdata['enable_traffic']         = Tools::flowToGB($value->transfer_enable);
            $tempdata['last_checkin_time']      = $value->lastCheckInTime();
            $tempdata['today_traffic']          = $value->TodayusedTraffic();
            $tempdata['enable']                 = $value->enable == 1 ? '可用' : '禁用';
            $tempdata['reg_date']               = $value->reg_date;
            $tempdata['reg_ip']                 = $value->reg_ip;
            $tempdata['auto_reset_day']         = $value->auto_reset_day;
            $tempdata['auto_reset_bandwidth']   = $value->auto_reset_bandwidth;
            $tempdata['ref_by']                 = $value->ref_by;
            $tempdata['ref_by_user_name']       = $value->ref_by_user_name();
            $tempdata['top_up']                 = $value->get_top_up();
            
            
            $tempdata['c_rebate']               = ($value->c_rebate ? '循环': '首次');
            $tempdata['rebate']   = ($value->rebate <= 0 ? $value->rebate < 0 ? $_ENV['code_payback'].'%' : '不返利' : $value->rebate.'%');

            $data[] = $tempdata;
        }

        return $response->withJson([
            'draw'            => $request->getParam('draw'),
            'recordsTotal'    => User::count(),
            'recordsFiltered' => $query['count'],
            'data'            => $data,
        ]);
    }
    
    // Cool
    public function addclass($request, $response, $args)
    {
     	$user = User::find($id);
        $vip = $request->getParam('vip');
        $change_class = $request->getParam('change_class');

        $class_h = $request->getParam('class_h');
        $users = User::where('class', $vip)->where('enable', 1)->get();
          
          if ($class_h <= 0) {
             $res['ret'] = 0;
             $res['msg'] = "时长数值有误,请检查";
             return $response->getBody()->write(json_encode($res));  
            }
      
        foreach($users as $user){
		  if ($change_class == 1) {
            if ($user->class != 0) {
            	$user->class_expire=date("Y-m-d H:i:s", strtotime($user->class_expire)+$class_h*3600);
            } else {
            	$user->class_expire=date("Y-m-d H:i:s", time()+$class_h*3600);
            }
            $user->save();
          }else{
            if (time()>strtotime($user->expire_in)) {
            	$user->expire_in=date("Y-m-d H:i:s", time()+$class_h*3600);
            } else {
            	$user->expire_in=date("Y-m-d H:i:s", strtotime($user->expire_in)+$class_h*3600);
            }//如果当前时间>账户到期时间(已过期)，那么现在时间加上套餐的时间；否则在账户原有基础时间上相加   
            $user->save();
          }
          
        }
        $res['ret'] = 1;
        $res['msg'] = " VIP等级：" .$vip. "，时长批量增加完毕, 请查阅.";
        return $response->getBody()->write(json_encode($res)); 
      
    }
    
    public function addtraffic($request, $response, $args)
    {
     	$user = User::find($id);
        $vip = $request->getParam('vip');
        $user_traffic = $request->getParam('user_traffic');
        $users = User::where('class', $vip)->where('enable', 1)->get();
          
          if ($user_traffic <= 0) {
             $res['ret'] = 0;
             $res['msg'] = "流量数值有误,请检查";
             return $response->getBody()->write(json_encode($res));  
            }
      
        foreach($users as $user){
            $user->transfer_enable += $user_traffic * 1073741824;
            $user->save();
        }
        $res['ret'] = 1;
        $res['msg'] = " VIP等级：" .$vip. "，流量批量增加完毕, 请查阅.";
        return $response->getBody()->write(json_encode($res)); 
      
    }
    
    public function addmoney($request, $response, $args)
    {
     	$user = User::find($id);
        $vip = $request->getParam('vip');
        $user_money = $request->getParam('user_money');
        $users = User::where('class', $vip)->where('enable', 1)->get();
          
          if ($user_money <= 0) {
             $res['ret'] = 0;
             $res['msg'] = "金额数值有误,请检查";
             return $response->getBody()->write(json_encode($res));  
            }
      
        foreach($users as $user){
            $user->money += $user_money;
            $user->save();
        }
        $res['ret'] = 1;
        $res['msg'] = " VIP等级：" .$vip. "，余额批量增加完毕, 请查阅.";
        return $response->getBody()->write(json_encode($res)); 
      
    }
    
}
