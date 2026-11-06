<?php
/**
 * Created by PhpStorm.
 * User: tonyzou
 * Date: 2018/9/24
 * Time: 下午4:23
 */

namespace App\Services\Gateway;

use App\Models\Bought;
use App\Models\Code;
use App\Models\Coupon;
use App\Models\Payback;
use App\Models\Paylist;
use App\Models\Shop;
use App\Models\User;
use App\Services\{
    CoolConfig
};
use App\Utils\Telegram;
use Slim\Http\{Request, Response};

abstract class AbstractPayment
{
    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    abstract public function purchase($request, $response, $args);

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    abstract public function notify($request, $response, $args);

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    abstract public function getReturnHTML($request, $response, $args);

    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    abstract public function getStatus($request, $response, $args);

    abstract public function getPurchaseHTML();

    public function postPayment($pid, $method)
    {
        $p = Paylist::where('tradeno', $pid)->first();

        if ($p->status == 1) {
            return json_encode(['errcode' => 0]);
        }

        $p->status = 1;
        $p->save();
        $user = User::find($p->userid);
        $user->money += $p->total;
        $user->save();
        $codeq = new Code();
        $codeq->code = $method;
        $codeq->isused = 1;
        $codeq->type = -1;
        $codeq->number = $p->total;
        $codeq->usedatetime = date('Y-m-d H:i:s');
        $codeq->userid = $user->id;
        $codeq->save();

   
        try {
            if ($p->shopid) {
                $shop = Shop::where('id', $p->shopid)->where('status', 1)->first();

                if ($shop == null) {
                    $res['ret'] = 0;
                    $res['msg'] = '非法请求';
                    return $res;
                }
                
                if ($p->coupon == '') {
                    $credit = 0;
                } else {
                    $coupon = Coupon::where('code', $p->coupon)->first();

                    if ($coupon == null) {
                        $credit = 0;
                    } else {
                        if ($coupon->onetime == 1) {
                            $onetime = true;
                        }
                        $credit = $coupon->credit;
                    }

                    if ($coupon->order($shop->id) == false) {
                        $credit = 0;
                    }

                    if ($coupon->expire < time()) {
                        $credit = 0;
                    }
                }

                $user = User::find($p->userid);
                $price = $shop->price * ((100 - $credit) / 100);

                if (bccomp($user->money, $price, 2) == -1) {
                    $res['ret'] = 0;
                    $res['msg'] = '余额不足，总价为' . $price . '元; 您的余额为'.$user->money.'元';
                    return $res;
                }

                $user->money = bcsub($user->money, $price, 2);
                $user->save();

                $bought = new Bought();
                $bought->userid = $user->id;
                $bought->shopid = $shop->id;
                $bought->datetime = time();
                $bought->renew = 0;
                if ($p->coupon != '') {
                    $bought->coupon = $p->coupon;
                }else{
                    $bought->coupon = '';
                }
                $bought->price = $price;
                $bought->save();
                
                $shop->buy($user);
            }
        } catch (\Throwable $exception) {

        }


        if ($user->ref_by != '' && $user->ref_by != 0 && $user->ref_by != null) {
            CoolConfig::add_payback( User::find($user->ref_by), $user, $codeq->number);
        }

        if ($_ENV['enable_donate'] == true) {
            if ($user->is_hide == 1) {
                Telegram::Send('一位不愿透露姓名的大老爷给我们捐了 ' . $codeq->number . ' 元!');
            } else {
                Telegram::Send($user->user_name . ' 大老爷给我们捐了 ' . $codeq->number . ' 元！');
            }
        }
        
        if (CoolConfig::get('Telegram_Payment') === true) {
            CoolConfig::SendPayment($user, $p, $codeq);
        }
        
        return 0;
    }

    public static function generateGuid()
    {
        mt_srand((double)microtime() * 10000);
        $charid = strtoupper(md5(uniqid(mt_rand() + time(), true)));
        $hyphen = chr(45);
        $uuid = chr(123)
            . substr($charid, 0, 8) . $hyphen
            . substr($charid, 8, 4) . $hyphen
            . substr($charid, 12, 4) . $hyphen
            . substr($charid, 16, 4) . $hyphen
            . substr($charid, 20, 12)
            . chr(125);
        $uuid = str_replace(['}', '{', '-'], '', $uuid);
        $uuid = substr($uuid, 0, 8);
        return $uuid;
    }
}
