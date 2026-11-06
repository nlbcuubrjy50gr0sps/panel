<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>使用教程 — {$config["appName"]}</title>
    {include file='user/header.tpl'}
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/page/page-faq.min.css">
    
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
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/help">Help</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <section id="faq-search-filter">
                    <div class="card faq-search" style="background-image: url('/theme/cool/assets/images/pages/banner.png')">
                        <div class="card-body text-center">
                            <!-- main title -->
                            <h2 class="text-primary">使用教程</h2>
                            <!-- subtitle -->
                            <p class="card-text mb-2">搜索关键字，获取你想要的教程</p>
                            <!-- search input -->
                            <form class="faq-search-input">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                    <span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></span>
                                    </div>
                                    <input type="text" class="form-control" id="searchbar" placeholder="输入标题关键字...">
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
                
                <section id="faq-search-content">
                    <div class="row faq-search-content-info match-height">
                        {foreach $classList_L1 as $list_L1}
                            <div class="col-md-4 col-sm-6 col-12 faq-search-content">
                                <div class="card">
                                    <a href="/user/help/view/{$list_L1->id}">
                                        <div class="card-img-top text-center py-3">
                                            <img src="{$list_L1->li}" width="120">
                                        </div>
                                        <div class="card-body text-center">
                                            <h4>{$list_L1->name}</h4>
                                            <p class="text-body mt-1 mb-0">{$list_L1->explain}</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        {/foreach}
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
        var searchbar = $('#searchbar'),
            search_content = $('.faq-search-content-info .faq-search-content'),
            no_result = $('.faq-search-content-info .no-result');
  
        searchbar.on('keyup', function () {
            var value = $(this).val().toLowerCase();
            if (value != '') {
                search_content.filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
                var search_row = $('.faq-search-content-info .faq-search-content:visible').length;
                
                if(search_row == 0){
                    no_result.removeClass('no-items');
                }else{
                    if (!no_result.hasClass('no-items')) {
                        no_result.addClass('no-items');
                    }
                }
            }else {
              search_content.show();
            }
        });
    </script>
    </body>
</html>