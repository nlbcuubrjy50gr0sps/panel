<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>常见问题 — {$config["appName"]}</title>
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
                            <h2 class="content-header-title float-left mb-0">常见问题</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/help">FAQ</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <section>
                    <div class="card faq-search" style="background-image: url('/theme/cool/assets/images/pages/banner.png')">
                        <div class="card-body text-center">
                            <!-- main title -->
                            <h2 class="text-primary">常见问题解答</h2>
                            <!-- subtitle -->
                            <p class="card-text mb-2">尝试选择对应问题的类目，获取你要的答案</p>
                            <!-- search input -->
                            <form class="faq-search-input">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                    <span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></span>
                                    </div>
                                    <input type="text" class="form-control" id="searchbar" placeholder="输入问题关键字...">
                                </div>
                            </form>
                        </div>
                    </div>
                </section>
                
                <section id="faq-tabs">
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-12">
                            <div class="faq-navigation d-flex justify-content-between flex-column mb-2 mb-md-0">
                                <img src="/theme/cool/img/faq-illustrations.svg" class="img-fluid d-none d-md-block">
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-8 col-sm-12">
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar avatar-tag bg-light-primary mr-1">
                                            <i class="feather icon-credit-card font-medium-4"></i>
                                        </div>
                                        <div>
                                            <h4 class="mb-0">常见问题</h4>
                                        </div>
                                    </div>
                                    <div class="collapse-margin collapse-icon mt-2" id="faq-qna">
		                                {if count($faq) == 0}
		                                    <p>无问题记录</p>
		                                {else}
    		                                {foreach $faq as $help}
    		                                <div class="card faq-cont">
                                                <div class="card-header" id="{$help->id}" data-toggle="collapse" role="button" data-target="#faq-{$help->id}" aria-expanded="false" aria-controls="faq-{$help->id}">
                                                    <span class="lead collapse-title">问 : {$help->title}</span>
                                                </div>
                                                <div id="faq-{$help->id}" class="collapse" aria-labelledby="18" data-parent="#faq-qna">
                                                    <div class="card-body">答 : {$help->content}</div>
                                                </div>
                                            </div>
		                                {/foreach}
		                                {/if}

    					                {$render}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <section class="faq-contact">
                    <div class="row mt-5 pt-75">
                        <div class="col-12 text-center">
                            <h2>还有其它问题?</h2>
                            <p class="mb-3">如果没有找到你想要问题的答案, 可以通过以下途径进行提问！</p>
                        </div>
                        <div class="col-sm-6">
                            <div class="card text-center faq-contact-card shadow-none py-1">
                                <div class="card-body">
                                    <a href="/user/ticket" class="avatar avatar-tag bg-light-primary mb-2 mx-auto">
                                        <i class="feather icon-grid font-medium-3"></i>
                                    </a>
                                    <h4>工单提问</h4>
                                    <span class="text-body">可通过工单页面发表工单求助</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card text-center faq-contact-card shadow-none py-1">
                                <div class="card-body">
                                    <a href="#" class="avatar avatar-tag bg-light-primary mb-2 mx-auto">
                                        <i class="feather icon-send font-medium-3"></i>
                                    </a>
                                    <h4>在线客服</h4>
                                    <span class="text-body">通过右下角在线客服，快速获取你想要的答案!</span>
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
        var searchbar = $('#searchbar'),
            search_content = $('#faq-qna .faq-cont'),
            no_result = $('#faq-qna .no-result');
  
        searchbar.on('keyup', function () {
            var value = $(this).val().toLowerCase();
            if (value != '') {
                search_content.filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
                var search_row = $('#faq-qna .faq-cont:visible').length;
                
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