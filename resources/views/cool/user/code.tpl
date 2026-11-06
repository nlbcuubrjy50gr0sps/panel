<!DOCTYPE html>
  <html lang="zh-CN">
   <head> 
    <title>我的钱包 — {$config["appName"]}</title>
    
    {include file='user/header.tpl'} 
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/datatables.bootstrap4.min.css">
    <style>
        .btn-radio .custom-control { position: absolute; left: 1.5rem; top: .3rem; }
        .btn-radio .badge-hot { position: absolute; right: 1rem; top: 0; border-radius: 0 .5rem 0 .5rem; padding: .375rem; }
    </style>
    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">我的钱包</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/code">Wallet</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-body">
                <div class="row">
                    <div class="col-lg-2">
                        <ul class="nav nav-pills flex-column nav-left">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="pill" href="#account-vertical-code" aria-expanded="true">
                                    <span class="font-weight-bold">在线充值</span>
                                </a>
                                <a class="nav-link" data-toggle="pill" href="#recharge-code" aria-expanded="true">
                                    <span class="font-weight-bold">充值码</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-lg-5">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">钱包充值</h4>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-secondary" role="alert">
                                    <div class="alert-body font-medium-1">
                                        <div>账户余额：<span class="text-primary">￥{$user->money}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane active" id="account-vertical-code" aria-labelledby="account-pill-code" aria-expanded="true">
                                        <div class="row match-height">
                                            <div class="col-12">充值方式：</div>
                                            <div class="col-md-9 mt-1">
                                                <ul class="nav nav-pills row" role="tablist" id="pay_the">
                                                    {if $config['payment_system'] == 'cool'}
                                                        {if $Cool_Config['pay_alipay'] != 'none' && $Cool_Config['pay_alipay'] != ''}
                                                        <li class="nav-alipay nav-item d-flex col-md-4 cursor_onclick">
                                                            <a class="nav-link border py-10 d-flex flex-grow-1 rounded flex-column align-items-center active" data-toggle="pill" data-name="alipay">
                                                                <span class="nav-icon py-1 w-auto">
                                                                    <i class="fab fa-alipay icon-2x"></i>
                                                                </span>
                                                                <span class="nav-text font-size-lg py-2 font-weight-bold text-center">支付宝</span>
                                                            </a>
                                                        </li>
                                                        {/if}
                                                        {if $Cool_Config['pay_wxpay'] != 'none' && $Cool_Config['pay_wxpay'] != ''}
                                                        <li class="nav-wxpay nav-item d-flex col-md-4 cursor_onclick">
                                                            <a class="nav-link border py-10 d-flex flex-grow-1 rounded flex-column align-items-center {if $Cool_Config['pay_alipay'] == 'none' || $Cool_Config['pay_alipay'] == ''}active{/if}" data-toggle="pill" data-name="wechat">
                                                                <span class="nav-icon py-1 w-auto">
                                                                    <i class="fab fa-weixin icon-2x"></i>
                                                                </span>
                                                                <span class="nav-text font-size-lg py-2 font-weight-bold text-center">微信支付</span>
                                                            </a>
                                                        </li>
                                                        {/if}
                                                        {if $Cool_Config['pay_crypto'] != 'none' && $Cool_Config['pay_crypto'] != ''}
                                                        <li class="nav-crypto nav-item d-flex col-md-4 cursor_onclick">
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
                                            
                                            <div class="col-12 mt-2">充值金额：</div>
                                            {foreach $Cool_Config['topup_select_list'] as $amount}
                                                <div class="col-xl-4 col-lg-4 col-12 mt-1">
                                                    <label class="btn-radio text-center {if $amount@index === 0}active{/if}">
                                                        <div class="custom-control custom-radio d-none">
                                                            <input type="radio" id="money{$amount}" name="money" value="{$amount}" class="custom-control-input" autocomplete="off" onclick="changeoption();">
                                                            <label class="custom-control-label" for="money{$amount}"></label>
                                                        </div>
                                                        <p class="mb-0 font-medium-3">￥{$amount}</p>
                                                    </label>
                                                </div>
                                            {/foreach}
                                            
                                            <div class="col-xl-12 col-12 mt-1">
                                                <label class="btn-radio text-center" for="money0">
                                                    <div class="custom-control custom-radio d-none">
                                                        <input type="radio" id="money0" name="money" value="0" class="custom-control-input" autocomplete="off">
                                                        <label class="custom-control-label" for="money0"></label>
                                                    </div>
                                                    <div class="input-group input-group-merge" style="width: 160px; margin: 0 auto;">
                                                        <span class="input-group-text" style="border: 0; background: transparent; font-size: 1.3rem;">￥</span>
                                                        <input type="text" id="c_number" class="form-control" placeholder="其它金额" oninput="change();" style="border: 0; background: transparent; font-size: 1.3rem;" for="money0">
                                                    </div>
                                                </label>
                                            </div>
                                            <div class="col-12 mt-1">
                                                <div class="d-flex align-items-center">
                                                    <div>支付金额:</div>
                                                    <div class="text-primary ml-50"><sup class="font-medium-1">￥</sup><span class="font-large-1 code_pay">{$Cool_Config['topup_select_list'][0]}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4 mt-1">
                                                <button class="btn btn-primary waves-effect waves-float waves-light" id="topup-confirm">立即充值</button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="tab-pane fade" id="recharge-code" role="tabpanel" aria-labelledby="recharge-code" aria-expanded="false">
                                        <div class="row match-height">
                                            <div class="col-12">
                                                 <h5>充值码</h5>
                                            </div>
                                            <div class="col-md-9 mt-1">
                                    		      <div class="form-group">
                                    		        <input id="pay_code" type="text" class="form-control">
                                    		      </div>
                                            </div>
                                            <div class="col-lg-4 mt-1">
                                              <button class="btn btn-primary waves-effect waves-float waves-light" onclick="codeTopup()">立即充值</button>
                                            </div>
                					    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-5">
                        <div class="card">
                            <div class="card-header">
                                <h4>充值记录</h4>
                                {if $Cool_Config['shop_conversion'] == true}
                                    <a class="btn btn-primary btn-icon icon-left waves-effect waves-light" data-toggle="pill" href="#" aria-expanded="true" onclick="Conversion();">
                                        <span class="font-weight-bold"><i class="fa fa-leaf"></i> 套餐折算</span>
                                    </a>
                                {/if}
                            </div>
                            
                            <div class="card-content">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover-animation mb-0"> 
                                            <thead>
							                  <tr>
                                                <th>ID</th>
                                                <th>类型</th>
                                                <th>操作</th>
                                                <th>使用时间</th>
							                  </tr>
                                            </thead>
                                            <tbody>
                                            {if count($codes) == 0}
                                                <tr>
                                                    <td colspan="4"><strong>无充值记录</strong></td>
                                                </tr>
                                            {else}
                                                {foreach $codes as $code}
                                                    {if $code->type!=-2}
                                                        <tr>
                                                            <td>{$code->id}</td>
                                                            {if $code->type==-1}
                                                                <td>金额充值</td>
                                                            {/if}
                                                            {if $code->type==10001}
                                                                <td>流量充值</td>
                                                            {/if}
                                                            
                                                            {if $code->type==-1}
                                                                <td>{$code->number} 元</td>
                                                            {/if}
                                                            {if $code->type==10001}
                                                                <td>{$code->number} GB 流量</td>
                                                            {/if}

                                                            <td>{$code->usedatetime}</td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                            {/if}
                                            </tbody>
                                        </table>
            		                    {if count($codes) != 0}
                		                    <div class="pagination float-right">
                		                        {$render}
                		                    </div>
            		                    {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <h4>套餐记录</h4>
                            </div>
                            <div class="card-content">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover-animation mb-0"> 
                                            <thead>
							                  <tr>
                                                <th>ID</th>
                                                <th>购买时间</th>
                                                <th>商品名称</th>
                                                <th>价格</th>
                                                <th>续费时间</th>
                                                <th>续费时重置流量</th>
                                                <th>操作</th>
							                  </tr>
                                            </thead>
                                            <tbody>
											{if count($shops) == 0}
							                    <tr>
							                      <td colspan="7"><strong>无购买记录</strong></td>
							                    </tr>
							                {else}
    											{foreach $shops as $shop}
    							                  <tr>
                                                    <td>{$shop->id}</td>
                                                    <td>{$shop->datetime()}</td>
                                                    <td>
                                                        {if !isset($shop->shop()->name)}
                                                            {$shop->coupon}
                                                        {else}
                                                            {$shop->shop()->name}
                                                        {/if}
                                                    </td>
                                                    <td>{$shop->price} 元</td>
                                                    <td>{$shop->renew()}</td>
                                                    <td>{$shop->auto_reset_bandwidth()}</td>
    							                    <td>
    							                        {if $shop->renew==0}
    							                            无操作
    							                        {else}
    							                            <a href="javascript:void(0);" onClick="delete_modal_show('{$shop->id}')" class="btn btn-sm btn-primary">关闭自动续费</a>
    							                        {/if}
    							                    </td>
    							                  </tr>
    											{/foreach}
											{/if}
                                            </tbody>
                                        </table>
            		                    {if count($shops) != 0}
                		                    <div class="pagination float-right">
                		                        {$render1}
                		                    </div>
            		                    {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
            
        {if $Cool_Config['shop_conversion'] == true}
            <!--PackageConversion modal-->
            <div class="modal fade" id="PackageConversion-modal" tabindex="-1" role="dialog" aria-labelledby="deleteidModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">折算确认</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="row col-12 col-form-label" id="zs_name"></label>
                            <label class="row col-12 col-form-label" id="zs_type"></label>
                            <label class="row col-12 col-form-label" id="zs_the"></label>
                            <label class="row col-12 col-form-label" id="zs_ppt"></label>
                            <label class="row col-12 col-form-label" id="zs_used"></label>
                            <label class="row col-12 col-form-label" id="zs_money"></label>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary" id="Conversion_ok" type="button" >确定折算</button>
                            <button class="btn btn-secondary waves-effect waves-float waves-light" type="button" data-dismiss="modal">取消</button>
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
    
    <script>
        $('.tab-content').find('.btn-radio').on('click', function () {
            if ($('.tab-content').find('.btn-radio').hasClass('active')) {
                $('.tab-content').find('.btn-radio').removeClass('active');
            }
            $(this).addClass('active');
        });
        
        $('#c_number').keyup(function(){
            $(this)[0].value=$(this)[0].value.replace(/^(0+)|[^\d]+/g,'')
        })
    </script>
    
    <script>
        function change() {
            $("input[name=money]:checked").attr('checked',false);
            $("#money0").attr("checked","checked");
            $('.code_pay').html($('#c_number').val());
            qian = Math.floor($('#c_number').val()/100) * 10;
            $('.code_number').html($('#c_number').val()*1 + qian);
        }
        
        function changeoption() {
            $('.code_pay').html($("input[name='money']:checked").val());
            qian = Math.floor($("input[name='money']:checked").val()/100) * 10;
            $('.code_number').html($("input[name='money']:checked").val()*1 + qian);
        }
    </script>
    
    <script>
        var paymentSystem = "{$config['payment_system']}";
        $('#topup-confirm').click(function () {
            walletTopup($('.cursor_onclick .active').attr('data-name'));
        })
    </script>
</body>
</html>