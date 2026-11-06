<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>审计规则 — {$config["appName"]}</title>
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
                            <h2 class="content-header-title float-left mb-0">审计规则</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/detect">Audit Rules</a>
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
                                        <p>为了网站的长远发展，也同时为了系统的正常运行，特制定了如下过滤规则，当您使用节点执行这些动作时，您的通信就会被截断。</p>
                                        <p>关于隐私：注意，我们仅用以下规则进行实时匹配和记录匹配到的规则，您的通信方向和通信内容我们不会做任何记录，请您放心。也请您理解我们对于这些不当行为的管理，谢谢！</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">规则</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        {if count($rules) == 0}
                                            <div class="text-center" style="transform:translateY(-10%);">
                                                <img src="/theme/cool/assets/images/nothing.png" width="200"><p>什么都没有...</p>
                                            </div>
                                        {else}
                                            <div class="table-responsive">
                                                <table class="table table-hover-animation">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>名称</th>
                                                            <th>描述</th>
                                                            <th>正则表达式</th>
                                                            <th>类型</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {foreach $rules as $rule}
                                                            <tr>
                                                                <td>#{$rule->id}</td>
                                                                <td>{$rule->name}</td>
                                                                <td>{$rule->text}</td>
                                                                <td>{$rule->regex}</td>
                                                                {if $rule->type == 1}
                                                                <td>数据包明文匹配</td>
                                                                {/if}
                                                                {if $rule->type == 2}
                                                                <td>数据包 hex 匹配</td>
                                                                {/if}
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                    		                    {if count($rules) != 0}
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