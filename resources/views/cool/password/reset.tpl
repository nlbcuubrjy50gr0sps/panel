<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
        <title>找回密码 &mdash; {$config["appName"]}</title>
        <!-- ico -->
        <link rel="shortcut icon" href="/favicon.ico" />
      
        <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/cool.css">
      	<link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/auth/page-auth.css">
        <link rel="stylesheet" type="text/css" href="/theme/cool/assets/vendors/css/vendors.min.css">
    	<link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap.css">
	    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap-extended.css">
	    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/sweetalert2.min.css">
	    <link rel="stylesheet" href="https://fastly.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">
	    
        {if $Cool_Config['enable_crisp'] == true && $Cool_Config['enable_crisp_outside'] == true}
        	{include file='crisp.tpl'}
        {/if}
      
        {if $Cool_Config['enable_chatra'] == true && $Cool_Config['enable_crisp_outside'] == true}
        	{include file='chatra.tpl'}
        {/if}
        
        <script>
            var isWeixin = function () {
            var ua = navigator.userAgent.toLowerCase();
            return ua.match(/MicroMessenger/i) == "micromessenger";
            };
            if (isWeixin() == true) {
                $('body').html('<h5 style="margin:20px">不支持在微信内访问<br>请点击右上角菜单<br>选择浏览器打开</h5>')
            }
        </script>
    </head>

	<!-- BEGIN: Body-->
    <body class="vertical-layout vertical-menu-modern blank-page navbar-floating footer-static  " data-open="click" data-menu="vertical-menu-modern" data-col="blank-page">
        <!-- BEGIN: Content-->
        <div class="app-content content ">
            <div class="content-overlay"></div>
            <div class="header-navbar-shadow"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <div class="auth-wrapper auth-v1 px-2">
                        <div class="auth-inner py-2">
                            <!-- Forgot Password v1 -->
                            <div class="card mb-0">
                                <div class="card-body">
                                    <a href="javascript:void(0);" class="brand-logo">
                                        <svg viewbox="0 0 139 95" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" height="28">
                                            <defs>
                                                <lineargradient id="linearGradient-1" x1="100%" y1="10.5120544%" x2="50%" y2="89.4879456%">
                                                    <stop stop-color="#000000" offset="0%"></stop>
                                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                                </lineargradient>
                                                <lineargradient id="linearGradient-2" x1="64.0437835%" y1="46.3276743%" x2="37.373316%" y2="100%">
                                                    <stop stop-color="#EEEEEE" stop-opacity="0" offset="0%"></stop>
                                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                                </lineargradient>
                                            </defs>
                                            <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <g id="Artboard" transform="translate(-400.000000, -178.000000)">
                                                    <g id="Group" transform="translate(400.000000, 178.000000)">
                                                        <path class="text-primary" id="Path" d="M-5.68434189e-14,2.84217094e-14 L39.1816085,2.84217094e-14 L69.3453773,32.2519224 L101.428699,2.84217094e-14 L138.784583,2.84217094e-14 L138.784199,29.8015838 C137.958931,37.3510206 135.784352,42.5567762 132.260463,45.4188507 C128.736573,48.2809251 112.33867,64.5239941 83.0667527,94.1480575 L56.2750821,94.1480575 L6.71554594,44.4188507 C2.46876683,39.9813776 0.345377275,35.1089553 0.345377275,29.8015838 C0.345377275,24.4942122 0.230251516,14.560351 -5.68434189e-14,2.84217094e-14 Z" style="fill: currentColor"></path>
                                                        <path id="Path1" d="M69.3453773,32.2519224 L101.428699,1.42108547e-14 L138.784583,1.42108547e-14 L138.784199,29.8015838 C137.958931,37.3510206 135.784352,42.5567762 132.260463,45.4188507 C128.736573,48.2809251 112.33867,64.5239941 83.0667527,94.1480575 L56.2750821,94.1480575 L32.8435758,70.5039241 L69.3453773,32.2519224 Z" fill="url(#linearGradient-1)" opacity="0.2"></path>
                                                        <polygon id="Path-2" fill="#000000" opacity="0.049999997" points="69.3922914 32.4202615 32.8435758 70.5039241 54.0490008 16.1851325"></polygon>
                                                        <polygon id="Path-21" fill="#000000" opacity="0.099999994" points="69.3922914 32.4202615 32.8435758 70.5039241 58.3683556 20.7402338"></polygon>
                                                        <polygon id="Path-3" fill="url(#linearGradient-2)" opacity="0.099999994" points="101.428699 0 83.0667527 94.1480575 130.378721 47.0740288"></polygon>
                                                    </g>
                                                </g>
                                            </g>
                                        </svg>
                                        <h2 class="brand-text text-primary ml-1">{$Cool_Config['small_brand']}</h2>
                                    </a>
    
                                    <h4 class="card-title mb-1">Forget password 🔒</h4>
                                    <p class="card-text mb-2">输入注册邮箱，我们会给您发送验证邮件帮助您重置密码.</p>
    
                                    <form class="form-group" action="javascript:void(0);"> 
                                        <div class="form-group">
                                            <label for="forgot-password-email" class="form-label">邮箱</label>
                                            <input id="email" class="form-control" type="text" name="email" autocomplete="off" tabindex="1" required>
                                        </div>
                                        <button class="btn btn-primary btn-block" id="reset-button">发送验证邮件</button>
                                    </form>
    
                                    <p class="text-center mt-2">
                                        <a href="/auth/login">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 3 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-left"><polyline points="15 18 9 12 15 6"></polyline></svg>
                                        返回登录 </a>
                                    </p>
                                </div>
                            </div>
                            <!-- /Forgot Password v1 -->
                        </div>
                    </div>
    
                </div>
            </div>
        </div>
        <!-- END: Content-->
    <!-- 结束:1:页面 -->

    <!-- 开始:JavaScript -->
    <script src="https://fastly.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
    <script src="/theme/cool/assets/js/notify.js"></script>
    <script src="/theme/cool/assets/js/sweetalert2.min.js"></script>
	<script>
        $('#reset-button').click(function(e) {
            $("#reset-button").text('正在发送');
            $('#reset-button').attr('disabled', true);
            $.ajax({
                type: "POST",
                url: location.pathname,
                dataType: "json",
                data: {
                    email: $("#email").val(),
                },
                success: function (data) {
                    if (data.ret == 1) {
                        $.notify({
                            title: '<strong>重置密码邮件已发送</strong>',
                            message: '如长时间未收到，请查看邮件垃圾箱，国内邮箱接收可能会延迟。<br>您需要从邮件中点击链接进行设置新密码'
                        },{
                            type: 'success',
                            placement: { 
                                from: "top", 
                                align: "center"
                            },
                            timer: 2000,
                            animate: {
                                enter: 'animated zoomIn',
                                exit: 'animated zoomOut'
                            }
                        });
                    } else {
                        $.notify({
                            title: '<strong>发送失败</strong>',
                            message: data.msg
                        },{
                            type: 'danger',
                            placement: { 
                                from: "top", 
                                align: "center"
                            },
                            timer: 2000,
                            animate: {
                                enter: 'animated zoomIn',
                                exit: 'animated zoomOut'
                            }
                        });
                    }
                    $("#reset-button").text('立即找回');
                    $('#reset-button').attr('disabled', false);
                }
            });
        });
    </script>
    <!-- 结束:JavaScript -->
    
  </body>
</html>