<?php

declare(strict_types=1);

use Slim\App as SlimApp;
use App\Middleware\{Auth, Guest, Admin, Mod_Mu};

return function (SlimApp $app) {
    // Home
    $app->get('/',          App\Controllers\HomeController::class . ':index');
    $app->get('/404',       App\Controllers\HomeController::class . ':page404');
    $app->get('/405',       App\Controllers\HomeController::class . ':page405');
    $app->get('/500',       App\Controllers\HomeController::class . ':page500');
    $app->get('/tos',       App\Controllers\HomeController::class . ':tos');
    $app->get('/staff',     App\Controllers\HomeController::class . ':staff');

    // other
    $app->post('/notify',               App\Controllers\HomeController::class . ':notify');

    // Telegram
    $app->post('/telegram_callback',    App\Controllers\HomeController::class . ':telegram');
    
    // Cool
    $app->get('/shop',                          App\Controllers\ShopController::class . ':index');
    $app->get('/shop/getshopinfo',              App\Controllers\ShopController::class . ':getShopInfo');
    $app->post('/shop/purchase',                App\Controllers\ShopController::class . ':purchase');

    // User Center
    $app->group('/user', function () {
        $this->get('',                          App\Controllers\UserController::class . ':index');
        $this->get('/',                         App\Controllers\UserController::class . ':index');

        $this->post('/checkin',                 App\Controllers\UserController::class . ':doCheckin');

        $this->get('/tutorial',                 App\Controllers\UserController::class . ':tutorial');
        $this->get('/announcement',             App\Controllers\UserController::class . ':announcement');

        $this->get('/donate',                   App\Controllers\UserController::class . ':donate');
        $this->get('/profile',                  App\Controllers\UserController::class . ':profile');
        $this->get('/invite',                   App\Controllers\UserController::class . ':invite');
        $this->get('/disable',                  App\Controllers\UserController::class . ':disable');

        $this->get('/node',                     App\Controllers\User\NodeController::class . ':user_node_page');
        $this->get('/node/{id}/ajax',           App\Controllers\User\NodeController::class . ':user_node_ajax');
        $this->get('/node/{id}',                App\Controllers\User\NodeController::class . ':user_node_info');

        $this->get('/detect',                   App\Controllers\UserController::class . ':detect_index');
        $this->get('/detect/log',               App\Controllers\UserController::class . ':detect_log');

        $this->get('/shop',                     App\Controllers\UserController::class . ':shop');
        $this->post('/coupon_check',            App\Controllers\UserController::class . ':CouponCheck');
        $this->post('/buy',                     App\Controllers\UserController::class . ':buy');
        $this->post('/buy_traffic_package',     App\Controllers\UserController::class . ':buy_traffic_package');

        $this->get('/ticket',                   App\Controllers\User\TicketController::class . ':ticket');
        $this->get('/ticket/create',            App\Controllers\User\TicketController::class . ':ticket_create');
        $this->post('/ticket',                  App\Controllers\User\TicketController::class . ':ticket_add');
        $this->get('/ticket/{id}/view',         App\Controllers\User\TicketController::class . ':ticket_view');
        $this->put('/ticket/{id}',              App\Controllers\User\TicketController::class . ':ticket_update');

        $this->post('/buy_invite',              App\Controllers\UserController::class . ':buyInvite');
        $this->post('/custom_invite',           App\Controllers\UserController::class . ':customInvite');
        $this->get('/edit',                     App\Controllers\UserController::class . ':edit');
        $this->post('/email',                   App\Controllers\UserController::class . ':updateEmail');
        $this->post('/username',                App\Controllers\UserController::class . ':updateUsername');
        $this->post('/password',                App\Controllers\UserController::class . ':updatePassword');
        $this->post('/send',                    App\Controllers\AuthController::class . ':sendVerify');
        $this->post('/wechat',                  App\Controllers\UserController::class . ':updateWechat');
        $this->post('/ssr',                     App\Controllers\UserController::class . ':updateSSR');
        $this->post('/theme',                   App\Controllers\UserController::class . ':updateTheme');
        $this->post('/mail',                    App\Controllers\UserController::class . ':updateMail');
        $this->post('/sspwd',                   App\Controllers\UserController::class . ':updateSsPwd');
        $this->post('/method',                  App\Controllers\UserController::class . ':updateMethod');
        $this->post('/hide',                    App\Controllers\UserController::class . ':updateHide');
        $this->get('/sys',                      App\Controllers\UserController::class . ':sys');
        $this->get('/trafficlog',               App\Controllers\UserController::class . ':trafficLog');
        $this->get('/kill',                     App\Controllers\UserController::class . ':kill');
        $this->post('/kill',                    App\Controllers\UserController::class . ':handleKill');
        $this->get('/logout',                   App\Controllers\UserController::class . ':logout');
        $this->get('/backtoadmin',              App\Controllers\UserController::class . ':backtoadmin');
        $this->get('/code',                     App\Controllers\UserController::class . ':code');

        $this->get('/code_check',               App\Controllers\UserController::class . ':code_check');
        $this->post('/code',                    App\Controllers\UserController::class . ':codepost');
        $this->post('/gacheck',                 App\Controllers\UserController::class . ':GaCheck');
        $this->post('/gaset',                   App\Controllers\UserController::class . ':GaSet');
        $this->get('/gareset',                  App\Controllers\UserController::class . ':GaReset');
        $this->get('/telegram_reset',           App\Controllers\UserController::class . ':telegram_reset');
        $this->post('/resetport',               App\Controllers\UserController::class . ':ResetPort');
        $this->post('/specifyport',             App\Controllers\UserController::class . ':SpecifyPort');
        $this->post('/unblock',                 App\Controllers\UserController::class . ':Unblock');
        $this->get('/bought',                   App\Controllers\UserController::class . ':bought');
        $this->delete('/bought',                App\Controllers\UserController::class . ':deleteBoughtGet');
        $this->get('/url_reset',                App\Controllers\UserController::class . ':resetURL');
        $this->get('/inviteurl_reset',          App\Controllers\UserController::class . ':resetInviteURL');

        // 订阅记录
        $this->get('/subscribe_log',            App\Controllers\UserController::class . ':subscribe_log');

        // getUserAllURL
        $this->get('/getUserAllURL',            App\Controllers\UserController::class . ':getUserAllURL');

        // getPcClient
        $this->get('/getPcClient',              App\Controllers\UserController::class . ':getPcClient');

        $this->post('/code/f2fpay',             App\Services\Payment::class . ':purchase');
        $this->get('/code/codepay',             App\Services\Payment::class . ':purchase');

        //Reconstructed Payment System
        $this->post('/payment/purchase',        App\Services\Payment::class . ':purchase');
        $this->get('/payment/return',           App\Services\Payment::class . ':returnHTML');

        $this->post('/doiam',                   App\Services\Payment::class . ':purchase');
        
        // Cool theme
        $this->get('/qrcode',                   App\Controllers\UserController::class . ':qrcode');
        $this->get('/money',                    App\Controllers\UserController::class . ':getmoney');
        $this->post('/node_filter',             App\Controllers\UserController::class . ':nodeFilterSave');
        
        $this->post('/redeem',                  App\Controllers\UserController::class . ':redeem');         // 套餐兑换
        $this->post('/quantitypay',             App\Controllers\UserController::class . ':quantitypay');    // 按量付费

        $this->get('/agent',                    App\Services\CoolConfig::class . ':agent');                 // 代理商
        $this->post('/agent/ajax',              App\Services\CoolConfig::class . ':agentlist'); 
        $this->get('/agent/view/{id}',          App\Services\CoolConfig::class . ':agent_user');
        $this->post('/agent/view/{id}',         App\Services\CoolConfig::class . ':agent_user_save');
  	    $this->post('/addUser',                 App\Services\CoolConfig::class . ':addUser');
        $this->delete('/agentdelete',           App\Services\CoolConfig::class . ':addDelete');
        
        $this->get('/help',                     App\Services\CoolConfig::class . ':help');                       // 帮助文档
        $this->get('/help/view/{id}',           App\Services\CoolConfig::class . ':help_doc');
        $this->get('/help/view/{id}/{doc}',     App\Services\CoolConfig::class . ':help_doc');
        
        $this->get('/faq',                      App\Services\CoolConfig::class . ':FAQ');                       // 常见问题
        
        $this->post('/shop/getshopinfo',        App\Controllers\UserController::class . ':getShopInfo');        // 商品
        $this->post('/shop/buytrafficpackage',  App\Controllers\UserController::class . ':buyTrafficPackage');  // 购买流量包
        $this->post('/shop/packageconversion',  App\Controllers\UserController::class . ':PackageConversion');  // 套餐折算
        
	    $this->get('/media',                    App\Controllers\UserController::class . ':media');              // 流媒体
	    $this->get('/share-account',            App\Controllers\UserController::class . ':share_account');      // 共享帐号
    })->add(new Auth());

    $app->group('/payment', function () {
        $this->get('/notify',           App\Services\Payment::class . ':notify');
        $this->post('/notify',          App\Services\Payment::class . ':notify');
        $this->post('/notify/{type}',   App\Services\Payment::class . ':notify');
        $this->get('/notify/{type}',    App\Services\Payment::class . ':notify');
        $this->post('/status',          App\Services\Payment::class . ':getStatus');
    });

    // Auth
    $app->group('/auth', function () {
        $this->get('/login',            App\Controllers\AuthController::class . ':login');
        $this->post('/qrcode_check',    App\Controllers\AuthController::class . ':qrcode_check');
        $this->post('/login',           App\Controllers\AuthController::class . ':loginHandle');
        $this->post('/qrcode_login',    App\Controllers\AuthController::class . ':qrcode_loginHandle');
        $this->get('/register',         App\Controllers\AuthController::class . ':register');
        $this->post('/register',        App\Controllers\AuthController::class . ':registerHandle');
        $this->post('/send',            App\Controllers\AuthController::class . ':sendVerify');
        $this->get('/logout',           App\Controllers\AuthController::class . ':logout');
        $this->get('/telegram_oauth',   App\Controllers\AuthController::class . ':telegram_oauth');
        $this->get('/login_getCaptcha', App\Controllers\AuthController::class . ':getCaptcha');
    })->add(new Guest());

    // Password
    $app->group('/password', function () {
        $this->get('/reset',            App\Controllers\PasswordController::class . ':reset');
        $this->post('/reset',           App\Controllers\PasswordController::class . ':handleReset');
        $this->get('/token/{token}',    App\Controllers\PasswordController::class . ':token');
        $this->post('/token/{token}',   App\Controllers\PasswordController::class . ':handleToken');
    })->add(new Guest());

    // Admin
    $app->group('/admin', function () {
        $this->get('',                          App\Controllers\AdminController::class . ':index');
        $this->get('/',                         App\Controllers\AdminController::class . ':index');

        $this->get('/sys',                      App\Controllers\AdminController::class . ':sys');
        $this->get('/invite',                   App\Controllers\AdminController::class . ':invite');
        $this->post('/invite',                  App\Controllers\AdminController::class . ':addInvite');
        $this->post('/chginvite',               App\Controllers\AdminController::class . ':chgInvite');
        $this->post('/payback/ajax',            App\Controllers\AdminController::class . ':ajax_payback');

        // Node Mange
        $this->get('/node',                     App\Controllers\Admin\NodeController::class . ':index');
        $this->get('/node/create',              App\Controllers\Admin\NodeController::class . ':create');
        $this->post('/node',                    App\Controllers\Admin\NodeController::class . ':add');
        $this->get('/node/{id}/edit',           App\Controllers\Admin\NodeController::class . ':edit');
        $this->put('/node/{id}',                App\Controllers\Admin\NodeController::class . ':update');
        $this->delete('/node',                  App\Controllers\Admin\NodeController::class . ':delete');
        $this->post('/node/ajax',               App\Controllers\Admin\NodeController::class . ':ajax');

        // Ticket Mange
        $this->get('/ticket',                   App\Controllers\Admin\TicketController::class . ':index');
        $this->post('/ticket',                  App\Controllers\Admin\TicketController::class . ':add');
        $this->get('/ticket/{id}/view',         App\Controllers\Admin\TicketController::class . ':show');
        $this->put('/ticket/{id}',              App\Controllers\Admin\TicketController::class . ':update');
        $this->post('/ticket/ajax',             App\Controllers\Admin\TicketController::class . ':ajax');

        // Shop Mange
        $this->get('/shop',                     App\Controllers\Admin\ShopController::class . ':index');
        $this->post('/shop/ajax',               App\Controllers\Admin\ShopController::class . ':ajax_shop');
        $this->get('/shop/create',              App\Controllers\Admin\ShopController::class . ':create');
        $this->post('/shop',                    App\Controllers\Admin\ShopController::class . ':add');
        $this->get('/shop/{id}/edit',           App\Controllers\Admin\ShopController::class . ':edit');
        $this->put('/shop/{id}',                App\Controllers\Admin\ShopController::class . ':update');
        $this->delete('/shop',                  App\Controllers\Admin\ShopController::class . ':deleteGet');

        // Bought Mange
        $this->get('/bought',                   App\Controllers\Admin\ShopController::class . ':bought');
        $this->delete('/bought',                App\Controllers\Admin\ShopController::class . ':deleteBoughtGet');
        $this->post('/bought/ajax',             App\Controllers\Admin\ShopController::class . ':ajax_bought');

        // Ann Mange
        $this->get('/announcement',             App\Controllers\Admin\AnnController::class . ':index');
        $this->get('/announcement/create',      App\Controllers\Admin\AnnController::class . ':create');
        $this->post('/announcement',            App\Controllers\Admin\AnnController::class . ':add');
        $this->get('/announcement/{id}/edit',   App\Controllers\Admin\AnnController::class . ':edit');
        $this->put('/announcement/{id}',        App\Controllers\Admin\AnnController::class . ':update');
        $this->delete('/announcement',          App\Controllers\Admin\AnnController::class . ':delete');
        $this->post('/announcement/ajax',       App\Controllers\Admin\AnnController::class . ':ajax');

        // Detect Mange
        $this->get('/detect',                   App\Controllers\Admin\DetectController::class . ':index');
        $this->get('/detect/create',            App\Controllers\Admin\DetectController::class . ':create');
        $this->post('/detect',                  App\Controllers\Admin\DetectController::class . ':add');
        $this->get('/detect/{id}/edit',         App\Controllers\Admin\DetectController::class . ':edit');
        $this->put('/detect/{id}',              App\Controllers\Admin\DetectController::class . ':update');
        $this->delete('/detect',                App\Controllers\Admin\DetectController::class . ':delete');
        $this->get('/detect/log',               App\Controllers\Admin\DetectController::class . ':log');
        $this->post('/detect/ajax',             App\Controllers\Admin\DetectController::class . ':ajax_rule');
        $this->post('/detect/log/ajax',         App\Controllers\Admin\DetectController::class . ':ajax_log');

        // IP Mange
        $this->get('/block',                    App\Controllers\Admin\IpController::class . ':block');
        $this->get('/unblock',                  App\Controllers\Admin\IpController::class . ':unblock');
        $this->post('/unblock',                 App\Controllers\Admin\IpController::class . ':doUnblock');
        $this->get('/login',                    App\Controllers\Admin\IpController::class . ':index');
        $this->get('/alive',                    App\Controllers\Admin\IpController::class . ':alive');
        $this->post('/block/ajax',              App\Controllers\Admin\IpController::class . ':ajax_block');
        $this->post('/unblock/ajax',            App\Controllers\Admin\IpController::class . ':ajax_unblock');
        $this->post('/login/ajax',              App\Controllers\Admin\IpController::class . ':ajax_login');
        $this->post('/alive/ajax',              App\Controllers\Admin\IpController::class . ':ajax_alive');

        // Code Mange
        $this->get('/code',                     App\Controllers\Admin\CodeController::class . ':index');
        $this->get('/code/create',              App\Controllers\Admin\CodeController::class . ':create');
        $this->post('/code',                    App\Controllers\Admin\CodeController::class . ':add');
        $this->get('/donate/create',            App\Controllers\Admin\CodeController::class . ':donate_create');
        $this->post('/donate',                  App\Controllers\Admin\CodeController::class . ':donate_add');
        $this->post('/code/ajax',               App\Controllers\Admin\CodeController::class . ':ajax_code');

        // User Mange
        $this->get('/user',                     App\Controllers\Admin\UserController::class . ':index');
        $this->get('/user/{id}/edit',           App\Controllers\Admin\UserController::class . ':edit');
        $this->put('/user/{id}',                App\Controllers\Admin\UserController::class . ':update');
        $this->delete('/user',                  App\Controllers\Admin\UserController::class . ':delete');
        $this->post('/user/changetouser',       App\Controllers\Admin\UserController::class . ':changetouser');
        $this->post('/user/ajax',               App\Controllers\Admin\UserController::class . ':ajax');
        $this->post('/user/create',             App\Controllers\Admin\UserController::class . ':createNewUser');

        // Coupon Mange
        $this->get('/coupon',                   App\Controllers\AdminController::class . ':coupon');
        $this->post('/coupon',                  App\Controllers\AdminController::class . ':addCoupon');
        $this->post('/coupon/ajax',             App\Controllers\AdminController::class . ':ajax_coupon');

        // Subscribe Log Mange
        $this->get('/subscribe',                App\Controllers\Admin\SubscribeLogController::class . ':index');
        $this->post('/subscribe/ajax',          App\Controllers\Admin\SubscribeLogController::class . ':ajax_subscribe_log');

        // Detect Ban Mange
        $this->get('/detect/ban',               App\Controllers\Admin\DetectBanLogController::class . ':index');
        $this->post('/detect/ban/ajax',         App\Controllers\Admin\DetectBanLogController::class . ':ajax_log');

        // Redeem Mange
        $this->get('/redeem',                   App\Controllers\AdminController::class . ':redeem');
        $this->post('/redeem',                  App\Controllers\AdminController::class . ':addRedeem');
        $this->post('/redeem/ajax',             App\Controllers\AdminController::class . ':ajax_redeem');

        // 指定用户购买记录以及添加套餐
        $this->get('/user/{id}/bought',         App\Controllers\Admin\UserLog\BoughtLogController::class . ':bought');
        $this->post('/user/{id}/bought/ajax',   App\Controllers\Admin\UserLog\BoughtLogController::class . ':bought_ajax');
        $this->delete('/user/bought',           App\Controllers\Admin\UserLog\BoughtLogController::class . ':bought_delete');
        $this->post('/user/{id}/bought/buy',    App\Controllers\Admin\UserLog\BoughtLogController::class . ':bought_add');

        // 指定用户充值记录
        $this->get('/user/{id}/code',           App\Controllers\Admin\UserLog\CodeLogController::class . ':index');
        $this->post('/user/{id}/code/ajax',     App\Controllers\Admin\UserLog\CodeLogController::class . ':ajax');

        // 指定用户订阅记录
        $this->get('/user/{id}/sublog',         App\Controllers\Admin\UserLog\SubLogController::class . ':index');
        $this->post('/user/{id}/sublog/ajax',   App\Controllers\Admin\UserLog\SubLogController::class . ':ajax');

        // 指定用户审计记录
        $this->get('/user/{id}/detect',         App\Controllers\Admin\UserLog\DetectLogController::class . ':index');
        $this->post('/user/{id}/detect/ajax',   App\Controllers\Admin\UserLog\DetectLogController::class . ':ajax');

        // 指定用户登录记录
        $this->get('/user/{id}/login',          App\Controllers\Admin\UserLog\LoginLogController::class . ':index');
        $this->post('/user/{id}/login/ajax',    App\Controllers\Admin\UserLog\LoginLogController::class . ':ajax');
        
        // Cool
        $this->post('/nologin',                 App\Controllers\AdminController::class         . ':delete_nologin');       // delete log
        $this->post('/detect_log',              App\Controllers\AdminController::class      . ':delete_detect_log');
        $this->post('/login_ip',                App\Controllers\AdminController::class        . ':delete_login_ip');
        $this->post('/paylist',                 App\Controllers\AdminController::class         . ':delete_paylist');
        $this->post('/codelist',                App\Controllers\AdminController::class         . ':delete_codelist');
        $this->post('/node_info',               App\Controllers\AdminController::class       . ':delete_node_info');
        $this->post('/node_online_log',         App\Controllers\AdminController::class . ':delete_node_online_log');
        $this->post('/trafficlog',              App\Controllers\AdminController::class      . ':delete_trafficlog');
        
        $this->post('/user/addclass',           App\Controllers\Admin\UserController::class . ':addclass');     // 用户中心功能
        $this->post('/user/addtraffic',         App\Controllers\Admin\UserController::class . ':addtraffic');
        $this->post('/user/addmoney',           App\Controllers\Admin\UserController::class . ':addmoney');
        
        $this->get('/faq',                      App\Controllers\Admin\FaqController::class . ':index');        // 常见问题
        $this->get('/faq/create',               App\Controllers\Admin\FaqController::class . ':create');
        $this->get('/faq/{id}/edit',            App\Controllers\Admin\FaqController::class . ':edit');
        $this->put('/faq/{id}',                 App\Controllers\Admin\FaqController::class . ':update');
        $this->delete('/faq',                   App\Controllers\Admin\FaqController::class . ':delete');
        $this->post('/faq',                     App\Controllers\Admin\FaqController::class . ':add');
        $this->post('/faq/ajax',                App\Controllers\Admin\FaqController::class . ':ajax');
        
        // 帮助文档
        $this->group('/help', function () {
            $this->get('/document',             App\Controllers\Admin\HelpController::class . ':index');
            $this->get('/document/create',      App\Controllers\Admin\HelpController::class . ':create');
            $this->get('/document/gethelpclass',App\Controllers\Admin\HelpController::class . ':getHelpClass');
            $this->get('/document/{id}/edit',   App\Controllers\Admin\HelpController::class . ':edit');
            $this->put('/document/{id}',        App\Controllers\Admin\HelpController::class . ':update');
            $this->delete('/document',          App\Controllers\Admin\HelpController::class . ':delete');
            $this->post('/document',            App\Controllers\Admin\HelpController::class . ':add');
            $this->post('/document/ajax',       App\Controllers\Admin\HelpController::class . ':ajax');

            $this->get('/class',                App\Controllers\Admin\HelpController::class . ':class_index');
            $this->get('/class/create',         App\Controllers\Admin\HelpController::class . ':class_create');
            $this->get('/class/{id}/edit',      App\Controllers\Admin\HelpController::class . ':class_edit');
            $this->put('/class/{id}',           App\Controllers\Admin\HelpController::class . ':class_update');
            $this->delete('/class',             App\Controllers\Admin\HelpController::class . ':class_delete');
            $this->post('/class',               App\Controllers\Admin\HelpController::class . ':class_add');
            $this->post('/class/ajax',          App\Controllers\Admin\HelpController::class . ':class_ajax');
        });

        // Config Mange
        $this->group('/config', function () {
            $this->put('/update/{key}',         App\Controllers\Admin\GConfigController::class . ':update');
            $this->get('/update/{key}/edit',    App\Controllers\Admin\GConfigController::class . ':edit');

            $this->get('/telegram',             App\Controllers\Admin\GConfigController::class . ':telegram');
            $this->post('/telegram/ajax',       App\Controllers\Admin\GConfigController::class . ':telegram_ajax');

            $this->get('/register',             App\Controllers\Admin\GConfigController::class . ':register');
            $this->post('/register/ajax',       App\Controllers\Admin\GConfigController::class . ':register_ajax');
        });
    })->add(new Admin());

    // mu
    $app->group('/mod_mu', function () {
        // 流媒体检测
        $this->post('/media/saveReport',    App\Controllers\Mod_Mu\NodeController::class . ':saveReport');
        // 其他
        $this->get('/nodes/{id}/info',      App\Controllers\Mod_Mu\NodeController::class . ':get_info');
        $this->post('/nodes/{id}/info',     App\Controllers\Mod_Mu\NodeController::class . ':info');
        $this->get('/nodes',                App\Controllers\Mod_Mu\NodeController::class . ':get_all_info');
        $this->post('/nodes/config',        App\Controllers\Mod_Mu\NodeController::class . ':getConfig');

        $this->get('/users',                App\Controllers\Mod_Mu\UserController::class . ':index');
        $this->post('/users/traffic',       App\Controllers\Mod_Mu\UserController::class . ':addTraffic');
        $this->post('/users/aliveip',       App\Controllers\Mod_Mu\UserController::class . ':addAliveIp');
        $this->post('/users/detectlog',     App\Controllers\Mod_Mu\UserController::class . ':addDetectLog');

        $this->get('/func/detect_rules',    App\Controllers\Mod_Mu\FuncController::class . ':get_detect_logs');
        $this->post('/func/block_ip',       App\Controllers\Mod_Mu\FuncController::class . ':addBlockIp');
        $this->get('/func/block_ip',        App\Controllers\Mod_Mu\FuncController::class . ':get_blockip');
        $this->get('/func/unblock_ip',      App\Controllers\Mod_Mu\FuncController::class . ':get_unblockip');
        $this->get('/func/ping',            App\Controllers\Mod_Mu\FuncController::class . ':ping');
        //============================================
    })->add(new Mod_Mu());

    // res
    $app->group('/res', function () {
        $this->get('/captcha/{id}',     App\Controllers\ResController::class . ':captcha');
    });

    $app->group('/link', function () {
        $this->get('/{token}',          App\Controllers\LinkController::class . ':GetContent');
    });
    
    //doc
    $app->group('/doc', function () {
        $this->get('',      App\Controllers\HomeController::class . ':getDocCenter');
        $this->get('/',     App\Controllers\HomeController::class . ':getDocCenter');
    });
    $app->get('/sublink',   App\Controllers\HomeController::class . ':getSubLink');
    //doc end

    $app->group('/getClient', function () {
        $this->get('/{token}', App\Controllers\UserController::class . ':getClientfromToken');
    });
    
};
