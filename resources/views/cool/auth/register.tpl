<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
        <title>注册 &mdash; {$config["appName"]}</title>
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
    <body class="vertical-layout vertical-menu-modern blank-page navbar-floating footer-static" data-open="click" data-menu="vertical-menu-modern" data-col="blank-page">
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
    
                                    <h4 class="card-title mb-1">Start here {$Cool_Config['small_brand']}!  🚀</h4>
                                    <p class="card-text mb-2">请注册您的账号开始体验！</p>
                                {if $config['register_mode'] == 'close'}
                                    <p>未开放注册</p>
                                {else}
                                    <form class="form-group" action="javascript:void(0);" method="POST" novalidate="" id="register-form">
                                        <div class="form-group">
                                            <label class="form-label" for="name">昵称</label>
                                            <input id="name" class="form-control" type="text" name="name" required>
                                        </div>
                                        
                                        <label class="form-label" for="name">邮箱</label>
                                        <div class="input-group">
											<input id="email" class="form-control" style="height: auto" type="text" name="email"  required>
										    {if $Cool_Config['enable_register_email_restrict'] == true}
												<select class="custom-select col-5" id="email_postfix" required>
                                                    {$email_first = true}
                                                    {foreach $Cool_Config['register_email_white_list'] as $email}
                                                    {if $email_first == true}
                                                    <option value="{$email}" selected="">{$email}</option>
                                                    {$email_first = false}
                                                    {else}
                                                    <option value="{$email}">{$email}</option>
                                                    {/if}
                                                    {/foreach}
                                                </select>
                                            {/if}
                                        </div>
                                        <br/>
                                        
                                        {if $enable_email_verify == 'true'} 
                                            <label class="form-label" for="name">邮箱验证码</label>
                                            <div class="input-group">
    											<input id="email_code" class="form-control" style="height: auto" type="text" name="email_code" required><button class="btn btn-primary" type="button" id="email_verify">获取验证码</button>
                                            </div>
                                            <br/>
                                        {/if}
                                        
                                        <div class="form-group">
                                            <label for="passwd" class="form-label">密码</label>
                                            <input id="passwd" class="form-control" type="password" name="passwd" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="repasswd" class="form-label">重复密码</label>
                                            <input id="repasswd" class="form-control" type="password" name="repasswd" required>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="code" class="form-label">邀请码</label>
                                            <input id="code" class="form-control" type="text" placeholder="邀请码 (没有邀请码请留空)" name="code">
                                        </div>
                                        
								        {if $geetest_html != null}
								          <div class="form-group">
								              <div class="form-group form-group-label">
								                  <div id="embed-captcha"></div>
								              </div>
								          </div>
								        {/if}
								        
								        {if $recaptcha_sitekey != null}
								          <div class="form-group">
								              <div class="form-group form-group-label">
								                  <div class="g-recaptcha" data-sitekey="{$recaptcha_sitekey}"></div>
								              </div>
								          </div>
								        {/if}
								        
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" type="checkbox" id="agree" tabindex="4" checked/>
                                                <label class="custom-control-label" for="agree">
                                                    注册即代表同意<a href="/tos" target="blank" class="kt-link kt-login__link kt-font-bold">&nbsp;服务条款.</a>
                                                </label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-block" id="register-button">注册</button>
                                    </form>
                                {/if}
                                    <p class="text-center mt-2">
                                        <span>已经有账号了？</span>
                                        <a href="/auth/login">
                                            <span>马上登录 👉</span>
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
		<script src="https://fastly.jsdelivr.net/npm/jquery-validation@1.19.1/dist/jquery.validate.min.js"></script>
		
		<!-- 开始:极验 -->
		{if $geetest_html != null}
			<script src="//static.geetest.com/static/tools/gt.js"></script>
			<script>
				var handlerEmbed = function (captchaObj) {
				  captchaObj.onSuccess(function () {
				      validate = captchaObj.getValidate();
				  });
				  captchaObj.appendTo("#embed-captcha");
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
		
        <script>
            // 注册后自动登录
            function login(email,passwd) {
                $.ajax({
                    type:"POST",
                    url:"/auth/login",
                    dataType:"json",
                    data:{
                        email: email,
                        passwd: passwd,
                        code: '',
                        remember_me: 1
                    },
                });
                window.setTimeout("location.href='/user'", 500);
            };
            "use strict";
            var KTLoginGeneral = function() {
                var handleSignInFormSubmit = function() {
                    $('#register-button').click(function(e) {
                        e.preventDefault();
                        var btn = $(this);
                        var form = $(this).closest('form');
                        form.validate({
                            rules: {
                                name: {
                                    required: true
                                },
                                email: {
                                    required: true
                                },
                                                                
                              	email_code: {
                                    required: true
                                },
                                                                
                              	passwd: {
                                    required: true,
                                    minlength: 8
                                },
                                repasswd: {
                                    required: true
                                },
                                agree: {
                                    required: true
                                }                            
                            },
                            messages: {
                                name: "请填写昵称",
                                email: "请填写邮箱",
                                email_code: "请填写邮箱验证码",                                
                              	passwd: {
                                    required: "请填写密码",
                                    minlength: "密码至少需要8位以上"
                                },
                                repasswd: "请再次填写密码",
                                agree: "使用本站服务必须同意服务条款"
                            },
                            errorPlacement: function(error, element) {
                            error.appendTo( element.parent() ); 
                            element.addClass('is-invalid');
                            error.addClass('invalid-feedback');
                            }
                        });
                        if (!form.valid()) {
                            $.notify({
                                message: '<strong>请完善注册资料</strong>'
                            },{
                                type: 'danger',
                                placement: { 
                                    from: "top", 
                                    align: "center"
                                },
                                timer: 1000,
                                animate: {
                                    enter: 'animated zoomIn',
                                    exit: 'animated zoomOut'
                                }
                            });
                            return;
                        };
                        
						{if $geetest_html != null}
						  validate = captcha.getValidate();
						  if (typeof validate === 'undefined' || !validate) {
						    swal.fire('请验证身份', '请滑动验证码来完成验证。', 'info');
						    return;
						  }
						{/if}
                        
                        $("#register-button").text('注册中');
                        $('#register-button').attr('disabled', true);

            			code = $("#code").val();
                      
                        {if $Cool_Config['enable_register_email_restrict'] == true}
                        	var email = $("#email").val() + $("#email_postfix").val();
                      	{else}
                        	var email = $("#email").val();
                        {/if}
                        
                        $.ajax({
                            type: "POST",
                            url: location.pathname,
                            dataType: "json",
                            data: {
					              email: email,
					              name: $("#name").val(),
					              passwd: $("#passwd").val(),
					              repasswd: $("#repasswd").val(),
					              {if $recaptcha_sitekey != null}
					                recaptcha: grecaptcha.getResponse(),
					              {/if}
					              {if $enable_email_verify == 'true'}
					                emailcode: $("#email_code").val(),
					              {/if}
					              code: code
					              {if $geetest_html != null},
					                geetest_challenge: validate.geetest_challenge,
					                geetest_validate: validate.geetest_validate,
					                geetest_seccode: validate.geetest_seccode
					              {/if}                          
                            },
                            success: function (data) {
                                if (data.ret == 1) {
                                    swal.fire({
                                        type: 'success',
                                        title: '注册成功',
                                        confirmButtonText: '转入用户中心',
                                        confirmButtonClass: 'btn btn-info',
                                        onClose: () => {
                                            login(email, $("#passwd").val());
                                        }
                                    });
                                } else {
                                    $("#register-button").text('注册');
                                    $('#register-button').attr('disabled', false);
                                    {if $geetest_html != null}
					                	captcha.reset();
					                {/if}
					                $("#code").val(code);
                                    $.notify({
                                        message: '<strong>'+data.msg+'</strong>'
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
                            }
                        });
                    });
                    
                }
                return {
                    init: function() {
                        handleSignInFormSubmit();
                    }
                };
            }();
            jQuery(document).ready(function() {
                KTLoginGeneral.init();
            });
        </script> 
        
	{if $enable_email_verify == 'true'}
		<script>
            // 计时器
            var wait = 60;
            function time(o) {
                if (wait == 0) {
                    o.removeAttr("disabled");
                    o.text("获取验证码");
                    wait = 60;
                } else {
                    o.attr("disabled", "disabled");
                    o.text("重新发送(" + wait + ")");
                    wait--;
                    setTimeout(function () {
                        time(o)
                    },
                    1000)
                }
            }
			
			// 验证码
            $("#email_verify").click(function () {
                $("#email_verify").text('正在发送');
                $('#email_verify').attr('disabled', true);
                $.ajax({
                    type: "POST",
                    url: "send",
                    dataType: "json",
                    data: {
                        email: $("#email").val(){if $Cool_Config['enable_register_email_restrict'] == true} + $("#email_postfix").val(){/if}
                    },
                    success: function (data) {
                        if (data.ret) {
                            $.notify({
                                title: '<strong>已发送验证码</strong>',
                                message: '如长时间未收到，请查看邮件垃圾箱；国内邮箱可能出现延迟。'
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
                            time($("#email_verify"));
                            $('#email_verify').attr('disabled', false);
                        } else {
                            $.notify({
                                title: '<strong>发送验证码失败</strong>',
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
                            $("#email_verify").text('获取验证码');
                            $('#email_verify').attr('disabled', false);
                        }
                    }
                });
            });
        </script> 
	{/if}
	
    {*dumplin:aff链*}
    <script>
        {*dumplin：轮子1.js读取url参数*}
        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == variable) {
                    return pair[1];
                }
            }
            return "";
        }
    
        {*dumplin:轮子2.js写入cookie*}
        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toGMTString();
            document.cookie = cname + "=" + cvalue + "; " + expires;
        }
    
        {*dumplin:轮子3.js读取cookie*}
        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i].trim();
                if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
            }
            return "";
        }
    
        {*dumplin:读取url参数写入cookie，自动跳转隐藏url邀请码*}
        if (getQueryVariable('code') != '') {
            setCookie('code', getQueryVariable('code'), 30);
            window.location.href = '/auth/register';
        }
    
        {*dumplin:读取cookie，自动填入邀请码框*}
        if ((getCookie('code')) != '') {
            $("#code").val(getCookie('code'));
        }
    </script>
    <!-- 结束:JavaScript -->  
		
    </body>
</html>