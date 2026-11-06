<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>帮助文档 — {$config["appName"]}</title>
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
                            <h2 class="content-header-title float-left mb-0">使用教程</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">使用教程</a>
                                    </li>
                                    <li class="breadcrumb-item">{$doc_c}</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <div class="row">
                
                    {if count($pageDoc) >= 1}
                        <div class="col-lg-3 col-md-5 col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">文章列表</h4>
                                </div>
                                <hr>
                                <div class="card-body" style="padding: 0 1rem 1rem 1rem">
                                        <ul class="list-group list-group-flush">
                                            {foreach $pageDoc as $doc}
                                                <li class="list-group-item" onclick="location='/user/help/view/{$doc->class}/{$doc->id}'">{$doc->title}</li>
                                            {/foreach}
                                        </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-9 col-md-7 col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div id="my-content">
                                        {foreach $doc_id as $doc}
                                            <h4 class="card-title mb-1">
                                                {$doc->title} 使用教程
                                            </h4>
                                            <p class="mb-2">最后更新于 {$doc->add_time}</p>
                                            {$content = str_replace('{$subUrl}{$ssr_sub_token}',$link,$doc->content)}
                                            {$content}
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {else}
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    编写中，有啥好的建议可以反馈给我。
                                </div>
                            </div>
                        </div>
                    {/if}
                    
                </div>
            </div>
            
        </div>
    </div>

    <!-- END: Content-->

    <!-- BEGIN: Footer-->
    {include file='user/footer.tpl'}
    <!-- END: Footer-->
    
    <script src="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/editormd.min.js"></script>
    <script src="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/lib/marked.min.js"></script>
    <script src="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/lib/prettify.min.js"></script>
    <script>
    $(function () {
            editormd.markdownToHTML("my-content");
    })
    </script>
    
    </body>
</html>