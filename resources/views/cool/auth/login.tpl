<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
        <title>登录 &mdash; {$config["appName"]}</title>
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
	<body class="vertical-layout vertical-menu-modern 1-column  navbar-floating footer-static bg-full-screen-image  blank-page blank-page" data-open="click" data-menu="vertical-menu-modern" data-col="1-column">
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

                            <div class="card mt-5">
                                <div class="card-body">
                                    <a href="javascript:void(0);" class="brand-logo">
                                        <svg viewBox="0 0 139 95" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" height="28">
                                            <defs>
                                                <linearGradient id="linearGradient-1" x1="100%" y1="10.5120544%" x2="50%" y2="89.4879456%">
                                                    <stop stop-color="#000000" offset="0%"></stop>
                                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                                </linearGradient>
                                                <linearGradient id="linearGradient-2" x1="64.0437835%" y1="46.3276743%" x2="37.373316%" y2="100%">
                                                    <stop stop-color="#EEEEEE" stop-opacity="0" offset="0%"></stop>
                                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                                </linearGradient>
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
    
                                    <h4 class="card-title mb-1">Welcome to {$Cool_Config['small_brand']}👋</h4>
                                    <p class="card-text mb-2">请登录您的账号开始体验！</p>
        
                                    <form class="form-group" action="javascript:void(0);" method="POST" novalidate="" id="login-form">
                                        <div class="form-group login-form-item">
                                            <label for="login-email" class="form-label">邮箱</label>
                                            <input id="email" class="form-control" type="text" name="email" autocomplete="off" tabindex="1" required="">
                                        </div>
    
                                        <div class="form-group login-form-item">
                                            <div class="d-flex justify-content-between">
                                                <label for="login-password" class="form-label">密码</label>
                                                <a href="/password/reset">
                                                    <small>忘记密码?</small>
                                                </a>
                                            </div>
                                            <div class="input-group input-group-merge form-password-toggle">
                                                <input id="password" class="form-control" type="password"  name="password" tabindex="2" required="">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group" id="2fa-form" style="display:none">
                                            <label for="login-email" class="form-label">令牌</label>
                                            <input id="2fa-code" class="form-control valid" type="number" placeholder="二步验证动态码,未设置为空即可" name="code_2fa">
                                        </div>
                                        
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" type="checkbox" id="remember-me" tabindex="3">
                                                <label class="custom-control-label" for="remember-me">记住我</label>
                                            </div>
                                        </div>
                                        {if $geetest_html != null}
						                  <div class="input-group mb-4">
						                    <div class="embed-captcha"></div>
						                  </div>
					                    {/if}
					                    
								        {if $recaptcha_sitekey != null}
						                  <div class="input-group mb-4">
						                    <div class="g-recaptcha" data-sitekey="{$recaptcha_sitekey}"></div>
						                  </div>
								        {/if}
                                        <button type="submit" class="btn btn-primary btn-block waves-effect waves-float login-button">登录</button>
                                    </form>
                                    <p class="text-center mt-2">
                                        <span>还没有账号？</span>
                                        <a href="/auth/register">
                                            <span>马上注册 👉</span>
                                        </a>
                                    </p>
                                </div>
                            </div>
                            <div class="text-center mt-2 text-small">
                                Copyright © 2021 {$config["appName"]}
					            <p class="mt-1">
					                Powered by 
					                <a href="/staff">SSPANEL</a> 
					                <div class="bullet"></div>
					            </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	    <!-- END: Content-->

        <!-- 开始:JavaScript -->
		<script src="https://fastly.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
        <script src="/theme/cool/assets/js/notify.js"></script>
        <script src="/theme/cool/assets/js/sweetalert2.min.js"></script>
		<script src="https://fastly.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"></script>
		<script src="https://fastly.jsdelivr.net/npm/jquery-validation@1.19.1/dist/jquery.validate.min.js"></script>

		<!-- 开始:极验 -->
		{if $geetest_html != null}
		  <script src="//static.geetest.com/static/tools/gt.js"></script>
		  <script>
		    captcha = '';
		    var handlerEmbed = function (captchaObj) {
		      captchaObj.onSuccess(function () {
		          validate = captchaObj.getValidate();
		      });
		      captchaObj.appendTo(".embed-captcha");
		      captcha = captchaObj;
		    };
		    initGeetest({
		      gt: "{$geetest_html->gt}",
		      challenge: "{$geetest_html->challenge}",
		      product: "embed",
		      width: "100%",
		      offline: {if $geetest_html->success}0{else}1{/if}
		    }, handlerEmbed);
		  </script>
		{/if}
		<!-- 结束:极验 --> 
		
		<!-- 开始: recaptcha -->
        {if $recaptcha_sitekey != null}
            <script src="https://recaptcha.net/recaptcha/api.js" async defer></script>
        {/if}
		<!-- 结束: recaptcha --> 
        
        <!-- 开始:登录js -->
        <script>
            $('.login-button').click(function() {
                var btn = $(this);
                var form = $(this).closest('form');
                form.validate({
                    rules: {
                        email: {
                            required: true,
                        },
                        password: {
                            required: true
                        }
                    },
                    messages: {
                        email: {
                            required: "请填写邮箱",
                        },
                        password: "请填写密码"
                    },
                    errorPlacement: function(error, element) {
                      error.appendTo( element.parent() ); 
                      element.addClass('is-invalid');
                      error.addClass('invalid-feedback');
                    }
                });
                if (!form.valid()) {
                    return;
                }
				
				{if $geetest_html != null}
				  validate = captcha.getValidate();
				  if (typeof validate === 'undefined' || !validate) {
				    swal.fire('请验证身份', '请滑动验证码来完成验证。', 'info');
				    return;
				  }
				{/if}
				
				$(".login-button").text('正在登录').attr('disabled', true);
				
                $.ajax({
                    type: "POST",
                    url: location.pathname,
                    dataType: "json",
                    data: {
			          email: $("#email").val(),
			          passwd: $("#password").val(),
			          code: $("#2fa-code").val(),{if $recaptcha_sitekey != null}
			          recaptcha: grecaptcha.getResponse(),{/if}
			          remember_me: $("#remember-me:checked").val(){if $geetest_html != null},
			          geetest_challenge: validate.geetest_challenge,
			          geetest_validate: validate.geetest_validate,
			          geetest_seccode: validate.geetest_seccode{/if}                           
			        },
                    success: function (data) {
                        if (data.ret == 1){
                        	$.notify({ title: '<strong>'+data.msg+'</strong>', message: '正在转入用户中心' },{ type: 'success', placement: { from: "top", align: "center"}, });
                            window.setTimeout("location.href='/user'", 1000);
                        }else if(data.ret == 2) {
                        	$(".login-button").text('登录').attr('disabled', false);
                            $('.login-form-item').hide('500');
                            $('#2fa-form').show('fast');
                            $.notify({
                                    message: '<strong>'+data.msg+'</strong>'
                                },{
                                    type: 'warning',
                                    placement: { 
                                        from: "top", 
                                        align: "center"
                                    },
                                    timer: 500,
                                    animate: {
                                        enter: 'animated zoomIn',
                                        exit: 'animated zoomOut'
                                    }
                                });
                        } else{
                        	$(".login-button").text('登录').attr('disabled', false);
                        	$.notify({
                                title: '<strong>登录失败</strong>',
                                message: data.msg
                            },{
                                type: 'danger',
                                placement: { 
                                    from: "top", 
                                    align: "center"
                                },
                                timer: 500,
                                animate: {
                                    enter: 'animated zoomIn',
                                    exit: 'animated zoomOut'
                                }
                            });
                        };
                    }
                });
            });
        </script>
        <!-- 结束: 登录js -->
        
        <script>
            var isWeixin = function () {
            var ua = navigator.userAgent.toLowerCase();
            return ua.match(/MicroMessenger/i) == "micromessenger";
            };
            if (isWeixin() == true) {
                $('#pjax-auth').html(''+
                '<div class="kt-login__signin flipInX animated" id="pjax-auth">'+
                '<div class="kt-login__head">'+
                '<h2 class="kt-login__title kt-font-danger">不支持在微信内访问</h2>'+
                '<div class="kt-login__desc">请点击右上角菜单，选择浏览器打开</div>'+
                '</div>'+
                '</div>');
                $('#auth-page-tab').hide();
                }
        </script>
        <!-- 结束:JavaScript -->
        
    </body>
</html>