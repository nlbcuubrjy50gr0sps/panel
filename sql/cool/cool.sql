/* 给 ticket 表 新增字段 */
ALTER TABLE `ticket` ADD COLUMN `type` longtext NOT NULL COMMENT '部门';
ALTER TABLE `ticket` ADD COLUMN `level` longtext NOT NULL COMMENT '优先级';

/* 给 user 表 新增字段 */
ALTER TABLE `user` ADD COLUMN `quantitypay` int(11) NULL DEFAULT 0 COMMENT '按量付费';
ALTER TABLE `user` ADD COLUMN `agent_id` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `user` ADD COLUMN `is_agent` int(11) NULL DEFAULT 0	COMMENT '代理商';
ALTER TABLE `user` ADD COLUMN `ref_accid` int(1) NULL DEFAULT 0;
ALTER TABLE `user` ADD COLUMN `ref_acc` varchar(32) NULL DEFAULT NULL;
ALTER TABLE `user` ADD COLUMN `ref_money` decimal(12, 2) NOT NULL DEFAULT 0.00;
ALTER TABLE `user` ADD COLUMN `back_money` decimal(12, 2) NOT NULL DEFAULT 0.00;
ALTER TABLE `user` ADD COLUMN `c_rebate` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `user` ADD COLUMN `rebate` int(11) NOT NULL DEFAULT -1;
ALTER TABLE `user` ADD COLUMN `creta` int(2) NULL DEFAULT 0;

/* 给 paylist 表 新增字段 */
ALTER TABLE `paylist` ADD COLUMN `shopid` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `paylist` ADD COLUMN `coupon` text NULL;
ALTER TABLE `paylist` ADD COLUMN `autorenew` int(1) NULL DEFAULT 0;
ALTER TABLE `paylist` ADD COLUMN `closerenew` int(1) NULL DEFAULT 1;
ALTER TABLE `paylist` ADD COLUMN `traffic` int(11) NULL DEFAULT 1;

/* 给 bought 表 新增字段 */
ALTER TABLE `bought` ADD COLUMN `code` text NULL comment '兑换码' AFTER `coupon`;
ALTER TABLE `bought` ADD COLUMN `usedd` INT(2) NOT NULL DEFAULT '0' COMMENT '生效套餐' AFTER `price`;
ALTER TABLE `bought` ADD COLUMN `agent_id` int(11) NOT NULL DEFAULT 0 comment '代理商ID';

/* 添加 Help 表 用户文档 */
CREATE TABLE IF NOT EXISTS `help`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `content` longtext NOT NULL,
  `markdown` longtext NOT NULL,
  `class` int(11) NOT NULL,
  `add_time` datetime(0) NOT NULL,
  `ontop` int(11) NULL DEFAULT 0,
  `sort` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 添加 Help_class 表 用户文档分类及默认用户文档分类 */
CREATE TABLE IF NOT EXISTS `help_class` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `li` tinytext COMMENT '图标',
  `pageshow` int(5) DEFAULT NULL COMMENT '是否在页面显示',
  `sort` int(5) DEFAULT NULL COMMENT '排序',
  `explain` varchar(125) NOT NULL COMMENT '分类说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `help_class` (`id`, `name`, `li`, `pageshow`, `sort`, `explain`) VALUES
(1, 'Windows', '/theme/cool/assets/images/help/windows.png', 1, 3, '适用于 Windows 7 或更高版本'),
(2, 'Android', '/theme/cool/assets/images/help/android.png', 1, 1, '适用于 Android 5.0 或更高版本'),
(3, 'IOS', '/theme/cool/assets/images/help/ios.png', 1, 1, '适用于 iOS 9 或更高版本'),
(4, 'macOS', '/theme/cool/assets/images/help/macos.png', 1, 0, '适用于 macOS Sierra (10.12) 或更高版本'),
(5, 'Linux', '/theme/cool/assets/images/help/linux.png	', 1, 0, '适用于……所有版本？'),
(6, '路由器 (暂无相关教程)', '/theme/cool/assets/images/help/router.png', 1, 0, '适用于软路由');

/* 创建 faq 表  */
CREATE TABLE IF NOT EXISTS `faq` (
  `id` int(11) primary key NOT NULL auto_increment,
  `title` longtext NOT NULL,
  `content` longtext NOT NULL,
  `markdown` longtext NOT NULL,
  `add_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 创建 redeem 表 套餐兑换码记录 */
CREATE TABLE IF NOT EXISTS `redeem` (
  `id` int(11) primary key NOT NULL auto_increment,
  `code` text NOT NULL,
  `shop` text NOT NULL COMMENT '商品ID',
  `onetime` int(11) NOT NULL COMMENT '兑换次数',
  `expire` bigint(20) NOT NULL COMMENT '有效期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 创建 stream_media 表 流媒体解锁 */
CREATE TABLE IF NOT EXISTS `stream_media` (
  `id` int(11) primary key NOT NULL auto_increment,
  `node_id` integer NOT NULL COMMENT '节点id',
  `result` text NOT NULL COMMENT '检测结果',
  `created_at` integer NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 节点筛选 */
ALTER TABLE `link` CHANGE `port` `port` INT NULL;
ALTER TABLE `link` CHANGE `address` `address` TEXT NULL;
ALTER TABLE `link` ADD COLUMN `filter` TEXT NULL DEFAULT NULL AFTER `userid`;
ALTER TABLE `link` ADD COLUMN `type` int(11) NULL DEFAULT 11 AFTER `id`;