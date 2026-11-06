<!DOCTYPE html>
  <html lang="zh-CN">
   <head> 
    <title>商店 — {$config["appName"]}</title> 
	{include file='user/header.tpl'}
	<link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/page/shop.css">

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-8 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">商店</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb shop-navigate">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/shop">Store</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                {if $Cool_Config['shop_enable_traffic_package'] == true && $user->class > 0}
	                <a class="btn btn-primary btn-icon icon-left waves-effect waves-light right traffic-style" data-toggle="modal" data-target="#traffic_package_modal"><i class="fas fa-gas-pump"></i> 流量包购买</a>
	            {/if}
                {if $config['quantit_show'] == true}
                    <a class="btn btn-primary btn-icon icon-left waves-effect waves-light right byvolum-style" data-toggle="modal" data-target="#Byvolume-modal"><i class="fab fa-paypal"></i> 按量付费</a>
                {/if}
            </div>
			<div class="row">
			
			{if $Cool_Config['show_shop_head'] == true}
                <div class="col-12">
                    <div class="card offer-box">
                        <div class="card-body p-0 bg-primary" style="border-radius:10px">
                            <div class="offer-slider">
                                <div class="carousel slide">
                                    <div class="selling-slide row" onclick="window.open('/user/invite','_self')">
                                        <div class="col-xl-4 col-md-6">
                                            <div class="d-flex">
                                                <div class="left-content" style="margin-left:1rem">
                                                    <p>邀请好友注册返现</p>
                                                    {if $config['code_payback'] > 0}
                                                        <h2 class="f-w-600" style="color:#FFFFFF;margin:1rem 0 1rem 0">获得TA的充值 <b>{if $user->rebate > 0}{$user->rebate}%{else}{$config["code_payback"]}%{/if}</b> 的返利</h2>
                                                    {/if}
                                                    <span class="badge badge-white rounded-pill">满100元</span>
                                                    <span class="badge badge-dotted rounded-pill ms-2 ">可提现 💰</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-12 shop_img">
                                            <div class="center-img tada animated"><img class="img-fluid" src="/theme/cool/assets/images/pages/rocket.png"></div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="d-flex">
                                                <div class="right-content">
                                                    <p>发送邀请链接给好友🏃</p>
                    	                            {if $config['invite_gift'] > 0}
                                                        <h2 class="f-w-600" style="color:#FFFFFF;margin:10px 0 10px 0">您将一次性获得 <b>{$config['invite_gift']}GB</b> 奖励</h2>
                                                    {/if}
                                                    {if $config['invite_get_money'] > 0}
                                                        <span class="badge badge-white rounded-pill">TA将获得 <b>{$config["invite_get_money"]}</b> 元奖励作为初始资金</span>
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
            
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body">
                            <ul class="nav nav-tabs border-tab shop_tab" role="tablist" style="border-bottom: 1px solid #dee2e6;">
                            {foreach $Cool_Config['shop_plan'] as $shop_class_name => $shop_info_time_id}
                                <li class="nav-item">
                                  <a class="nav-link {if $shop_info_time_id@index === 0} active{/if}" id="top-home-tab" data-toggle="tab" href="#top-home-{$shop_class_name}" aria-controls="home" role="tab" aria-selected="true"><i class="fa fa-ravelry"></i> <span style="word-break: keep-all">{$shop_class_name}</span></a>
                                </li>
                            {/foreach}
                            
                                {if $Cool_Config['shop_redeem'] == true}
                                    <li class="nav-item">
                                      <a class="nav-link" id="top-home-tab" data-toggle="tab" href="#top-home-meal" aria-controls="home" role="tab" aria-selected="true"><i class="feather icon-gift"></i> <span style="word-break: keep-all">套餐兑换</span></a>
                                    </li>
                                {/if}
                            </ul>
                            <div class="tab-content" id="top-tabContent">
                            {foreach $Cool_Config['shop_plan'] as $shop_class_name => $shop_info_time_id}
                                {foreach $shop_info_time_id as $shop_info => $shop_time_id}
                                <div class="tab-pane fade {if $shop_info_time_id@index === 0} active show{/if}" id="top-home-{$shop_class_name}" role="tabpanel" aria-labelledby="top-home-tab">
                                    <div class="row" style="padding: 1.5rem">
                                        <div class="col-sm-12">
                                            <div class="tab-content" id="top-tabContent">
                                                <div class="row">
                                                
                                                    {foreach $shop_time_id as $shop_time => $shop_id}
                                                        {foreach $shops as $shop}
                                                        {if $shop->id !== $shop_id}{continue}{/if}
                                                            <div class="col-md-4 pb-1">
                                                                <div class="pricing-card p-30 b-primary shadow shadow-showcase">
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
                                                                        <li>套餐流量: <b>{$shop->bandwidth()} GB</b></li>
                                                                        <li>会员等级: <b>[Lv.{$shop->user_class()}] 会员</b></li>
                                                                        <li>等级时长: <b>{$shop->class_expire()} 天</b></li>
                                                                        <li>同时在线: <b>{if {$shop->connector()} == '0' }无限制{else}{$shop->connector()}个设备{/if}</b></li>
                                                                        <li>端口速率: <b>{if {$shop->speedlimit()} == '0' }无限制{else}{$shop->speedlimit()}Mbps{/if}</b></li>
                                                                        <li>账号时长: <b>{$shop->expire()} 天</b></li>
                                                                        <li>重置周期: <b>{if $shop->reset()!=0}{$shop->reset()}天重置{else}到期清零{/if}</b></li>
                                                                    </ul>
                                                                    <div class="text-center mt-3">
                                                                        <button class="btn btn-primary" type="button" onclick="{if $user->quantitypay == '1'}nobuy(){else}buy('{$shop->id}',{$shop->auto_renew}){/if}">立即订阅</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        {/foreach}
                                                    {/foreach}
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/foreach}
                            {/foreach}
                            
                            {if $Cool_Config['shop_redeem'] == true}
                                <!-- 套餐兑换 -->
                                <div class="tab-pane fade" id="top-home-meal" role="tabpanel" aria-labelledby="top-home-tab">
                                        <div class="row" style="padding: 0.5rem">
                                            <div class="col-sm-12">
                                                <div class="tab-content" id="top-tabContent">
                                                    <h3 class="modal-title mb-1"><strong>套餐兑换</strong></h3>
                                                    <p class="txt-secondary">通过发放的套餐兑换码,可以在此页面兑换成相应套餐<code>（兑换码可通过购买、活动获得）</code></p>
                                                    <div class="form-group mt-1">
                                                        <label class="form-control-label h5">兑换码</label>
                                                        <input type="text" class="form-control" id="code_goods">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-info waves-effect" onclick="Readeem()">兑换</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            
                        </div>
                    </div>
                </div>
			</div>

				<!--coupon modal-->
			    <div class="modal fade" id="coupon_modal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 id="couponModalLabel" class="ls-2">你有优惠码吗?</h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				    	<div id="dailymail-modal-body-content"> 
				    		<p>有的话,请在这里输入</p>
				    		<p>没有的话, 直接确定吧</p> 
							<div class="form-group">
								<label class="form-control-label">输入你的优惠码&nbsp;:&nbsp;</label>
								<input id="coupon" class="form-control" type="text">
							</div>	
						</div>
				      </div>
					  <div class="modal-footer">
		                    <button type="button" class="btn btn-primary" onclick="updateCoupon()">确认提交</button>
		               </div>
				    </div>
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
							    <p><font color="red">如您是更换套餐,那剩余流量和有效期将会重置。</font></p> 
                                <label class="row col-12 col-form-label" id="shop_name"></label>
                                <label class="row col-12 col-form-label" id="shop_credit">优惠额度：</label>
                                <label class="row col-12 col-form-label" id="shop_total"></label>
                                <label class="row col-12 col-form-label" id="shop_stneed"></label>
								<fieldset class="checkbox" id="disableo">
	                                <div class="vs-checkbox-con vs-checkbox-primary">
	                                    <span>到期时自动续费：</span>
	                                    <input type="checkbox" id="autorenew">
	                                    <span class="vs-checkbox">
	                                        <span class="vs-checkbox--check">
	                                            <i class="vs-icon feather icon-check"></i>
	                                        </span>
	                                    </span>
	                                </div>
	                            </fieldset>
	                            
	                            <!--pay system-->
                	            <div class="form-group row form-group-marginless" style="display: none" id="shop_payment">
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
                                <button type="button" class="btn btn-primary" data-dismiss="modal" id="pay-confirm">确定</button> 
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button> 
							 </div> 
						</div> 
					</div> 
				</div> 
				
				{if $config['quantit_show'] == true}
					<div class="modal fade" id="Byvolume-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> 
						<div class="modal-dialog modal-dialog-centered" role="document"> 
							<div class="modal-content shadow-lg">
								<div class="modal-header">
									<h4 class="modal-title"><strong>{if $user->quantitypay == '0'}启用{else}关闭{/if}按量付费</strong></h4> 
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						        		<span aria-hidden="true">&times;</span>
						        	</button>
								</div> 
								<div class="modal-body"> 
									{if $user->quantitypay == '0'}
										<p>启用按量付费后,您可获得<code>Level {$config['quantit_class']}</code>等级权限,按量付费价格为<code>{$config['quantit_money']}RMB/1G</code>,速度限制为<code>{$config['quantit_speedlimit']}Mbps</code>,限制<code>{$config['quantit_connector']}个</code>设备同时在线,系统自动按您使用的流量在余额中扣费,请确保您有足够的余额。</p>
										{if $config['quantit_shop'] == true }
    										<p>
    											<div style="display:inline">为了保障稳定性,按量付费需您购买过正常套餐（不包括试用套餐）后才可启用。按量付费启用后</div>
    											<div style="color:red; display:inline">您的当前套餐将会失效且流量将会被重置,且启用期间您的账户签到将不能获得流量</div>
    											<div style="display:inline">,请您留意。</div>
    										</p>
    									{/if}
									{else}
										<p>关闭按量付费后,您的账号将被重置。</p>
									{/if}
								</div> 
								<div class="modal-footer"> 
									<button type="button" class="btn btn-info waves-effect buyTrafficPackage" onclick="payasyougo()">确认{if $user->quantitypay == '0'}启用{else}关闭{/if}</button> 
									<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button> 
								</div> 
							</div> 
						</div> 
					</div>
				{/if}
				
				{if $Cool_Config['shop_enable_traffic_package'] == true && $user->class > 0}
    				<!--traffic_package modal-->
    				<div class="modal fade" id="traffic_package_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    				    <div class="modal-dialog modal-dialog-centered" role="document">
    				        <div class="modal-content shadow-lg">
    				            <div class="modal-header">
    				                <h4 class="modal-title"><strong>购买流量叠加包</strong></h4>
    				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
    				                    <span aria-hidden="true">&times;</span>
    				                </button>
    				            </div>
    				            <div class="modal-body">
    				                <code>流量叠加包在您套餐流量重置时会一起清零,请酌情购买</code>
    				                <div class="mb-2"></div>
    				                <p class="description">购买单位: GB （最小单位 <code>50</code> GB）</p>
    				                <div class="input-group input-group-lg bootstrap-touchspin mb-2">
    				                    <span class="input-group-btn input-group-prepend bootstrap-touchspin-injected"></span>
    				                    <input type="number" class="touchspin-step form-control" value="50">
    				                    <span class="input-group-btn input-group-append bootstrap-touchspin-injected"></span>
    				                </div>
    				                <div class="form-group mt-1">
    				                    <label class="form-control-label">购买价格:（元）</label>
    				                    <input id="traffic_price_1" type="hidden" value="{$Cool_Config['shop_traffic_package']}">
    				                    <input id="traffic_price_2" class="form-control" type="num" disabled required>
    				                </div>
    				                <div class="custom-control custom-radio mb-2">
    				                    <input type="hidden" id="user_money1" value="{$user->money}">
    				                    <input type="radio" id="pay_code1" name="customRadio" class="custom-control-input" checked>
    				                    <label id="pay_text1" class="custom-control-label" for="pay_code1">余额支付: {$user->money}</label>
    				                </div>
    				                <div class="modal-footer">
    				                    <button type="button" class="btn btn-info waves-effect buyTrafficPackage" onclick="buyTrafficPackage()">购买</button>
    				                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
    				                </div>
    				            </div>
    				        </div>
    				    </div>
    			    </div>
				{/if}
				
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
                                      支付到账需要一段时间,请勿关闭或刷新此页面
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <a id="to-coolpay" href="##" class="btn btn-primary">继续支付</a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                
			</div> 
		</div>
    <!-- END: Content-->

    <!-- BEGIN: Footer-->
		{include file='user/footer.tpl'}
    <!-- END: Footer-->
	<script src="/theme/cool/assets/js/scripts/jquery.bootstrap-touchspin.js"></script>
	<script src="/theme/cool/assets/js/scripts/number-input.js"></script>
	
    <script>
        var userMoney = '{$user->money}';
        var paymentSystem = "{$config['payment_system']}";
        var payment = $('.cursor_onclick .active').attr('data-name');
    	function buy(id,auto) {
    	    shop = id;
    	    $("#coupon_modal").modal();
    	}
	</script>
	
	<script>
        function nobuy() {
           Swal.fire({ type: "error",title: '请注意',html: '按量付费不允许购买套餐' });
    	}
    	
    	{if $Cool_Config['shop_enable_traffic_package'] == true && $user->class > 0}
	    	$(function () {
		    	$(".count_price").click(function () {
		    		var a_1 = $('#traffic_price_1').val();
		    		var b_1 = $('.touchspin-step').val();
		    		document.getElementById('traffic_price_2').value = b_1 * a_1;
		    	});
			});
			window.onload=function(){
				var a_1 = $('#traffic_price_1').val();
				var b_1 = $('.touchspin-step').val();
				document.getElementById('traffic_price_2').value = b_1 * a_1;
			}
		{/if}
    </script>
    
</body>
</html>