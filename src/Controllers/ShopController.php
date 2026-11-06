<?php
namespace App\Controllers;


use App\Models\Ann;
use App\Models\Shop;
use App\Models\User;
use App\Services\Auth;
use App\Services\Config;
use App\Services\CoolConfig;
use App\Services\Payment;
use App\Utils\Check;
use App\Utils\GA;
use App\Utils\Hash;
use App\Utils\Radius;
use App\Utils\Tools;
use Ramsey\Uuid\Uuid;
use voku\helper\AntiXSS;

class ShopController extends BaseController
{
    /**
     * @param $request
     * @param $response
     * @param $args
     * @throws \SmartyException
     */
    public function index($request, $response, $args)
    {
        $shops = Shop::where('status', 1)->orderBy('name')->get();
        $Ann = Ann::where('id', CoolConfig::get('shop_ann'))->first();

        return $this->view()
            ->assign('shops', $shops)
            ->assign('shop_id', $shops[0]['id'])
            ->assign('ann', $Ann)
            ->display('shop.tpl');
    }

    /**
     * @param $request
     * @param $response
     * @param $args
     * @return \Psr\Http\Message\ResponseInterface
     */
    public function getShopInfo($request, $response, $args)
    {
        $shop_id = $request->getQueryParams()['shop_id'];
        if (empty($shop_id)) {
            $res['ret'] = 0;
            return $this->echoJson($response, $res);
        }
        $shop = Shop::where('id', $shop_id)->first();
        $res['id'] = $shop_id;
        $res['name'] = $shop->name;
        $res['price'] = $shop->price;
        $res['ret'] = 1;

        return $response->getBody()->write(json_encode($res));
    }

    public function purchase($request, $response, $args)
    {
        $email = $request->getParam('email');
        $email = trim($email);
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $type = $request->getParam('type');
        $price = $request->getParam('price');
        // check email format
        if (!Check::isEmailLegal($email)) {
            $res['ret'] = 0;
            $res['msg'] = '邮箱无效';
            return $response->getBody()->write(json_encode($res));
        }
        $email_postfix = '@'.(explode("@",$email)[1]);
        
        if (CoolConfig::get('enable_register_email_restrict') == true) {
            $email_postfix = '@'.(explode("@",$email)[1]);
            if (in_array($email_postfix, CoolConfig::get('register_email_black_list')) == true) {
                $res['ret'] = 0;
                $res['msg'] = '邮箱后缀已被拉黑';
                return $response->getBody()->write(json_encode($res));
            }
        }
        
        if (CoolConfig::get('enable_register_email_restrict') == true) {
            if (in_array($email_postfix, CoolConfig::get('register_email_white_list')) == false) {
                $res['ret'] = 0;
                $res['msg'] = '小老弟还会发送post请求啊';
                return $response->getBody()->write(json_encode($res));
            }
        }
        
        // check email
        $user = User::where('email', $email)->first();
        if ($user != null) {
            $res['ret'] = 0;
            $res['msg'] = '邮箱已经被注册了';
            return $response->getBody()->write(json_encode($res));
        }
        // check pwd length
        if (strlen($passwd) < 8) {
            $res['ret'] = 0;
            $res['msg'] = '密码请大于8位';
            return $response->getBody()->write(json_encode($res));
        }
        // do reg user
        $user                       = new User();
        $antiXss                    = new AntiXSS();
        $current_timestamp          = time();

        $user->user_name            = $antiXss->xss_clean($email);
        $user->email                = $email;
        $user->pass                 = Hash::passwordHash($passwd);
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
        $user->im_type              = $imtype;
        $user->im_value             = $antiXss->xss_clean($imvalue);

        $user->transfer_enable      = Tools::toGB(Config::getconfig('Register.string.defaultTraffic'));
        $user->invite_num           = (int) Config::getconfig('Register.string.defaultInviteNum');
        $user->auto_reset_day       = $_ENV['free_user_reset_day'];
        $user->auto_reset_bandwidth = $_ENV['free_user_reset_bandwidth'];
        $user->money                = 0;
        $user->sendDailyMail        = Config::getconfig('Register.bool.send_dailyEmail');
        
        //dumplin：填写邀请人，写入邀请奖励
        $user->ref_by = 0;
        if ($c != null && $c->user_id != 0) {
            $user->ref_by = $c->user_id;
            $user->money = (int) Config::getconfig('Register.string.defaultInvite_get_money');
            $gift_user->transfer_enable += $_ENV['invite_gift'] * 1024 * 1024 * 1024;
            --$gift_user->invite_num;
            $gift_user->save();
        }
        if ($telegram_id) {
            $user->telegram_id = $telegram_id;
        }

        $user->class_expire     = date('Y-m-d H:i:s', time() + (int) Config::getconfig('Register.string.defaultClass_expire') * 3600);
        $user->class            = (int) Config::getconfig('Register.string.defaultClass');
        $user->node_connector   = (int) Config::getconfig('Register.string.defaultConn');
        $user->node_speedlimit  = (int) Config::getconfig('Register.string.defaultSpeedlimit');
        $user->expire_in        = date('Y-m-d H:i:s', time() + (int) Config::getconfig('Register.string.defaultExpire_in') * 86400);
        $user->reg_date         = date('Y-m-d H:i:s');
        $user->reg_ip           = $_SERVER['REMOTE_ADDR'];
        $user->theme            = $_ENV['theme'];

        $groups                 = explode(',', $_ENV['random_group']);

        $user->node_group       = $groups[array_rand($groups)];

        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token = $secret;
        $user->ga_enable = 0;

        $user->save();
        
        $time = 3600 * 24;
        Auth::login($user->id, $time);

        $res['ret'] = 1;

        return $response->getBody()->write(json_encode($res));
    }
}