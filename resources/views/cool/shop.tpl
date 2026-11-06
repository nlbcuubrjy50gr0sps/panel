<!DOCTYPE html>
  <html lang="zh-CN">
   <head> 
    <title>商店 — {$config["appName"]}</title> 
	<meta charset="UTF-8" /> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
    
    <!-- BEGIN: Vendor CSS-->
	<link rel="stylesheet" href="https://fastly.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/vendors/css/vendors.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/cool.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/style-purple.css">
	<!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/sweetalert2.min.css">
    <!-- END: Page CSS-->
    
	<link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/page/shop.css">
    <style>
        .shop-title{
            color: #7367f0;
        }
        .active-plan {
            -webkit-box-shadow: 0 0px 4px #5e72e4;
        }
        .bullet:after {
            content: '\2022';
        }
    </style>
</head>

<!-- BEGIN: Body-->
<body class="horizontal-layout horizontal-menu navbar-floating footer-static" data-open="hover" data-menu="horizontal-menu" data-col="">
    <!-- BEGIN: Header-->
    <nav class="header-navbar navbar-expand-lg navbar navbar-fixed align-items-center navbar-shadow navbar-brand-center" data-nav="brand-center">
        <div class="navbar-header d-xl-block d-none">
            <ul class="nav navbar-nav flex-row">
                <li class="nav-item">
	            	<a class="navbar-brand router-link-active" href="/user">
	                    <span class="brand-logo"></span>
	                    <h2 class="brand-text mb-0">&nbsp;{$config["appName"]} </h2>
	                </a>
                </li>
            </ul>
        </div>
        <div class="navbar-wrapper">
            <div class="navbar-container content">
                <div class="navbar-collapse" id="navbar-mobile">
                    <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                        <ul class="nav navbar-nav">
                            <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon feather icon-menu"></i></a></li>
                        </ul>
                    </div>
                	<ul class="nav navbar-nav float-right">
                        <li class="nav-item d-none d-lg-block"><a class="nav-link" href="/" data-toggle="tooltip" data-placement="top" title="" data-original-title="My Account"><i class="ficon feather icon-home"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <!-- END: Header-->
    
    <div class="content" style="padding-top: 4.5rem;">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-body">
                <section id="installing-node" class="card">
                  <div class="card-header">
                    <h4 class="card-title shop-title"><i class="fas fa-bullhorn"></i> 公告</h4>
                  </div>
                  <div class="card-content">
                    <div class="card-body">
                        <div class="row pb-50">
                            <div class="col-lg-12 col-12 d-flex justify-content-between flex-column order-lg-1 order-2">
                                <h5 class="font-medium-1">
                                    <p>{$ann->content}</p>
                                </h5>
                            </div>
                        </div>
                    </div>
                  </div>
                </section>
            
                <section id="account-plan" class="card">
                    <div class="card-body">
                        <h4 class="card-title shop-title"><i class="fa fa-user-plus"></i> 创建一个账号 </h4>
                        <p class="card-subtitle text-muted" style="margin-left: 24px;"> 竭尽全力为您提供优质的服务. </p>
                    </div>
                  
                    <div class="row pricing-card">
                        <div class="mx-auto col-12">
                                <div class="col-11">
                                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                                        <label class="form-label" for="email">邮箱</label>
                                        <input id="email" class="form-control" type="text" placeholder="请输入邮箱">
                                    </div>
                                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                                        <label class="form-label" for="passwd">密码</label>
                                        <input id="passwd" class="form-control" type="password" placeholder="请输入密码">
                                    </div>
                                </div>
                        </div>
                    </div>
                </section>
                
                <section id="pricing-plan" class="card">
                    <div class="card-body">
                        <h4 class="card-title shop-title"><i class="fas fa-hand-o-right"></i> 选择合适的会员订阅计划 </h4>
                        <p class="card-subtitle text-muted" style="margin-left: 24px;"> 竭尽全力为您提供优质的服务. </p>
                    </div>
                  
                    <div class="row pricing-card">
                        <div class="mx-auto col-lg-11">
                            <div class="row">
                                {foreach $shops as $shop}
                                    <div class="col-md-3 mb-4" id="shop-{$shop->id}">
                                        <div class="pricing-card p-30 shadow shadow-showcase">
                                            <span class="badge badge-primary">{$shop->name}</span>
            								{$shopLt = $shop->limitamount()}
            								{if $shopLt != 0}
                								<div style="position:absolute;top: -5px;right: 10px;">
                								    <div class="corner-text">限购</div>
                								    <img style="width: 60px" src="/theme/cool/assets/images/HOT.png">
                								</div>
                							{/if}
                                            <br>
                                            <div class="price-value txt-primary" style="position: relative;">
                                                <span class="currency">¥</span>
                                                <span class="amount">{$shop->price}</span>
                                                <span class="duration">{$shop->class_expire()}天</span>
                                                <span class="badge badge-primary classify">{$shop_time}</span>
                                            </div>
                                            
                                            {$shopLt = $shop->limitamount()}
                                            {$shopBi = $shop->limitamount('bi')}
                                            {$shopCan = $shop->limitamount('can')}
                                            <div class="d-flex flex-column w-100">
                                                <span class="font-size-sm text-muted font-weight-bold pb-1">
                                                    {if $shopLt == 0}此商品无限制购买{else}<span class="{if $shopBi < 5}text-danger{else}text-primary{/if}">{if $shopCan === 0}此商品已售空, 可尝试购买其它时长{else}此商品限购剩余 {$shopCan} 份{/if}{/if}</span>
                                                </span>
                                                <div class="progress progress-md w-100">
                                                    <div class="progress-bar progress-bar-striped {if $shopBi < 5}bg-danger{else}bg-primary{/if}" role="progressbar" style="width: {$shopBi}%;" aria-valuenow="{$shopBi}" aria-valuemin="0" aria-valuemax="100">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <ul class="pricing-content">
                                                <li>使用流量: <b>{$shop->bandwidth()} GB</b></li>
                                                <li>等级时长: <b>{$shop->class_expire()} 天</b></li>
                                                <li>会员等级: <b>[Lv.{$shop->user_class()}] 会员</b></li>
                                                <li>同时在线: <b>{if {$shop->connector()} == '0' }无限制{else}{$shop->connector()}个设备{/if}</b></li>
                                                <li>端口速率: <b>{if {$shop->speedlimit()} == '0' }无限制{else}{$shop->speedlimit()}Mbps{/if}</b></li>
                                                <li>账号时长: <b>{$shop->class_expire()} 天</b></li>
                                                <li>重置周期: <b>{if $shop->reset()!=0}{$shop->reset()}天重置{else}到期清零{/if}</b></li>
                                            </ul>
                                            <div class="text-center mt-3">
                                                <button class="btn btn-primary" type="button" onclick="subscribeShop({$shop->id})">立即订阅</button>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </div>
        
			<!--buy modal-->
			<div class="modal fade" id="order_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> 
				<div class="modal-dialog modal-dialog-centered" role="document"> 
					<div class="modal-content shadow-lg"> 
						 <div class="modal-header"> 
						  <h4 class="modal-title kt-font-primary" id="exampleModalLongTitle"><strong>订单确认</strong></h4> 
						  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        		<span aria-hidden="true">&times;</span>
			        	  </button>
						 </div> 
						 <div class="modal-body"> 
						    <p><font color="red"> 购买会员计划即代表同意《服务条款》和《使用政策》。</font></p> 
                            <label class="row col-12 col-form-label" id="shop_name"></label>
                            <label class="row col-12 col-form-label" id="shop_total"></label>
                            <label class="row col-12 col-form-label" id="shop_stneed"></label>
                            
                            <!--pay system-->
            	            <div class="form-group row form-group-marginless" id="shop_payment">
                                <label class="col-lg-12 col-form-label">支付方式：</label>
                                <div class="col-lg-12">
                                    <ul class="nav nav-pills row" role="tablist" id="pay_the">
                                 
                                    {if $config['payment_system'] == 'cool'}
                                        {if $Cool_Config['pay_alipay'] != 'none' && $Cool_Config['pay_alipay'] != ''}
                                        <li class="nav-alipay nav-item d-flex col mb-3 mb-lg-0 cursor_onclick">
                                            <a class="nav-link border py-10 d-flex flex-grow-1 rounded flex-column align-items-center active" data-toggle="pill" data-name="alipay">
                                                <span class="nav-icon py-1 w-auto">
                                                    <i class="fab fa-alipay icon-2x"></i>
                                                </span>
                                                <span class="nav-text font-size-lg py-2 font-weight-bold text-center">支付宝</span>
                                            </a>
                                        </li>
                                        {/if}
                                        {if $Cool_Config['pay_wxpay'] != 'none' && $Cool_Config['pay_wxpay'] != ''}
                                        <li class="nav-wxpay nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick">
                                            <a class="nav-link border py-10 d-flex flex-grow-1 rounded flex-column align-items-center {if $Cool_Config['pay_alipay'] == 'none' || $Cool_Config['pay_alipay'] == ''}active{/if}" data-toggle="pill" data-name="wechat">
                                                <span class="nav-icon py-1 w-auto">
                                                    <i class="fab fa-weixin icon-2x"></i>
                                                </span>
                                                <span class="nav-text font-size-lg py-2 font-weight-bold text-center">微信支付</span>
                                            </a>
                                        </li>
                                        {/if}
                                        {if $Cool_Config['pay_crypto'] != 'none' && $Cool_Config['pay_crypto'] != ''}
                                        <li class="nav-crypto nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick">
                                            <a class="nav-link border py-10 d-flex flex-grow-1 rounded flex-column align-items-center" data-toggle="pill" data-name="crypto">
                                                <span class="nav-icon py-1 w-auto">
                                                    <i class="fab fa-bitcoin icon-2x"></i>
                                                </span>
                                                <span class="nav-text font-size-lg py-2 font-weight-bold text-center">数字货币</span>
                                            </a>
                                        </li>
                                        {/if}
                                    {/if}
                               
                             
                                    </ul>
                                </div>
                            </div>
						 </div> 
						 <div class="modal-footer"> 
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="payShop()">确定</button> 
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button> 
						 </div> 
					</div> 
				</div> 
			</div>
		
			{if $config['payment_system'] == 'cool'}
				<div class="modal fade" id="coolpay-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> 
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">支付</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div style="text-align: center">
                                  点击“继续支付”打开支付页面支付<br>
                                  支付到账需要一段时间，请勿关闭或刷新此页面
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a id="to-coolpay" href="##" target="blank" class="btn btn-primary">继续支付</a>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
        
    </div><hr/>
    
	<footer class="footer footer-static footer-light">
        <p class="clearfix blue-grey lighten-2 mb-0">
        	<span class="float-md-left d-block d-md-inline-block mt-25">Copyright &copy; {date("Y")} {$config["appName"]} • Powered by <a class="text-bold-800 grey darken-2" href="/staff" target="_blank">Cool</a></span>
        	<!-- 本模板作者 TG号：@Cool_WuKong -->
        	<span class="float-md-right d-none d-md-block"><i class="feather icon-heart pink"></i></span>
        </p>
    </footer><hr/>

    <script src="https://fastly.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
    <script src="/theme/cool/assets/js/clipboard.min.js"></script>
    <script src="/theme/cool/assets/vendors/js/vendors.min.js"></script>
    <script src="/theme/cool/assets/js/sweetalert2.min.js"></script>

    <script>
        let shop_id = 0;
        let shop_price = 0;

        function subscribeShop(id) {
            $.ajax({
                'type': 'GET',
                'url': '/shop/getshopinfo',
                'dataType': 'json',
                'data': {
                    'shop_id' : id
                },
                'success': function (res) {
                    $('#shop-' + id).addClass('active-plan');
                    if (id !== shop_id) {
                        $('#shop-' + shop_id).removeClass('active-plan');
                    }
                    shop_id = id;
                    shop_price = parseFloat(res.price);
    				$('#shop_name').text('商品名称：' + res.name);
    				$('#shop_total').text('套餐金额：' + res.price);
    				$('#shop_stneed').text('实际支付：' + res.price);
    				$("#order_modal").modal();
                }
            });
        }
        let tid = 0;
        
        function payShop() {
            if (!$("#email").val() || !$("#passwd").val()) {
                swal('', '请输入邮箱和密码~！', 'info');
                return false
            }
            let email = $("#email").val();
            let passwd = $("#passwd").val();
            let type = $('.cursor_onclick .active').attr('data-name');
            
            console.log(type, shop_price)
            
            $.ajax({
                'type': 'POST',
                'url': '/shop/purchase',
                'dataType': 'json',
                'data': {
                    'email': email,
                    'passwd': passwd,
                    'shop': shop_id,
                    'price': shop_price,
                    'type': type,
                },
                'success': function (res) {
                    if (res['ret']) {
                        $.ajax({
                            'type': 'POST',
                            'url': '/user/payment/purchase',
                            'dataType': 'json',
                            'data': {
                                'price': shop_price,
                                'type': type,
                            },
                            'success': function (res) {
                    			if (res['ret']) {
                    				var url = ((document.location.toString()).split("#")[0]).split('?')[0];
                    				var user_location = ((url.split("//")[1]).split("/"))[2];
                    				if (res['type'] == 'url') {
                    					if (user_location == 'code') {
                    					  window.location.href = res['url'];
                    					} else {
                    					  $('#coolpay-modal').modal('show');
                    					  $('#to-coolpay').attr("href", res['url']);
                    					}
                    				} else if (res['type'] == 'qrcode') {
                    					var url = encodeURIComponent(res['url'])
                    					var redirect_url = '/user/qrcode?type='+type+'&qrcode='+url+'&tradeno='+data.tradeno+'&price='+price;
                    					if (user_location == 'code') {
                    					  window.location.href = redirect_url; //  qrcode to url
                    					} else {
                    					  $('#coolpay-modal').modal('show');
                    					  $('#to-coolpay').attr("href", redirect_url); // qrcode to url
                    					}
                    				}
                    				tid = setTimeout(checkMoney, 1000);
                    			} else {
                    				Swal.fire(
                    					'发生错误',
                    					res.msg,
                    					'error'
                    				)
                    			}
                            },
                            'error': function (error) {
                                Swal.fire('发生错误', '请联系客服', 'error');
                            }
                        });
                    } else {
                        Swal.fire('发生错误', res['msg'], 'error');
                    }
                },
                'error': function (error) {
                    Swal.fire('发生错误', '请联系客服', 'error');
                }
            });
        }
        
        function checkMoney() {
            $.ajax({
                'type': 'GET',
                'url': '/user/money',
                'dataType': 'json',
                'async': false,
                'success': function (res) {
                    if (res['ret']) {
                        if (parseFloat(res['money']) >= parseFloat(shop_price)) {
                            clearTimeout(tid);
                            $.ajax({
                                'type': 'POST',
                                'url': '/user/buy',
                                'dataType': 'json',
                                'data': {
                                    'coupon': '',
                                    'shop': shop_id,
                                    'autorenew': 0,
                                    'disableothers': 1
                                },
                                'success': function (res) {
                                    if (res['ret']) {
                                        swal({
                                            'type': 'success', 'title': '购买成功', 'onClose': () => {
                                                window.location.assign('/user');
                                            }
                                        });
                                    } else {
                                        Swal.fire('发生错误', res['msg'], 'error');
                                    }
                                },
                                'error': function (error) {
                                    Swal.fire('发生错误', '请联系客服', 'error');
                                }
                            });
                        }
                    }
                },
                'error': function (error) {
                    Swal.fire('发生错误', '请联系客服', 'error');
                }
            });
            tid = setTimeout(checkMoney, 1000);
        }
        
    </script>    
    
</body>
<!-- END: Body-->
</html>