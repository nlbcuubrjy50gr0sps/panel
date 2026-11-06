<!DOCTYPE html>
  <html lang="zh-CN">
   <head> 
    <title>用户中心 — {$config["appName"]}</title> 

	{include file='user/header.tpl'}
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/chart-apex.css">
    <style>
    	.nav-pills .nav-link {
    		font-weight: 500;
    		transition: all .15s ease;
    		box-shadow: 0 4px 6px rgba(50,50,93,.11),0 1px 3px rgba(0,0,0,.08);
    	}
    	
    	.dropdown .btn-group{
    	    margin: 5px;
    	}
    	
    	@media (max-width:575.98px) {
    		.nav-pills .nav-item {
    			margin-bottom: 1rem
    		}
    	}
    	
    	@media (max-width:767.98px) {
    		.nav-pills:not(.nav-pills-circle) .nav-item {
    			padding-right: 0
    		}
    	}

    	@keyframes flame {
          50% {
            -webkit-transform: scale(0.8) rotate(45deg);
                    transform: scale(0.8) rotate(45deg);
          }
        }
    </style>
    <!-- BEGIN: Content-->
   </head>

<body>
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-body">
                <!-- Dashboard Analytics Start -->
                <section id="dashboard-analytics">
                    <div class="row">
                        <div class="col-lg-6 col-md-12 col-sm-12">			  
                            <div class="card bg-analytics text-white">
                                <div class="card-content">
                                    <div class="card-body text-center">
                                        <img src="/theme/cool/assets/images/elements/decore-left.png" class="img-left" alt="card-img-left">
                                        <img src="/theme/cool/assets/images/elements/decore-right.png" class="img-right" alt="card-img-right">
                                        <div class="avatar avatar-xl bg-primary shadow mt-0">
                                            <div class="avatar-content">
                                                <i class="feather icon-award white font-large-1"></i>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <h1 class="mb-2 text-white">Hi, {$user->user_name}</h1>
                                            <p class="m-auto w-75">欢迎使用 <strong>{$config["appName"]}</strong>，期待给您带来优秀的网络加速服务</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
						<div class="col-xl-3 col-md-6">
			              <div class="card card-stats">
			                <!-- Card body -->
			                <div class="card-body">
			                  <div class="row">
			                    <div class="col">
			                    	{if $user->quantitypay == '1'}
			                    	  <span class="h3 font-weight-bold mb-0">按量付费</span>
				                      <h5 class="card-title text-uppercase text-muted mb-0" style="font-size: 14px;">按量付费启用中</h5>
			                    	{else}
				                      <span class="h3 font-weight-bold mb-0">VIP{$user->class}<small> 用户</small></span>
				                      <h5 class="card-title text-uppercase text-muted mb-0" style="font-size: 14px;">到期时间：{$user->class_expire}</h5>
				                    {/if}
			                    </div>
		                        <div class="avatar bg-rgba-primary p-50 m-0">
                                    <div class="avatar-content">
                                        <i class="feather icon-users font-medium-5" style="color:#7367f0"></i>
                                    </div>
                                </div>
			                  </div>
			                </div>
			              </div>
			              <div class="card card-stats">
			                <!-- Card body -->
			                <div class="card-body">
			                  <div class="row">
			                    <div class="col">
			                      <span class="h3 font-weight-bold mb-0">{$user->online_ip_count()} / {if $user->node_connector == 0}∞{else}{$user->node_connector}{/if}</span>
			                      <h5 class="card-title text-uppercase text-muted mb-0" style="font-size: 14px;">在线设备</h5>
			                    </div>
		                        <div class="avatar bg-rgba-warning p-50 m-0">
                                    <div class="avatar-content">
                                        <i class="feather icon-smartphone text-warning font-medium-5"></i>
                                    </div>
                                </div>
			                  </div>
			                </div>
				          </div>
			            </div>
						<div class="col-xl-3 col-md-6">
			              <div class="card card-stats">
			                <!-- Card body -->
			                <div class="card-body">
			                  <div class="row">
			                    <div class="col">
			                      <span class="h3 font-weight-bold mb-0">¥ {$user->money}</span>
			                      <h5 class="card-title text-uppercase text-muted mb-0" style="font-size: 14px;">账户余额 </h5>
			                    </div>
		                        <div class="avatar bg-rgba-success p-50 m-0">
                                    <div class="avatar-content">
                                        <i class="feather icon-credit-card text-success font-medium-5"></i>
                                    </div>
                                </div>
			                  </div>
			                </div>
			              </div>
			              <div class="card card-stats">
			                <!-- Card body -->
			                <div class="card-body">
			                  <div class="row">
			                    <div class="col">
			                      <span class="h3 font-weight-bold mb-0">{if $user->node_speedlimit!=0}{$user->node_speedlimit} <small>Mbps</small>{else}不限{/if}</span>
			                      <h5 class="card-title text-uppercase text-muted mb-0" style="font-size: 14px;">宽带速率</h5>
			                    </div>
		                        <div class="avatar bg-gradient-info p-50 m-0">
                                    <div class="avatar-content">
                                        <i class="feather icon-bar-chart-2 text-gradient-info font-medium-5"></i>
                                    </div>
                                </div>
			                  </div>
			                </div>
				          </div>
			            </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="text-bold-500 mb-25">最新公告</h4>
                                </div>
                                <hr />
                                <div class="card-content">
                                    <div class="card-body">
                                        <div class="row pb-50">
                                            <div class="col-lg-12 col-12 d-flex justify-content-between flex-column order-lg-1 order-2">
                                                <h5 class="font-medium-1">
                                                    <p>{$ann->content}</p>
                                                </h5>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row avg-sessions pt-50">
                                            <div class="col-12">
                                                <p><b><span style="line-height:29px;font-size:14px;float: right;">更新时间：{$ann->date}</span></b></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="text-bold-500 mb-25">使用教程</h4>
                                </div>
                                <hr />
                                <div class="card-content">
                                    <div class="card-body">
                                         <ul class="dashboard-tabs nav nav-pills row nav-primary row-paddingless m-0 p-0" role="tablist">
                                             <li class="nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick"> <a class="nav-link border d-flex flex-grow-1 rounded flex-column align-items-center active" data-toggle="pill" href="#tab_windows"> <span class="nav-icon py-2 w-auto"><i class="fab fa-windows icon-3x"></i></span> <span class="nav-text font-size-lg py-2 font-weight-bold text-center">Windows</span> </a> </li>
                                             
                                             <li class="nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick"> <a class="nav-link border d-flex flex-grow-1 rounded flex-column align-items-center" data-toggle="pill" href="#tab_android"> <span class="nav-icon py-2 w-auto"><i class="fab fa-android icon-3x"></i></span> <span class="nav-text font-size-lg py-2 font-weight-bold text-center">Android</span> </a> </li>
                                             
                                             <li class="nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick"> <a class="nav-link border d-flex flex-grow-1 rounded flex-column align-items-center" data-toggle="pill" href="#tab_ios"> <span class="nav-icon py-2 w-auto"><i class="fab fa-apple icon-3x"></i></span> <span class="nav-text font-size-lg py-2 font-weight-bold text-center">IOS</span> </a> </li>
                                             
                                             <li class="nav-item d-flex col flex-grow-1 flex-shrink-0 mb-3 mb-lg-0 cursor_onclick"> <a class="nav-link border d-flex flex-grow-1 rounded flex-column align-items-center" data-toggle="pill" href="#tab_macos"> <span class="nav-icon py-2 w-auto"><i class="fab fa-apple icon-3x"></i></span> <span class="nav-text font-size-lg py-2 font-weight-bold text-center">macOS</span> </a> </li>
                                         </ul>
                                         <div class="separator separator-dashed p-1"></div>
                                         <div class="tab-content ml-1 p-0">
                                             <div class="tab-pane active" id="tab_windows" role="tabpanel">
                                                 <div class="card-body pb-0 pl-0">
                                                     <div class="flex-grow-1 card-spacer-x">
                                                        {foreach $Cool_Config['client_windows'] as $c_w}
                                                            <div class="d-flex align-items-center justify-content-between mb-3">
                                                                <div class="d-flex align-items-center mr-2">
                                                                 <div class="symbol symbol-60 symbol-light flex-shrink-0">
                                                                     <div class="symbol-label">
                                                                         <img src="{$c_w['img']}" alt="" class="h-50" />
                                                                     </div>
                                                                 </div>
                                                                 <div class="ml-1">
                                                                     <span class="font-size-h5 text-primary font-weight-bolder">{$c_w['name']}</span>
                                                                     <div class="font-size-sm text-muted font-weight-bold mt-1">
                                                                         {$c_w['vs']}
                                                                     </div>
                                                                 </div>
                                                                </div>
                                                                <div style="display:flex">
                                                                    {if $c_w['dl_url']}
                                                                        <a href="{$c_w['dl_url']}" class="btn btn-primary font-weight-bold btn-pill mr-1">立即下载</a>
                                                                    {/if}
                                                                    <a href="{$c_w['url']}" class="btn btn-primary font-weight-bold btn-pill">安装教程</a>
                                                                </div>
                                                            </div>
                                                            {if !$c_w@last}
                                                                <div class="separator separator-dashed mb-3"></div>
                                                            {/if}
                                                        {/foreach}
                                                     </div>
                                                 </div>
                                             </div>
                                             <div class="tab-pane" id="tab_android" role="tabpanel">
                                                 <div class="card-body pb-0 pl-0">
                                                     <div class="flex-grow-1 card-spacer-x">
                                                        {foreach $Cool_Config['client_android'] as $c_w}
                                                            <div class="d-flex align-items-center justify-content-between mb-3">
                                                                <div class="d-flex align-items-center mr-2">
                                                                 <div class="symbol symbol-60 symbol-light flex-shrink-0">
                                                                     <div class="symbol-label">
                                                                         <img src="{$c_w['img']}" alt="" class="h-50" />
                                                                     </div>
                                                                 </div>
                                                                 <div class="ml-1">
                                                                     <span class="font-size-h5 text-primary font-weight-bolder">{$c_w['name']}</span>
                                                                     <div class="font-size-sm text-muted font-weight-bold mt-1">
                                                                         {$c_w['vs']}
                                                                     </div>
                                                                 </div>
                                                                </div>
                                                                <div style="display:flex">
                                                                    {if $c_w['dl_url']}
                                                                        <a href="{$c_w['dl_url']}" class="btn btn-primary font-weight-bold btn-pill mr-1">立即下载</a>
                                                                    {/if}
                                                                    <a href="{$c_w['url']}" class="btn btn-primary font-weight-bold btn-pill">安装教程</a>
                                                                </div>
                                                            </div>
                                                            {if !$c_w@last}
                                                                <div class="separator separator-dashed mb-3"></div>
                                                            {/if}
                                                        {/foreach}
                                                     </div>
                                                 </div>
                                             </div>
                                             <div class="tab-pane" id="tab_ios" role="tabpanel">
                                                 <div class="card-body pb-0 pl-0">
                                                     <div class="flex-grow-1 card-spacer-x">
                                                        {foreach $Cool_Config['client_ios'] as $c_w}
                                                            <div class="d-flex align-items-center justify-content-between mb-3">
                                                                <div class="d-flex align-items-center mr-2">
                                                                 <div class="symbol symbol-60 symbol-light flex-shrink-0">
                                                                     <div class="symbol-label">
                                                                         <img src="{$c_w['img']}" alt="" class="h-50" />
                                                                     </div>
                                                                 </div>
                                                                 <div class="ml-1">
                                                                     <span class="font-size-h5 text-primary font-weight-bolder">{$c_w['name']}</span>
                                                                     <div class="font-size-sm text-muted font-weight-bold mt-1">
                                                                         {$c_w['vs']}
                                                                     </div>
                                                                 </div>
                                                                </div>
                                                                <div style="display:flex">
                                                                    {if $c_w['dl_url']}
                                                                        <a href="{$c_w['dl_url']}" class="btn btn-primary font-weight-bold btn-pill mr-1">立即下载</a>
                                                                    {/if}                                                                    
                                                                    <a href="{$c_w['url']}" class="btn btn-primary font-weight-bold btn-pill">安装教程</a>
                                                                </div>
                                                            </div>
                                                            {if !$c_w@last}
                                                                <div class="separator separator-dashed mb-3"></div>
                                                            {/if}
                                                        {/foreach}
                                                     </div>
                                                 </div>
                                             </div>
                                             <div class="tab-pane" id="tab_macos" role="tabpanel">
                                                 <div class="card-body pb-0 pl-0">
                                                     <div class="flex-grow-1 card-spacer-x">
                                                        {foreach $Cool_Config['client_macos'] as $c_w}
                                                            <div class="d-flex align-items-center justify-content-between mb-3">
                                                                <div class="d-flex align-items-center mr-2">
                                                                 <div class="symbol symbol-60 symbol-light flex-shrink-0">
                                                                     <div class="symbol-label">
                                                                         <img src="{$c_w['img']}" alt="" class="h-50" />
                                                                     </div>
                                                                 </div>
                                                                 <div class="ml-1">
                                                                     <span class="font-size-h5 text-primary font-weight-bolder">{$c_w['name']}</span>
                                                                     <div class="font-size-sm text-muted font-weight-bold mt-1">
                                                                         {$c_w['vs']}
                                                                     </div>
                                                                 </div>
                                                                </div>
                                                                <div style="display:flex">
                                                                    {if $c_w['dl_url']}
                                                                        <a href="{$c_w['dl_url']}" class="btn btn-primary font-weight-bold btn-pill mr-1">立即下载</a>
                                                                    {/if}                                                                    
                                                                    <a href="{$c_w['url']}" class="btn btn-primary font-weight-bold btn-pill">安装教程</a>
                                                                </div>
                                                            </div>
                                                            {if !$c_w@last}
                                                                <div class="separator separator-dashed mb-3"></div>
                                                            {/if}
                                                        {/foreach}
                                                     </div>
                                                 </div>
                                             </div>
                                        </div>
									</div>
								</div>
					        </div>
                        </div>
                    
                        <div class="col-12 col-md-6 col-lg-6">
                            <div class="card">
                                <div class="card-header">
                                    <h4>订阅信息</h4>
                                	<span style="line-height:29px;font-size:14px;float: right;">
                						{if $user->isAbleToCheckin() }
                                			<button type="button" id="checkin" class="btn btn-primary btn-sm waves-effect waves-light float-right"><i class="far fa-calendar-check fa-lg icon-ver"></i>&nbsp;每日签到</button>
                                		{else}
                            				<button type="button" class="btn btn-primary disabled btn-sm waves-effect waves-light float-right"><i class="far fa-calendar-check fa-lg icon-ver"></i>&nbsp;已签到</button>
                                		{/if}
                                	</span>
                                </div>
                                <hr />
                                <div class="card-content">
                                    <div class="card-body pt-0">
	                                    <div class="dropdown">
	                                    
                                            {if (in_array("ss",$Cool_Config['subscribe_type']))}
    	                                        <!-- SS订阅 -->
        										<div class="btn-group">
                                                	<button type="button" class="btn btn-ss round waves-effect waves-light copy-text" data-clipboard-text="{$subInfo['ss']}"><i class="cool-ss"></i>SS 订阅</button>
                                                </div>
    	                                    {/if}
	                                    
                                            {if (in_array("ssr",$Cool_Config['subscribe_type']))}
    	                                        <!-- SSR订阅 -->
    											<div class="btn-group">
    	                                        	<button type="button" class="btn btn-ssr round dropdown-toggle waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="cool-ssr"></i>&nbsp;SSR 订阅</button>
    	                                        	<div class="dropdown-menu dropdown-node dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-14px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
    	                                              <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['ssr']}">复制 SSR 订阅</button>
    	                                              <button type="button" class="dropdown-item" href="##" onclick="importSublink('ssr')">一键导入 SSR</button>
    	                                        	</div>
    	                                        </div>
    	                                    {/if}
	                                    
                                            {if (in_array("v2ray",$Cool_Config['subscribe_type']))}
                                                <!-- V2ray订阅 -->
        										<div class="btn-group">
                                                	<button type="button" class="btn btn-v2ray round waves-effect waves-light copy-text" data-clipboard-text="{$subInfo['v2ray']}"><i class="cool-v2rayng"></i>复制 V2Ray 订阅</button>
                                                </div>
                                            {/if}
                                            
                                            {if (in_array("v2ray_vless",$Cool_Config['subscribe_type']))}    
                                                <!-- V2ray vless订阅 -->
        										<div class="btn-group">
                                                	<button type="button" class="btn btn-v2ray round waves-effect waves-light copy-text" data-clipboard-text="{$subInfo['v2ray_vless']}"><i class="cool-v2rayng"></i>复制 V2Ray-VLESS 订阅</button>
                                                </div>
                                            {/if}
                                            
    	                                    {if (in_array("ss",$Cool_Config['subscribe_type'])) || (in_array("v2ray",$Cool_Config['subscribe_type']))}
    	                                        <!-- Clash订阅 -->
    											<div class="btn-group">
    	                                        	<button type="button" class="btn btn-clash round dropdown-toggle waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="cool-clash"></i>&nbsp;Clash 订阅</button>
    	                                        	<div class="dropdown-menu dropdown-node dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-14px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
    	                                              <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['clash']}">复制 Clash 订阅</button>
    	                                              <button type="button" class="dropdown-item" href="##" onclick="importSublink('clash')">一键导入 Clash</button>
    	                                        	</div>
    	                                        </div>
    	                                    {/if}
	                                    
	                                        {if (in_array("ss",$Cool_Config['subscribe_type'])) || (in_array("v2ray",$Cool_Config['subscribe_type']))}
                                                <!-- AnXray 订阅 -->
        										<div class="btn-group">
                                                	<button type="button" class="btn btn-anxray round waves-effect waves-light copy-text" data-clipboard-text="{$subInfo['anxray']}"><i class="cool-anxray"></i>复制 AnXray 订阅</button>
                                                </div>
    	                                    {/if}
    	                                    
    	                                    {if (in_array("trojan",$Cool_Config['subscribe_type']))}
                                                <!-- trojan订阅 -->
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-pill btn-trojan copy-text round" data-clipboard-text="{$subInfo['trojan']}"><i class="cool-v2rayng text-white"></i>&nbsp;复制 Trojan 订阅&nbsp;&nbsp;</button>
                                                </div>
    	                                    {/if}
    	                                    
                    	                    {if (in_array("ss",$Cool_Config['subscribe_type']))}
                    	                    {if (!in_array("surge",$Cool_Config['index_import_buttons']))}
        	                                    <!-- surge -->
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-pill btn-surge dropdown-toggle round waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="cool-surge text-white"></i>&nbsp;Surge 订阅&nbsp;&nbsp;</button>
                                                    <div class="dropdown-menu dropdown-node dropdown-menu-right">
                                                        <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['surge2']}">复制 Surge 2 节点订阅</button>
                                                        <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['surge3']}">复制 Surge 3 节点订阅</button>
                                                        <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['surge4']}">复制 Surge 4 节点订阅</button>
                                                    </div>
                                                </div>
                                            {/if}
    	                                    {/if}
    	                                    
    	                                    {if (!in_array("shadowrocket",$Cool_Config['index_import_buttons']))}
                                                <!-- Shadowrocket订阅 -->
                                                <div class="btn-group">
                                                	<button type="button" class="btn btn-shadowrocket round dropdown-toggle waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="cool-shadowrocket"></i>&nbsp;Shadowrocket 订阅</button>
                                                	<div class="dropdown-menu dropdown-node dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-14px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                      <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['shadowrocket']}">复制 Shadowrocket 订阅</button>
                                                      <button type="button" class="dropdown-item" href="##" onclick="importSublink('shadowrocket')">一键导入 Shadowrocket</button>
                                                	</div>
                                                </div>
    	                                    {/if}
    	                                    
                                            {if (in_array("ss",$Cool_Config['subscribe_type'])) || (in_array("v2ray",$Cool_Config['subscribe_type']))}
                                                {if (!in_array("kitsunebi",$Cool_Config['index_import_buttons']))}
                                                    <!-- kitsunebi订阅 -->
                                                    <div class="btn-group">
                                                        <button type="button" class="btn btn-pill btn-kitsunebi copy-text round" data-clipboard-text="{$subInfo['kitsunebi']}"><i class="cool-kitsunebi text-white"></i>&nbsp;复制 Kitsunebi 订阅</button>
                                                    </div>
                                                {/if}
                                            {/if}
            
                                            {if (!in_array("quantumultx",$Cool_Config['index_import_buttons']))}
    	                                       	<!-- Quantumult X订阅 -->
    	                                        <div class="btn-group">
    	                                            <button type="button" class="btn btn-pill btn-quantumultx copy-text round" data-clipboard-text="{$subInfo['quantumultx']}"><i class="cool-quantumultx text-white"></i>&nbsp;复制 Quantumult X 订阅&nbsp;&nbsp;</button>
    	                                        </div>
                                            {/if}
                                            
    	                                    {if (!in_array("quantumult",$Cool_Config['index_import_buttons']))}
    	                                        <!-- Quantumult订阅 -->
    	                                        <div class="btn-group">
    	                                        	<button type="button" class="btn btn-quantumult round dropdown-toggle waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="cool-quantumult"></i>&nbsp;Quantumult 订阅</button>
    	                                        	<div class="dropdown-menu dropdown-node dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-14px, 38px, 0px); top: 0px; left: 0px; will-change: transform;">
    	                                              <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['ssr']}">复制 SSR 订阅</button>
    	                                              <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo['quantumult_v2']}">复制 V2ray 订阅</button>
    	                                              <div class="dropdown-divider"></div>
    	                                              <button type="button" class="dropdown-item" href="##" onclick="importSublink('quantumult')">一键导入 SSR 节点订阅</button>
    	                                              <button type="button" class="dropdown-item" href="##" onclick="importSublink('quantumult_v2')">一键导入 V2ray 节点订阅</button>
    	                                        	</div>
    	                                        </div>
                                            {/if}
                                            
    	                                    {if (!in_array("surfboard",$Cool_Config['index_import_buttons']))}
    	                                        <!-- surfboard订阅 -->
    	                                        <div class="btn-group">
                                                    <button type="button" class="btn btn-pill btn-surfboard copy-text round" data-clipboard-text="{$subInfo['surfboard']}"><i class="cool-surfboard text-white"></i>&nbsp;复制 Surfboard 订阅</button>
                                                </div>
                                            {/if}
                                        
                                        </div>
                                    </div>
                                </div>
                            </div>
            
                            <div class="card">
                                <div class="card-body" style="position: relative;">
                                    <h4 class="card-title mb-50">流量报表</h4>
                                    <p class="card-text font-small-3">下次流量重置日期：{$user->valid_use_loop()}</p>
                                    <hr />
                                    <div id="donut-chart"></div>
                                    <div class="mt-1" style="border-radius: 5px">
                                        <li class="list-group-item d-flex justify-content-between traffic-info">
                                            <div class="series-info">
                                                <i class="fa fa-circle font-small-3" style="color:{if $Cool_Config['theme_style_color'] == 'cyan'}#5ED2C0{else}#7D72F1{/if}"></i>
                                                <span class="text-bold-600">剩余流量 ： 
                                                    {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}%
                                                </span>
                                            </div>
                                            <div class="product-result">
                                                <span>{$user->unusedTraffic()}</span>
                                            </div>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between traffic-info">
                                            <div class="series-info">
                                                <i class="fa fa-circle font-small-3 text-danger"></i>
                                                <span class="text-bold-600">今日已用 ： 
                                                    {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}%
                                                </span>
                                            </div>
                                            <div class="product-result">
                                                <span>{$user->TodayusedTraffic()}</span>
                                            </div>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between traffic-info">
                                            <div class="series-info">
                                                <i class="fa fa-circle font-small-3 text-warning"></i>
                                                <span class="text-bold-600">历史使用 ：  
                                                    {number_format($user->last_day_t/$user->transfer_enable*100,2)}%
                                                </span>
                                            </div>
                                            <div class="product-result">
                                                <span>{$user->LastusedTraffic()}</span>
                                            </div>
                                        </li>
                                    </div>
                                </div>
                            </div>

                            {if $Cool_Config['enable_index_placard'] == true}
                             <div class="modal fade" id="tos_notify" tabindex="-1" role="dialog">
                        		  <div class="modal-dialog modal-dialog-centered" role="document">
                        		    <div class="modal-content">
                                        <div class="card mb-0">
                                            <div class="card-body">
                                                {$Cool_Config['index_placard_content']}
                                                <div class="d-flex align-items-right justify-content-between mt-2">
                                                    <div class="custom-control custom-switch custom-control-inline"></div>
                                                    <button class="btn btn-primary waves-effect waves-float waves-light" data-dismiss="modal" aria-label="Close">关闭</button>
                                                </div>
                                            </div>
                                        </div>
                        			</div>
                        		  </div>
                        		</div>
                            {/if}
                        </div>
                    </div>
                </select>
            </div>
        </div>
    </div>
    <!-- END: Content-->

    <!-- BEGIN: Footer-->
		{include file='user/footer.tpl'}
    <!-- END: Footer-->
    
    <!-- C3 Chart -->
	<script src="/theme/cool/assets/vendors/js/charts/apexcharts.min.js"></script>
	<script src="/theme/cool/assets/vendors/js/charts/flatpickr.min.js"></script>
	<script src="/theme/cool/assets/vendors/js/charts/chart-apex.js"></script>
	<script>
    var donutChartEl = document.querySelector('#donut-chart'),
        donutChartConfig = {
            chart: {
                height: 350,
                type: 'donut'
            },
            legend: {
                show: true,
                position: 'bottom'
            },
            labels: ['可用', '已用', '今日已用'],
            series: [
                {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)},
                {number_format($user->last_day_t/$user->transfer_enable*100,2)},
                {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}
            ],
            colors: ['{if $Cool_Config['theme_style_color'] == 'cyan'}#5ED2C0{else}#7D72F1{/if}', '#FF9F43', '#EA5455'],
            dataLabels: {
                enabled: true,
                formatter: function(val, opt) {
                    return parseInt(val) + '%';
                }
            },
            plotOptions: {
                pie: {
                    donut: {
                        labels: {
                            show: true,
                            name: {
                                fontSize: '2rem',
                                fontFamily: "Nunito",
                            },
                            value: {
                                fontSize: '1rem',
                                fontFamily: "Nunito",
                                formatter: function(val) {
                                    return parseInt(val) + '%';
                                }
                            },
                        }
                    }
                }
            },
        };
	</script>
	
    {if $Cool_Config['enable_index_placard'] == true}
        <script>
          {if $Cool_Config['enable_index_placard_time'] == true}
              function setCookie(name, value) {
                  var exp = new Date();
                  exp.setTime(exp.getTime() + 1 * 60 * 1000*60*24);
                  document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ";path=/";
                  }
          
              function ReadCookie(name) {
                  var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
                  if (arr = document.cookie.match(reg)) return unescape(arr[2]);
                  else return null;
                  }
                  if (ReadCookie("cnxad_lunbo") == "" || ReadCookie("cnxad_lunbo") == null) {
                      $('#tos_notify').modal('show');
                      setCookie("cnxad_lunbo", "yes");
                      }
          {else}
                $("#tos_notify").modal();
          {/if}
        </script>
    {/if}
</body>
</html>