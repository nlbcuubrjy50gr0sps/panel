<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>{$config["appName"]}</title>
    <!-- Favicon -->
    <link href="/favicon.png" rel="icon" type="image/png">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" href="https://fastly.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/theme/style-{$Cool_Config['theme_style_color']}.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/cool.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="/theme/cool/assets/css/plugins/sweetalert2.min.css">
    <!-- END: Theme CSS-->
    <style>
        .goog-te-banner-frame {
            display: none
        }

        .icon-ver {
            vertical-align: middle;
        }

        .col-xxxs {
            float: none;
            width: 17%;
        }
    </style>
</head>

<body>
    <!-- Main content -->
    <div class="main-content" id="panel" style="overflow-y: auto;">
        <div class="container-fluid">
            <!-- Table -->
            <div class="row">
                <div class="col-lg-6 col-sm-6">
                    <!-- Custom form validation -->
                    <div class="card">
                        <!-- Card header -->
                        <div class="card-header">
                            <h5 class="mb-0">配置信息 (Vless)</h5>
                        </div>
                        <!-- Card body -->
                        <div class="card-body">
                            <div class="tab-content">
                                <table>
                                    <tbody>
                                        {foreach $node['info'] as $key => $value}
                                        <tr>
                                            <td>{$key}</td>
                                            <td>{$value}</td>
                                        </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                                <p align="center" class="mt-2">
                                  <a class="btn btn-sm btn-primary" href="{$node['url']}">点击添加</a>
                                  <span class="btn btn-sm btn-primary copy-modal" data-clipboard-text="{$node['url']}">点击复制</span> 
                                </p>
                            </div>
                        </div>
                    </div>
                    <!--card-->
                </div>
            </div>
            <!--row-->

        </div><!-- Page content -->
    </div><!-- Main content -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="/theme/cool/assets/js/clipboard.min.js"></script>
    <script src="/theme/cool/assets/vendors/js/vendors.min.js"></script>
    <script src="/theme/cool/assets/js/sweetalert2.min.js"></script>
    <script src="/theme/cool/assets/js/cool.js?{$Cool_Config['Cool_js_version']}"></script>
</body>
</html>