<?php

/**
 * Created by PhpStorm.
 * User: tonyzou
 * Date: 2018/9/24
 * Time: 下午7:07
 */

namespace App\Services;

use App\Services\Gateway\{
    AopF2F,
    PaymentWall,
    PAYJS,
    YftPay,
    StripePay,
    PayBeaver,
    MGate,
    EasyPay,
    PolicePay,
    THeadPay,
    CoolPay
};

class Payment
{
    public static function getClient()
    {
        $method = $_ENV['payment_system'];
        switch ($method) {
            case ('paymentwall'):
                return new PaymentWall();
            case ('f2fpay'):
                return new AopF2F();
            case ('payjs'):
                return new PAYJS($_ENV['payjs_key']);
            case ('yftpay'):
                return new YftPay();
            case ('stripe'):
                return new StripePay();
            case ('paybeaver'):
                return new PayBeaver();
            case ('mgate'):
                return new MGate();
            case ("policepay"):
                return new PolicePay();
            case ('theadpay'):
                return new THeadPay();
            case ("easypay"):
                return new EasyPay(Config::get('easypay_app_secret'));
            case ("cool"):
                return new CoolPay();
            default:
                return null;
        }
    }

    public static function notify($request, $response, $args)
    {
        return self::getClient()->notify($request, $response, $args);
    }

    public static function returnHTML($request, $response, $args)
    {
        return self::getClient()->getReturnHTML($request, $response, $args);
    }

    public static function purchaseHTML()
    {
        if (self::getClient() != null) {
            return self::getClient()->getPurchaseHTML();
        }

        return '';
    }

    public static function getStatus($request, $response, $args)
    {
        return self::getClient()->getStatus($request, $response, $args);
    }

    public static function purchase($request, $response, $args)
    {
        return self::getClient()->purchase($request, $response, $args);
    }
}
