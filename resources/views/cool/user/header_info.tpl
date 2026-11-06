	<meta charset="UTF-8" /> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/style-{$Cool_Config['theme_style_color']}.css">
	<!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/sweetalert2.min.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/core/colors/palette-gradient.css">
    <!-- END: Page CSS-->
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="horizontal-layout horizontal-menu navbar-floating footer-static" data-open="hover" data-menu="horizontal-menu" data-col="">

    <!-- BEGIN: Header-->
    <nav class="header-navbar navbar-expand-lg navbar navbar-fixed align-items-center navbar-shadow navbar-brand-center" data-nav="brand-center">
        <div class="navbar-header d-xl-block d-none">
            <ul class="nav navbar-nav flex-row">
                <li class="nav-item">
	            	<a class="navbar-brand" href="/user">
	                    <div class="brand-logo"></div>
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
						<ul class="nav navbar-nav bookmark-icons">
                            <li class="nav-item d-none d-lg-block"><a class="nav-link" href="/user/shop" data-toggle="tooltip" data-placement="top" title="" data-original-title="购买套餐">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-bag"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                            </a></li>
                        </ul>
                        <ul class="nav navbar-nav">
                            <li class="nav-item d-none d-lg-block"><a class="nav-link"  {if $Cool_Config['document_type'] == 'sspanel'}href="/doc/"{else} href="/user/help" {/if} data-toggle="tooltip" data-placement="top" data-original-title="下载与使用教程">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-book-open"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path></svg>
                            </a></li>
                        </ul>
                    </div>
                	<ul class="nav navbar-nav float-right">
                        <li class="dropdown dropdown-notification nav-item">
                            <a href="#" data-toggle="dropdown" id="tongzhi" class="nav-link notification-toggle nav-link-lg"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bell"><path d="M22 17H2a3 3 0 0 0 3-3V9a7 7 0 0 1 14 0v5a3 3 0 0 0 3 3zm-8.27 4a2 2 0 0 1-3.46 0"></path></svg>
                            </a>
							<div class="dropdown-menu dropdown-list dropdown-menu-right">
					          <div class="dropdown-header">温馨提示
					            {*<div class="float-right">
					              <a href="#" onclick="aready()">知道了</a>
					            </div>*}
					          </div>
					          <div class="dropdown-list-content dropdown-list-icons">
					            <a href="/user/announcement" class="dropdown-item dropdown-item-unread">
					              <div class="dropdown-item-icon bg-primary text-white">
					                <i class="fas fa-code"></i>
					              </div>
					              <div class="dropdown-item-desc">
					                查看公告日志!
					                <div class="time text-primary">{$time}</div>
					              </div>
					            </a>
					            {if $user->lastSsTime() == '从未使用过' and $user->class>=0}
					            <a href="/doc/#/" class="dropdown-item">
					                  <div class="dropdown-item-icon bg-info text-white">
					                    <i class="fas fa-bell"></i>
					                  </div>
					                  <div class="dropdown-item-desc">
					                    无从下手？<b>点我下载客户端或查看教程</b>，轻松上手！
					                    <div class="time">{$time}</div>
					                  </div>
					                </a>
					            {/if}
					            {if substr($user->unusedTraffic(),0,-2) <= 0 and $user->class != 0}
					            <a href="/user/shop" class="dropdown-item">
					              <div class="dropdown-item-icon bg-danger text-white">
					                <i class="fas fa-exclamation-triangle"></i>
					              </div>
					              <div class="dropdown-item-desc">
					                您的流量已用尽，无法继续使用本站服务。如需更多流量，请前往商店购买流量加油包。
					                <div class="time">{$time}</div>
					              </div>
					            </a>
					            {/if}
					            {if $user->class == 0}
					            <a href="/user/shop" class="dropdown-item">
					              <div class="dropdown-item-icon bg-danger text-white">
					                <i class="fas fa-exclamation-triangle"></i>
					              </div>
					              <div class="dropdown-item-desc">
					                您的会员计划已过期，请及时到商店购买。
					                <div class="time">{$time}</div>
					              </div>
					            </a>
					            {/if}
					            {if substr($user->unusedTraffic(),0,-2) <= 5 && substr($user->unusedTraffic(),0,-2) > 0 && {substr($user->unusedTraffic(),-2)} == 'GB'}
					            <a href="/user/shop" class="dropdown-item">
					              <div class="dropdown-item-icon bg-danger text-white">
					                <i class="fas fa-exclamation-triangle"></i>
					              </div>
					              <div class="dropdown-item-desc">
					                您的可用流量不足5GB，如需更多流量，可前往会员商店购买套餐或流量加油包。
					                <div class="time">{$time}</div>
					              </div>
					            </a>
					            {/if}
					            {if $class_left_days < 5 && substr($user->unusedTraffic(),0,-2) > 5}
					            <a href="/user/shop" class="dropdown-item">
					              <div class="dropdown-item-icon bg-danger text-white">
					                <i class="fas fa-exclamation-triangle"></i>
					              </div>
					              <div class="dropdown-item-desc">
					                您的套餐即将到期，请及时到商店续费或购买套餐。
					                <div class="time">{$time}</div>
					              </div>
					            </a>
					            {/if}
					          </div>
					        </div>
                        </li>
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                            <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600">{$user->user_name}</span><span class="user-status">{$user->email}</span></div><span><img class="round" src="{$user->gravatar}" alt="avatar" height="40" width="40"></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right">
                            	<a class="dropdown-item" href="/user/profile"><i class="feather icon-user"></i> 我的账号</a>
                            	<a class="dropdown-item" href="/user/code"><i class="feather icon-credit-card""></i> 我的背包</a>
                            	<a class="dropdown-item" href="/user/invite"><i class="feather icon-paperclip"></i> 推荐计划</a>
                            	{if $user->is_admin}
                            		<a class="dropdown-item" href="/admin"><i class="feather icon-message-square"></i> 管理中心</a>
                            	{/if}
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="/user/logout"><i class="feather icon-power"></i> 退出登录</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <!-- END: Header-->

    <!-- BEGIN: Main Menu-->
    <div class="horizontal-menu-wrapper">
        <div class="header-navbar navbar-expand-sm navbar navbar-horizontal floating-nav navbar-light navbar-shadow menu-border" role="navigation" data-menu="menu-wrapper" data-menu-type="floating-nav">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mr-auto">
                    	<a class="navbar-brand" href="/user">
                            <div class="brand-logo"></div>
                            <h2 class="brand-text mb-0">{$Cool_Config['small_brand']}</h2>
                        </a>
                    </li>
                    <li class="nav-item nav-toggle">
                    	<a class="nav-link modern-nav-toggle pr-0" data-toggle="collapse">
                    		<i class="feather icon-x d-block d-xl-none font-medium-4 primary toggle-icon"></i>
                    		<i class="toggle-icon feather icon-disc font-medium-4 d-none d-xl-block collapse-toggle-icon primary" data-ticon="icon-disc"></i>
                    	</a>
                	</li>
                </ul>
            </div>
            <!-- Horizontal menu content-->
            <div class="navbar-container main-menu-content" data-menu="menu-container">
                <ul class="nav navbar-nav sidebarnav" id="main-menu-navigation" data-menu="menu-navigation">
	                <li class="nav-item mr-1"><a href="/user"><i class="feather icon-home"></i><span class="menu-title">首页</span></a></li>
	                <li class="nav-item mr-1"><a href="/user/code"><i class="feather icon-credit-card"></i><span class="menu-title">钱包</span></a></li>
	                <li class="nav-item mr-1"><a href="/user/shop"><i class="feather icon-shopping-cart"></i><span class="menu-title">商店</span></a></li>
	                <li class="nav-item mr-1"><a href="/user/node"><i class="feather icon-server"></i><span class="menu-title">节点列表</span></a></li>
	                
	                {if $config['streaming_media_show'] === true}
	                    <li class="nav-item mr-1"><a href="/user/media"><i class="feather icon-airplay"></i><span class="menu-title">流媒体解锁</span></a></li>
	                {/if}
	                
	                {if $Cool_Config['show_share'] === true}
	                    <li class="nav-item mr-1"><a href="/user/share-account"><i class="feather icon-share-2"></i><span class="menu-title">共享账号</span></a></li>
	                {/if}
	                
                    <li class="dropdown nav-item mr-1" data-menu="dropdown"><a class="dropdown-toggle nav-page" href="#" data-toggle="dropdown"><i class="feather icon-user"></i><span>我的账号</span></a>
                        <ul class="dropdown-menu">
							<li data-menu><a class="dropdown-item" href="/user/invite"><i class="feather icon-paperclip"></i><span class="menu-title">邀请注册</span></a></li>
        	                {if $user->is_admin==1 || $user->is_agent == 1}
        	                	<li data-menu><a class="dropdown-item" href="/user/agent"><i class="feather icon-users"></i><span class="menu-title">代理中心</span></a></li>
        	                {/if}
        	                {if $config['subscribeLog_show'] === true}
        	                    <li data-menu><a class="dropdown-item" href="/user/subscribe_log"><i class="feather icon-align-left"></i><span class="menu-title">订阅记录</span></a></li>
        	                {/if}
							<li data-menu><a class="dropdown-item" href="/user/profile"><i class="feather icon-user"></i><span class="menu-title">账号设置</span></a></li>
							<li data-menu><a class="dropdown-item" href="/user/edit"><i class="feather icon-settings"></i><span class="menu-title">节点设置</span></a></li>
                        </ul>
                    </li>
                    <li class="nav-item mr-1"><a href="/user/ticket"><i class="feather icon-headphones"></i><span class="menu-title">工单系统</span></a></li>
	                <li class="nav-item mr-1"><a href="/user/detect"><i class="feather icon-shield"></i><span class="menu-title">审计系统</span></a></li>
	                <li class="nav-item mr-1"><a href="/user/detect/log"><i class="feather icon-shield-off"></i><span class="menu-title">审计记录</span></a></li>
	                
	                {if $Cool_Config['document_type'] == 'sspanel'}
	                    <li class="nav-item mr-1"><a href="/doc/"><i class="feather icon-book"></i><span class="menu-title">使用教程</span></a></li>
	                {else}
	                    <li class="nav-item mr-1"><a href="/user/help"><i class="feather icon-book"></i><span class="menu-title">使用教程</span></a></li>
	                {/if}
	                <li class="nav-item mr-1"><a href="/user/faq"><i class="feather icon-help-circle"></i><span class="menu-title">常见问题</span></a></li>
	                
	                {if $user->is_admin}
                    	<li class="nav-item"><a href="/admin"><i class="feather icon-settings"></i><span class="menu-title">管理面板</span></a></li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
    <!-- END: Main Menu-->