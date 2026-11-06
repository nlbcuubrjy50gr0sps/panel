<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>流媒体解锁 — {$config["appName"]}</title>
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
                            <h2 class="content-header-title float-left mb-0">流媒体解锁</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/media">Media</a>
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
                                        <p>您可以在这里查看节点的流媒体解锁情况。</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">列表</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        {if count($results) == 0}
                                            <div class="text-center" style="transform:translateY(-10%);">
                                                <img src="/theme/cool/assets/images/nothing.png" width="200"><p>什么都没有...</p>
                                            </div>
                                        {else}
                                            <div class="table-responsive">
                                                <table class="table table-hover-animation mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th>节点</th>
                                                            {foreach $results['0']['unlock_item'] as $key => $value}
                                                                {if $key != 'BilibiliChinaMainland'}
                                                                    {if $key == 'BilibiliHKMCTW'}
                                                                        <th>港澳台B站</th>
                                                                    {else if $key == 'BilibiliTW'}
                                                                        <th>台湾B站</th>
                                                                    {else}
                                                                        <th>{$key}</th>
                                                                    {/if}
                                                                {/if}
                                                            {/foreach}
                                                            <th>更新时间</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {foreach $results as $result}
                                                            <tr>
                                                                <td>{$result['node_name']}</td>
                                                                <td>{$result['unlock_item']['YouTube']}</td>
                                                                <td>{$result['unlock_item']['Netflix']}</td>
                                                                <td>{$result['unlock_item']['DisneyPlus']}</td>
                                                                <td>{$result['unlock_item']['BilibiliHKMCTW']}</td>
                                                                <td>{$result['unlock_item']['BilibiliTW']}</td>
                                                                <td>{$result['unlock_item']['MyTVSuper']}
                                                                <td>{$result['unlock_item']['BBC']}</td>
                                                                <td>{$result['unlock_item']['Abema']}</td>
                                                                <td>{date('Y-m-d H:i:s', $result['created_at'])}</td>
                                                            </tr>
                                                        {/foreach}
                                                    </tbody>
                                                </table>
                    		                    {if count($results) != 0}
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
    <script>
        $("td:contains('Yes')").css("color", "green");
        $("td:contains('No')").css("color", "red");
        $("td:contains('Unknow')").css("color", "orange");
        $("td:contains('仅限自制')").css("color", "purple");
    </script>
    </body>
</html>