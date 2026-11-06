<?php

/*

 .----------------.  .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. |
| |     ______   | || |     ____     | || |     ____     | || |   _____      | |
| |   .' ___  |  | || |   .'    `.   | || |   .'    `.   | || |  |_   _|     | |
| |  / .'   \_|  | || |  /  .--.  \  | || |  /  .--.  \  | || |    | |       | |
| |  | |         | || |  | |    | |  | || |  | |    | |  | || |    | |   _   | |
| |  \ `.___.'\  | || |  \  `--'  /  | || |  \  `--'  /  | || |   _| |__/ |  | |
| |   `._____.'  | || |   `.____.'   | || |   `.____.'   | || |  |________|  | |
| |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------' 

	  by @悟空 https://t.me/Cool_WuKong

*/


# ┌──────────────────────────────────────────────────────────┐
# │                     主题设置                             │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['Cool_version'] = '2022-01'; 		    // 主题版本号，方便区分版本信息
$Cool_Config['Cool_js_version'] = '5.5'; 		    // 可随便写，每次获得最新授权文件就改变这个值进行强制缓存刷新，避免旧的浏览器缓存继续生效
$Cool_Config['theme_style_color'] = 'cyan';		    // 主题配色选项，可选择：purple（紫色）、red（红色）、cyan（青色）、green（绿色）、dark（黑色）
$Cool_Config['layout_typer'] = 'rightVertical';		// 主题布局样式，可选：rightVertical 或 Horizontal
$Cool_Config['small_brand'] = 'Cool';		    // 侧边栏名称
$Cool_Config['document_type'] = 'cool';		        // 帮助文档类型，sspanel: 为SSP原版自带，cool: 为主题自带，管理面板手动编写文档内容
$Cool_Config['enable_telegram_button'] = true;    	// 是否显示侧边栏 Telegram 按钮
$Cool_Config['telegram_group_link'] = '#';   		// Telegram 按钮的链接


# ┌──────────────────────────────────────────────────────────┐
# │                       首页                               │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['subscribe_type'] = ['ss','ssr','v2ray','trojan','v2ray_vless'];    // 'ss','ssr','v2ray','trojan', 'v2ray_vless' 选择网站支持的代理协议，会影响复制订阅链接和一键导入按钮的显示，若无ss，则不显示相关ss订阅
$Cool_Config['index_import_buttons'] = [''];          // 不在首页显示的一键导入按钮， quantumult | shadowrocket | surfboard | quantumultx | surge | kitsunebi

$Cool_Config['enable_index_placard'] = true;        // 是否在用户登录后弹出重要公告
$Cool_Config['enable_index_placard_time'] = true;   // 重要公告弹窗是否24小时只弹一次
$Cool_Config['index_placard_content'] = '
<h4 class="text-center text-primary mb-2">欢迎光临</h4>
<p class="description badge-dot"><i class="bg-warning"></i>你能来到本站说明你已经知道本站是干嘛的了。</p>
<p class="description badge-dot"><i class="bg-warning"></i>首先记住一点, 墙外非法外之地，请注意你的言行，低调是唯一的墙外生存之道。</p>
<p class="description badge-dot"><i class="bg-warning"></i>其次你要熟悉下左侧的菜单栏，记住 <a href="/user">用户中心</a> 的位置。</p>
<p class="description badge-dot"><i class="bg-warning"></i>然后使用任何节点，需遵循节点所属国家的相关法律以及中国法律。</p>
<p class="description badge-dot"><i class="bg-warning"></i>最后有问题请联系客服 或 提交工单</p>
';   // 重要公告的内容


# ┌──────────────────────────────────────────────────────────┐
# │                   管理面板                               │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['quick_operation'] = true;             // 管理员后台是否开启快捷操作  


# ┌──────────────────────────────────────────────────────────┐
# │                   签到设置                               │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['daily_bonus_mode'] = 'sspanel';  // 签到的模式，sspanel: 为原版模式，level: 为不同等级给不同的签到流量
$Cool_Config['daily_bonus_settings'] = [  // 为不同等级给不同的签到流量，仅在 daily_bonus_mode 为 level 时生效
    0 => [  // 用户等级
        'min' => 0,  // 最低流量，单位为MB
        'max' => 50   // 最高流量，单位为MB
    ],
    1 => [
        'min' => 50,
        'max' => 100
    ],
    2 => [
        'min' => 100,
        'max' => 150
    ],
    3 => [
        'min' => 200,
        'max' => 300
    ],
];


# ┌──────────────────────────────────────────────────────────┐
# │                       注册                               │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['enable_register_email_restrict'] = true;      // 设置为true时，会限制注册时使用的邮箱后缀
$Cool_Config['register_email_white_list'] = ['@gmail.com','@qq.com','@outlook.com','@163.com','@126.com','@yeah.net','@foxmail.com'];   
                                                            // 注册时的邮箱后缀白名单，仅在上面的设置为true时生效
$Cool_Config['register_email_black_list'] = ['@bcaoo.com','@chacuo.net','@tmpmail.net','@tmail.ws','@tmpmail.org','@moimoi.re','@bccto.me','@027168.com','@disbox.org','@linshiyouxiang.net','@t.odmail.cn','@tmails.net','@moakt.co','@moakt.ws','@disbox.net','@bareed.ws'];   
                                                            // 注册时的邮箱后缀黑名单
// 循环返利
$Cool_Config['all_rebate'] = true;            // 设置为 true 所有用户都循环返利, false 除了单独用户设置为循环外,其他用户只会获取被邀请用户首次充值金额


# ┌──────────────────────────────────────────────────────────┐
# │                     共享账号                             │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['show_share'] = true;   // 是否显示共享账号
$Cool_Config['share_account'] = [    // 一个array为一个共享账号
    'AppleID' =>
        array(
            'name' => 'AppleID',                                              // 名称
            'img' => '/theme/cool/assets/images/share/appleid.png',           // 头部显示的图片
            'account' => 'COOL',	// 帐号
            'passwd' => '123456',	// 密码
            'class' => 3			// 用户等级要求		
        ), 
    'Netflix' => 
        array(
            'name' => 'Netflix',                                              // 名称
            'img' => '/theme/cool/assets/images/share/netflix.png',           // 头部显示的图片
            'account' => 'COOL',	// 帐号
            'passwd' => '123456',	// 密码
            'class' => 3			// 用户等级要求		
        ), 
    'HBO' => 
        array(
            'name' => 'HBO',                                              // 名称
            'img' => '/theme/cool/assets/images/share/hbo.png',            // 头部显示的图片
            'account' => 'COOL',	// 帐号
            'passwd' => '123456',	// 密码
            'class' => 3			// 用户等级要求		
        ), 
    'Hulu' =>
        array(
            'name' => 'Hulu',                                              // 名称
            'img' => '/theme/cool/assets/images/share/hulu.png',            // 头部显示的图片
            'account' => 'COOL',	// 帐号
            'passwd' => '123456',	// 密码
            'class' => 3			// 用户等级要求
        ), 
];

# ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────┐
# │                                              支付系统 设置                                                │
# └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
# 使用哪种支付方式需要在 Config 中设置好参数
# 未支持的支付方式有：paymentwall
# 目前支持的支付方式: 不使用请设置为 none 
# 支付宝:  f2fpay | stripe | yftpay | mgate | policepay | paybeaver | theadpay | epay | EasyPay
# 微信  :  payjs  | stripe | policepay | paybeaver | theadpay | epay | EasyPay
# 数字货币: none
$Cool_Config['pay_alipay']     = 'none';        // 支付宝默认
$Cool_Config['pay_wxpay']      = 'none';     // 微信默认
$Cool_Config['pay_crypto']     = 'none';	// 数字货币支付
$Cool_Config['mix_amount'] = 0;     // 限制每次最低充值, 商店购买套餐不受此限制。（因为商店扣除余额后可能出现很低的金额）
$Cool_Config['topup_select_list'] = [9.9, 19.9, 29.9,59.9,119.9,219.9];  //充值金额选项设定


# ┌──────────────────────────────────────────────────────────┐
# │                        商店                              │
# └──────────────────────────────────────────────────────────┘
# 折算金额计算方式 time : 按套餐使用了多久计算, flow : 按用户当前流量和套餐流量对比计算 , auto : 自动计算套餐使用时间和流量, 按两者使用百分比最多的计算
$Cool_Config['shop_conversion_mode']   = 'auto';
$Cool_Config['shop_conversion']        = true;          // 允许套餐折算返还余额
$Cool_Config['shop_formalities']       = 2;             // 套餐折算时扣除手续费 (单位: 百分比, 0 为不扣手续费) 不建议太高免得挨骂

$Cool_Config['shop_enable_traffic_package'] = true;     // 商店是否显示流量叠加包的选项（仅在用户购买过商品后才会显示）
$Cool_Config['shop_traffic_package'] = '0.5';		    // 流量包购买，1G 流量多少元

$Cool_Config['shop_redeem'] = true;		                // 商店是否显示套餐兑换
$Cool_Config['shop_redeem_conversion'] = false;		    // 是否允许通过兑换码兑换的套餐折算

$Cool_Config['show_shop_head'] = true;      // 商店是否显示邀请横幅
$Cool_Config['shop_plan'] = array(
    '试用套餐' => array(                    // 对应商店显示的名称
        '描述' => array(                    // 对应的商品描述, 目前取消了
            '试用' => 1,                    // 商品分类对应商品ID，单个分类只能对应一个ID
        ),
    ),
    '青铜套餐' => array(                // 需要多个套餐可以自己复制array增加到下面    
        '描述' => array(                   
            '月付' => 2,                    
            '季付' => 3,
        ),
    ),
    '白银套餐' => array(                // 需要多个套餐可以自己复制array增加到下面
        '描述' => array(
            '月付' => 4,
            '季付' => 5,
        ),
    )
);

// 按量付费  .config里37行配置

// 购买注册一体 访问地址：域名/shop
$Cool_Config['shop_ann'] = 1;		        // 显示的公告ID

# ┌──────────────────────────────────────────────────────────┐
# │                     TG机器人                             │
# └──────────────────────────────────────────────────────────┘
# Telegram 私发至管理员
$Cool_Config['Telegram_Admin']  = [1];      // 管理员的ID (只有这些管理员才能接收到TG通知)
$Cool_Config['Telegram_Ticket'] = true;     // 开启工单的TG通知
$Cool_Config['Telegram_Payment'] = true;    // 用户充值提醒


# ┌──────────────────────────────────────────────────────────┐
# │                     在线客服                             │
# └──────────────────────────────────────────────────────────┘
// Crisp客服 配置
$Cool_Config['enable_crisp'] = false;   // 是否启用 Crisp 在线客服系统 https://crisp.chat
$Cool_Config['enable_crisp_outside'] = false;   // 是否对未登录的用户也启用 Crisp，设置为 false 的话，着陆页和登录/注册等页面不会显示 Crisp 和 charta
$Cool_Config['crisp_wesite_id'] = '';    // Crisp 的网站ID，格式为 '18b46e92-eb21-76d3-bfb7-8f2ae9adba64'

// Chatra客服 配置
$Cool_Config['enable_chatra'] = false;    // 是否启用 Chatra 在线客服系统 https://chatra.io
$Cool_Config['chatra_id'] = '';    // Chatra 的 ChatraID，可以在 Chatra 提供的网站代码里找到


# ┌──────────────────────────────────────────────────────────┐
# │                     节点列表                             │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['show_node_load'] = true;  		// 是否显示节点的负载
$Cool_Config['show_online_user'] = true;		// 是否显示节点的在线人数
$Cool_Config['show_node_traffic_rate'] = true;  // 是否显示节点的流量倍率
$Cool_Config['show_node_speedlimit'] = true;	// 是否显示节点的限速
$Cool_Config['show_node_info'] = true;	        // 是否只允许通过订阅方式获取节点信息

# 节点订阅筛选
$Cool_Config['nodes_filter'] = true;            // 开启订阅节点筛选
$Cool_Config['nodes_miniName'] = true;          // 允许用户开启节点正则匹配简化节点名称, 启用该选项需熟悉使用正则表达式
$Cool_Config['nodes_regex'] = '/\[(.*?)\]/';     // 节点筛选设置中节点名称缩短的正则表达式, 默认 [ ] 中的字符都会被移除

$Cool_Config['node_class_name']          = [   //  节点的等级对应的名字
    0 => '公益节点',   // 格式为 节点等级 => 节点等级名字
    1 => '青铜节点',
    2 => '白银节点',
    3 => '黄金节点',
];

/*
'美国'=>'us'	'香港'=>'hk'	'荷兰'=>'nl'
'新加'=>'sg'	'日本'=>'jp'	'罗马'=>'ro'
'回国'=>'cn'	'中国'=>'cn'	'澳大'=>'au'
'台湾'=>'tw'	'菲律'=>'ph'	'澳门'=>'mo'
'俄罗'=>'ru'	'韩国'=>'kr'	'马来'=>'my'
'德国'=>'de'	'英国'=>'gb'	'法国'=>'fr'
'越南'=>'vn'	'印度'=>'in'	'印尼'=>'id'
*/
$Cool_Config['flag_mode'] = 'node-name';   // 节点列表的国旗取值方式。node-name 为从节点名字前两个字取值（比如美国Vultr取值为美国）。node-info 为从节点状态取值，在节点列表里编辑节点，填写节点状态为 us 则显示美国国旗。us这个是国家ISO 3166码，不懂就谷歌。


# ┌──────────────────────────────────────────────────────────┐
# │                     节点设置                             │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['show_protocol'] = true;   // 是否允许用户自定义混淆和协议
$Cool_Config['show_method'] = true;     // 是否允许用户自定义加密方式


# ┌──────────────────────────────────────────────────────────┐
# │                     使用教程                             │
# └──────────────────────────────────────────────────────────┘
# 说明一下: 安装教程的文件在 主题目录 user/tutorial 下, 该目录下的文件夹对应文档中心的一级分类(去除空格,并区分大小写)
# 各文件夹下的tpl文件的名字 对应文档中心的二级分类(去除空格,并区分大小写)。 
# 如果目录名字或文件名字不对， 文档中心不会显示下载教程链接，首页的下载教程链接也会404
# 这里设置的选项控制主页的显示， 客户端下载链接控制教程页面的客户端下载
/**
 *    Windows 客户端
 */
$Cool_Config['client_windows'] = [
    'ssr' => array(                                                         // 一个array为一个客户端, 可以自行增加或删除
        'name' => 'SSR',                                                    // 客户端名称
        'img' => '/theme/cool/assets/images/tutorial/ssr-ico.png',          // 图标, 使用png透明文件
        'url' => '/user/help/view/1/3',                                     // 安装教程的url地址
        'dl_url' => '',                                     // 软件下载地址 若想不显示 为空即可
        'vs'  => 'v5.4.2',                                                  // 版本号
    ),
    'clash' => array(
        'name'  => 'Clash',
        'img'   => '/theme/cool/assets/images/tutorial/clashr-ico.png',
        'url'   => '/user/help/view/1/4',
        'dl_url' => '',                          
        'vs'    => 'v0.18.1',
    ),
    'netch' => array(
        'name'  => 'Netch',
        'img'   => '/theme/cool/assets/images/tutorial/netch.png',
        'url'   => '/user/help/view/1/5',
        'dl_url' => '',                       
        'vs'    => 'v1.9.0',
    )
];

/**
 *    Android 客户端
 */
$Cool_Config['client_android'] = [
    'ssr' => array(
        'name'  => 'SSR',
        'img'   => '/theme/cool/assets/images/tutorial/ssr-ico.png',
        'url'   => '/user/help/view/2/7',
        'dl_url' => '',                      
        'vs'    => 'v5.2.6',
    ),
    'clash' => array(
        'name'  => 'Clash',
        'img'   => '/theme/cool/assets/images/tutorial/clashr-ico.png',
        'url'   => '/user/help/view/2/6',
        'dl_url' => '',
        'vs'    => 'v2.4.12',
    ),
    'V2rayN' => array(
        'name'  => 'V2rayN',
        'img'   => '/theme/cool/assets/images/tutorial/v2ray.png',
        'url'   => '/user/help/view/2/8',
        'dl_url' => '',
        'vs'    => 'v1.6.20',
    )
];

/**
 *    Apple iOS客户端
 */
$Cool_Config['client_ios'] = [
    'Shadowrocket' => array(
        'name'  => 'Shadowrocket',
        'img'   => '/theme/cool/assets/images/tutorial/shadowrocket-ico.png',
        'url'   => '/user/help/view/3/9',
        'dl_url' => '',
        'vs'    => 'v2.1.83',
    ),
    'Quantumult' => array(
        'name'  => 'Quantumult',
        'img'   => '/theme/cool/assets/images/tutorial/quantumult-ico.png',
        'url'   => '/user/help/view/3/10',
        'dl_url' => '',
        'vs'    => 'v2.2.13',
    ),
];

/**
 *    Apple Mac客户端
 */
$Cool_Config['client_macos'] = [
    'ClashX' => array(
        'name'  => 'ClashX',
        'img'   => '/theme/cool/assets/images/tutorial/clashr-ico.png',
        'url'   => '/user/help/view/4/11',
        'dl_url' => '',
        'vs'    => 'v1.70.0',
    ),
];


# ┌──────────────────────────────────────────────────────────┐
# │                      着陆页                              │
# └──────────────────────────────────────────────────────────┘
$Cool_Config['plans-info'] = array(              // 着陆页套餐信息
    'plan_1' => array(
        'name' => '标准版',
        'price' => '9.9',
        'features' => [
            array(
                'support' => true,
                'name' => '50GB 使用流量'
            ),
            array(
                'support' => true,
                'name' => '2个 在线客户端'
            ),
            array(
                'support' => true,
                'name' => '工单技术支持'
            ),
            array(
                'support' => true,
                'name' => '国际标准节点'
            ),
            array(
                'support' => false,
                'name' => '国内中转节点'
            ),
            array(
                'support' => false,
                'name' => 'IPLC专线节点'
            ),
        ]
    ),
    'plan_2' => array(
        'name' => '高级版',
        'price' => '19.9',
        'currency' => '¥',
        'billing' => '每月',
        'features' => [
            array(
                'support' => true,
                'name' => '100GB 使用流量'
            ),
            array(
                'support' => true,
                'name' => '4个 在线客户端'
            ),
            array(
                'support' => true,
                'name' => '24/7 在线技术支持'
            ),
            array(
                'support' => true,
                'name' => '国际标准节点'
            ),
            array(
                'support' => true,
                'name' => '国内中转节点'
            ),
            array(
                'support' => false,
                'name' => 'IPLC专线节点'
            ),
        ]
    ),
    'plan_3' => array(
        'name' => '加强版',
        'price' => '29.9',
        'currency' => '¥',
        'billing' => '每月',
        'features' => [
            array(
                'support' => true,
                'name' => '300GB 使用流量'
            ),
            array(
                'support' => true,
                'name' => '8个 在线客户端'
            ),
            array(
                'support' => true,
                'name' => '24/7 在线技术支持'
            ),
            array(
                'support' => true,
                'name' => '国际标准节点'
            ),
            array(
                'support' => true,
                'name' => '国内中转节点'
            ),
            array(
                'support' => true,
                'name' => 'IPLC专线节点'
            ),
        ]
    ),
);

?>