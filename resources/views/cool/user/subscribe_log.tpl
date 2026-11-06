<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>订阅记录 — {$config["appName"]}</title>
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
                            <h2 class="content-header-title float-left mb-0">订阅记录</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/subscribe_log">Subscribe</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-body">
                <!-- account setting page start -->
                <section id="page-account-settings">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <div class="alert-text">
                                        <p>您可在此查询您账户所有的订阅记录，确保您的账户没有被盗用。</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">记录</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        {if count($logs) == 0}
                                            <div class="text-center" style="transform:translateY(-10%);">
                                                <img src="/theme/cool/assets/images/nothing.png" width="200"><p>什么都没有...</p>
                                            </div>
                                        {else}
                                            <div class="table-responsive">
                                                <table class="table table-hover-animation mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>订阅类型</th>
                                                            <th>IP</th>
                                                            <th>归属地</th>
                                                            <th>时间</th>
                                                            <th>User-Agent</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {foreach $logs as $log}
                                                            <tr>
                                                                <td>#{$log->id}</td>
                                                                <td>{$log->subscribe_type}</td>
                                                                <td>{$log->request_ip}</td>
                                                                {assign var="location" value=$iplocation->getlocation($log->request_ip)}
                                                                <td>{iconv("gbk", "utf-8//IGNORE", $location.country)} {iconv("gbk", "utf-8//IGNORE", $location.area)}</td>
                                                                <td>{$log->request_time}</td>
                                                                <td>{$log->request_user_agent}</td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                    		                    {if count($logs) != 0}
                        		                    <div class="pagination float-right">
                        		                        {$render}
                        		                    </div>
                    		                    {/if}
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <!-- BEGIN: Footer-->
    {include file='user/footer.tpl'}
    <!-- END: Footer-->

    </body>
</html>