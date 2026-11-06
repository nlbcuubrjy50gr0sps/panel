<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>邀请中心 — {$config["appName"]}</title>
    {include file='user/header.tpl'}

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">邀请注册</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/invite">Invitation</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
<div class="content-body">
    <div class="row match-height">
        <div class="col-lg-4 col-12">
            <div class="card card-developer-meetup">
                <div class="meetup-img-wrapper rounded-top text-center">
                    <img src="/theme/cool/assets/images/marketing.svg" alt="Meeting Pic" height="170">
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">每邀请一位用户并充值将得到TA的充值金额<code>{if $user->rebate > 0}{$user->rebate}%{else}{$config["code_payback"]}%{/if}</code>的返利</li>
                        <li class="list-group-item">满100元可提现，也可以用于购买服务。</li>
                        <li class="list-group-item">当前返利：<code>{$user->back_money}</code> 
                            <button class="btn btn-sm btn-primary ml-1 waves-effect waves-float waves-light" data-toggle="modal" data-target="#request-withdraw-modal">点击提现</button>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="card card-payment">
                <div class="card-header">
                    <h4 class="card-title">邀请链接</h4>
                </div>
                <div class="card-body">
                
                    <p>剩余可邀请次数：<code>{$user->invite_num}</code> 次</p>
                    <p class="mt-2">邀请他人注册时, 请将以下链接发给被邀请者:</p>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <button class="btn btn-danger waves-effect" type="button" data-toggle="modal" data-target="#reset-invite-modal">重置链接</button>
                        </div>
                        <input type="text" class="form-control" readonly="" value="{$config["baseUrl"]}/auth/register?code={$code->code}">
                        <div class="input-group-append">
                            <button class="copy-text btn btn-primary waves-effect" type="button" data-clipboard-text="{$config["baseUrl"]}/auth/register?code={$code->code}">复制链接</button>
                        </div>
                    </div>
                    
                    {if $config['invite_price']>=0 || $config['custom_invite_price']>=0}
                        {if $config['invite_price']>=0}
                            <p class="mt-2">购买邀请次数 <code>{$config['invite_price']}</code> 元 / 次：</p>
                            <div class="input-group">
                                <input id="buy-invite-num" type="text" class="form-control" placeholder="请输入需要购买的次数">
                                <div class="input-group-append">
                                    <button class="btn btn-success waves-effect" type="button" onclick="buy_Invite()">确认购买</button>
                                </div>
                            </div>
                        {/if}
                        
                        {if $config['custom_invite_price']>=0}
                            <p class="mt-2">定制链接后缀 <code>{$config['custom_invite_price']}</code> 元 / 次：</p>
                            <div class="input-group">
                                <input id="custom-invite-link" type="text" class="form-control" placeholder="输入链接后缀">
                                <div class="input-group-append">
                                    <button class="btn btn-warning waves-effect" type="button" onclick="custom_invite_confirm()">确认定制</button>
                                </div>
                            </div>
                        {/if}
                    {/if}
                    
                </div>
            </div>
        </div>
        
        <div class="col-lg-4 col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">邀请记录</h4>
                </div>
                <div class="card-content">
                    <div class="card-body">
                        {if count($invite_user) == 0}
                            <div class="text-center" style="transform:translateY(-10%);">
                                <img src="/theme/cool/assets/images/nothing.png" width="200"><p>什么都没有...</p>
                            </div>
                        {else}
                            <div class="table-responsive">
                                <table class="table table-hover-animation mb-0">
                                    <thead>
                                        <tr>
                                            <th><strong>被邀请用户ID</strong></th>
                                            <th><strong>用户邮箱</strong></th>
                                            <th><strong>注册时间</strong></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $invite_user as $invite_users}
                                            <tr>
                                                <td>{$invite_users->id}</td>
                                                <td>{$invite_users->email}</td>
                                                <td>{$invite_users->reg_date}</td>
                                            </tr> 
                                        {/foreach} 
                                    </tbody>
                                </table>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">返利记录</h4>
                </div>
                <div class="card-content">
                    <div class="card-body">
                        {if count($paybacks) == 0}
                            <div class="text-center" style="transform:translateY(-10%);">
                                <img src="/theme/cool/assets/images/nothing.png" width="200"><p>什么都没有...</p>
                            </div>
                        {else}
                            <div class="table-responsive">
                                <table class="table table-hover-animation mb-0">
                                    <thead>
                                        <tr>
                                            <th><strong>被邀ID</strong></th>
                                            <th><strong>获得返利</strong></th>
                                            <th><strong>返利时间</strong></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       {foreach $paybacks as $payback}
                                            <tr>
                                                <td>{$payback->userid}</td>
                                                <td>{$payback->ref_get} 元</td>
                                                <td>{date('Y-m-d H:i:s', $payback->datetime)}</td>
                                            </tr> 
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</div>

        </div>
    </div>
    
    <!-- 工单提现 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="request-withdraw-modal" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">创建提现申请</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p>由于安全原因，当前仅接受拥有有效套餐的用户的提现申请<br /><br />通过 &middot; <a href="/user/ticket">工单支持</a> &middot; 来进行提现<br /><br />工单内容请填写准确的收款支付宝账号+提现金额<br /><br />当您申请提现后,我们会在1天内处理您的提现申请并回复</p>
                    </div>
                </div>
                <div class="modal-footer bg-whitesmoke br">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 重置链接 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="reset-invite-modal">
        <div class="modal-dialog modal-dialog-centered modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">重置邀请链接</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>确定要重置邀请链接吗？点击确定后会重置并自动刷新本页。</p>
                </div>
                <div class="modal-footer bg-whitesmoke br">
                    <a type="button" class="btn btn-primary" style="color:white" id="reset-link">确定</a>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <!-- BEGIN: Footer-->
    {include file='user/footer.tpl'}
    <!-- END: Footer-->

    </body>
</html>