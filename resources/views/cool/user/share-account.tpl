<!DOCTYPE html>
  <html lang="zh-CN">
   <head> 
    <title>共享账号 — {$config["appName"]}</title> 
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
                            <h2 class="content-header-title float-left mb-0">共享账号</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="/user/share-account">Account Sharing</a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-body">
                <section id="collapsible">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                    <div class="alert-text">
                                        <h4 class="card-title">说明</h4>
                                    </div>
                                </div>
                                {if $Cool_Config['show_share'] == true}
                                <div class="card-content">
                                    <div class="card-body">
                                        <p class="card-text">本站对符合要求的会员提供部分软件的ID共享账号以满足部分会员的需求，例如Apple ID、Netflix奈飞等共享账号。</p>
                                        <br />
										<div class="section-body">
										    <div class="row">
										      {foreach $Cool_Config['share_account'] as $c_w}
										      <div class="col-12 col-md-6 col-lg-3" >
										        <div class="card" style="box-shadow: 0 0 2rem 0 rgba(136,152,170,.15)!important">
										          <div class="card-header text-center">
										            <img class="img-fluid" src="{$c_w['img']}">
										            <h3 class="f-w-600 mt-1 mb-1" style="margin: auto;">{$c_w['name']}</h3>
										          </div>
										          <div class="node-body">
    										              {if $user->class >= $c_w['class']}
                                                            <main class="cool-drag">
                                                                <label>账号：</label>
                                                                <div class="cool-item copy-text" data-clipboard-text="{$c_w['account']}" >{$c_w['account']}</div>
                                                                <label>密码：</label>
                                                                <div class="cool-item copy-text" data-clipboard-text="{$c_w['passwd']}">点击复制后在密码框长按粘贴</div>
                                                            </main>
    										              {else}
                                                            <main class="cool-drag">
                                                                <label>账号：</label>
                                                                <div class="cool-item">该账号仅 <span class="text-primary">会员[LV.{$c_w['class']}]</span> 及以上会员可用</div>
                                                                <label>密码：</label>
                                                                <div class="cool-item" style="margin-bottom:20px">该账号仅 <span class="text-primary">会员[LV.{$c_w['class']}]</span> 及以上会员可用</div>
                                                            </main>
    										              {/if}
										          </div>
										        </div>
										      </div>
										      {/foreach}
										    </div>
										</div>
                                    </div>
                                </div>
                                {else}
	                                <div class="card-content">
	                                    <div class="card-body">
		                                    <h4>
		                                        本站暂未开放共享账号
		                                    </h4>
	                                    </div>
	                                </div>
                                {/if}
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