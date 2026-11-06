<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/10/10
 * Time: 17:03
 */

namespace App\Services\Gateway;

use App\Models\Paylist;
use App\Services\Auth;
use App\Services\Config;

class YftPay extends AbstractPayment
{
    private $user;

    public function __construct()
    {
        $this->user = Auth::getUser();
    }

    public function purchase($request, $response, $args)
    {
        return $this->constructPayPara($request);
    }
    
    public function CoolPay($type, $price, $shopid=null, $coupon=null)
    {
        $yftLib = new YftPayUtil();
        $pay_config = new YftPayConfig();
        $pay_config->init();

        $user = Auth::getUser();

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->status = 0;
        $pl->tradeno = self::generateGuid();
        $pl->datetime = time();
        if ($shopid != 0) {
            $pl->shopid = $shopid;
        }
        if ($coupon != null) {
            $pl->coupon = $coupon;
        }
        $pl->save();

        $subject = '余额充值';

        $notify_url = $_ENV['baseUrl'] . '/payment/notify/yftpay';
        $return_url = $_ENV['baseUrl'] . '/user/payment/return?tradeno=' . $pl->tradeno;

        $secret = $_ENV['yft_secret'];
        $parameter = [
            "total_fee" => $pl->total,
            "notify_url" => $notify_url,
            "return_url" => $return_url,
            "secret" => $secret,
            "out_trade_no" => $pl->tradeno
        ];

        $url = $yftLib->buildRequestForm($parameter, $pl->tradeno, $pay_config);
        $results = array('ret'=>1,'url'=>$url,'tradeno' => $pl->tradeno );
        return $results;
    }

    public function notify($request, $response, $args)
    {
        $yftUtil = new YftPayUtil();
        $pay_config = new YftPayConfig();
        $pay_config->init();
        //价格
        $total_fee = $request->getParam("total_fee");
        //易付通返回的订单号
        $yft_order_no = $request->getParam("trade_no");
        //面板生成的订单号
        $ss_order_no = $request->getParam("out_trade_no");
        //订单说明
        $subject = $request->getParam("subject");
        //付款状态
        $trade_status = $request->getParam("trade_status");
        //加密验证字符串
        $sign = $request->getParam("sign");
        $verifyNotify = $yftUtil->md5Verify(floatval($total_fee), $ss_order_no, $yft_order_no, $trade_status, $sign);
        if ($verifyNotify && $trade_status == 'TRADE_SUCCESS') {//验证成功
            /*
            加入您的入库及判断代码;
            >>>>>>>！！！为了保证数据传达到回调地址，会请求4次。所以必须要先判断订单状态，然后再插入到数据库，这样后面即使请求3次，也不会造成订单重复！！！！<<<<<<<
            判断返回金额与实金额是否想同;
            判断订单当前状态;
            完成以上才视为支付成功
            */
            $order = Paylist::where('tradeno', $ss_order_no)->first();
            if ($order->status == 0) {
                $this->postPayment($ss_order_no, '易付 充值');
                return "success";
            }
            return "fail";
        } else {
            //验证失败
            return "fail";
        }
    }

    /**
     * @param $request
     * @return string
     */
    private function constructPayPara($request)
    {
        $yftLib = new YftPayUtil();
        $pay_config = new YftPayConfig();
        $pay_config->init();
        /**************************请求参数**************************/
        //订单名称
        $subject = $request->getParams()['subject'];//必填
        //付款金额
        $total_fee = $request->getParams()['total_fee'];//必填 需为整数
        //服务器异步通知页面路径
        $notify_url = $request->getUri()->getScheme() . "://" . $request->getUri()->getHost() . "/payment/notify";
        //需http://格式的完整路径，不能加?id=123这类自定义参数
        //页面跳转同步通知页面路径
        $return_url = $request->getUri()->getScheme() . "://" . $request->getUri()->getHost() . $pay_config->pay_config["return_url"];
        //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
        $secret = Config::get('yft_secret');
        $ss_order_no = self::genOrderNumber();
        /************************************************************/
        //构造要请求的参数数组，无需改动
        $parameter = [
            "total_fee" => $total_fee,
            "notify_url" => $notify_url,
            "return_url" => $return_url,
            "secret" => $secret,
            "out_trade_no" => $ss_order_no
        ];
        //向数据库插入订单信息
        $order = new Paylist();
        $order->userid = $this->user->id;
        $order->total = $total_fee;
        $order->status = 0;
        $order->tradeno = $ss_order_no;
        $order->datetime = time();
        $order->save();
        //建立请求
        $html_text = $yftLib->buildRequestForm($parameter, $ss_order_no, $pay_config);
        return $html_text;
    }

    public function getPurchaseHTML()
    {
        return 1;
    }

    public function getReturnHTML($request, $response, $args)
    {
        // TODO: Implement getReturnHTML() method.
    }

    public function getStatus($request, $response, $args)
    {
        // TODO: Implement getStatus() method.
    }

    private function genOrderNumber()
    {
        //生成订单号
        // 密码字符集，可任意添加你需要的字符
        $date = time();
        $date = "yft" . date("YmdHis", $date);
        $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $password = "";
        for ($i = 0; $i < 8; $i++) {
            // 这里提供两种字符获取方式
            // 第一种是使用 substr 截取$chars中的任意一位字符；
            // 第二种是取字符数组 $chars 的任意元素
            $password .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
        }
        return $date . $password;
    }
}
