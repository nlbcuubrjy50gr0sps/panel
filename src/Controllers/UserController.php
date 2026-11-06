<?php

namespace App\Controllers;

use App\Services\{
    Auth,
    Captcha,
    Config,
    CoolConfig,
    Payment
};
use App\Models\{
    Ip,
    Ann,
    Code,
    Node,
    Shop,
    User,
    Link,
    Token,
    Faq,
    Paylist,
    Bought,
    Redeem,
    StreamMedia,
    Coupon,
    Payback,
    BlockIp,
    LoginIp,
    UnblockIp,
    DetectLog,
    DetectRule,
    InviteCode,
    EmailVerify,
    UserSubscribeLog
};
use App\Utils\{
    GA,
    URL,
    Hash,
    Check,
    QQWry,
    Tools,
    Cookie,
    Telegram,
    ClientProfiles,
    DatatablesHelper,
    TelegramSessionManager
};
use Ozdemir\Datatables\Datatables;
use voku\helper\AntiXSS;
use Ramsey\Uuid\Uuid;
use Slim\Http\{
    Request,
    Response
};

/**
 *  HomeController
 */
class UserController extends BaseController
{
    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function index($request, $response, $args)
    {
        $captcha = Captcha::generate();

        if ($_ENV['subscribe_client_url'] != '') {
            $getClient = new Token();
            for ($i = 0; $i < 10; $i++) {
                $token = $this->user->id . Tools::genRandomChar(16);
                $Elink = Token::where('token', '=', $token)->first();
                if ($Elink == null) {
                    $getClient->token = $token;
                    break;
                }
            }
            $getClient->user_id     = $this->user->id;
            $getClient->create_time = time();
            $getClient->expire_time = time() + 10 * 60;
            $getClient->save();
        } else {
            $token = '';
        }
        
        return $response->write(
            $this->view()
                ->assign('ssr_sub_token', $this->user->getSublink())
                ->assign('display_ios_class', $_ENV['display_ios_class'])
                ->assign('display_ios_topup', $_ENV['display_ios_topup'])
                ->assign('ios_account', $_ENV['ios_account'])
                ->assign('ios_password', $_ENV['ios_password'])
                ->assign('ann', Ann::orderBy('date', 'desc')->first())
                ->assign('geetest_html', $captcha['geetest'])
                ->assign('mergeSub', $_ENV['mergeSub'])
                ->assign('subUrl', $_ENV['subUrl'])
                ->registerClass('URL', URL::class)
                ->assign('recaptcha_sitekey', $captcha['recaptcha'])
                ->assign('subInfo', LinkController::getSubinfo($this->user, 0))
                ->assign('getClient', $token)
                
                // cool
                ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
                ->assign('time', date("Y-m-d H:i:s",time()))    
                ->display('user/index.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function code($request, $response, $args)
    {
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        
        $codes   = Code::where('type', '<>', '-2')->where('userid', '=', $this->user->id)->orderBy('id', 'desc')->paginate(5, ['*'], 'page', $pageNum);
        $codes->setPath('/user/code');
        $render = Tools::paginate_render($codes);
        
        $shops = Bought::where('userid', $this->user->id)->orderBy('id', 'desc')->paginate(5, ['*'], 'page', $pageNum);
        $shops->setPath('/user/code');
        $render1 = Tools::paginate_render($shops);
        
        if ($request->getParam('json') == 1) {
            $res['ret'] = 1;
            foreach ($shops as $shop) {
                $shop->datetime = $shop->datetime();
                $shop->name = $shop->shop()->name;
                $shop->content = $shop->shop()->content();
            };
            $res['shops'] = $shops;
            return $response->withJson($res);
        };
        
        return $response->write(
            $this->view()
                ->assign('shops', $shops)
                ->assign('codes', $codes)
                ->assign('render', $render)
                ->assign('render1', $render1)
                ->assign('time', date("Y-m-d H:i:s",time()))
                ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)     // cool
                ->display('user/code.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function donate($request, $response, $args)
    {
        if ($_ENV['enable_donate'] != true) {
            exit(0);
        }

        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $codes = Code::where(
            static function ($query) {
                $query->where('type', '=', -1)
                    ->orWhere('type', '=', -2);
            }
        )->where('isused', 1)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $codes->setPath('/user/donate');
        $render = Tools::paginate_render($codes);
        return $response->write(
            $this->view()
                ->assign('codes', $codes)
                ->assign('total_in', Code::where('isused', 1)->where('type', -1)->sum('number'))
                ->assign('total_out', Code::where('isused', 1)->where('type', -2)->sum('number'))
                ->assign('render', $render)
                ->display('user/donate.tpl')
        );
    }

    public function isHTTPS()
    {
        define('HTTPS', false);
        if (defined('HTTPS') && HTTPS) {
            return true;
        }
        if (!isset($_SERVER)) {
            return false;
        }
        if (!isset($_SERVER['HTTPS'])) {
            return false;
        }
        if ($_SERVER['HTTPS'] === 1) {  //Apache
            return true;
        }

        if ($_SERVER['HTTPS'] === 'on') { //IIS
            return true;
        }

        if ($_SERVER['SERVER_PORT'] == 443) { //其他
            return true;
        }
        return false;
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function code_check($request, $response, $args)
    {
        $time  = $request->getQueryParams()['time'];
        $codes = Code::where('userid', '=', $this->user->id)
            ->where('usedatetime', '>', date('Y-m-d H:i:s', $time))
            ->first();

        if ($codes != null && strpos($codes->code, '充值') !== false) {
            return $response->withJson([
                'ret' => 1
            ]);
        }
        return $response->withJson([
            'ret' => 0
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function codepost($request, $response, $args)
    {
        $code = trim($request->getParam('code'));
        if ($code == '') {
            return $response->withJson([
                'ret' => 0,
                'msg' => '非法输入'
            ]);
        }
        $codeq = Code::where('code', $code)->where('isused', 0)->first();
        if ($codeq == null) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '此充值码错误'
            ]);
        }

        $user               = $this->user;
        $codeq->isused      = 1;
        $codeq->usedatetime = date('Y-m-d H:i:s');
        $codeq->userid      = $user->id;
        $codeq->save();

        if ($codeq->type == -1) {
            $user->money += $codeq->number;
            $user->save();
            if ($user->ref_by != 0) {
                $gift_user = $user->ref_by_user();
                if ($gift_user != null) {
                    CoolConfig::add_payback(User::find($user->ref_by), $user, $codeq->number);
                }
            }

            if ($_ENV['enable_donate']) {
                if ($this->user->is_hide == 1) {
                    Telegram::Send('姐姐姐姐，一位不愿透露姓名的大老爷给我们捐了 ' . $codeq->number . ' 元呢~');
                } else {
                    Telegram::Send('姐姐姐姐，' . $this->user->user_name . ' 大老爷给我们捐了 ' . $codeq->number . ' 元呢~');
                }
            }

            return $response->withJson([
                'ret' => 1,
                'msg' => '充值成功，充值的金额为' . $codeq->number . '元'
            ]);
        }

        if ($codeq->type == 10001) {
            $user->transfer_enable += $codeq->number * 1024 * 1024 * 1024;
            $user->save();
        }

        if ($codeq->type == 10002) {
            if (time() > strtotime($user->expire_in)) {
                $user->expire_in = date('Y-m-d H:i:s', time() + $codeq->number * 86400);
            } else {
                $user->expire_in = date('Y-m-d H:i:s', strtotime($user->expire_in) + $codeq->number * 86400);
            }
            $user->save();
        }

        if ($codeq->type >= 1 && $codeq->type <= 10000) {
            if ($user->class == 0 || $user->class != $codeq->type) {
                $user->class_expire = date('Y-m-d H:i:s', time());
                $user->save();
            }
            $user->class_expire = date('Y-m-d H:i:s', strtotime($user->class_expire) + $codeq->number * 86400);
            $user->class = $codeq->type;
            $user->save();
        }

        return $response->withJson([
            'ret' => 1,
            'msg' => ''
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function GaCheck($request, $response, $args)
    {
        $code = $request->getParam('code');
        if ($code == '') {
            return $response->withJson([
                'ret' => 0,
                'msg' => '二维码不能为空'
            ]);
        }
        $user  = $this->user;
        $ga    = new GA();
        $rcode = $ga->verifyCode($user->ga_token, $code);
        if (!$rcode) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '动态码错误'
            ]);
        }
        
        // 开启用户二步验证
        $user->ga_enable = 1;
        $user->save();
        
        return $response->withJson([
            'ret' => 1,
            'msg' => '成功开启二步验证'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function GaSet($request, $response, $args)
    {
        $enable = $request->getParam('enable');
        if ($enable == '') {
            return $response->withJson([
                'ret' => 0,
                'msg' => '选项无效'
            ]);
        }
        
        $user = $this->user;
        
        // 关闭二步验证需要确认账号密码
        $passwd = $request->getParam('passwd');
        if (!Hash::checkPassword($user->pass, $passwd)) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '密码错误'
            ]);
        }
        
        $user->ga_enable = $enable;
        $user->save();
        return $response->withJson([
            'ret' => 1,
            'msg' => '设置成功'
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function ResetPort($request, $response, $args)
    {
        $temp = $this->user->ResetPort();
        return $response->withJson([
            'ret' => ($temp['ok'] === true ? 1 : 0),
            'msg' => $temp['msg']
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function SpecifyPort($request, $response, $args)
    {
        $temp = $this->user->SpecifyPort((int) $request->getParam('port'));
        return $response->withJson([
            'ret' => ($temp['ok'] === true ? 1 : 0),
            'msg' => $temp['msg']
        ]);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function GaReset($request, $response, $args)
    {
        $ga             = new GA();
        $secret         = $ga->createSecret();
        $user           = $this->user;
        $user->ga_token = $secret;
        $user->save();
        return $response->withStatus(302)->withHeader('Location', '/user/edit');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function profile($request, $response, $args)
    {
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $paybacks = Payback::where('ref_by', $this->user->id)->orderBy('datetime', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $paybacks->setPath('/user/profile');

        $iplocation = new QQWry();
        $userip = array();
        $total = Ip::where('datetime', '>=', time() - 300)->where('userid', '=', $this->user->id)->paginate(15, ['*'], 'page', $pageNum);

        $totallogin = LoginIp::where('userid', '=', $this->user->id)->where('type', '=', 0)->orderBy('datetime', 'desc')->take(10)->get();
        $userloginip = array();

        foreach ($totallogin as $single) {
            //if(isset($useripcount[$single->userid]))
            {
                if (!isset($userloginip[$single->ip])) {
                    //$useripcount[$single->userid]=$useripcount[$single->userid]+1;
                    $location = $iplocation->getlocation($single->ip);
                    $userloginip[$single->ip]['location'] = iconv('gbk', 'utf-8//IGNORE', $location['country'] . $location['area']);
                    $userloginip[$single->ip]['logintime'] = date("Y-m-d H:i:s", $single->datetime);
                }
            }
        }

        foreach ($total as $single) {
            //if(isset($useripcount[$single->userid]))
            {
                $single->ip = Tools::getRealIp($single->ip);
                $is_node = Node::where('node_ip', $single->ip)->first();
                if ($is_node) {
                    continue;
                }
                if (!isset($userip[$single->ip])) {
                    //$useripcount[$single->userid]=$useripcount[$single->userid]+1;
                    $location = $iplocation->getlocation($single->ip);
                    $userip[$single->ip] = iconv('gbk', 'utf-8//IGNORE', $location['country'] . $location['area']);
                }
            }
        }
        
		$bind_token = TelegramSessionManager::add_bind_session($this->user);

        $BIP = BlockIp::where("ip", $_SERVER["REMOTE_ADDR"])->first();
        if ($BIP == null) {
            $Block = $_SERVER["REMOTE_ADDR"] . " 没有被封";
            $isBlock = 0;
        } else {
            $Block = $_SERVER["REMOTE_ADDR"] . " 已被封";
            $isBlock = 1;
        }

        if ($request->getParam('json') == 1) {
            $res['userip']      = $userip;
            $res['userloginip'] = $userloginip;
            $res['paybacks']    = $paybacks;
            $res['ret']         = 1;
            return $response->getBody()->write(json_encode($res));
        };

        return $response->write(
            $this->view()
                ->assign('boughts', $boughts)
                ->assign('Block', $Block)
                ->assign('isBlock', $Block)
                ->assign('telegram_bot', Config::get('telegram_bot'))
                ->assign('bind_token', $bind_token)
                ->assign('userip', $userip)
                ->assign('userloginip', $userloginip)
                
                // cool
                ->assign('time', date("Y-m-d H:i:s",time()))
                ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
                ->assign('paybacks', $paybacks)
                ->display('user/profile.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function announcement($request, $response, $args)
    {
        $Anns = Ann::orderBy('date', 'desc')->get();

        if ($request->getParam('json') == 1) {
            return $response->withJson([
                'Anns' => $Anns,
                'ret'  => 1,
            ]);
        };

        return $response->write(
            $this->view()
                ->assign('anns', $Anns)
                ->display('user/announcement.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function tutorial($request, $response, $args)
    {
        return $response->write(
            $this->view()->display('user/tutorial.tpl')
        );
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function edit($request, $response, $args)
    {
        $themes = Tools::getDir(BASE_PATH . '/resources/views');

        $BIP = BlockIp::where('ip', $_SERVER['REMOTE_ADDR'])->first();
        if ($BIP == null) {
            $Block = 'IP: ' . $_SERVER['REMOTE_ADDR'] . ' 没有被封';
            $isBlock = 0;
        } else {
            $Block = 'IP: ' . $_SERVER['REMOTE_ADDR'] . ' 已被封';
            $isBlock = 1;
        }

        $bind_token = TelegramSessionManager::add_bind_session($this->user);

        $config_service = new Config();

        return $this->view()
            ->assign('user', $this->user)
            ->assign('themes', $themes)
            ->assign('isBlock', $isBlock)
            ->assign('Block', $Block)
            ->assign('bind_token', $bind_token)
            ->assign('telegram_bot', $_ENV['telegram_bot'])
            ->assign('config_service', $config_service)
            ->registerClass('URL', URL::class)
            
            // cool
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
            ->display('user/edit.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function invite($request, $response, $args)
    {
        $code = InviteCode::where('user_id', $this->user->id)->first();
        if ($code == null) {
            $this->user->addInviteCode();
            $code = InviteCode::where('user_id', $this->user->id)->first();
        }

        $paybacks = Payback::where('ref_by', $this->user->id)->orderBy('id', 'desc')->paginate(14, ['*'], 'page', $pageNum);
        if (!$paybacks_sum = Payback::where('ref_by', $this->user->id)->sum('ref_get')) {
            $paybacks_sum = 0;
        }
        $paybacks->setPath('/user/invite');

        $invite_user = User::where('ref_by', $this->user->id)->orderBy('id', 'desc')->paginate(14, ['*'], 'page', $pageNum);
        $invite_user->setPath('/user/invite');

        return $this->view()
            ->assign('code', $code)
            ->assign('paybacks', $paybacks)
            ->assign('paybacks_sum', $paybacks_sum)
            
            // cool
            ->assign('invite_user', $invite_user)
            ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->display('user/invite.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function buyInvite($request, $response, $args)
    {
        $price = $_ENV['invite_price'];
        $num = $request->getParam('num');
        $num = trim($num);

        if (!Tools::isInt($num) || $price < 0 || $num <= 0) {
            $res['ret'] = 0;
            $res['msg'] = '非法请求';
            return $response->withJson($res);
        }

        $amount = $price * $num;

        $user = $this->user;

        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->withJson($res);
        }

        if ($user->money < $amount) {
            $res['ret'] = 0;
            $res['msg'] = '余额不足，总价为' . $amount . '元。';
            return $response->withJson($res);
        }
        $user->invite_num += $num;
        $user->money -= $amount;
        $user->save();
        $res['invite_num'] = $user->invite_num;
        $res['ret'] = 1;
        $res['msg'] = '邀请次数添加成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function customInvite($request, $response, $args)
    {
        $price = $_ENV['custom_invite_price'];
        $customcode = $request->getParam('customcode');
        $customcode = trim($customcode);

        if (!Tools::is_validate($customcode) || $price < 0 || $customcode == '' || strlen($customcode) > 32) {
            $res['ret'] = 0;
            $res['msg'] = '非法请求,邀请链接后缀不能包含特殊符号且长度不能大于32字符';
            return $response->withJson($res);
        }

        if (InviteCode::where('code', $customcode)->count() != 0) {
            $res['ret'] = 0;
            $res['msg'] = '此后缀名被抢注了';
            return $response->withJson($res);
        }

        $user = $this->user;

        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->withJson($res);
        }

        if ($user->money < $price) {
            $res['ret'] = 0;
            $res['msg'] = '余额不足，总价为' . $price . '元。';
            return $response->withJson($res);
        }
        $code = InviteCode::where('user_id', $user->id)->first();
        $code->code = $customcode;
        $user->money -= $price;
        $user->save();
        $code->save();
        $res['ret'] = 1;
        $res['msg'] = '定制成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function sys($request, $response, $args)
    {
        return $this->view()->assign('ana', '')->display('user/sys.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updatePassword($request, $response, $args)
    {
        $oldpwd = $request->getParam('oldpwd');
        $pwd = $request->getParam('pwd');
        $repwd = $request->getParam('repwd');
        $user = $this->user;
        if (!Hash::checkPassword($user->pass, $oldpwd)) {
            $res['ret'] = 0;
            $res['msg'] = '旧密码错误';
            return $response->withJson($res);
        }
        if ($pwd != $repwd) {
            $res['ret'] = 0;
            $res['msg'] = '两次输入不符合';
            return $response->withJson($res);
        }

        if (strlen($pwd) < 8) {
            $res['ret'] = 0;
            $res['msg'] = '密码太短啦';
            return $response->withJson($res);
        }
        $hashPwd = Hash::passwordHash($pwd);
        $user->pass = $hashPwd;
        $user->save();

        if ($_ENV['enable_forced_replacement'] == true) {
            $user->clean_link();
        }

        $res['ret'] = 1;
        $res['msg'] = '修改成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateEmail($request, $response, $args)
    {
        $user = $this->user;
        $newemail = $request->getParam('newemail');
        $oldemail = $user->email;
        $otheruser = User::where('email', $newemail)->first();
        if ($_ENV['enable_telegram'] !== true) {
            $res['ret'] = 0;
            $res['msg'] = '未啓用用戶自行修改郵箱功能';
            return $response->withJson($res);
        }
        if (Config::getconfig('Register.bool.Enable_email_verify')) {
            $emailcode = $request->getParam('emailcode');
            $mailcount = EmailVerify::where('email', '=', $newemail)->where('code', '=', $emailcode)->where('expire_in', '>', time())->first();
            if ($mailcount == null) {
                $res['ret'] = 0;
                $res['msg'] = '您的邮箱验证码不正确';
                return $response->withJson($res);
            }
        }
        if ($newemail == '') {
            $res['ret'] = 0;
            $res['msg'] = '未填写邮箱';
            return $response->withJson($res);
        }
        if (!Check::isEmailLegal($newemail)) {
            $res['ret'] = 0;
            $res['msg'] = '邮箱无效';
            return $response->withJson($res);
        }
        if ($otheruser != null) {
            $res['ret'] = 0;
            $res['msg'] = '邮箱已经被使用了';
            return $response->withJson($res);
        }
        if ($newemail == $oldemail) {
            $res['ret'] = 0;
            $res['msg'] = '新邮箱不能和旧邮箱一样';
            return $response->withJson($res);
        }
        $antiXss = new AntiXSS();
        $user->email = $antiXss->xss_clean($newemail);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = '修改成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateUsername($request, $response, $args)
    {
        $newusername = $request->getParam('newusername');
        $user = $this->user;
        $antiXss = new AntiXSS();
        $user->user_name = $antiXss->xss_clean($newusername);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = '修改成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateHide($request, $response, $args)
    {
        $hide = $request->getParam('hide');
        $user = $this->user;
        $user->is_hide = $hide;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = '修改成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function Unblock($request, $response, $args)
    {
        $user = $this->user;
        $BIP = BlockIp::where('ip', $_SERVER['REMOTE_ADDR'])->get();
        foreach ($BIP as $bi) {
            $bi->delete();
        }

        $UIP = new UnblockIp();
        $UIP->userid = $user->id;
        $UIP->ip = $_SERVER['REMOTE_ADDR'];
        $UIP->datetime = time();
        $UIP->save();

        $res['ret'] = 1;
        $res['msg'] = $_SERVER['REMOTE_ADDR'];
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function shop($request, $response, $args)
    {
        $user = $this->user;
      
     	$shop_price1 = CoolConfig::get("shops_price")['plan_1'];
        $shop_price2 = CoolConfig::get("shops_price")['plan_2'];
        $shop_price3 = CoolConfig::get("shops_price")['plan_3'];
        $shop_price4 = CoolConfig::get("shops_price")['plan_4'];
      
	    $shops_p_c1 = Shop::where(
	        static function ($query) use ($shop_price1) {
                $query->Where('id', '=', $shop_price1['p1_price_1'])
                    ->orwhere('id', '=', $shop_price1['p1_price_2'])
                    ->orwhere('id', '=', $shop_price1['p1_price_3'])
                    ->orwhere('id', '=', $shop_price1['p1_price_4'])
                    ->orwhere('id', '=', $shop_price1['p1_price_5'])
                    ->orwhere('id', '=', $shop_price1['p1_price_6'])
                    ->orwhere('id', '=', $shop_price1['p1_price_7'])
                    ->orwhere('id', '=', $shop_price1['p1_price_8'])
                    ->orwhere('id', '=', $shop_price1['p1_price_9']);
	            }
            )->where('status', '=', 1)->orderBy('price', 'asc')->get();
      
	    $shops_p_c2 = Shop::where(
		    static function ($query) use ($shop_price2) {
                $query->Where('id', '=', $shop_price2['p2_price_1'])
				->orWhere('id', '=', $shop_price2['p2_price_2'])
				->orWhere('id', '=', $shop_price2['p2_price_3'])
				->orWhere('id', '=', $shop_price2['p2_price_4'])
				->orWhere('id', '=', $shop_price2['p2_price_5'])
				->orWhere('id', '=', $shop_price2['p2_price_6'])
                ->orwhere('id', '=', $shop_price1['p2_price_7'])
                ->orwhere('id', '=', $shop_price1['p2_price_8'])
                ->orwhere('id', '=', $shop_price1['p2_price_9']);
	        })->where('status', '=', 1)->orderBy('price', 'asc')->get();
        
        $shops_p_c3 = Shop::where(
	        static function ($query) use ($shop_price3) {
                $query->Where('id', '=', $shop_price3['p3_price_1'])
                    ->orwhere('id', '=', $shop_price3['p3_price_2'])
                    ->orwhere('id', '=', $shop_price3['p3_price_3'])
                    ->orwhere('id', '=', $shop_price3['p3_price_4'])
                	->orwhere('id', '=', $shop_price3['p3_price_5'])
                	->orwhere('id', '=', $shop_price3['p3_price_6'])
                    ->orwhere('id', '=', $shop_price3['p3_price_7'])
                	->orwhere('id', '=', $shop_price3['p3_price_8'])
                	->orwhere('id', '=', $shop_price3['p3_price_9']);
	            }
            )->where('status', '=', 1)->orderBy('price', 'asc')->get();
			   
	    $shops_p_c4 = Shop::where(
	        static function ($query) use ($shop_price4) {
                $query->Where('id', '=', $shop_price4['p4_price_1'])
                    ->orwhere('id', '=', $shop_price4['p4_price_2'])
                    ->orwhere('id', '=', $shop_price4['p4_price_3'])
                    ->orwhere('id', '=', $shop_price4['p4_price_4'])
                    ->orwhere('id', '=', $shop_price4['p4_price_5'])
                    ->orwhere('id', '=', $shop_price4['p4_price_6'])
                    ->orwhere('id', '=', $shop_price3['p4_price_7'])
                	->orwhere('id', '=', $shop_price3['p4_price_8'])
                	->orwhere('id', '=', $shop_price3['p4_price_9']);
	            }
            )->where('status', '=', 1)->orderBy('price', 'asc')->get();
            
        $shops = Shop::where('status', 1)->orderBy('name')->get();
        
        return $this->view()
		  ->assign('shops_p_c1', $shops_p_c1)
		  ->assign('shops_p_c2', $shops_p_c2)
		  ->assign('shops_p_c3', $shops_p_c3)
		  ->assign('shops_p_c4', $shops_p_c4)
		  ->assign('time', date("Y-m-d H:i:s",time()))
          ->assign('shops', $shops)
          ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)     // cool
          ->display('user/shop.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function CouponCheck($request, $response, $args)
    {
        $coupon = $request->getParam('coupon');
        $coupon = trim($coupon);

        $user = $this->user;

        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->withJson($res);
        }

        $shop = $request->getParam('shop');

        $shop = Shop::where('id', $shop)->where('status', 1)->first();

        if ($shop == null) {
            $res['ret'] = 0;
            $res['msg'] = '非法请求';
            return $response->withJson($res);
        }
        
        if ($shop->limitamount() != 0 && $shop->limitamount('can') <= 0) {
            $res['ret'] = 0;
            $res['msg'] = '该商品已达到购买上限';
            return $response->getBody()->write(json_encode($res));
        }
        
        if ($coupon == '') {
            $res['ret'] = 1;
            $res['name'] = $shop->name;
            $res['credit'] = '0 %';
            $res['total'] = $shop->price . '元';
            return $response->withJson($res);
        }

        $coupon = Coupon::where('code', $coupon)->first();

        if ($coupon == null) {
            $res['ret'] = 0;
            $res['msg'] = '优惠码无效';
            return $response->withJson($res);
        }
        if ($coupon->expire < time()) {
            $res['ret'] = 0;
            $res['msg'] = '优惠码已过期';
            return $response->getBody()->write(json_encode($res));
        }
        if ($coupon->order($shop->id) == false) {
            $res['ret'] = 0;
            $res['msg'] = '此优惠码不可用于此商品';
            return $response->withJson($res);
        }

        $use_limit = $coupon->onetime;
        if ($use_limit > 0) {
            $use_count = Bought::where('userid', $user->id)->where('coupon', $coupon->code)->count();
            if ($use_count >= $use_limit) {
                $res['ret'] = 0;
                $res['msg'] = '优惠码次数已用完';
                return $response->withJson($res);
            }
        }

        $res['ret'] = 1;
        $res['name'] = $shop->name;
        $res['credit'] = $coupon->credit . ' %';
        $res['total'] = $shop->price * ((100 - $coupon->credit) / 100) . '元';

        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function buy($request, $response, $args)
    {
        $user   = $this->user;
        $coupon = $request->getParam('coupon');
        $coupon = trim($coupon);
        $code = $coupon;
        $shop = $request->getParam('shop');
        $disableothers = 1;
        $autorenew = $request->getParam('autorenew');

        $shop = Shop::where('id', $shop)->where('status', 1)->first();
    
    /*
        $orders = Bought::where('userid', $this->user->id)->get();
        foreach ($orders as $order) {
            if ($order->shop()->use_loop()) {
                if ($order->valid()) {
                    $res['ret'] = 0;
                    $res['msg'] = '您购买的含有自动重置系统的套餐还未过期，无法购买新套餐';
                    return $response->withJson($res);
                }
            }
        };
    */
        if ($shop == null) {
            $res['ret'] = 0;
            $res['msg'] = '非法请求';
            return $response->withJson($res);
        }

        if ($user->quantitypay == 1){
        	$res['ret'] = 0;
            $res['msg'] = "你已开通按量付费，不支持购买套餐，请先关闭";
            return $response->getBody()->write(json_encode($res));
        }
        
        if ($coupon == '') {
            $credit = 0;
        } else {
            $coupon = Coupon::where('code', $coupon)->first();

            if ($coupon == null) {
                $credit = 0;
            } else {
                if ($coupon->onetime == 1) {
                    $onetime = true;
                }

                $credit = $coupon->credit;
            }

            if ($coupon->order($shop->id) == false) {
                $res['ret'] = 0;
                $res['msg'] = '此优惠码不可用于此商品';
                return $response->withJson($res);
            }

            if ($coupon->expire < time()) {
                $res['ret'] = 0;
                $res['msg'] = '此优惠码已过期';
                return $response->withJson($res);
            }

            $use_limit = $coupon->onetime;
            if ($use_limit > 0) {
                $use_count = Bought::where('userid', $user->id)->where('coupon', $coupon->code)->count();
                if ($use_count >= $use_limit) {
                    $res['ret'] = 0;
                    $res['msg'] = '优惠码次数已用完';
                    return $response->withJson($res);
                }
            }
        }

        $price = $shop->price * ((100 - $credit) / 100);

        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->withJson($res);
        }

        if (bccomp($user->money, $price, 2) == -1) {
            $res['ret'] = 0;
            $res['msg'] = '喵喵喵~ 当前余额不足，总价为' . $price . '元。</br><a href="/user/code">点击进入充值界面</a>';
            return $response->withJson($res);
        }

        $user->money = bcsub($user->money, $price, 2);
        $user->save();

        if ($disableothers == 1) {
            $boughts = Bought::where('userid', $user->id)->get();
            foreach ($boughts as $disable_bought) {
                $disable_bought->renew = 0;
                $disable_bought->save();
            }
        }
        
        CoolConfig::bought_usedd($user, 1, 0);
        $bought = new Bought();
        $bought->userid = $user->id;
        $bought->shopid = $shop->id;
        $bought->datetime = time();
        if ($autorenew == 0 || $shop->auto_renew == 0) {
            $bought->renew = 0;
        } else {
            $bought->renew = time() + $shop->auto_renew * 86400;
        }

        $bought->coupon = $code;


        if (isset($onetime)) {
            $price = $shop->price;
        }
        $bought->price = $price;
        $bought->usedd = 1;
        $bought->save();

        $shop->buy($user);

        $res['ret'] = 1;
        $res['msg'] = '购买成功';

        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function bought($request, $response, $args)
    {
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $shops = Bought::where('userid', $this->user->id)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $shops->setPath('/user/bought');
        if ($request->getParam('json') == 1) {
            $res['ret'] = 1;
            foreach ($shops as $shop) {
                $shop->datetime = $shop->datetime();
                $shop->name = $shop->shop()->name;
                $shop->content = $shop->shop()->content();
            };
            $res['shops'] = $shops;
            return $response->withJson($res);
        };
        $render = Tools::paginate_render($shops);
        return $this->view()
            ->assign('shops', $shops)
            ->assign('render', $render)
            ->display('user/bought.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function deleteBoughtGet($request, $response, $args)
    {
        $id = $request->getParam('id');
        $shop = Bought::where('id', $id)->where('userid', $this->user->id)->first();

        if ($shop == null) {
            $rs['ret'] = 0;
            $rs['msg'] = '关闭自动续费失败，订单不存在。';
            return $response->withJson($rs);
        }

        if ($this->user->id == $shop->userid) {
            $shop->renew = 0;
        }

        if (!$shop->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = '关闭自动续费失败';
            return $response->withJson($rs);
        }
        $rs['ret'] = 1;
        $rs['msg'] = '关闭自动续费成功';
        return $response->withJson($rs);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateWechat($request, $response, $args)
    {
        $type = $request->getParam('imtype');
        $wechat = $request->getParam('wechat');
        $wechat = trim($wechat);

        $user = $this->user;

        if ($user->telegram_id != 0) {
            $res['ret'] = 0;
            $res['msg'] = '您绑定了 Telegram ，所以此项并不能被修改。';
            return $response->withJson($res);
        }

        if ($wechat == '' || $type == '') {
            $res['ret'] = 0;
            $res['msg'] = '非法输入';
            return $response->withJson($res);
        }

        $user1 = User::where('im_value', $wechat)->where('im_type', $type)->first();
        if ($user1 != null) {
            $res['ret'] = 0;
            $res['msg'] = '此联络方式已经被注册';
            return $response->withJson($res);
        }

        $user->im_type = $type;
        $antiXss = new AntiXSS();
        $user->im_value = $antiXss->xss_clean($wechat);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = '修改成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateSSR($request, $response, $args)
    {
        $protocol = $request->getParam('protocol');
        $obfs = $request->getParam('obfs');
        $obfs_param = $request->getParam('obfs_param');
        $obfs_param = trim($obfs_param);

        $user = $this->user;

        if ($obfs == '' || $protocol == '') {
            $res['ret'] = 0;
            $res['msg'] = '非法输入';
            return $response->withJson($res);
        }

        if (!Tools::is_param_validate('obfs', $obfs)) {
            $res['ret'] = 0;
            $res['msg'] = '混淆无效';
            return $response->withJson($res);
        }

        if (!Tools::is_param_validate('protocol', $protocol)) {
            $res['ret'] = 0;
            $res['msg'] = '协议无效';
            return $response->withJson($res);
        }

        $antiXss = new AntiXSS();

        $user->protocol = $antiXss->xss_clean($protocol);
        $user->obfs = $antiXss->xss_clean($obfs);
        $user->obfs_param = $antiXss->xss_clean($obfs_param);

        if (!Tools::checkNoneProtocol($user)) {
            $res['ret'] = 0;
            $res['msg'] = '系统检测到您目前的加密方式为 none ，但您将要设置为的协议并不在以下协议<br>' . implode(',', Config::getSupportParam('allow_none_protocol')) . '<br>之内，请您先修改您的加密方式，再来修改此处设置。';
            return $response->withJson($res);
        }

        if (!URL::SSCanConnect($user) && !URL::SSRCanConnect($user)) {
            $res['ret'] = 0;
            $res['msg'] = '您这样设置之后，就没有客户端能连接上了，所以系统拒绝了您的设置，请您检查您的设置之后再进行操作。';
            return $response->withJson($res);
        }

        $user->save();

        if (!URL::SSCanConnect($user)) {
            $res['ret'] = 1;
            $res['msg'] = '设置成功，但您目前的协议，混淆，加密方式设置会导致 Shadowsocks原版客户端无法连接，请您自行更换到 ShadowsocksR 客户端。';
            return $response->withJson($res);
        }

        if (!URL::SSRCanConnect($user)) {
            $res['ret'] = 1;
            $res['msg'] = '设置成功，但您目前的协议，混淆，加密方式设置会导致 ShadowsocksR 客户端无法连接，请您自行更换到 Shadowsocks 客户端。';
            return $response->withJson($res);
        }

        $res['ret'] = 1;
        $res['msg'] = '设置成功，您可自由选用客户端来连接。';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateTheme($request, $response, $args)
    {
        $theme = $request->getParam('theme');

        $user = $this->user;

        if ($theme == '') {
            $res['ret'] = 0;
            $res['msg'] = '非法输入';
            return $response->withJson($res);
        }

        $user->theme = filter_var($theme, FILTER_SANITIZE_STRING);
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = '设置成功';
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateMail($request, $response, $args)
    {
        $value = (int) $request->getParam('mail');
        if (in_array($value, [0, 1, 2])) {
            $user = $this->user;
            if ($value == 2 && $_ENV['enable_telegram'] === false) {
                $res['ret'] = 0;
                $res['msg'] = '修改失败，当前无法使用 Telegram 接收每日报告';
                return $response->withJson($res);
            }
            $user->sendDailyMail = $value;
            $user->save();
            $res['ret'] = 1;
            $res['msg'] = '修改成功';
        } else {
            $res['ret'] = 0;
            $res['msg'] = '非法输入';
        }
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateSsPwd($request, $response, $args)
    {
        $user = $this->user;
        $pwd = Tools::genRandomChar(16);
        $current_timestamp = time();
        $new_uuid = Uuid::uuid3(Uuid::NAMESPACE_DNS, $user->email . '|' . $current_timestamp);
        $otheruuid = User::where('uuid', $new_uuid)->first();

        if ($pwd == '') {
            $res['ret'] = 0;
            $res['msg'] = '密码不能为空';
            return $response->withJson($res);
        }
        if (!Tools::is_validate($pwd)) {
            $res['ret'] = 0;
            $res['msg'] = '密码无效';
            return $response->withJson($res);
        }
        if ($otheruuid != null) {
            $res['ret'] = 0;
            $res['msg'] = '目前出现一些问题，请稍后再试';
            return $response->withJson($res);
        }

        $user->uuid = $new_uuid;
        $user->save();
        $user->updateSsPwd($pwd);
        $res['ret'] = 1;

        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function updateMethod($request, $response, $args)
    {
        $user          = $this->user;
        $method        = strtolower($request->getParam('method'));
        $result        = $user->updateMethod($method);
        $result['ret'] = $result['ok'] ? 1 : 0;
        return $response->withJson($result);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function logout($request, $response, $args)
    {
        Auth::logout();
        return $response->withStatus(302)->withHeader('Location', '/');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function doCheckIn($request, $response, $args)
    {
        if ($_ENV['enable_checkin_captcha'] == true) {
            $ret = Captcha::verify($request->getParams());
            if (!$ret) {
                return $response->withJson([
                    'ret' => 0,
                    'msg' => '系统无法接受您的验证结果，请刷新页面后重试。'
                ]);
            }
        }

        if (strtotime($this->user->expire_in) < time()) {
            $res['ret'] = 0;
            $res['msg'] = '您的账户已过期，无法签到。';
            return $response->withJson($res);
        }

        $checkin = $this->user->checkin();
        if ($checkin['ok'] === false) {
            $res['ret'] = 0;
            $res['msg'] = $checkin['msg'];
            return $response->withJson($res);
        }
        
        // Cool
        if ($this->user->quantitypay == '1') {
            $res['ret'] = 0;
            $res['msg'] = '您已启用按量付费，签到无效';
            return $response->withJson($res);
        } 

        $res['msg'] = $checkin['msg'];
        $res['unflowtraffic'] = $this->user->transfer_enable;
        $res['traffic'] = Tools::flowAutoShow($this->user->transfer_enable);
        $res['trafficInfo'] = array(
            'todayUsedTraffic' => $this->user->TodayusedTraffic(),
            'lastUsedTraffic' => $this->user->LastusedTraffic(),
            'unUsedTraffic' => $this->user->unusedTraffic(),
        );
        $res['ret'] = 1;
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function kill($request, $response, $args)
    {
        return $this->view()->display('user/kill.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function handleKill($request, $response, $args)
    {
        $user = $this->user;

        $email = $user->email;

        $passwd = $request->getParam('passwd');
        // check passwd
        $res = array();
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = ' 密码错误';
            return $response->withJson($res);
        }

        if ($_ENV['enable_kill'] == true) {
            Auth::logout();
            $user->kill_user();
            $res['ret'] = 1;
            $res['msg'] = '您的帐号已经从我们的系统中删除。欢迎下次光临!';
        } else {
            $res['ret'] = 0;
            $res['msg'] = '管理员不允许删除，如需删除请联系管理员。';
        }
        return $response->withJson($res);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function detect_index($request, $response, $args)
    {
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $logs = DetectRule::paginate(15, ['*'], 'page', $pageNum);

        if ($request->getParam('json') == 1) {
            $res['ret'] = 1;
            $res['logs'] = $logs;
            return $response->withJson($res);
        }

        $logs->setPath('/user/detect');
        $render = Tools::paginate_render($logs);
        return $this->view()
            ->assign('rules', $logs)
            ->assign('render', $render)
            // cool
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
            ->display('user/detect_index.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function detect_log($request, $response, $args)
    {
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $logs = DetectLog::orderBy('id', 'desc')->where('user_id', $this->user->id)->paginate(15, ['*'], 'page', $pageNum);

        if ($request->getParam('json') == 1) {
            $res['ret'] = 1;
            foreach ($logs as $log) {
                /** @var DetectLog $log */
                if ($log->node() == null) {
                    DetectLog::node_is_null($log);
                    continue;
                }
                if ($log->rule() == null) {
                    DetectLog::rule_is_null($log);
                    continue;
                }
                $log->node_name         = $log->node_name();
                $log->detect_rule_name  = $log->rule_name();
                $log->detect_rule_text  = $log->rule_text();
                $log->detect_rule_regex = $log->rule_regex();
                $log->detect_rule_type  = $log->rule_type();
                $log->detect_rule_date  = $log->datetime();
            }
            $res['logs'] = $logs;
            return $response->withJson($res);
        }

        $logs->setPath('/user/detect/log');
        $render = Tools::paginate_render($logs);
        return $this->view()
            ->assign('logs', $logs)
            ->assign('render', $render)
            
            // cool
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
            ->display('user/detect_log.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function disable($request, $response, $args)
    {
        return $this->view()->display('user/disable.tpl');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function telegram_reset($request, $response, $args)
    {
        $user = $this->user;
        $user->TelegramReset();
        return $response->withStatus(302)->withHeader('Location', '/user/edit');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function resetURL($request, $response, $args)
    {
        $user = $this->user;
        $user->clean_link();
        return $response->withStatus(302)->withHeader('Location', '/user');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function resetInviteURL($request, $response, $args)
    {
        $user = $this->user;
        $user->clear_inviteCodes();
        return $response->withStatus(302)->withHeader('Location', '/user/invite');
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function backtoadmin($request, $response, $args)
    {
        $userid = Cookie::get('uid');
        $adminid = Cookie::get('old_uid');
        $user = User::find($userid);
        $admin = User::find($adminid);

        if (!$admin->is_admin || !$user) {
            Cookie::set([
                'uid' => null,
                'email' => null,
                'key' => null,
                'ip' => null,
                'expire_in' => null,
                'old_uid' => null,
                'old_email' => null,
                'old_key' => null,
                'old_ip' => null,
                'old_expire_in' => null,
                'old_local' => null
            ], time() - 1000);
        }
        $expire_in = Cookie::get('old_expire_in');
        $local = Cookie::get('old_local');
        Cookie::set([
            'uid' => Cookie::get('old_uid'),
            'email' => Cookie::get('old_email'),
            'key' => Cookie::get('old_key'),
            'ip' => Cookie::get('old_ip'),
            'expire_in' => $expire_in,
            'old_uid' => null,
            'old_email' => null,
            'old_key' => null,
            'old_ip' => null,
            'old_expire_in' => null,
            'old_local' => null
        ], $expire_in);
        return $response->withStatus(302)->withHeader('Location', $local);
    }

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function getUserAllURL($request, $response, $args)
    {
        $user = $this->user;
        $type = $request->getQueryParams()["type"];
        $return = '';
        switch ($type) {
            case 'ss':
                $return .= URL::get_NewAllUrl($user, ['type' => 'ss']) . PHP_EOL;
                break;
            case 'ssr':
                $return .= URL::get_NewAllUrl($user, ['type' => 'ssr']) . PHP_EOL;
                break;
            case 'v2ray':
                $return .= URL::get_NewAllUrl($user, ['type' => 'vmess']) . PHP_EOL;
                break;
            default:
                $return .= '悟空别闹！';
                break;
        }
        $response = $response->withHeader('Content-type', ' application/octet-stream; charset=utf-8')
            ->withHeader('Cache-Control', 'no-store, no-cache, must-revalidate')
            ->withHeader('Content-Disposition', ' attachment; filename=node.txt');

        return $response->write($return);
    }

    /**
     * 订阅记录
     *
     * @param Request  $request
     * @param Response $response
     * @param array    $args
     */
    public function subscribe_log($request, $response, $args)
    {
        if ($_ENV['subscribeLog_show'] === false) {
            return $response->withStatus(302)->withHeader('Location', '/user');
        }
        $pageNum = $request->getQueryParams()['page'] ?? 1;
        $logs = UserSubscribeLog::orderBy('id', 'desc')->where('user_id', $this->user->id)->paginate(15, ['*'], 'page', $pageNum);
        $iplocation = new QQWry();
        $logs->setPath('/user/subscribe_log');

        if (($request->getParam('json') == 1)) {
            $res['ret'] = 1;
            $res['logs'] = $logs;
            foreach ($logs as $log) {
                $location = $iplocation->getlocation($log->request_ip);
                $log->country = iconv("gbk", "utf-8//IGNORE", $location['country']);
                $log->area = iconv("gbk", "utf-8//IGNORE", $location['area']);
            }
            $res['subscribeLog_keep_days'] = $_ENV['subscribeLog_keep_days'];
            return $response->withJson($res);
        }
        $render = Tools::paginate_render($logs);
        return $this->view()
            ->assign('logs', $logs)
            ->assign('iplocation', $iplocation)
            ->assign('render', $render)
            
            // cool
            ->assign('time', date("Y-m-d H:i:s",time()))
            ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
            ->fetch('user/subscribe_log.tpl');
    }

    /**
     * 获取包含订阅信息的客户端压缩档，PHP 需安装 zip 扩展
     *
     * @param Request  $request
     * @param Response $response
     * @param array    $args
     */
    public function getPcClient($request, $response, $args)
    {
        $zipArc = new \ZipArchive();
        $user_token = LinkController::GenerateSSRSubCode($this->user->id);
        $type = trim($request->getQueryParams()['type']);
        // 临时文件存放路径
        $temp_file_path = BASE_PATH . '/storage/';
        // 客户端文件存放路径
        $client_path = BASE_PATH . '/resources/clients/';
        switch ($type) {
            case 'ss-win':
                $user_config_file_name = 'gui-config.json';
                $content = ClientProfiles::getSSPcConf($this->user);
                break;
            case 'ssr-win':
                $user_config_file_name = 'gui-config.json';
                $content = ClientProfiles::getSSRPcConf($this->user);
                break;
            case 'v2rayn-win':
                $user_config_file_name = 'guiNConfig.json';
                $content = ClientProfiles::getV2RayNPcConf($this->user);
                break;
            default:
                return 'gg';
        }
        $temp_file_path .= $type . '_' . $user_token . '.zip';
        $client_path .= $type . '/';
        // 文件存在则先删除
        if (is_file($temp_file_path)) {
            unlink($temp_file_path);
        }
        // 超链接文件内容
        $site_url_content = '[InternetShortcut]' . PHP_EOL . 'URL=' . $_ENV['baseUrl'];
        // 创建 zip 并添加内容
        $zipArc->open($temp_file_path, \ZipArchive::CREATE);
        $zipArc->addFromString($user_config_file_name, $content);
        $zipArc->addFromString('点击访问_' . $_ENV['appName'] . '.url', $site_url_content);
        Tools::folderToZip($client_path, $zipArc, strlen($client_path));
        $zipArc->close();

        $newResponse = $response->withHeader('Content-type', ' application/octet-stream')->withHeader('Content-Disposition', ' attachment; filename=' . $type . '.zip');
        $newResponse->write(file_get_contents($temp_file_path));
        unlink($temp_file_path);

        return $newResponse;
    }

    /**
     * 从使用同数据库的其他面板下载客户端[内置节点]
     *
     * @param Request  $request
     * @param Response $response
     * @param array    $args
     */
    public function getClientfromToken($request, $response, $args)
    {
        $token = $args['token'];
        $Etoken = Token::where('token', '=', $token)->where('create_time', '>', time() - 60 * 10)->first();
        if ($Etoken == null) {
            return '下载链接已失效，请刷新页面后重新点击.';
        }
        $user = User::find($Etoken->user_id);
        if ($user == null) {
            return null;
        }
        $this->user = $user;
        return $this->getPcClient($request, $response, $args);
    }
    
    /**
     * Cool Theme
     *
     * @param Request  $request
     * @param Response $response
     * @param array    $args
     */
    public function qrcode($request, $response, $args)
    {
        return $this->view()->display('user/pay/qrcode.tpl'); 
    } 
    
    public function getmoney($request, $response, $args)
    {
        $user = $this->user;
        $res['money'] = $user->money;
        $res['ret'] = 1;
        return $response->getBody()->write(json_encode($res));
    }
     
    public function Quantit($set)
    {
        $user = $this->user;
        if ($set == 1) {
            $user->class = Config::get('quantit_class');
            $user->t = '0';
            $user->u = '0';
            $user->d = '0';
            $user->transfer_enable = '0';
            $user->class_expire = '2039-12-30 00:00:00';
            $user->node_speedlimit = Config::get('quantit_speedlimit');
            $user->node_connector = Config::get('quantit_connector');
            $user->quantitypay = '1';
            $user->save();
        }elseif($set == 0){
            $user->class = '0';
            $user->t = '0';
            $user->u = '0';
            $user->d = '0';
            $user->transfer_enable = '0';
            $user->class_expire = date('Y-m-d H:i:s',time());
            $user->node_speedlimit = '0.00';
            $user->node_connector = '1';
            $user->quantitypay = '0';
            $user->save();
        }
    }
    
    
    /**
     *  套餐兑换
     */
    public function redeem($request, $response, $args)
    {
        $user = $this->user;
        $code = $request->getParam('code');
        $code = trim($code);
        
        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->withJson($res);
        }

        $code = Redeem::where('code', $code)->first();

        if ($code == null) {
            $res['ret'] = 0;
            $res['msg'] = '兑换码无效';
            return $response->withJson($res);
        }

        $use_limit = $code->onetime;
        if ($use_limit > 0) {
            $use_count = Bought::where('userid', $user->id)->where('code', $code->code)->count();
            if ($use_count >= $use_limit) {
                $res['ret'] = 0;
                $res['msg'] = '兑换码次数已用完';
                return $response->withJson($res);
            }
        }
        
        CoolConfig::bought_usedd($user, 1, 0);
        $shop = Shop::where('id', $code->shop)->where('status', 1)->first();
        
        $bought = new Bought();
        $bought->userid = $user->id;
        $bought->shopid = $code->shop;
        $bought->datetime = time();
        $bought->renew = 0;
        $bought->coupon = '';
        $bought->code = $code->code;
        $bought->price = $shop->price;
        $bought->usedd = 1;
        $bought->save();

        $shop->buy($user);
        
        $res['ret'] = 1;
        $res['msg'] = '兑换成功，套餐名为' . $shop->name;

        return $response->withJson($res);
    }
    
    /**
     *  按量付费
     */
    public function quantitypay($request, $response, $args)
    {
        $user = $this->user;
        $bought = Bought::where('userid',$user->id)->first();
        
        if (Config::get('quantit_shop') == true) {
            if ($bought && $user->quantitypay == '0') {
                if ($user->money < Config::get('quantit_money')) {
                    $res['ret'] = 0;
                    $res['msg'] = "余额不足，请先充值";
                    return $response->getBody()->write(json_encode($res));
                }
    			self::Quantit(1);
                $res['ret'] = 1;
                $res['msg'] = "启用成功";
                return $response->getBody()->write(json_encode($res));
            }elseif($user->quantitypay == '1'){
                self::Quantit(0);
                $res['ret'] = 1;
                $res['msg'] = "关闭成功";
                return $response->getBody()->write(json_encode($res));
            }else{
                $res['ret'] = 0;
                $res['msg'] = "您的账号未购买过正常套餐，由于安全原因，暂时不能启用按量付费功能。";
                return $response->getBody()->write(json_encode($res));
            }
        }else{
            if ($user->quantitypay == '0') {
               if ($user->money < Config::get('quantit_money')) {
                    $res['ret'] = 0;
                    $res['msg'] = "余额不足，请先充值";
                    return $response->getBody()->write(json_encode($res));
                }
    			self::Quantit(1);
                $res['ret'] = 1;
                $res['msg'] = "启用成功";
                return $response->getBody()->write(json_encode($res));
            }elseif($user->quantitypay == '1'){
                self::Quantit(0);
                $res['ret'] = 1;
                $res['msg'] = "关闭成功";
                return $response->getBody()->write(json_encode($res));
            }
        }
    }
    
    
    /**
     *  商品信息
     */
    public function getShopInfo($request, $response, $args)
    {
        $shopid = $request->getParam('shop_id');
        if ($shopid === null) {
            return 0;
        }
        $shop = Shop::find($shopid);

        if ($shop === null) {
            return 0;
        }
        
        $res['name'] = $shop->name;
        $res['price'] = $shop->price;
        $res['ret'] = 1;
        return $response->getBody()->write(json_encode($res));
    }
    
    /**
     *  流量包
     */
    public function buyTrafficPackage($request, $response, $args)
    {
        $traffic = intval($request->getParam('traffic'));
        $price = $request->getParam('price');
        $result = CoolConfig::get('shop_traffic_package')*$traffic;
      	$user = $this->user;
      
        if ($price != $result) {
            $res['ret'] = 0;
            $res['msg'] = "订单金额错误,请检查后提交.";
            return $response->getBody()->write(json_encode($res));
        }

        if (bccomp($user->money , $price,2)==-1) {
            $res['ret'] = 0;
            $res['msg'] = '喵喵喵~ 当前余额不足，总价为' . $price . '元。</br><a href="/user/code">点击进入充值界面</a>';
            return $response->getBody()->write(json_encode($res));
        }

        $user->money =bcsub($user->money , $price,2);
        $user->transfer_enable+=$traffic*1024*1024*1024;
        $user->save();

  
        $code = new Code();
        $code->code = $user->id;
        $code->type = '10001';
        $code->number = $traffic;
        $code->isused      = 1;
        $code->userid      = $user->id;
        $code->usedatetime = date('Y-m-d H:i:s');
        $code->save();

        $res['ret'] = 1;
        $res['msg'] = "购买成功, 流量增加 ".$traffic."GB";

        return $response->getBody()->write(json_encode($res));
    }
    
    /**
     *  套餐折算
     */
    public function PackageConversion($request, $response, $args)
    {
        if (!CoolConfig::get('shop_conversion')) {
            $res = ['ret' => 0, 'msg' => '管理员设置不允许折算'];
            return $response->getBody()->write(json_encode($res));
        }
        
        /* 识别用户 和 登录状态*/
        $user = $this->user;
        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->getBody()->write(json_encode($res));
        }

        /* 获取套餐记录 */
        $bought = Bought::where('userid', $user->id)->where('usedd', 1)->first();

        if ($bought->userid != $user->id) {
            $res = ['ret' => 0, 'msg' => '非法操作'];
            return $response->getBody()->write(json_encode($res));
        }
        
        if (!CoolConfig::get('shop_redeem_conversion')) {
            if (!$bought->code == null) {
                $res = ['ret' => 0, 'msg' => '通过兑换码兑换的套餐不允许进行折算操作'];
                return $response->getBody()->write(json_encode($res));
            }
        }

        $cool = new CoolConfig();
        if ($request->getParam('ok') === 'ok') {
            /* 返还操作 */
            $res = $cool->PackageConversion_OK($user, $bought);
        } else {
            /* 计算返还信息 */
            $res = $cool->getConversionInfo($user, $bought);
        }

        return $response->getBody()->write(json_encode($res, JSON_UNESCAPED_UNICODE));
    }
    
    /**
     *  共享帐号
     */
	public function share_account($request, $response, $args)
    {
        return $this->view()
        ->assign('class_left_days', floor((strtotime($this->user->class_expire)-time())/86400)+1)
        ->assign('display_ios_topup', Config::get('display_ios_topup'))
        ->assign('time', date("Y-m-d H:i:s",time()))->display('user/share-account.tpl');
    }
    
    /**
     *  节点筛选
     */
    public function nodeFilterSave($request, $response, $args)
    {
        $user = $this->user;
        
        /* 识别用户 和 登录状态*/
        if (!$user->isLogin) {
            $res['ret'] = -1;
            return $response->getBody()->write(json_encode($res));
        }

        $mode = $request->getParam('filter_mode');
        $sort = explode("-", $request->getParam('filter_sort'));
        $link = Link::where('type', 11)->where('userid', $user->id)->first();
        if ($link==null){
            return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '您的订阅异常, 请尝试重置订阅']));
        }
        $rule = json_decode($link->filter, true);

        switch ($mode) {
            case ('all'):
                $rule['mode'] = 'all';
                break;
            case ('nodes_class'):
                $rule['mode'] = 'nodes_class';
                $rule['nodes_class']['the'] = ">=";
                if ($rule['nodes_class']['the'] === null) {
                    return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '请指定订阅节点等级']));
                }
                $rule['nodes_class']['value'] = $request->getParam('nodes_class_value');
                break;
            case ('nodes_id'):
                $rule['mode'] = 'nodes_id';
                $rule['nodes_id'] = $request->getParam('nodes_id');
                if ($rule['nodes_id'] === null) {
                    return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '节点不能为空']));
                }
                break;
        }

        $rule['sort'] = [ 'type' => $sort[0], 'value' => $sort[1] ];
        if (CoolConfig::get('nodes_miniName') === true) {
            $rule['mininame'] = (int) $request->getParam('filter_mininame');
        }

        $link->filter = json_encode($rule);
        if ($link->save()) {
            return $response->getBody()->write(json_encode(['ret' => 1, 'msg' => '保存成功, ' . PHP_EOL . '请更新订阅获取最新节点']));
        }

        return $response->getBody()->write(json_encode(['ret' => 0, 'msg' => '保存失败']));
    }
    
    /**
     *  流媒体检测
     */
    public function media($request, $response, $args)
    {
        $results = [];
        $db = new DatatablesHelper;
        $nodes = $db->query('SELECT DISTINCT node_id FROM stream_media');
        
        foreach ($nodes as $node_id)
        {
            $node = Node::where('id', $node_id)->first();
            
            $unlock = StreamMedia::where('node_id', $node_id)
            ->orderBy('id', 'desc')
            ->where('created_at', '>', time() - 86460) // 只获取最近一天零一分钟内上报的数据
            ->first();
            
            if ($unlock != null) {
                $details = json_decode($unlock->result, true);
                $details = str_replace('Originals Only', '仅限自制', $details);
                $details = str_replace('Oversea Only', '仅限海外', $details);

                foreach ($details as $key => $value)
                {
                    $info = [
                        'node_name' => $node->name,
                        'created_at' => $unlock->created_at,
                        'unlock_item' => $details
                    ];
                }
                
                array_push($results, $info);
            }
        }

        if ($_ENV['streaming_media_unlock_multiplexing'] != null ) {
            foreach ($_ENV['streaming_media_unlock_multiplexing'] as $key => $value)
            {
                $key_node = Node::where('id', $key)->first();
                $value_node = StreamMedia::where('node_id', $value)
                ->orderBy('id', 'desc')
                ->where('created_at', '>', time() - 86460) // 只获取最近一天零一分钟内上报的数据
                ->first();

                if ($value_node != null) {
                    $details = json_decode($value_node->result, true);
                    $details = str_replace('Originals Only', '仅限自制', $details);
                    $details = str_replace('Oversea Only', '仅限海外', $details);
                    
                    $info = [
                        'node_name' => $key_node->name,
                        'created_at' => $value_node->created_at,
                        'unlock_item' => $details
                    ];
                    
                    array_push($results, $info);
                }
           }
        }

        array_multisort(array_column($results, 'node_name'), SORT_ASC, $results);
        
        return $this->view()
            ->assign('results', $results)
            ->display('user/media.tpl');
    }
}