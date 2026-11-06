<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <title>扫码支付</title>
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
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/cool.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/style-{$Cool_Config['theme_style_color']}.css">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/sweetalert2.min.css">
    <!-- END: Page CSS-->
    
</head>
<!-- END: Head-->

<body>
    <div class="app-content">
        <section class="section">
            <div class="container mt-5">
                <div class="row">
                    <div class="col-12 col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-8 ">
                        <div class="card ">
                            <div class="card-header" style="margin: 0.5rem auto">
                                <h4 id='title'></h4>
                            </div>

                            <div class="card-body">
                                <div class="form-group text-center">
                                    <div id="qrcode"></div>
                                </div>

                                <div class="form-group text-center">
                                    <a href="#" class="btn btn-icon icon-left" style="color: #98a6ad;" onclick="window.history.go(-1);"><i class="fas fa-arrow-left"></i> 返回上一页</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- BEGIN: Vendor JS-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="/theme/cool/assets/vendors/js/vendors.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="/theme/cool/assets/js/notify.js"></script>
    <script src="/theme/cool/assets/js/clipboard.min.js"></script>
    <script src="/theme/cool/assets/js/sweetalert2.min.js"></script>
    <script src="/theme/cool/assets/js/cool.js?{$Cool_Config['Cool_js_version']}"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="/theme/cool/assets/js/core/app.js"></script>
    <script src="/theme/cool/assets/js/core/app-menu.js"></script>
    <!-- BEGIN: Page JS-->


    <script src="https://fastly.jsdelivr.net/npm/kjua@0.1.2/dist/kjua.min.js"></script>

    <script>
        function getQueryParam(name) {
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                if (pair[0] == name) {
                    return pair[1];
                }
            }
            return (false);
        }

        function f() {
            $.ajax({
                type: "POST",
                url: "/payment/status",
                dataType: "json",
                data: {
                    tradeno: tradeno
                },
                success: function(data) {
                    if (data.result) {
                        clearTimeout(tid);
                        window.location.assign('/user/payment/return?tradeno=' + tradeno);
                    }
                },
                error: function(jqXHR) {
                    console.log(jqXHR);
                }
            });
            tid = setTimeout(f, 1000);
        }

        var payment = getQueryParam('type');
        var price = getQueryParam('price');
        var tradeno = getQueryParam('tradeno');

        if (payment == 'alipay') {
            $('#title').text('打开支付宝，扫码支付' + price + '元');
        } else if (payment == 'wechat') {
            $('#title').text('打开微信，扫码支付' + price + '元');
        }

        var qrcode = decodeURIComponent(getQueryParam('qrcode'));
        $('#qrcode').html(
            kjua({
                text: qrcode,
                render: 'image',
                size: 256
            })
        );

        setTimeout(f, 1000);
    </script>
</body>

</html>