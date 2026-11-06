<?php
namespace App\Services\Gateway;

use App\Services\{
    View, Auth, Config, CoolConfig
};
use App\Models\{
    Shop, Paylist
};
use Omnipay\Omnipay;
use Stripe\Stripe;
use Stripe\Charge;

class CoolPay extends AbstractPayment {
    
    public function purchase($request, $response, $args) {
        
        $price = $request->getParam('price');
        $type = $request->getParam('type');
        $shopid = $request->getParam('shopid');
        $coupon = $request->getParam('coupon');
         
        $user = Auth::getUser();
        
        if ($price < CoolConfig::get('mix_amount')) {
            return json_encode(['ret' => 0, 'msg' => '充值最低金额为 ' . CoolConfig::get('mix_amount') . ' 元']);
        }
        
        if ($price <= 0) {
            return json_encode(['ret' => 0, 'msg' => "金额必须大于0元"]);
        }
        
        if ($type == 'alipay') {
            $payment_system = CoolConfig::get('pay_alipay');
            switch ($payment_system) {
                case ('f2fpay'):
                    $f2fpay = new AopF2F();
                    $result = $f2fpay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('theadpay'):
                    $theadpay = new THeadPay();
                    $result = $theadpay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['msg']
                        );
                    }
                    return json_encode($return);
                case ('mgate'):
                    $MGate = new MGate();
                    $result = $MGate->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['msg']
                        );
                    }
                    return json_encode($return);
                case ('stripe'):
                    $stripe = new StripePay();
                    $result = $stripe->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('policepay'):
                    $PolicePay = new PolicePay();
                    $result = $PolicePay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => $result['type'],
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('paybeaver'):
                    $paybeaver = new PayBeaver();
                    $result = $paybeaver->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('epay'):
                    $epay = new epay();
                    $result = $epay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('EasyPay'):
                    $easypay = new EasyPay(Config::get('easypay_app_secret'));
                    $result = $easypay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                default:
                    $return = array(
                        'ret' => 0,
                        'msg' => $payment_system.' 支付系统错误,请联系客服'
                    );
                    return json_encode($return);
            }
        } else if ($type == 'wechat') {
            $payment_system = CoolConfig::get('pay_wxpay');
            switch ($payment_system) {
                case ('stripe'):
                    $stripe = new StripePay();
                    $result = $stripe->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('paybeaver'):
                    $paybeaver = new PayBeaver();
                    $result = $paybeaver->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('payjs'):
                    $payjs = new PAYJS($_ENV['payjs_key']);
                    $result = $payjs->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('policepay'):
                    $PolicePay = new PolicePay();
                    $result = $PolicePay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => $result['type'],
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('theadpay'):
                    $theadpay = new THeadPay();
                    $result = $theadpay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['msg']
                        );
                    }
                    return json_encode($return);
                case ('epay'):
                    $epay = new epay();
                    $result = $epay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('EasyPay'):
                    $easypay = new EasyPay(Config::get('easypay_app_secret'));
                    $result = $easypay->CoolPay($type, $price, $shopid, $coupon);
                    if ($result['errcode'] === 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['pid'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                default:
                    $return = array(
                        'ret' => 0,
                        'msg' => $payment_system.' 支付系统不支持,请联系客服'
                    );
                    return json_encode($return);
            }
        }else {
            return json_encode(['ret' => 0, 'msg' => '错误的支付方式']);
        }
    }
    
    public function notify($request, $response, $args) {
        
        $path = $request->getUri()->getPath();
        $path_exploded = explode('/', $path);
        $payment_system = $path_exploded[3];
        
        switch ($payment_system) {
            case ('mgate'):
                $mgate = new MGate();
                $mgate->notify($request, $response, $args);
                return;
            case ('theadpay'):
                $notify = new THeadPay();
                $notify->notify($request, $response, $args);
                return;
            case ('f2fpay'):
                $f2fpay = new AopF2F();

                $gateway = Omnipay::create('Alipay_AopF2F');
                $gateway->setSignType('RSA2'); //RSA/RSA2
                $gateway->setAppId(Config::get('f2fpay_app_id'));
                $gateway->setPrivateKey(Config::get('merchant_private_key')); // 可以是路径，也可以是密钥内容
                $gateway->setAlipayPublicKey(Config::get('alipay_public_key')); // 可以是路径，也可以是密钥内容

                $aliRequest = $gateway->completePurchase();
                $aliRequest->setParams($_POST);
        
                $aliResponse = $aliRequest->send();
                $pid = $aliResponse->data('out_trade_no');
                if ($aliResponse->isPaid()) {
                    $this->postPayment($pid, '支付宝');
                    die('success'); //The response should be 'success' only
                }
                return 'f2fpay';
            case ('stripe'):
                Stripe::setApiKey(Config::get('stripe_key'));
                $endpoint_secret = Config::get('stripe_webhook_endpoint_secret');
                $payload = @file_get_contents('php://input');
                $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
                $event = null;
        
                try {
                    $event = \Stripe\Webhook::constructEvent(
                        $payload,
                        $sig_header,
                        $endpoint_secret
                    );
                } catch (\UnexpectedValueException $e) {
                    http_response_code(400);
                    exit();
                } catch (\Stripe\Error\SignatureVerification $e) {
                    http_response_code(400);
                    exit();
                }
        
                switch ($event->type) {
                    case 'source.chargeable':
                        $source = $event->data->object;
                        $charge = Charge::create([
                            'amount' => $source['amount'],
                            'currency' => $source['currency'],
                            'source' => $source['id'],
                          ]);
                        if ($charge['status'] == 'succeeded') {
                            $type = null;
                            if ($source['type'] == 'alipay') {
                                $type = '支付宝支付'; 
                            } else if ($source['type'] == 'wechat') {
                                $type = '微信支付';
                            }
                            $order = Paylist::where('tradeno', '=', $source['id'])->first();
                            if ($order->status != 1) {
                                $this->postPayment($source['id'], 'Stripe '.$type);
                                echo 'SUCCESS';
                            } else {
                                echo 'ERROR';
                            }
                        }
                        break;
                    default:
                        http_response_code(400);
                        exit();
                }
        
                http_response_code(200);
            case ('yftpay'):
                $yftUtil = new YftPayUtil();
                $pay_config = new YftPayConfig();
                $pay_config->init();
                $total_fee = $request->getParam("total_fee");
                $yft_order_no = $request->getParam("trade_no");
                $ss_order_no = $request->getParam("out_trade_no");
                $subject = $request->getParam("subject");
                $trade_status = $request->getParam("trade_status");
                $sign = $request->getParam("sign");
                $verifyNotify = $yftUtil->md5Verify(floatval($total_fee), $ss_order_no, $yft_order_no, $trade_status, $sign);
                if ($verifyNotify && $trade_status == 'TRADE_SUCCESS') {
                    $order = Paylist::where('tradeno', $ss_order_no)->first();
                    if ($order->status == 0) {
                        $this->postPayment($ss_order_no, '易付通');
                        return "success";
                    }
                    return "fail";
                } else {
                    return "fail";
                }
                return "fail";
            case ('payjs'):
                $payjs = new PAYJS($_ENV['payjs_key']);
                $payjs->notify($request, $response, $args);
                return;
            case ('policepay'):
                $order_data = $_REQUEST;
                $pid = $order_data['out_trade_no'];     //订单号
				unset($order_data['s']);
                $type    = $order_data['type'];          
                $status    = $order_data['trade_status']; //获取传递过来的交易状态
                $signs    = $order_data['sign'];
                $pl = Paylist::where('tradeno',$pid)->first();
                if ($pl->status == 1) {
                    echo 'success';
                    return;
                }
                $policepay = new PolicePay();
				$result = json_decode($policepay->notify($request, $response, $args),true);
                if ($result=='success'){
					echo "success";
				}else{
					echo "fail";
				} 
				return;
            case ('paybeaver'):
                $paybeaver = new PayBeaver();
                $paybeaver->notify($request, $response, $args);
                return;
            case ('epay'):
                $epay = new epay();
                $epay->notify($request, $response, $args);
                return;
            default:
                return 'failed';
        }
    }
    
    public function getPurchaseHTML() {
        return 1;
    }
    
    public function getReturnHTML($request, $response, $args)
    {
        $tradeno = $_GET['tradeno'];
        if ($tradeno == '' || $tradeno == null) {
            $tradeno = $_GET['source'];
        }
        if ($tradeno == '' || $tradeno == null) {
            $tradeno = $_GET['out_trade_no'];
        }
        $p = Paylist::where('tradeno', '=', $tradeno)->first();
        $money = $p->total;
        if ($p->status === 1) {
            $success = 1;
        } else {
            $success = 0;
        }
        if($p->shopid == null){
            return View::getSmarty()->assign('money', $money)->assign('success', $success)->fetch('user/pay_success.tpl');
        }else{
            return View::getSmarty()->assign('shopid', $p->shopid)->assign('success', $success)->fetch('user/pay_success.tpl');
        }
    }
    
    public function getStatus($request, $response, $args)
    {
        $p = Paylist::where('tradeno', $_POST['tradeno'])->first();
        $return['ret'] = 1;
        $return['result'] = $p->status;
        return json_encode($return);
    }
}