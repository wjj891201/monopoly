/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : monopoly

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2023-03-15 00:13:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for xw_account
-- ----------------------------
DROP TABLE IF EXISTS `xw_account`;
CREATE TABLE `xw_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL COMMENT '用戶ID',
  `currency_id` int(11) NOT NULL COMMENT '幣種ID',
  `currency_code` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '货币',
  `asset_type` enum('funding','spot','swap','otc') CHARACTER SET utf8 NOT NULL COMMENT '余额类型：funding資金賬戶；spot幣幣賬戶；swap永續合約賬戶；otc',
  `freeze` decimal(30,6) NOT NULL DEFAULT '0.000000' COMMENT '冻结数量',
  `available` decimal(30,6) NOT NULL DEFAULT '0.000000' COMMENT '可用数量',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1启用0冻结',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id_2` (`member_id`,`currency_id`,`asset_type`),
  KEY `member_id` (`member_id`),
  KEY `asset_type` (`asset_type`),
  KEY `currency_id` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_account
-- ----------------------------
INSERT INTO `xw_account` VALUES ('1', '1', '2', 'USDT', 'funding', '200.000000', '33319.000000', '1', '2023-02-24 16:15:44', '2023-03-04 18:37:48');

-- ----------------------------
-- Table structure for xw_account_log
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_log`;
CREATE TABLE `xw_account_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `scene` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '变更场景',
  `item_id` int(8) NOT NULL COMMENT '关联id',
  `operate_type` enum('add','sub') CHARACTER SET utf8 NOT NULL,
  `balance_type` enum('available','freeze') CHARACTER SET utf8 NOT NULL,
  `asset_type` enum('funding','spot','swap','otc') CHARACTER SET utf8 NOT NULL COMMENT '余额类型：funding資金賬戶；spot幣幣賬戶；swap永續合約賬戶；',
  `currency_id` int(11) NOT NULL COMMENT '币种ID',
  `currency_code` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '币种',
  `amount` decimal(16,6) NOT NULL COMMENT '变更数量',
  `before_amount` decimal(16,6) NOT NULL COMMENT '变更之前数量',
  `after_amount` decimal(16,6) NOT NULL COMMENT '变更之后数量',
  `remark` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '備註',
  `created_at` datetime NOT NULL COMMENT '变更时间',
  PRIMARY KEY (`id`),
  KEY `currency_id` (`currency_id`),
  KEY `member_id` (`member_id`),
  KEY `scene` (`scene`),
  KEY `asset_type` (`asset_type`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_account_log
-- ----------------------------
INSERT INTO `xw_account_log` VALUES ('4', '1', 'funding', '8', 'sub', 'available', 'funding', '2', 'USDT', '33.000000', '33333.000000', '33300.000000', '商戶交易', '2023-02-26 15:15:26');
INSERT INTO `xw_account_log` VALUES ('5', '1', 'funding', '9', 'sub', 'available', 'funding', '2', 'USDT', '3.000000', '33300.000000', '33297.000000', '商戶交易', '2023-02-26 15:16:22');
INSERT INTO `xw_account_log` VALUES ('6', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33297.000000', '33298.000000', '', '2023-03-04 18:34:20');
INSERT INTO `xw_account_log` VALUES ('7', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33298.000000', '33299.000000', '', '2023-03-04 18:34:20');
INSERT INTO `xw_account_log` VALUES ('8', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33299.000000', '33300.000000', '', '2023-03-04 18:34:20');
INSERT INTO `xw_account_log` VALUES ('9', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33300.000000', '33301.000000', '', '2023-03-04 18:35:21');
INSERT INTO `xw_account_log` VALUES ('10', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33301.000000', '33302.000000', '', '2023-03-04 18:35:21');
INSERT INTO `xw_account_log` VALUES ('11', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33302.000000', '33303.000000', '', '2023-03-04 18:35:22');
INSERT INTO `xw_account_log` VALUES ('12', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '1.000000', '33303.000000', '33304.000000', '', '2023-03-04 18:35:22');
INSERT INTO `xw_account_log` VALUES ('13', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '3.000000', '33304.000000', '33307.000000', '', '2023-03-04 18:36:07');
INSERT INTO `xw_account_log` VALUES ('14', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '3.000000', '33307.000000', '33310.000000', '', '2023-03-04 18:36:07');
INSERT INTO `xw_account_log` VALUES ('15', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '3.000000', '33310.000000', '33313.000000', '', '2023-03-04 18:36:08');
INSERT INTO `xw_account_log` VALUES ('16', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '3.000000', '33313.000000', '33316.000000', '', '2023-03-04 18:36:08');
INSERT INTO `xw_account_log` VALUES ('17', '1', '後台', '1', 'add', 'available', 'funding', '2', 'USDT', '3.000000', '33316.000000', '33319.000000', '', '2023-03-04 18:37:48');

-- ----------------------------
-- Table structure for xw_account_pair
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_pair`;
CREATE TABLE `xw_account_pair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cc_id` int(8) NOT NULL COMMENT '幣鏈信息',
  `name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `input_address` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '入金地址',
  `output_address` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '出金地址',
  `fee_recharge` decimal(20,4) NOT NULL COMMENT '充值手续费',
  `fee_withdraw` decimal(20,4) NOT NULL COMMENT '提現手續費',
  `recharge_price` decimal(20,4) NOT NULL COMMENT '充值价格',
  `withdraw_price` decimal(20,4) NOT NULL COMMENT '提現价格',
  `min_recharge` decimal(20,4) NOT NULL COMMENT '最低订单金额',
  `max_recharge` decimal(20,4) NOT NULL COMMENT '最大订单金额',
  `min_withdraw` decimal(20,4) NOT NULL COMMENT '最小提現',
  `max_withdraw` decimal(20,4) NOT NULL COMMENT '最大提現',
  `sort_order` int(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否前端显示',
  `is_recharge` tinyint(1) NOT NULL COMMENT '是否可买',
  `is_withdraw` tinyint(1) NOT NULL COMMENT '是否可卖',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `is_show` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='资产交易对';

-- ----------------------------
-- Records of xw_account_pair
-- ----------------------------
INSERT INTO `xw_account_pair` VALUES ('1', '5', 'USDT', '0xCe29996800385753dF0db9dAc67A15277b6D54eC', '0x2e4a46d066d98231d3b9a4e8190f430635d0d01b', '0.0200', '0.0000', '0.0500', '5.0000', '0.1000', '99999999.9999', '0.0000', '0.0000', '9999', '0', '1', '0', '2022-07-23 20:27:47', '2022-10-18 13:28:21');

-- ----------------------------
-- Table structure for xw_account_recharge
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_recharge`;
CREATE TABLE `xw_account_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `cc_id` int(11) NOT NULL COMMENT '币链id',
  `amount` decimal(16,6) NOT NULL COMMENT '充值数量',
  `tx_id` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '链上交易号',
  `from_address` varchar(255) CHARACTER SET utf8 NOT NULL,
  `to_address` varchar(255) CHARACTER SET utf8 NOT NULL,
  `remark` varchar(50) CHARACTER SET utf8 NOT NULL,
  `status` enum('created','finished','reject','') NOT NULL,
  `is_admin` tinyint(1) NOT NULL COMMENT '是否手动添加',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trx_id` (`tx_id`(255)) USING BTREE,
  KEY `member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_account_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for xw_account_reward
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_reward`;
CREATE TABLE `xw_account_reward` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `member_id` int(8) NOT NULL,
  `item` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '类型',
  `item_id` int(20) NOT NULL COMMENT '具体数据',
  `from_member_id` int(8) NOT NULL COMMENT '来自哪个用户',
  `amount` decimal(16,6) NOT NULL COMMENT '数量',
  `currency_id` int(8) NOT NULL COMMENT '币种id',
  `currency_code` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '币种代码',
  `is_settled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否结算',
  `asset_type` enum('funding') CHARACTER SET utf8 NOT NULL COMMENT '余额类型',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `amount` (`amount`),
  KEY `currency_id` (`currency_id`),
  KEY `asset_type` (`asset_type`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_account_reward
-- ----------------------------

-- ----------------------------
-- Table structure for xw_account_transfer
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_transfer`;
CREATE TABLE `xw_account_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_member` int(8) NOT NULL COMMENT '来自账户',
  `to_member` int(8) NOT NULL COMMENT '接收帐户',
  `from_asset_type` enum('funding','spot','swap','otc') CHARACTER SET utf8 NOT NULL,
  `to_asset_type` enum('funding','spot','swap','otc') CHARACTER SET utf8 NOT NULL,
  `from_balance_type` enum('available','freeze') CHARACTER SET utf8 NOT NULL,
  `to_balance_type` enum('available','freeze') CHARACTER SET utf8 NOT NULL,
  `currency_id` int(11) NOT NULL COMMENT '幣種ID',
  `amount` decimal(16,4) NOT NULL COMMENT '劃轉數量',
  `fee` decimal(16,4) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '時間',
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `from_account` (`from_member`),
  KEY `to_account` (`to_member`),
  KEY `currency_id` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='資金劃轉';

-- ----------------------------
-- Records of xw_account_transfer
-- ----------------------------

-- ----------------------------
-- Table structure for xw_account_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `xw_account_withdraw`;
CREATE TABLE `xw_account_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `cc_id` int(11) NOT NULL COMMENT '币链id',
  `amount` decimal(16,6) NOT NULL COMMENT '提现数量',
  `fee` decimal(16,6) NOT NULL COMMENT '提现手续费',
  `real_amount` decimal(16,6) NOT NULL COMMENT '实际到账',
  `withdraw_address_id` int(11) NOT NULL COMMENT '提現地址id',
  `to_address` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '提现地址',
  `remark` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '标签',
  `tx_id` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '链上交易号',
  `status` enum('create','refuse','finish') CHARACTER SET utf8 NOT NULL COMMENT '状态：0、待审核；1、提现成功；2、提现失败；3、确认',
  `created_at` datetime DEFAULT NULL,
  `checked_at` datetime DEFAULT NULL COMMENT '审核时间',
  `refused_at` datetime NOT NULL,
  `finished_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `currency_chain_id` (`cc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_account_withdraw
-- ----------------------------
INSERT INTO `xw_account_withdraw` VALUES ('1', '1', '2', '11.000000', '0.000000', '0.000000', '0', '', '32423', '234', '', '2023-02-15 12:48:10', null, '2023-02-21 21:35:29', '0000-00-00 00:00:00', '2023-02-21 21:35:29');
INSERT INTO `xw_account_withdraw` VALUES ('2', '1', '2', '11.000000', '0.000000', '0.000000', '0', '', '2342', '234', '', '2023-02-15 12:48:49', '2023-02-21 21:32:25', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2023-02-21 21:32:25');

-- ----------------------------
-- Table structure for xw_admin
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin`;
CREATE TABLE `xw_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `nickname` varchar(255) DEFAULT '',
  `thumb` varchar(255) DEFAULT NULL,
  `theme` varchar(255) NOT NULL DEFAULT 'black' COMMENT '系统主题',
  `mobile` int(11) DEFAULT '0',
  `email` varchar(255) DEFAULT '',
  `desc` text COMMENT '备注',
  `did` int(11) NOT NULL DEFAULT '0' COMMENT '部门id',
  `position_id` int(11) NOT NULL DEFAULT '0' COMMENT '职位id',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `last_login_at` datetime NOT NULL,
  `login_num` int(11) NOT NULL DEFAULT '0',
  `last_login_ip` varchar(64) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常,0禁止登录,-1删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- ----------------------------
-- Records of xw_admin
-- ----------------------------
INSERT INTO `xw_admin` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '/static/admin/images/icon.png', 'black', '2343423', '23423', 'dfasd', '1', '1', '2023-01-28 16:04:49', '2023-02-22 09:47:07', '2023-03-14 16:13:50', '75', '127.0.0.1', '1');

-- ----------------------------
-- Table structure for xw_admin_department
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_department`;
CREATE TABLE `xw_admin_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '部门名称',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `leader_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '部门负责人ID',
  `phone` varchar(60) NOT NULL DEFAULT '' COMMENT '部门联系电话',
  `remark` varchar(1000) DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：-1删除 0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='部门组织';

-- ----------------------------
-- Records of xw_admin_department
-- ----------------------------
INSERT INTO `xw_admin_department` VALUES ('1', '谷歌', '0', '0', '13688888888', '', '1', '0000-00-00 00:00:00', '2023-02-21 22:14:44');
INSERT INTO `xw_admin_department` VALUES ('2', '广州总公司', '1', '0', '13688888889', '', '1', '0000-00-00 00:00:00', '2023-02-21 22:13:59');
INSERT INTO `xw_admin_department` VALUES ('3', '人事部2', '2', '0', '13688888898', '', '1', '0000-00-00 00:00:00', '2023-01-30 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('4', '财务部', '2', '0', '13688888898', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('5', '市场部', '2', '0', '13688888978', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('6', '销售部', '2', '0', '13688889868', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('7', '技术部', '2', '0', '13688898858', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('8', '客服部', '2', '0', '13688988848', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('9', '销售一部', '6', '0', '13688998838', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('10', '销售二部', '6', '0', '13688999828', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('11', '深圳分公司', '1', '0', '13688999918', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('12', '人事部', '11', '0', '13688888886', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('13', '市场部', '11', '0', '13688888886', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('14', '财务部', '11', '0', '13688888876', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_department` VALUES ('15', '销售部', '11', '0', '13688888666', '', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for xw_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_log`;
CREATE TABLE `xw_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `type` varchar(80) NOT NULL DEFAULT '' COMMENT '操作类型',
  `action` varchar(80) NOT NULL DEFAULT '' COMMENT '操作动作',
  `subject` varchar(80) NOT NULL DEFAULT '' COMMENT '操作主体',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '操作标题',
  `content` text COMMENT '操作描述',
  `module` varchar(32) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(32) NOT NULL DEFAULT '' COMMENT '控制器',
  `function` varchar(32) NOT NULL DEFAULT '' COMMENT '方法',
  `rule_menu` varchar(255) NOT NULL DEFAULT '' COMMENT '节点权限路径',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录ip',
  `item_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作数据id',
  `param` text COMMENT '参数json格式',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0删除 1正常',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COMMENT='后台操作日志表';

-- ----------------------------
-- Records of xw_admin_log
-- ----------------------------
INSERT INTO `xw_admin_log` VALUES ('1', '1', 'admin', 'delete', '刪除', '功能菜單', '刪除', '超级管理员在2023-03-06 16:10:10刪除了功能菜單', 'admin', 'admin_menu', 'delete', '', '127.0.0.1', '161', '{\"id\":161,\"pid\":0,\"src\":\"\",\"title\":\"\\u5546\\u5bb6\\u7ba1\\u7406\",\"name\":\"\\u5546\\u5bb6\\u7ba1\\u7406\",\"icon\":\"bi-cart3\",\"menu\":1,\"sort_order\":9999,\"status\":1,\"module\":\"\",\"crud\":\"\",\"created_at\":\"2023-02-26 11:18:55\",\"updated_at\":\"2023-02-26 11:18:55\"}', '1', '2023-03-06 16:10:10');
INSERT INTO `xw_admin_log` VALUES ('2', '1', 'admin', 'login', '登錄', '系統', '', '超级管理员在2023-03-07 14:58:08登錄了系統', 'admin', 'login', 'login', '', '127.0.0.1', '1', '{\"last_login_at\":\"2023-03-07 14:58:08\",\"last_login_ip\":\"127.0.0.1\",\"login_num\":71}', '1', '2023-03-07 14:58:08');
INSERT INTO `xw_admin_log` VALUES ('3', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-09 09:15:21編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '1', '{\"id\":\"1\",\"admin_title\":\"\\u5927\\u5bcc\\u7fc1\\u5f8c\\u53f0\",\"title\":\"\\u5927\\u5bcc\\u7fc1\"}', '1', '2023-03-09 09:15:21');
INSERT INTO `xw_admin_log` VALUES ('4', '1', 'admin', 'login', '登錄', '系統', '', '超级管理员在2023-03-09 14:30:47登錄了系統', 'admin', 'login', 'login', '', '127.0.0.1', '1', '{\"last_login_at\":\"2023-03-09 14:30:47\",\"last_login_ip\":\"127.0.0.1\",\"login_num\":72}', '1', '2023-03-09 14:30:47');
INSERT INTO `xw_admin_log` VALUES ('5', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:44:03刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '9', '{\"id\":9,\"lang\":\"\",\"cate_id\":2,\"title\":\"sdfa\",\"desc\":\"sdfasdfsdfadsf\",\"image\":22,\"content\":\"<p>dsfasdf<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"0000-00-00 00:00:00\",\"updated_at\":\"2023-02-21 20:52:19\"}', '1', '2023-03-09 15:44:03');
INSERT INTO `xw_admin_log` VALUES ('6', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:02刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '1', '{\"id\":1,\"lang\":\"\",\"cate_id\":1,\"title\":\"23423\",\"desc\":\"23423\",\"image\":15,\"content\":\"<p>23423423<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":234,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:12:33\",\"updated_at\":\"2023-02-11 10:12:43\"}', '1', '2023-03-09 15:48:02');
INSERT INTO `xw_admin_log` VALUES ('7', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:05刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '2', '{\"id\":2,\"lang\":\"\",\"cate_id\":1,\"title\":\"\\u6e2c\\u8a66\",\"desc\":\"334322\",\"image\":16,\"content\":\"<p>23423423423<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":3,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:25:19\",\"updated_at\":\"2023-02-11 10:25:28\"}', '1', '2023-03-09 15:48:05');
INSERT INTO `xw_admin_log` VALUES ('8', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:07刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '3', '{\"id\":3,\"lang\":\"\",\"cate_id\":1,\"title\":\"sdfsdf\",\"desc\":\"2342342\",\"image\":17,\"content\":\"<p>32423423423<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":23423,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:26:35\",\"updated_at\":\"2023-02-11 10:26:35\"}', '1', '2023-03-09 15:48:07');
INSERT INTO `xw_admin_log` VALUES ('9', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:14刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"lang\":\"\",\"cate_id\":1,\"title\":\"sdf\",\"desc\":\"sdf\",\"image\":0,\"content\":\"<p>sdfaf<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:29:09\",\"updated_at\":\"2023-02-11 17:38:51\"}', '1', '2023-03-09 15:48:14');
INSERT INTO `xw_admin_log` VALUES ('10', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:18刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '5', '{\"id\":5,\"lang\":\"\",\"cate_id\":4,\"title\":\"\\u5167\\u5bb91\",\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u5167\\u5bb91\\u5167\\u5bb91\\u5167\\u5bb91\\u5167\\u5bb91<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-13 15:16:39\",\"updated_at\":\"2023-02-17 14:55:47\"}', '1', '2023-03-09 15:48:18');
INSERT INTO `xw_admin_log` VALUES ('11', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:22刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '6', '{\"id\":6,\"lang\":\"\",\"cate_id\":4,\"title\":\"\\u5167\\u5bb92\",\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u5167\\u5bb92<span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-13 15:16:55\",\"updated_at\":\"2023-02-13 15:16:55\"}', '1', '2023-03-09 15:48:22');
INSERT INTO `xw_admin_log` VALUES ('12', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:24刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '7', '{\"id\":7,\"lang\":\"\",\"cate_id\":6,\"title\":\"\\u6e2c\\u8a66\\u516c\\u544a\",\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-15 16:30:46\",\"updated_at\":\"2023-02-15 16:30:46\"}', '1', '2023-03-09 15:48:24');
INSERT INTO `xw_admin_log` VALUES ('13', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:26刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '10', '{\"id\":10,\"lang\":\"\",\"cate_id\":4,\"title\":\"sdfas\",\"desc\":\"sdfadsf\",\"image\":0,\"content\":\"<p>sdfsadf<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-21 20:52:13\",\"updated_at\":\"2023-02-21 20:52:13\"}', '1', '2023-03-09 15:48:26');
INSERT INTO `xw_admin_log` VALUES ('14', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:28刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '11', '{\"id\":11,\"lang\":\"\",\"cate_id\":7,\"title\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\",\"desc\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\",\"image\":24,\"content\":\"<p>\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a<\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-26 10:58:50\",\"updated_at\":\"2023-02-26 10:58:50\"}', '1', '2023-03-09 15:48:28');
INSERT INTO `xw_admin_log` VALUES ('15', '1', 'admin', 'delete', '刪除', '文章', '刪除', '超级管理员在2023-03-09 15:48:31刪除了文章', 'admin', 'article', 'delete', '', '127.0.0.1', '12', '{\"id\":12,\"lang\":\"\",\"cate_id\":7,\"title\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\",\"desc\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\",\"image\":27,\"content\":\"<p>\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2<img src=\\\"\\/storage\\/202302\\/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png\\\" alt=\\\"\\\" width=\\\"1000\\\" height=\\\"600\\\" \\/><\\/p>\",\"read\":0,\"type\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-26 10:59:37\",\"updated_at\":\"2023-02-26 10:59:37\"}', '1', '2023-03-09 15:48:31');
INSERT INTO `xw_admin_log` VALUES ('16', '1', 'admin', 'delete', '刪除', '文章分類', '刪除', '超级管理员在2023-03-09 15:48:46刪除了文章分類', 'admin', 'article_cate', 'delete', '', '127.0.0.1', '2', '{\"id\":2,\"pid\":1,\"title\":\"sdf\",\"desc\":\"aafs\",\"sort_order\":0,\"status\":1,\"created_at\":\"2023-02-09 21:23:39\",\"updated_at\":\"2023-02-09 21:23:39\"}', '1', '2023-03-09 15:48:46');
INSERT INTO `xw_admin_log` VALUES ('17', '1', 'admin', 'delete', '刪除', '文章分類', '刪除', '超级管理员在2023-03-09 15:48:48刪除了文章分類', 'admin', 'article_cate', 'delete', '', '127.0.0.1', '1', '{\"id\":1,\"pid\":0,\"title\":\"\\u6e2c\\u8a66\",\"desc\":\"\",\"sort_order\":999,\"status\":1,\"created_at\":\"2023-02-07 20:56:06\",\"updated_at\":\"2023-02-10 21:45:48\"}', '1', '2023-03-09 15:48:48');
INSERT INTO `xw_admin_log` VALUES ('18', '1', 'admin', 'delete', '刪除', '文章分類', '刪除', '超级管理员在2023-03-09 15:51:18刪除了文章分類', 'admin', 'article_cate', 'delete', '', '127.0.0.1', '5', '{\"id\":5,\"pid\":3,\"title\":\"\\u5206\\u985e2\",\"desc\":\"\",\"sort_order\":0,\"status\":1,\"created_at\":\"2023-02-13 15:16:18\",\"updated_at\":\"2023-02-13 15:16:18\"}', '1', '2023-03-09 15:51:18');
INSERT INTO `xw_admin_log` VALUES ('19', '1', 'admin', 'delete', '刪除', '文章分類', '刪除', '超级管理员在2023-03-09 15:51:20刪除了文章分類', 'admin', 'article_cate', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"pid\":3,\"title\":\"\\u5206\\u985e1\",\"desc\":\"\",\"sort_order\":0,\"status\":1,\"created_at\":\"2023-02-13 15:16:12\",\"updated_at\":\"2023-02-13 15:16:12\"}', '1', '2023-03-09 15:51:20');
INSERT INTO `xw_admin_log` VALUES ('20', '1', 'admin', 'delete', '刪除', '文章分類', '刪除', '超级管理员在2023-03-09 15:51:23刪除了文章分類', 'admin', 'article_cate', 'delete', '', '127.0.0.1', '3', '{\"id\":3,\"pid\":0,\"title\":\"\\u5e6b\\u52a9\\u4e2d\\u5fc3\",\"desc\":\"\",\"sort_order\":0,\"status\":1,\"created_at\":\"2023-02-13 15:15:57\",\"updated_at\":\"2023-02-13 15:15:57\"}', '1', '2023-03-09 15:51:23');
INSERT INTO `xw_admin_log` VALUES ('21', '1', 'admin', 'add', '新增', '文章分類', '新建', '超级管理员在2023-03-09 15:52:22新增了文章分類', 'admin', 'article_cate', 'add', '', '127.0.0.1', '8', '{\"pid\":\"0\",\"sort_order\":\"0\",\"title\":\"\\u4fc3\\u92b7\\u6d3b\\u52d5\",\"desc\":\"\\u4fc3\\u92b7\\u6d3b\\u52d5\",\"id\":\"0\"}', '1', '2023-03-09 15:52:22');
INSERT INTO `xw_admin_log` VALUES ('22', '1', 'admin', 'add', '新增', '配置項', '新建/編輯', '超级管理员在2023-03-09 16:33:36新增了配置項', 'admin', 'conf', 'add', '', '127.0.0.1', '3', '{\"id\":\"0\",\"title\":\"\\u5927\\u5bcc\\u7fc1\\u53c3\\u6578\",\"status\":\"1\",\"name\":\"parameter\",\"created_at\":\"2023-03-09 16:33:36\"}', '1', '2023-03-09 16:33:36');
INSERT INTO `xw_admin_log` VALUES ('23', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-09 20:01:28編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.015\"}', '1', '2023-03-09 20:01:28');
INSERT INTO `xw_admin_log` VALUES ('24', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:04:53數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '1', '{\"table\":\"member_role\",\"id\":\"1\"}', '1', '2023-03-09 20:04:53');
INSERT INTO `xw_admin_log` VALUES ('25', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:05:06數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"currency\",\"id\":\"3\",\"field\":\"is_trade\"}', '1', '2023-03-09 20:05:06');
INSERT INTO `xw_admin_log` VALUES ('26', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-09 20:17:42編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '73', '{\"pid\":\"72\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\\/\\u7de8\\u8f2f\",\"name\":\"\\u7528\\u6236\\u7b49\\u7d1a\",\"src\":\"admin\\/role\\/edit\",\"sort\":\"1\",\"icon\":\"\",\"id\":\"73\",\"admin_id\":1,\"updated_at\":\"2023-03-09 20:17:42\"}', '1', '2023-03-09 20:17:42');
INSERT INTO `xw_admin_log` VALUES ('27', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:27:47數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '1', '{\"table\":\"member_role\",\"id\":\"1\"}', '1', '2023-03-09 20:27:47');
INSERT INTO `xw_admin_log` VALUES ('28', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:27:51數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '1', '{\"table\":\"member_role\",\"id\":\"1\"}', '1', '2023-03-09 20:27:51');
INSERT INTO `xw_admin_log` VALUES ('29', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:27:54數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '2', '{\"table\":\"member_role\",\"id\":\"2\"}', '1', '2023-03-09 20:27:54');
INSERT INTO `xw_admin_log` VALUES ('30', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:27:56數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"member_role\",\"id\":\"3\"}', '1', '2023-03-09 20:27:56');
INSERT INTO `xw_admin_log` VALUES ('31', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:27:59數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '4', '{\"table\":\"member_role\",\"id\":\"4\"}', '1', '2023-03-09 20:27:59');
INSERT INTO `xw_admin_log` VALUES ('32', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:28:02數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '5', '{\"table\":\"member_role\",\"id\":\"5\"}', '1', '2023-03-09 20:28:02');
INSERT INTO `xw_admin_log` VALUES ('33', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:28:05數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '2', '{\"table\":\"member_role\",\"id\":\"2\"}', '1', '2023-03-09 20:28:05');
INSERT INTO `xw_admin_log` VALUES ('34', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:28:31數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '2', '{\"table\":\"member_role\",\"id\":\"2\"}', '1', '2023-03-09 20:28:31');
INSERT INTO `xw_admin_log` VALUES ('35', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 20:28:51數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"member_role\",\"id\":\"3\"}', '1', '2023-03-09 20:28:51');
INSERT INTO `xw_admin_log` VALUES ('36', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:23:15數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"member_role\",\"id\":\"3\"}', '1', '2023-03-09 21:23:15');
INSERT INTO `xw_admin_log` VALUES ('37', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:23:20數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '6', '{\"table\":\"member_role\",\"id\":\"6\"}', '1', '2023-03-09 21:23:20');
INSERT INTO `xw_admin_log` VALUES ('38', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:23:24數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '1', '{\"table\":\"member_role\",\"id\":\"1\"}', '1', '2023-03-09 21:23:24');
INSERT INTO `xw_admin_log` VALUES ('39', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:23:32數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"member_role\",\"id\":\"3\"}', '1', '2023-03-09 21:23:32');
INSERT INTO `xw_admin_log` VALUES ('40', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:59:21數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '4', '{\"table\":\"member_role\",\"id\":\"4\"}', '1', '2023-03-09 21:59:21');
INSERT INTO `xw_admin_log` VALUES ('41', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:59:22數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '5', '{\"table\":\"member_role\",\"id\":\"5\"}', '1', '2023-03-09 21:59:22');
INSERT INTO `xw_admin_log` VALUES ('42', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:59:22數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '6', '{\"table\":\"member_role\",\"id\":\"6\"}', '1', '2023-03-09 21:59:22');
INSERT INTO `xw_admin_log` VALUES ('43', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-09 21:59:23數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '2', '{\"table\":\"member_role\",\"id\":\"2\"}', '1', '2023-03-09 21:59:23');
INSERT INTO `xw_admin_log` VALUES ('44', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:26:10編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '6', '{\"name\":\"L6\",\"accumulate\":\"0\",\"maintenance\":\"0\",\"dice_num\":\"1\",\"layer_num\":\"1\",\"id\":\"6\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:26:10\"}', '1', '2023-03-09 22:26:10');
INSERT INTO `xw_admin_log` VALUES ('45', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:29:16編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '5', '{\"name\":\"L5\",\"accumulate\":\"2500\",\"maintenance\":\"500\",\"dice_num\":\"2\",\"layer_num\":\"2\",\"id\":\"5\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:29:16\"}', '1', '2023-03-09 22:29:16');
INSERT INTO `xw_admin_log` VALUES ('46', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:34:59編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '4', '{\"name\":\"L4\",\"accumulate\":\"10000\",\"maintenance\":\"2000\",\"dice_num\":\"3\",\"layer_num\":\"4\",\"id\":\"4\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:34:59\"}', '1', '2023-03-09 22:34:59');
INSERT INTO `xw_admin_log` VALUES ('47', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:54:18編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '3', '{\"name\":\"L3\",\"accumulate\":\"50000\",\"maintenance\":\"5000\",\"dice_num\":\"4\",\"layer_num\":\"6\",\"id\":\"3\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:54:18\"}', '1', '2023-03-09 22:54:18');
INSERT INTO `xw_admin_log` VALUES ('48', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:55:07編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '2', '{\"name\":\"L2\",\"accumulate\":\"250000\",\"maintenance\":\"10000\",\"dice_num\":\"5\",\"layer_num\":\"8\",\"id\":\"2\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:55:06\"}', '1', '2023-03-09 22:55:07');
INSERT INTO `xw_admin_log` VALUES ('49', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 22:55:57編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '1', '{\"name\":\"L1\",\"accumulate\":\"500000\",\"maintenance\":\"20000\",\"dice_num\":\"6\",\"layer_num\":\"10\",\"id\":\"1\",\"admin_id\":1,\"updated_at\":\"2023-03-09 22:55:57\"}', '1', '2023-03-09 22:55:57');
INSERT INTO `xw_admin_log` VALUES ('50', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 23:37:12編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '6', '{\"name\":\"L6\",\"accumulate\":\"1\",\"maintenance\":\"0\",\"dice_num\":\"1\",\"layer_num\":\"1\",\"id\":\"6\",\"admin_id\":1,\"updated_at\":\"2023-03-09 23:37:12\"}', '1', '2023-03-09 23:37:12');
INSERT INTO `xw_admin_log` VALUES ('51', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-09 23:37:23編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '6', '{\"name\":\"L6\",\"accumulate\":\"0\",\"maintenance\":\"0\",\"dice_num\":\"1\",\"layer_num\":\"1\",\"id\":\"6\",\"admin_id\":1,\"updated_at\":\"2023-03-09 23:37:23\"}', '1', '2023-03-09 23:37:23');
INSERT INTO `xw_admin_log` VALUES ('52', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-09 23:45:54新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '177', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u623f\\u7522\\u7ba1\\u7406\",\"name\":\"\\u623f\\u7522\\u7ba1\\u7406\",\"src\":\"\",\"sort\":\"\",\"icon\":\"bi-house\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-09 23:45:54\",\"created_at\":\"2023-03-09 23:45:54\"}', '1', '2023-03-09 23:45:54');
INSERT INTO `xw_admin_log` VALUES ('53', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-09 23:47:34新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '178', '{\"pid\":\"177\",\"menu\":\"1\",\"title\":\"\\u5206\\u7c7b\",\"name\":\"\\u5206\\u7c7b\",\"src\":\"admin\\/house_cate\\/list\",\"sort\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-09 23:47:34\",\"created_at\":\"2023-03-09 23:47:34\"}', '1', '2023-03-09 23:47:34');
INSERT INTO `xw_admin_log` VALUES ('54', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-09 23:48:05編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178\",\"admin_id\":1,\"updated_at\":\"2023-03-09 23:48:05\"}', '1', '2023-03-09 23:48:05');
INSERT INTO `xw_admin_log` VALUES ('55', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 00:10:02編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '178', '{\"pid\":\"177\",\"menu\":\"1\",\"title\":\"\\u5206\\u7c7b\",\"name\":\"\\u5206\\u7c7b\",\"src\":\"admin\\/house_cate\\/index\",\"sort\":\"9999\",\"icon\":\"\",\"id\":\"178\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:10:02\"}', '1', '2023-03-10 00:10:02');
INSERT INTO `xw_admin_log` VALUES ('56', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 00:10:16編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '159', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u9322\\u5305\\u7ba1\\u7406\",\"name\":\"\\u9322\\u5305\\u7ba1\\u7406\",\"src\":\"\",\"sort\":\"9\",\"icon\":\"bi-wallet\",\"id\":\"159\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:10:16\"}', '1', '2023-03-10 00:10:16');
INSERT INTO `xw_admin_log` VALUES ('57', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 00:15:04編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '159', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u9322\\u5305\\u7ba1\\u7406\",\"name\":\"\\u9322\\u5305\\u7ba1\\u7406\",\"src\":\"\",\"sort_order\":\"9\",\"icon\":\"bi-wallet\",\"id\":\"159\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:15:04\"}', '1', '2023-03-10 00:15:04');
INSERT INTO `xw_admin_log` VALUES ('58', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 00:15:13編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '177', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u623f\\u7522\\u7ba1\\u7406\",\"name\":\"\\u623f\\u7522\\u7ba1\\u7406\",\"src\":\"\",\"sort_order\":\"10\",\"icon\":\"bi-house\",\"id\":\"177\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:15:13\"}', '1', '2023-03-10 00:15:13');
INSERT INTO `xw_admin_log` VALUES ('59', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 00:21:04編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '178', '{\"pid\":\"177\",\"menu\":\"1\",\"title\":\"\\u5730\\u5340\\u7ba1\\u7406\",\"name\":\"\\u5730\\u5340\\u7ba1\\u7406\",\"src\":\"admin\\/house_cate\\/index\",\"sort_order\":\"1\",\"icon\":\"\",\"id\":\"178\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:21:04\"}', '1', '2023-03-10 00:21:04');
INSERT INTO `xw_admin_log` VALUES ('60', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 00:26:24新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '179', '{\"pid\":\"177\",\"menu\":\"1\",\"title\":\"\\u623f\\u7522\\u5217\\u8868\",\"name\":\"\\u623f\\u7522\\u5217\\u8868\",\"src\":\"admin\\/house\\/index\",\"sort_order\":\"2\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:26:24\",\"created_at\":\"2023-03-10 00:26:24\"}', '1', '2023-03-10 00:26:24');
INSERT INTO `xw_admin_log` VALUES ('61', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 00:27:57新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '180', '{\"pid\":\"177\",\"menu\":\"1\",\"title\":\"\\u8a02\\u55ae\\u5217\\u8868\",\"name\":\"\\u8a02\\u55ae\\u5217\\u8868\",\"src\":\"admin\\/house_order\\/index\",\"sort_order\":\"3\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:27:57\",\"created_at\":\"2023-03-10 00:27:57\"}', '1', '2023-03-10 00:27:57');
INSERT INTO `xw_admin_log` VALUES ('62', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 00:39:23新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '181', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u5f69\\u91d1\\u6c60\\u7ba1\\u7406\",\"name\":\"\\u5f69\\u91d1\\u6c60\\u7ba1\\u7406\",\"src\":\"\",\"sort_order\":\"11\",\"icon\":\"bi-currency-dollar\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:39:23\",\"created_at\":\"2023-03-10 00:39:23\"}', '1', '2023-03-10 00:39:23');
INSERT INTO `xw_admin_log` VALUES ('63', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-10 00:39:52編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"179\",\"180\",\"181\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,179,180,181\",\"admin_id\":1,\"updated_at\":\"2023-03-10 00:39:52\"}', '1', '2023-03-10 00:39:52');
INSERT INTO `xw_admin_log` VALUES ('64', '1', 'admin', 'login', '登錄', '系統', '', '超级管理员在2023-03-10 09:08:31登錄了系統', 'admin', 'login', 'login', '', '127.0.0.1', '1', '{\"last_login_at\":\"2023-03-10 09:08:31\",\"last_login_ip\":\"127.0.0.1\",\"login_num\":73}', '1', '2023-03-10 09:08:31');
INSERT INTO `xw_admin_log` VALUES ('65', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 10:14:29新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '182', '{\"pid\":\"178\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u65b0\\u5efa\",\"src\":\"admin\\/house_cate\\/add\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 10:14:29\",\"created_at\":\"2023-03-10 10:14:29\"}', '1', '2023-03-10 10:14:29');
INSERT INTO `xw_admin_log` VALUES ('66', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-10 10:15:17編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '182', '{\"pid\":\"178\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u5730\\u5340\\u5206\\u985e\",\"src\":\"admin\\/house_cate\\/add\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"182\",\"admin_id\":1,\"updated_at\":\"2023-03-10 10:15:17\"}', '1', '2023-03-10 10:15:17');
INSERT INTO `xw_admin_log` VALUES ('67', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 10:16:13新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '183', '{\"pid\":\"178\",\"menu\":\"2\",\"title\":\"\\u7de8\\u8f2f\",\"name\":\"\\u5730\\u5340\\u5206\\u985e\",\"src\":\"admin\\/house_cate\\/edit\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 10:16:13\",\"created_at\":\"2023-03-10 10:16:13\"}', '1', '2023-03-10 10:16:13');
INSERT INTO `xw_admin_log` VALUES ('68', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 10:17:57新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '184', '{\"pid\":\"178\",\"menu\":\"2\",\"title\":\"\\u522a\\u9664\",\"name\":\"\\u5730\\u5340\\u5206\\u985e\",\"src\":\"admin\\/house_cate\\/delete\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 10:17:57\",\"created_at\":\"2023-03-10 10:17:57\"}', '1', '2023-03-10 10:17:57');
INSERT INTO `xw_admin_log` VALUES ('69', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-10 10:18:25編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"180\",\"181\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,180,181\",\"admin_id\":1,\"updated_at\":\"2023-03-10 10:18:25\"}', '1', '2023-03-10 10:18:25');
INSERT INTO `xw_admin_log` VALUES ('70', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 11:02:46新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '3', '{\"title\":\" \\u6d4b\\u8bd5\",\"min_price\":\"1\",\"max_price\":\"1\",\"sort_order\":\"1\",\"desc\":\"1\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 11:02:46\",\"created_at\":\"2023-03-10 11:02:46\"}', '1', '2023-03-10 11:02:46');
INSERT INTO `xw_admin_log` VALUES ('71', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 11:11:29新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '4', '{\"title\":\"13952615484\",\"min_price\":\"1\",\"max_price\":\"1\",\"sort_order\":\"1\",\"desc\":\"1\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 11:11:29\",\"created_at\":\"2023-03-10 11:11:29\"}', '1', '2023-03-10 11:11:29');
INSERT INTO `xw_admin_log` VALUES ('72', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 11:29:53刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"title\":\"13952615484\",\"min_price\":\"1.0000\",\"max_price\":\"1.0000\",\"sort_order\":1,\"status\":1,\"desc\":\"1\",\"created_at\":\"2023-03-10 11:11:29\",\"updated_at\":\"2023-03-10 11:11:29\"}', '1', '2023-03-10 11:29:53');
INSERT INTO `xw_admin_log` VALUES ('73', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 11:30:00刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '1', '{\"id\":1,\"title\":\"\\u9996\\u9875\\u8f6e\\u64ad\",\"min_price\":\"0.0000\",\"max_price\":\"0.0000\",\"sort_order\":9999,\"status\":1,\"desc\":\"\\u9996\\u9875\\u8f6e\\u64ad\\u7ec4\\u3002\",\"created_at\":\"2023-02-08 19:47:40\",\"updated_at\":\"2023-02-11 00:00:00\"}', '1', '2023-03-10 11:30:00');
INSERT INTO `xw_admin_log` VALUES ('74', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 13:54:22刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '2', '{\"id\":2,\"title\":\"\\u6d4b\\u8bd5\",\"min_price\":\"0.0000\",\"max_price\":\"0.0000\",\"sort_order\":9999,\"status\":1,\"desc\":\"11\",\"created_at\":\"2023-02-08 00:00:00\",\"updated_at\":\"2023-02-10 00:00:00\"}', '1', '2023-03-10 13:54:22');
INSERT INTO `xw_admin_log` VALUES ('75', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 13:58:22新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '5', '{\"title\":\"1212\",\"min_price\":\"3\",\"max_price\":\"200\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 13:58:22\",\"created_at\":\"2023-03-10 13:58:22\"}', '1', '2023-03-10 13:58:22');
INSERT INTO `xw_admin_log` VALUES ('76', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:02:45新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '6', '{\"title\":\"111\",\"min_price\":\"12\",\"max_price\":\"34\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:02:45\",\"created_at\":\"2023-03-10 14:02:45\"}', '1', '2023-03-10 14:02:45');
INSERT INTO `xw_admin_log` VALUES ('77', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:04:05新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '7', '{\"title\":\"\\u7684\\u5473\\u9053\\u65e0\",\"min_price\":\"22\",\"max_price\":\"50\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:04:05\",\"created_at\":\"2023-03-10 14:04:05\"}', '1', '2023-03-10 14:04:05');
INSERT INTO `xw_admin_log` VALUES ('78', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:05:26新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '8', '{\"title\":\"222\",\"min_price\":\"2\",\"max_price\":\"22\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:05:26\",\"created_at\":\"2023-03-10 14:05:26\"}', '1', '2023-03-10 14:05:26');
INSERT INTO `xw_admin_log` VALUES ('79', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:06:43新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '9', '{\"title\":\"2222\\u6211\",\"min_price\":\"2\",\"max_price\":\"30\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:06:43\",\"created_at\":\"2023-03-10 14:06:43\"}', '1', '2023-03-10 14:06:43');
INSERT INTO `xw_admin_log` VALUES ('80', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:08:29刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '9', '{\"id\":9,\"title\":\"2222\\u6211\",\"min_price\":\"2.0000\",\"max_price\":\"30.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 14:06:43\",\"updated_at\":\"2023-03-10 14:06:43\"}', '1', '2023-03-10 14:08:30');
INSERT INTO `xw_admin_log` VALUES ('81', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:08:32刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '8', '{\"id\":8,\"title\":\"222\",\"min_price\":\"2.0000\",\"max_price\":\"22.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 14:05:26\",\"updated_at\":\"2023-03-10 14:05:26\"}', '1', '2023-03-10 14:08:32');
INSERT INTO `xw_admin_log` VALUES ('82', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:08:34刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '7', '{\"id\":7,\"title\":\"\\u7684\\u5473\\u9053\\u65e0\",\"min_price\":\"22.0000\",\"max_price\":\"50.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 14:04:05\",\"updated_at\":\"2023-03-10 14:04:05\"}', '1', '2023-03-10 14:08:34');
INSERT INTO `xw_admin_log` VALUES ('83', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:08:36刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '6', '{\"id\":6,\"title\":\"111\",\"min_price\":\"12.0000\",\"max_price\":\"34.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 14:02:45\",\"updated_at\":\"2023-03-10 14:02:45\"}', '1', '2023-03-10 14:08:36');
INSERT INTO `xw_admin_log` VALUES ('84', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:18:09新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '10', '{\"title\":\"111\",\"min_price\":\"2\",\"max_price\":\"34\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:18:09\",\"created_at\":\"2023-03-10 14:18:09\"}', '1', '2023-03-10 14:18:09');
INSERT INTO `xw_admin_log` VALUES ('85', '1', 'admin', 'edit', '編輯', '地區分類', '新建', '超级管理员在2023-03-10 14:35:59編輯了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '5', '{\"title\":\"1212\",\"min_price\":\"3.0000\",\"max_price\":\"200.0000\",\"sort_order\":\"0\",\"desc\":\"\",\"id\":\"5\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:35:59\"}', '1', '2023-03-10 14:35:59');
INSERT INTO `xw_admin_log` VALUES ('86', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:36:08刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '5', '{\"id\":5,\"title\":\"1212\",\"min_price\":\"3.0000\",\"max_price\":\"200.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 13:58:22\",\"updated_at\":\"2023-03-10 14:35:59\"}', '1', '2023-03-10 14:36:08');
INSERT INTO `xw_admin_log` VALUES ('87', '1', 'admin', 'delete', '刪除', '地區分類', '刪除', '超级管理员在2023-03-10 14:36:13刪除了地區分類', 'admin', 'house_cate', 'delete', '', '127.0.0.1', '10', '{\"id\":10,\"title\":\"111\",\"min_price\":\"2.0000\",\"max_price\":\"34.0000\",\"sort_order\":0,\"status\":1,\"desc\":\"\",\"created_at\":\"2023-03-10 14:18:09\",\"updated_at\":\"2023-03-10 14:18:09\"}', '1', '2023-03-10 14:36:13');
INSERT INTO `xw_admin_log` VALUES ('88', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 14:43:16新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '11', '{\"title\":\"\\u5df4\\u9ece\",\"min_price\":\"50\",\"max_price\":\"200\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:43:16\",\"created_at\":\"2023-03-10 14:43:16\"}', '1', '2023-03-10 14:43:16');
INSERT INTO `xw_admin_log` VALUES ('89', '1', 'admin', 'add', '新增', '文章', '編輯', '超级管理员在2023-03-10 14:43:54新增了文章', 'admin', 'article', 'edit', '', '127.0.0.1', '13', '{\"title\":\"12\",\"cate_id\":\"6\",\"status\":\"1\",\"sort_order\":\"\",\"type\":\"0\",\"desc\":\"22\",\"file\":\"\",\"image\":\"\",\"id\":\"\",\"content\":\"<p>2222<\\/p>\",\"admin_id\":1,\"updated_at\":\"2023-03-10 14:43:54\",\"created_at\":\"2023-03-10 14:43:54\"}', '1', '2023-03-10 14:43:54');
INSERT INTO `xw_admin_log` VALUES ('90', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 16:12:05新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '185', '{\"pid\":\"179\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u623f\\u7522\\u5217\\u8868\",\"src\":\"admin\\/house\\/add\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 16:12:05\",\"created_at\":\"2023-03-10 16:12:05\"}', '1', '2023-03-10 16:12:05');
INSERT INTO `xw_admin_log` VALUES ('91', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 16:19:35新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '186', '{\"pid\":\"179\",\"menu\":\"2\",\"title\":\"\\u7de8\\u8f2f\",\"name\":\"\\u623f\\u7522\\u5217\\u8868\",\"src\":\"admin\\/house\\/edit\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 16:19:35\",\"created_at\":\"2023-03-10 16:19:35\"}', '1', '2023-03-10 16:19:35');
INSERT INTO `xw_admin_log` VALUES ('92', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-10 16:20:52新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '187', '{\"pid\":\"179\",\"menu\":\"2\",\"title\":\"\\u522a\\u9664\",\"name\":\"\\u623f\\u7522\\u5217\\u8868\",\"src\":\"admin\\/house\\/delete\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 16:20:52\",\"created_at\":\"2023-03-10 16:20:52\"}', '1', '2023-03-10 16:20:52');
INSERT INTO `xw_admin_log` VALUES ('93', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-10 16:22:02編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"180\",\"181\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,180,181\",\"admin_id\":1,\"updated_at\":\"2023-03-10 16:22:02\"}', '1', '2023-03-10 16:22:02');
INSERT INTO `xw_admin_log` VALUES ('94', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:22:21刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '1', '{\"id\":1,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"23423\",\"price\":null,\"desc\":\"23423\",\"image\":15,\"content\":\"<p>23423423<\\/p>\",\"read\":0,\"sort_order\":234,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:12:33\",\"updated_at\":\"2023-02-11 10:12:43\"}', '1', '2023-03-10 16:22:21');
INSERT INTO `xw_admin_log` VALUES ('95', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:22:24刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '2', '{\"id\":2,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u6e2c\\u8a66\",\"price\":null,\"desc\":\"334322\",\"image\":16,\"content\":\"<p>23423423423<\\/p>\",\"read\":0,\"sort_order\":3,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:25:19\",\"updated_at\":\"2023-02-11 10:25:28\"}', '1', '2023-03-10 16:22:24');
INSERT INTO `xw_admin_log` VALUES ('96', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:34:04刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '3', '{\"id\":3,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"sdfsdf\",\"price\":null,\"desc\":\"2342342\",\"image\":17,\"content\":\"<p>32423423423<\\/p>\",\"read\":0,\"sort_order\":23423,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:26:35\",\"updated_at\":\"2023-02-11 10:26:35\"}', '1', '2023-03-10 16:34:04');
INSERT INTO `xw_admin_log` VALUES ('97', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:34:06刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"sdf\",\"price\":null,\"desc\":\"sdf\",\"image\":0,\"content\":\"<p>sdfaf<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-11 10:29:09\",\"updated_at\":\"2023-02-11 17:38:51\"}', '1', '2023-03-10 16:34:06');
INSERT INTO `xw_admin_log` VALUES ('98', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:34:09刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '5', '{\"id\":5,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u5167\\u5bb91\",\"price\":null,\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u5167\\u5bb91\\u5167\\u5bb91\\u5167\\u5bb91\\u5167\\u5bb91<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-13 15:16:39\",\"updated_at\":\"2023-02-17 14:55:47\"}', '1', '2023-03-10 16:34:09');
INSERT INTO `xw_admin_log` VALUES ('99', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:34:11刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '6', '{\"id\":6,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u5167\\u5bb92\",\"price\":null,\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u5167\\u5bb92<span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><span style=\\\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\\\">\\u5167\\u5bb92<\\/span><\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-13 15:16:55\",\"updated_at\":\"2023-02-13 15:16:55\"}', '1', '2023-03-10 16:34:11');
INSERT INTO `xw_admin_log` VALUES ('100', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:35:06刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '7', '{\"id\":7,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u6e2c\\u8a66\\u516c\\u544a\",\"price\":null,\"desc\":\"\",\"image\":0,\"content\":\"<p>\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a\\u6e2c\\u8a66\\u516c\\u544a<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-15 16:30:46\",\"updated_at\":\"2023-02-15 16:30:46\"}', '1', '2023-03-10 16:35:06');
INSERT INTO `xw_admin_log` VALUES ('101', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:35:08刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '9', '{\"id\":9,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"sdfa\",\"price\":null,\"desc\":\"sdfasdfsdfadsf\",\"image\":22,\"content\":\"<p>dsfasdf<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"0000-00-00 00:00:00\",\"updated_at\":\"2023-02-21 20:52:19\"}', '1', '2023-03-10 16:35:08');
INSERT INTO `xw_admin_log` VALUES ('102', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:35:10刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '10', '{\"id\":10,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"sdfas\",\"price\":null,\"desc\":\"sdfadsf\",\"image\":0,\"content\":\"<p>sdfsadf<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-21 20:52:13\",\"updated_at\":\"2023-02-21 20:52:13\"}', '1', '2023-03-10 16:35:10');
INSERT INTO `xw_admin_log` VALUES ('103', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 16:35:17刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '11', '{\"id\":11,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\",\"price\":null,\"desc\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\",\"image\":24,\"content\":\"<p>\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a<\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-26 10:58:50\",\"updated_at\":\"2023-02-26 10:58:50\"}', '1', '2023-03-10 16:35:17');
INSERT INTO `xw_admin_log` VALUES ('104', '1', 'admin', 'upload', '上傳', '系統', '', '超级管理员在2023-03-10 17:00:28上傳了系統', 'admin', 'api', 'upload', '', '127.0.0.1', '1', '{\"filepath\":\"\\/storage\\/202303\\/291c0ad63c1a64ceaf8668eff0473c9e.png\",\"name\":\"20230130221912_550.png\",\"mimetype\":\"image\\/png\",\"fileext\":\"png\",\"filesize\":536036,\"filename\":\"202303\\/291c0ad63c1a64ceaf8668eff0473c9e.png\",\"sha1\":\"cd842160f692d3841927040320b1d76e5e2caaa0\",\"md5\":\"291c0ad63c1a64ceaf8668eff0473c9e\",\"module\":\"admin\",\"action\":\"upload\",\"uploadip\":\"127.0.0.1\",\"created_at\":\"2023-03-10 17:00:28\",\"user_id\":1,\"status\":1,\"admin_id\":1,\"audit_time\":1678438828,\"use\":\"thumb\"}', '1', '2023-03-10 17:00:28');
INSERT INTO `xw_admin_log` VALUES ('105', '1', 'admin', 'delete', '刪除', '房產列表', '刪除', '超级管理员在2023-03-10 17:03:54刪除了房產列表', 'admin', 'house', 'delete', '', '127.0.0.1', '12', '{\"id\":12,\"pid\":0,\"cate_id\":11,\"owner_id\":0,\"title\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\",\"price\":null,\"desc\":\"\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\",\"image\":27,\"content\":\"<p>\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2\\u6e2c\\u8a66\\u6700\\u65b0\\u8cc7\\u8a0a2<img src=\\\"\\/storage\\/202302\\/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png\\\" alt=\\\"\\\" width=\\\"1000\\\" height=\\\"600\\\" \\/><\\/p>\",\"read\":0,\"sort_order\":0,\"status\":1,\"admin_id\":1,\"created_at\":\"2023-02-26 10:59:37\",\"updated_at\":\"2023-02-26 10:59:37\"}', '1', '2023-03-10 17:03:54');
INSERT INTO `xw_admin_log` VALUES ('106', '1', 'admin', 'add', '新增', '房產列表', '編輯', '超级管理员在2023-03-10 17:35:43新增了房產列表', 'admin', 'house', 'edit', '', '127.0.0.1', '13', '{\"title\":\"1212\",\"cate_id\":\"11\",\"status\":\"1\",\"sort_order\":\"\",\"desc\":\"\",\"file\":\"\",\"image\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 17:35:43\",\"created_at\":\"2023-03-10 17:35:43\"}', '1', '2023-03-10 17:35:43');
INSERT INTO `xw_admin_log` VALUES ('107', '1', 'admin', 'upload', '上傳', '系統', '', '超级管理员在2023-03-10 17:35:58上傳了系統', 'admin', 'api', 'upload', '', '127.0.0.1', '1', '{\"filepath\":\"\\/storage\\/202303\\/291c0ad63c1a64ceaf8668eff0473c9e.png\",\"name\":\"20230130221912_550.png\",\"mimetype\":\"image\\/png\",\"fileext\":\"png\",\"filesize\":536036,\"filename\":\"202303\\/291c0ad63c1a64ceaf8668eff0473c9e.png\",\"sha1\":\"cd842160f692d3841927040320b1d76e5e2caaa0\",\"md5\":\"291c0ad63c1a64ceaf8668eff0473c9e\",\"module\":\"admin\",\"action\":\"upload\",\"uploadip\":\"127.0.0.1\",\"created_at\":\"2023-03-10 17:35:58\",\"user_id\":1,\"status\":1,\"admin_id\":1,\"audit_time\":1678440958,\"use\":\"thumb\"}', '1', '2023-03-10 17:35:58');
INSERT INTO `xw_admin_log` VALUES ('108', '1', 'admin', 'add', '新增', '房產列表', '編輯', '超级管理员在2023-03-10 17:36:02新增了房產列表', 'admin', 'house', 'edit', '', '127.0.0.1', '14', '{\"title\":\"22323\",\"cate_id\":\"11\",\"status\":\"1\",\"sort_order\":\"\",\"desc\":\"\",\"file\":\"\",\"image\":\"31\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 17:36:02\",\"created_at\":\"2023-03-10 17:36:02\"}', '1', '2023-03-10 17:36:02');
INSERT INTO `xw_admin_log` VALUES ('109', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 17:55:27新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '12', '{\"title\":\"\\u502b\\u6566\",\"min_price\":\"50\",\"max_price\":\"230\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 17:55:27\",\"created_at\":\"2023-03-10 17:55:27\"}', '1', '2023-03-10 17:55:27');
INSERT INTO `xw_admin_log` VALUES ('110', '1', 'admin', 'add', '新增', '地區分類', '新建', '超级管理员在2023-03-10 17:55:38新增了地區分類', 'admin', 'house_cate', 'add', '', '127.0.0.1', '13', '{\"title\":\"\\u6771\\u4eac\",\"min_price\":\"30\",\"max_price\":\"200\",\"sort_order\":\"\",\"desc\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 17:55:38\",\"created_at\":\"2023-03-10 17:55:38\"}', '1', '2023-03-10 17:55:38');
INSERT INTO `xw_admin_log` VALUES ('111', '1', 'admin', 'add', '新增', '房產列表', '編輯', '超级管理员在2023-03-10 21:05:25新增了房產列表', 'admin', 'house', 'edit', '', '127.0.0.1', '15', '{\"title\":\"11\",\"cate_id\":\"12\",\"status\":\"1\",\"price\":\"45\",\"sort_order\":\"\",\"desc\":\"\",\"file\":\"\",\"image\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-10 21:05:25\",\"created_at\":\"2023-03-10 21:05:25\"}', '1', '2023-03-10 21:05:25');
INSERT INTO `xw_admin_log` VALUES ('112', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-11 00:22:32新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '188', '{\"pid\":\"181\",\"menu\":\"1\",\"title\":\"\\u5145\\u503c\\u8a18\\u9304\",\"name\":\"\\u5f69\\u91d1\\u6c60\\u7ba1\\u7406\",\"src\":\"admin\\/bonus_pool\\/index\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 00:22:32\",\"created_at\":\"2023-03-11 00:22:32\"}', '1', '2023-03-11 00:22:32');
INSERT INTO `xw_admin_log` VALUES ('113', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-11 00:24:44新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '189', '{\"pid\":\"188\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u5f69\\u91d1\\u6c60\\u7ba1\\u7406\",\"src\":\"admin\\/bonus_pool\\/add\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 00:24:44\",\"created_at\":\"2023-03-11 00:24:44\"}', '1', '2023-03-11 00:24:44');
INSERT INTO `xw_admin_log` VALUES ('114', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-11 00:25:10編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"180\",\"181\",\"188\",\"189\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,180,181,188,189\",\"admin_id\":1,\"updated_at\":\"2023-03-11 00:25:10\"}', '1', '2023-03-11 00:25:10');
INSERT INTO `xw_admin_log` VALUES ('115', '1', 'admin', 'add', '新增', '彩金池管理', '新建', '超级管理员在2023-03-11 20:48:02新增了彩金池管理', 'admin', 'bonus_pool', 'add', '', '127.0.0.1', '2', '{\"flow\":\"0\",\"price\":\"100\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 20:48:02\",\"created_at\":\"2023-03-11 20:48:02\"}', '1', '2023-03-11 20:48:02');
INSERT INTO `xw_admin_log` VALUES ('116', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-11 21:33:24新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '190', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u901a\\u884c\\u8b49\",\"name\":\"\\u901a\\u884c\\u8b49\",\"src\":\"\",\"sort_order\":\"12\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 21:33:24\",\"created_at\":\"2023-03-11 21:33:24\"}', '1', '2023-03-11 21:33:24');
INSERT INTO `xw_admin_log` VALUES ('117', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-11 21:35:09編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '190', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u901a\\u884c\\u8b49\",\"name\":\"\\u901a\\u884c\\u8b49\",\"src\":\"\",\"sort_order\":\"12\",\"icon\":\"bi-compass\",\"id\":\"190\",\"admin_id\":1,\"updated_at\":\"2023-03-11 21:35:09\"}', '1', '2023-03-11 21:35:09');
INSERT INTO `xw_admin_log` VALUES ('118', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-11 21:38:41新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '191', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\",\"name\":\"\\u901a\\u884c\\u8b49\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 21:38:41\",\"created_at\":\"2023-03-11 21:38:41\"}', '1', '2023-03-11 21:38:41');
INSERT INTO `xw_admin_log` VALUES ('119', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-11 21:39:07新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '192', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\",\"name\":\"\\u901a\\u884c\\u8b49\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-11 21:39:07\",\"created_at\":\"2023-03-11 21:39:07\"}', '1', '2023-03-11 21:39:07');
INSERT INTO `xw_admin_log` VALUES ('120', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-11 21:39:23編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"192\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,180,181,188,189,190,191,192\",\"admin_id\":1,\"updated_at\":\"2023-03-11 21:39:23\"}', '1', '2023-03-11 21:39:23');
INSERT INTO `xw_admin_log` VALUES ('121', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:38:58數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:38:58');
INSERT INTO `xw_admin_log` VALUES ('122', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:40:16數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '12', '{\"table\":\"member\",\"id\":\"12\"}', '1', '2023-03-12 00:40:16');
INSERT INTO `xw_admin_log` VALUES ('123', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:42:19數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:42:19');
INSERT INTO `xw_admin_log` VALUES ('124', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:42:35數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:42:35');
INSERT INTO `xw_admin_log` VALUES ('125', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:42:40數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:42:40');
INSERT INTO `xw_admin_log` VALUES ('126', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:42:42數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:42:42');
INSERT INTO `xw_admin_log` VALUES ('127', '1', 'admin', 'edit', '編輯', '房產列表', '編輯', '超级管理员在2023-03-12 00:43:10編輯了房產列表', 'admin', 'house', 'edit', '', '127.0.0.1', '24', '{\"title\":\"\\u6765\\u751f\\u7f18\",\"cate_id\":\"11\",\"status\":\"0\",\"price\":\"60.0000\",\"sort_order\":\"0\",\"desc\":\"\",\"file\":\"\",\"image\":\"0\",\"id\":\"24\",\"admin_id\":1,\"updated_at\":\"2023-03-12 00:43:10\"}', '1', '2023-03-12 00:43:10');
INSERT INTO `xw_admin_log` VALUES ('128', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 00:45:46數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 00:45:46');
INSERT INTO `xw_admin_log` VALUES ('129', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-12 17:33:06編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '188', '{\"pid\":\"181\",\"menu\":\"1\",\"title\":\"\\u8cc7\\u91d1\\u65e5\\u8a8c\",\"name\":\"\\u5f69\\u91d1\\u6c60\\u7ba1\\u7406\",\"src\":\"admin\\/bonus_pool\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"188\",\"admin_id\":1,\"updated_at\":\"2023-03-12 17:33:06\"}', '1', '2023-03-12 17:33:06');
INSERT INTO `xw_admin_log` VALUES ('130', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 17:54:14編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.015\"}', '1', '2023-03-12 17:54:14');
INSERT INTO `xw_admin_log` VALUES ('131', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-12 21:04:44編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '72', '{\"pid\":\"4\",\"menu\":\"1\",\"title\":\"\\u5bcc\\u7fc1\\u7b49\\u7d1a\",\"name\":\"\\u5bcc\\u7fc1\\u7b49\\u7d1a\",\"src\":\"admin\\/role\\/index\",\"sort_order\":\"1\",\"icon\":\"\",\"id\":\"72\",\"admin_id\":1,\"updated_at\":\"2023-03-12 21:04:44\"}', '1', '2023-03-12 21:04:44');
INSERT INTO `xw_admin_log` VALUES ('132', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:05:03編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.015\"}', '1', '2023-03-12 21:05:03');
INSERT INTO `xw_admin_log` VALUES ('133', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:05:26編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.015\"}', '1', '2023-03-12 21:05:26');
INSERT INTO `xw_admin_log` VALUES ('134', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:11:12編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.02\"}', '1', '2023-03-12 21:11:12');
INSERT INTO `xw_admin_log` VALUES ('135', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:19:09編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"admin_title\":\"200\",\"title\":\"0.015\"}', '1', '2023-03-12 21:19:09');
INSERT INTO `xw_admin_log` VALUES ('136', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:19:40編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"total_money\":\"200\",\"z_proportion\":\"3\",\"m_proportion\":\"1\",\"p_proportion\":\"1\",\"c_proportion\":\"2\"}', '1', '2023-03-12 21:19:40');
INSERT INTO `xw_admin_log` VALUES ('137', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:27:20編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"total_money\":\"300\",\"z_proportion\":\"0.02\",\"m_proportion\":\"0.02\",\"p_proportion\":\"0.005\",\"c_proportion\":\"0.015\"}', '1', '2023-03-12 21:27:20');
INSERT INTO `xw_admin_log` VALUES ('138', '1', 'admin', 'edit', '編輯', '配置詳情', '編輯', '超级管理员在2023-03-12 21:27:34編輯了配置詳情', 'admin', 'conf', 'edit', '', '127.0.0.1', '3', '{\"id\":\"3\",\"total_money\":\"400\",\"z_proportion\":\"0.02\",\"m_proportion\":\"0.02\",\"p_proportion\":\"0.005\",\"c_proportion\":\"0.015\"}', '1', '2023-03-12 21:27:34');
INSERT INTO `xw_admin_log` VALUES ('139', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 21:32:49數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 21:32:49');
INSERT INTO `xw_admin_log` VALUES ('140', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 21:32:59數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 21:32:59');
INSERT INTO `xw_admin_log` VALUES ('141', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 21:35:33數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 21:35:34');
INSERT INTO `xw_admin_log` VALUES ('142', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:01:16數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 22:01:16');
INSERT INTO `xw_admin_log` VALUES ('143', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:05:35數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\"}', '1', '2023-03-12 22:05:35');
INSERT INTO `xw_admin_log` VALUES ('144', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:06:06數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '21', '{\"table\":\"house\",\"id\":\"21\"}', '1', '2023-03-12 22:06:06');
INSERT INTO `xw_admin_log` VALUES ('145', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:07:11數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '2', '{\"table\":\"currency\",\"id\":\"2\",\"field\":\"status\"}', '1', '2023-03-12 22:07:11');
INSERT INTO `xw_admin_log` VALUES ('146', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:15:40數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '24', '{\"table\":\"house\",\"id\":\"24\",\"field\":\"active\"}', '1', '2023-03-12 22:15:40');
INSERT INTO `xw_admin_log` VALUES ('147', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-12 22:15:45數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '22', '{\"table\":\"house\",\"id\":\"22\",\"field\":\"active\"}', '1', '2023-03-12 22:15:45');
INSERT INTO `xw_admin_log` VALUES ('148', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:40:44編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '6', '{\"name\":\"L6\",\"accumulate\":\"0\",\"maintenance\":\"0\",\"dice_num\":\"1\",\"layer_num\":\"0.1\",\"id\":\"6\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:40:44\"}', '1', '2023-03-12 22:40:44');
INSERT INTO `xw_admin_log` VALUES ('149', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:43:01編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '6', '{\"name\":\"L6\",\"accumulate\":\"0\",\"maintenance\":\"0\",\"dice_num\":\"1\",\"layer_num\":\"1\",\"reward_ratio\":\"0.1\",\"id\":\"6\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:43:01\"}', '1', '2023-03-12 22:43:01');
INSERT INTO `xw_admin_log` VALUES ('150', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:47:37編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '5', '{\"name\":\"L5\",\"accumulate\":\"2500\",\"maintenance\":\"500\",\"dice_num\":\"2\",\"layer_num\":\"2\",\"reward_ratio\":\"0.1\",\"id\":\"5\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:47:37\"}', '1', '2023-03-12 22:47:37');
INSERT INTO `xw_admin_log` VALUES ('151', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:47:43編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '4', '{\"name\":\"L4\",\"accumulate\":\"10000\",\"maintenance\":\"2000\",\"dice_num\":\"3\",\"layer_num\":\"4\",\"reward_ratio\":\"0.1\",\"id\":\"4\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:47:43\"}', '1', '2023-03-12 22:47:43');
INSERT INTO `xw_admin_log` VALUES ('152', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:47:49編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '3', '{\"name\":\"L3\",\"accumulate\":\"50000\",\"maintenance\":\"5000\",\"dice_num\":\"4\",\"layer_num\":\"6\",\"reward_ratio\":\"0.1\",\"id\":\"3\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:47:49\"}', '1', '2023-03-12 22:47:49');
INSERT INTO `xw_admin_log` VALUES ('153', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:47:55編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '2', '{\"name\":\"L2\",\"accumulate\":\"250000\",\"maintenance\":\"10000\",\"dice_num\":\"5\",\"layer_num\":\"8\",\"reward_ratio\":\"0.1\",\"id\":\"2\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:47:55\"}', '1', '2023-03-12 22:47:55');
INSERT INTO `xw_admin_log` VALUES ('154', '1', 'admin', 'edit', '編輯', '用戶等級', '新建/編輯', '超级管理员在2023-03-12 22:48:01編輯了用戶等級', 'admin', 'role', 'edit', '', '127.0.0.1', '1', '{\"name\":\"L1\",\"accumulate\":\"500000\",\"maintenance\":\"20000\",\"dice_num\":\"6\",\"layer_num\":\"10\",\"reward_ratio\":\"0.1\",\"id\":\"1\",\"admin_id\":1,\"updated_at\":\"2023-03-12 22:48:01\"}', '1', '2023-03-12 22:48:01');
INSERT INTO `xw_admin_log` VALUES ('155', '1', 'admin', 'edit', '編輯', '房產列表', '編輯', '超级管理员在2023-03-12 23:41:54編輯了房產列表', 'admin', 'house', 'edit', '', '127.0.0.1', '24', '{\"title\":\"\\u6765\\u751f\\u7f18\",\"cate_id\":\"11\",\"status\":\"0\",\"price\":\"60.0000\",\"owner_id\":\"2\",\"sort_order\":\"0\",\"desc\":\"\",\"file\":\"\",\"image\":\"0\",\"id\":\"24\",\"admin_id\":1,\"updated_at\":\"2023-03-12 23:41:54\"}', '1', '2023-03-12 23:41:54');
INSERT INTO `xw_admin_log` VALUES ('156', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-12 23:54:02新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '193', '{\"pid\":\"179\",\"menu\":\"2\",\"title\":\"\\u67e5\\u770b\",\"name\":\"\\u623f\\u7522\\u5217\\u8868\",\"src\":\"admin\\/house\\/read\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-12 23:54:02\",\"created_at\":\"2023-03-12 23:54:02\"}', '1', '2023-03-12 23:54:02');
INSERT INTO `xw_admin_log` VALUES ('157', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-12 23:56:12編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"192\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,192\",\"admin_id\":1,\"updated_at\":\"2023-03-12 23:56:12\"}', '1', '2023-03-12 23:56:12');
INSERT INTO `xw_admin_log` VALUES ('158', '1', 'admin', 'login', '登錄', '系統', '', '超级管理员在2023-03-13 09:24:58登錄了系統', 'admin', 'login', 'login', '', '127.0.0.1', '1', '{\"last_login_at\":\"2023-03-13 09:24:58\",\"last_login_ip\":\"127.0.0.1\",\"login_num\":74}', '1', '2023-03-13 09:24:58');
INSERT INTO `xw_admin_log` VALUES ('159', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:03:37新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '194', '{\"pid\":\"4\",\"menu\":\"1\",\"title\":\"\\u9ab0\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u7528\\u6236\\u7ba1\\u7406\",\"src\":\"admin\\/member_sieve\\/index\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:03:37\",\"created_at\":\"2023-03-13 15:03:37\"}', '1', '2023-03-13 15:03:37');
INSERT INTO `xw_admin_log` VALUES ('160', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-13 15:04:18編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"194\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"192\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,194,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,192\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:04:18\"}', '1', '2023-03-13 15:04:18');
INSERT INTO `xw_admin_log` VALUES ('161', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 15:05:01編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '194', '{\"pid\":\"4\",\"menu\":\"1\",\"title\":\"\\u9ab0\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u7528\\u6236\\u7ba1\\u7406\",\"src\":\"admin\\/member_sieve\\/index\",\"sort_order\":\"4\",\"icon\":\"\",\"id\":\"194\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:05:01\"}', '1', '2023-03-13 15:05:01');
INSERT INTO `xw_admin_log` VALUES ('162', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 15:10:46編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '190', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"\",\"sort_order\":\"12\",\"icon\":\"bi-cart-dash-fill\",\"id\":\"190\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:10:46\"}', '1', '2023-03-13 15:10:46');
INSERT INTO `xw_admin_log` VALUES ('163', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 15:11:27編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '190', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"\",\"sort_order\":\"12\",\"icon\":\"bi-cart-dash\",\"id\":\"190\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:11:27\"}', '1', '2023-03-13 15:11:27');
INSERT INTO `xw_admin_log` VALUES ('164', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 15:12:09編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '191', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u5217\\u8868\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"191\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:12:09\"}', '1', '2023-03-13 15:12:09');
INSERT INTO `xw_admin_log` VALUES ('165', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 15:13:42編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '192', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u8a02\\u55ae\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"192\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:13:42\"}', '1', '2023-03-13 15:13:42');
INSERT INTO `xw_admin_log` VALUES ('166', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:15:00新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '195', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:15:00\",\"created_at\":\"2023-03-13 15:15:00\"}', '1', '2023-03-13 15:15:00');
INSERT INTO `xw_admin_log` VALUES ('167', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-13 15:15:18編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"194\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"192\",\"195\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,194,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,192,195\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:15:18\"}', '1', '2023-03-13 15:15:18');
INSERT INTO `xw_admin_log` VALUES ('168', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:17:26新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '196', '{\"pid\":\"0\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"\",\"sort_order\":\"13\",\"icon\":\"bi-cart-plus\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:17:26\",\"created_at\":\"2023-03-13 15:17:26\"}', '1', '2023-03-13 15:17:26');
INSERT INTO `xw_admin_log` VALUES ('169', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:19:10新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '197', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u5217\\u8868\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:19:10\",\"created_at\":\"2023-03-13 15:19:10\"}', '1', '2023-03-13 15:19:10');
INSERT INTO `xw_admin_log` VALUES ('170', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:20:40新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '198', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u8a02\\u55ae\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:20:40\",\"created_at\":\"2023-03-13 15:20:40\"}', '1', '2023-03-13 15:20:40');
INSERT INTO `xw_admin_log` VALUES ('171', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 15:23:08新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '199', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:23:08\",\"created_at\":\"2023-03-13 15:23:08\"}', '1', '2023-03-13 15:23:08');
INSERT INTO `xw_admin_log` VALUES ('172', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-13 15:23:50編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"194\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"192\",\"195\",\"196\",\"197\",\"198\",\"199\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,194,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,192,195,196,197,198,199\",\"admin_id\":1,\"updated_at\":\"2023-03-13 15:23:50\"}', '1', '2023-03-13 15:23:50');
INSERT INTO `xw_admin_log` VALUES ('173', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-13 21:01:50編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '191', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u5217\\u8868\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"admin\\/sell_card\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"191\",\"admin_id\":1,\"updated_at\":\"2023-03-13 21:01:50\"}', '1', '2023-03-13 21:01:50');
INSERT INTO `xw_admin_log` VALUES ('174', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 21:39:36新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '200', '{\"pid\":\"191\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u639b\\u8ce3\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/sell_card\\/add\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 21:39:36\",\"created_at\":\"2023-03-13 21:39:36\"}', '1', '2023-03-13 21:39:36');
INSERT INTO `xw_admin_log` VALUES ('175', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 21:40:19新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '201', '{\"pid\":\"191\",\"menu\":\"2\",\"title\":\"\\u7de8\\u8f2f\",\"name\":\"\\u639b\\u8ce3\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/sell_card\\/edit\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 21:40:19\",\"created_at\":\"2023-03-13 21:40:19\"}', '1', '2023-03-13 21:40:19');
INSERT INTO `xw_admin_log` VALUES ('176', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-13 21:41:01新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '202', '{\"pid\":\"191\",\"menu\":\"2\",\"title\":\"\\u522a\\u9664\",\"name\":\"\\u639b\\u8ce3\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/sell_card\\/delete\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 21:41:01\",\"created_at\":\"2023-03-13 21:41:01\"}', '1', '2023-03-13 21:41:01');
INSERT INTO `xw_admin_log` VALUES ('177', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-13 21:41:17編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"194\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"200\",\"201\",\"202\",\"192\",\"195\",\"196\",\"197\",\"198\",\"199\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,194,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,200,201,202,192,195,196,197,198,199\",\"admin_id\":1,\"updated_at\":\"2023-03-13 21:41:17\"}', '1', '2023-03-13 21:41:17');
INSERT INTO `xw_admin_log` VALUES ('178', '1', 'admin', 'add', '新增', '掛賣寶列表', '新建', '超级管理员在2023-03-13 22:33:41新增了掛賣寶列表', 'admin', 'sell_card', 'add', '', '127.0.0.1', '1', '{\"day\":\"7\",\"price\":\"9.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 22:33:41\",\"created_at\":\"2023-03-13 22:33:41\"}', '1', '2023-03-13 22:33:41');
INSERT INTO `xw_admin_log` VALUES ('179', '1', 'admin', 'add', '新增', '掛賣寶列表', '新建', '超级管理员在2023-03-13 22:35:05新增了掛賣寶列表', 'admin', 'sell_card', 'add', '', '127.0.0.1', '2', '{\"day\":\"15\",\"price\":\"17.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 22:35:05\",\"created_at\":\"2023-03-13 22:35:05\"}', '1', '2023-03-13 22:35:05');
INSERT INTO `xw_admin_log` VALUES ('180', '1', 'admin', 'add', '新增', '掛賣寶列表', '新建', '超级管理员在2023-03-13 22:35:24新增了掛賣寶列表', 'admin', 'sell_card', 'add', '', '127.0.0.1', '3', '{\"day\":\"30\",\"price\":\"29.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 22:35:24\",\"created_at\":\"2023-03-13 22:35:24\"}', '1', '2023-03-13 22:35:24');
INSERT INTO `xw_admin_log` VALUES ('181', '1', 'admin', 'status', '數據狀態', '系統', '', '超级管理员在2023-03-13 22:42:35數據狀態了系統', 'admin', 'index', 'status', '', '127.0.0.1', '3', '{\"table\":\"sell_card\",\"id\":\"3\"}', '1', '2023-03-13 22:42:35');
INSERT INTO `xw_admin_log` VALUES ('182', '1', 'admin', 'add', '新增', '掛賣寶列表', '新建', '超级管理员在2023-03-13 22:49:44新增了掛賣寶列表', 'admin', 'sell_card', 'add', '', '127.0.0.1', '4', '{\"day\":\"1\",\"price\":\"1\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-13 22:49:44\",\"created_at\":\"2023-03-13 22:49:44\"}', '1', '2023-03-13 22:49:44');
INSERT INTO `xw_admin_log` VALUES ('183', '1', 'admin', 'delete', '刪除', '掛賣寶列表', '刪除', '超级管理员在2023-03-13 23:03:55刪除了掛賣寶列表', 'admin', 'sell_card', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"day\":1,\"price\":\"1.0000\",\"status\":1,\"admin_id\":1,\"sort_order\":0,\"created_at\":\"2023-03-13 22:49:44\"}', '1', '2023-03-13 23:03:55');
INSERT INTO `xw_admin_log` VALUES ('184', '1', 'admin', 'login', '登錄', '系統', '', '超级管理员在2023-03-14 16:13:50登錄了系統', 'admin', 'login', 'login', '', '127.0.0.1', '1', '{\"last_login_at\":\"2023-03-14 16:13:50\",\"last_login_ip\":\"127.0.0.1\",\"login_num\":75}', '1', '2023-03-14 16:13:50');
INSERT INTO `xw_admin_log` VALUES ('185', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-14 16:29:59編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '192', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u8a02\\u55ae\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"admin\\/sell_card_order\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"192\",\"admin_id\":1,\"updated_at\":\"2023-03-14 16:29:59\"}', '1', '2023-03-14 16:29:59');
INSERT INTO `xw_admin_log` VALUES ('186', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-14 16:51:23編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '195', '{\"pid\":\"190\",\"menu\":\"1\",\"title\":\"\\u639b\\u8ce3\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u639b\\u8ce3\\u5bf6\",\"src\":\"admin\\/sell_card_use\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"195\",\"admin_id\":1,\"updated_at\":\"2023-03-14 16:51:23\"}', '1', '2023-03-14 16:51:23');
INSERT INTO `xw_admin_log` VALUES ('187', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-14 17:18:18編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '197', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u5217\\u8868\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"admin\\/buy_card\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"197\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:18:18\"}', '1', '2023-03-14 17:18:18');
INSERT INTO `xw_admin_log` VALUES ('188', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-14 17:40:37新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '203', '{\"pid\":\"197\",\"menu\":\"2\",\"title\":\"\\u65b0\\u5efa\",\"name\":\"\\u6436\\u623f\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/buy_card\\/add\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:40:37\",\"created_at\":\"2023-03-14 17:40:37\"}', '1', '2023-03-14 17:40:37');
INSERT INTO `xw_admin_log` VALUES ('189', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-14 17:41:16新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '204', '{\"pid\":\"197\",\"menu\":\"2\",\"title\":\"\\u7de8\\u8f2f\",\"name\":\"\\u6436\\u623f\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/buy_card\\/edit\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:41:16\",\"created_at\":\"2023-03-14 17:41:16\"}', '1', '2023-03-14 17:41:16');
INSERT INTO `xw_admin_log` VALUES ('190', '1', 'admin', 'add', '新增', '功能菜單', '新建', '超级管理员在2023-03-14 17:41:56新增了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '205', '{\"pid\":\"197\",\"menu\":\"2\",\"title\":\"\\u522a\\u9664\",\"name\":\"\\u6436\\u623f\\u5bf6\\u5217\\u8868\",\"src\":\"admin\\/buy_card\\/delete\",\"sort_order\":\"\",\"icon\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:41:56\",\"created_at\":\"2023-03-14 17:41:56\"}', '1', '2023-03-14 17:41:56');
INSERT INTO `xw_admin_log` VALUES ('191', '1', 'admin', 'edit', '編輯', '角色管理', '新建', '超级管理员在2023-03-14 17:43:42編輯了角色管理', 'admin', 'admin_role', 'add', '', '127.0.0.1', '1', '{\"id\":\"1\",\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"status\":\"1\",\"rule\":[\"1\",\"9\",\"10\",\"11\",\"12\",\"17\",\"18\",\"19\",\"154\",\"20\",\"21\",\"22\",\"153\",\"23\",\"24\",\"25\",\"26\",\"27\",\"28\",\"29\",\"30\",\"31\",\"32\",\"158\",\"2\",\"33\",\"3\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"112\",\"4\",\"72\",\"73\",\"74\",\"75\",\"76\",\"77\",\"78\",\"80\",\"194\",\"113\",\"114\",\"117\",\"118\",\"119\",\"115\",\"120\",\"121\",\"122\",\"116\",\"123\",\"125\",\"135\",\"126\",\"127\",\"133\",\"128\",\"129\",\"134\",\"130\",\"132\",\"173\",\"174\",\"175\",\"176\",\"5\",\"81\",\"82\",\"83\",\"84\",\"85\",\"86\",\"87\",\"89\",\"8\",\"108\",\"109\",\"110\",\"111\",\"159\",\"160\",\"177\",\"178\",\"182\",\"183\",\"184\",\"179\",\"185\",\"186\",\"187\",\"193\",\"180\",\"181\",\"188\",\"189\",\"190\",\"191\",\"200\",\"201\",\"202\",\"192\",\"195\",\"196\",\"197\",\"203\",\"204\",\"205\",\"198\",\"199\"],\"desc\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\uff0c\\u7cfb\\u7edf\\u81ea\\u52a8\\u5206\\u914d\\u6240\\u6709\\u53ef\\u64cd\\u4f5c\\u6743\\u9650\\u53ca\\u83dc\\u5355\\u3002\",\"rules\":\"1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,194,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,200,201,202,192,195,196,197,203,204,205,198,199\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:43:42\"}', '1', '2023-03-14 17:43:42');
INSERT INTO `xw_admin_log` VALUES ('192', '1', 'admin', 'add', '新增', '搶房寶列表', '新建', '超级管理员在2023-03-14 17:54:03新增了搶房寶列表', 'admin', 'buy_card', 'add', '', '127.0.0.1', '1', '{\"num\":\"10\",\"price\":\"9.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:54:03\",\"created_at\":\"2023-03-14 17:54:03\"}', '1', '2023-03-14 17:54:03');
INSERT INTO `xw_admin_log` VALUES ('193', '1', 'admin', 'add', '新增', '搶房寶列表', '新建', '超级管理员在2023-03-14 17:54:42新增了搶房寶列表', 'admin', 'buy_card', 'add', '', '127.0.0.1', '2', '{\"num\":\"20\",\"price\":\"14.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:54:42\",\"created_at\":\"2023-03-14 17:54:42\"}', '1', '2023-03-14 17:54:42');
INSERT INTO `xw_admin_log` VALUES ('194', '1', 'admin', 'add', '新增', '搶房寶列表', '新建', '超级管理员在2023-03-14 17:54:58新增了搶房寶列表', 'admin', 'buy_card', 'add', '', '127.0.0.1', '3', '{\"num\":\"30\",\"price\":\"19.9\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:54:58\",\"created_at\":\"2023-03-14 17:54:58\"}', '1', '2023-03-14 17:54:58');
INSERT INTO `xw_admin_log` VALUES ('195', '1', 'admin', 'add', '新增', '搶房寶列表', '新建', '超级管理员在2023-03-14 17:55:15新增了搶房寶列表', 'admin', 'buy_card', 'add', '', '127.0.0.1', '4', '{\"num\":\"1\",\"price\":\"1\",\"status\":\"1\",\"sort_order\":\"\",\"id\":\"\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:55:15\",\"created_at\":\"2023-03-14 17:55:15\"}', '1', '2023-03-14 17:55:15');
INSERT INTO `xw_admin_log` VALUES ('196', '1', 'admin', 'edit', '編輯', '搶房寶列表', '新建', '超级管理员在2023-03-14 17:55:20編輯了搶房寶列表', 'admin', 'buy_card', 'add', '', '127.0.0.1', '4', '{\"num\":\"2\",\"price\":\"1.0000\",\"status\":\"1\",\"sort_order\":\"0\",\"id\":\"4\",\"admin_id\":1,\"updated_at\":\"2023-03-14 17:55:20\"}', '1', '2023-03-14 17:55:20');
INSERT INTO `xw_admin_log` VALUES ('197', '1', 'admin', 'delete', '刪除', '搶房寶列表', '刪除', '超级管理员在2023-03-14 17:55:24刪除了搶房寶列表', 'admin', 'buy_card', 'delete', '', '127.0.0.1', '4', '{\"id\":4,\"num\":2,\"price\":\"1.0000\",\"status\":1,\"admin_id\":1,\"sort_order\":0,\"created_at\":\"2023-03-14 17:55:15\"}', '1', '2023-03-14 17:55:24');
INSERT INTO `xw_admin_log` VALUES ('198', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-14 21:30:58編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '198', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u8a02\\u55ae\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"admin\\/buy_card_order\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"198\",\"admin_id\":1,\"updated_at\":\"2023-03-14 21:30:58\"}', '1', '2023-03-14 21:30:58');
INSERT INTO `xw_admin_log` VALUES ('199', '1', 'admin', 'edit', '編輯', '功能菜單', '新建', '超级管理员在2023-03-14 22:27:34編輯了功能菜單', 'admin', 'admin_menu', 'add', '', '127.0.0.1', '199', '{\"pid\":\"196\",\"menu\":\"1\",\"title\":\"\\u6436\\u623f\\u5bf6\\u4f7f\\u7528\\u8a18\\u9304\",\"name\":\"\\u6436\\u623f\\u5bf6\",\"src\":\"admin\\/buy_card_use\\/index\",\"sort_order\":\"0\",\"icon\":\"\",\"id\":\"199\",\"admin_id\":1,\"updated_at\":\"2023-03-14 22:27:34\"}', '1', '2023-03-14 22:27:34');

-- ----------------------------
-- Table structure for xw_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_menu`;
CREATE TABLE `xw_admin_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `src` varchar(255) NOT NULL DEFAULT '' COMMENT 'url鏈接',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名稱',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '日誌操作名稱',
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '圖示',
  `menu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是菜單,1是,2不是',
  `sort_order` int(4) NOT NULL DEFAULT '9999' COMMENT '大的靠前',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '狀態,0禁用,1正常',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT '所屬模組',
  `crud` varchar(255) NOT NULL DEFAULT '' COMMENT 'crud標識',
  `created_at` datetime NOT NULL COMMENT '創建時間',
  `updated_at` datetime NOT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COMMENT='菜單及許可權表';

-- ----------------------------
-- Records of xw_admin_menu
-- ----------------------------
INSERT INTO `xw_admin_menu` VALUES ('1', '0', '', '系統管理', '系統管理', 'bi-gear', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('2', '0', '', '系統工具', '系統工具', 'bi-briefcase', '1', '2', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('3', '0', '', '廣告管理', '廣告管理', 'bi-box', '1', '3', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('4', '0', '', '用戶管理', '用戶管理', 'bi-people', '1', '4', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('5', '0', '', '資訊中心', '資訊中心', 'bi-journal-text', '1', '7', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('8', '0', '', '單 頁 面', '單 頁 面', 'bi-stickies', '1', '8', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('9', '1', 'admin/conf/index', '系統配置', '系統配置', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('10', '9', 'admin/conf/add', '新建/編輯', '配置項', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('11', '9', 'admin/conf/delete', '刪除', '配置項', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('12', '9', 'admin/conf/edit', '編輯', '配置詳情', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('17', '1', 'admin/admin_menu/index', '功能菜單', '功能菜單', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('18', '17', 'admin/admin_menu/add', '新建', '功能菜單', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '2023-02-21 22:38:07');
INSERT INTO `xw_admin_menu` VALUES ('19', '17', 'admin/admin_menu/delete', '刪除', '功能菜單', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('20', '1', 'admin/admin_role/index', '角色管理', '角色管理', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('21', '20', 'admin/admin_role/add', '新建', '角色管理', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('22', '20', 'admin/admin_role/delete', '刪除', '角色管理', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('23', '1', 'admin/admin_department/index', '部門架構', '部門', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('24', '23', 'admin/admin_department/add', '新建/編輯', '部門', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('25', '23', 'admin/admin_department/delete', '刪除', '部門', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('26', '1', 'admin/admin_position/index', '崗位職稱', '崗位職稱', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('27', '26', 'admin/admin_position/add', '新建/編輯', '崗位職稱', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('28', '26', 'admin/admin_position/delete', '刪除', '崗位職稱', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('29', '1', 'admin/admin/index', '系統用戶', '系統用戶', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('30', '29', 'admin/admin/add', '添加', '系統用戶', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '2023-02-21 22:50:07');
INSERT INTO `xw_admin_menu` VALUES ('31', '29', 'admin/admin/view', '查看', '系統用戶', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('32', '29', 'admin/admin/delete', '刪除', '系統用戶', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('33', '2', 'admin/admin_log/index', '操作日誌', '操作日誌', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('58', '3', 'admin/banner/cate_list', '廣告位', '輪播組', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('59', '58', 'admin/banner/cate_add', '新建/編輯', '輪播組', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('60', '58', 'admin/banner/cate_delete', '刪除', '輪播組', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('61', '3', 'admin/banner/list', '輪播廣告管理', '輪播圖', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('62', '61', 'admin/banner/add', '新建/編輯', '輪播圖', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('63', '61', 'admin/banner/delete', '刪除', '輪播圖', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('72', '4', 'admin/role/index', '富翁等級', '富翁等級', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '2023-03-12 21:04:44');
INSERT INTO `xw_admin_menu` VALUES ('73', '72', 'admin/role/edit', '新建/編輯', '用戶等級', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '2023-03-09 20:17:42');
INSERT INTO `xw_admin_menu` VALUES ('74', '72', 'admin/role/disable', '禁用/啟用', '用戶等級', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('75', '4', 'admin/member/index', '用戶管理', '用戶', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('76', '75', 'admin/member/edit', '編輯', '用戶資訊', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('77', '75', 'admin/member/view', '查看', '用戶資訊', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('78', '75', 'admin/member/disable', '禁用/啟用', '用戶', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('80', '4', 'admin/member/log', '操作日誌', '用戶操作日誌', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('81', '5', 'admin/article_cate/index', '文章分類', '文章分類', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('82', '81', 'admin/article_cate/add', '新建', '文章分類', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('83', '81', 'admin/article_cate/edit', '編輯', '文章分類', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('84', '81', 'admin/article_cate/delete', '刪除', '文章分類', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('85', '5', 'admin/article/index', '文章列表', '文章', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('86', '85', 'admin/article/add', '新建', '文章', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('87', '85', 'admin/article/edit', '編輯', '文章', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('89', '85', 'admin/article/delete', '刪除', '文章', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('108', '8', 'admin/page/index', '單頁面列表', '單頁面', '', '1', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('109', '108', 'admin/page/add', '新建', '單頁面', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('110', '108', 'admin/page/edit', '編輯', '單頁面', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('111', '108', 'admin/page/delete', '刪除', '單頁面', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('112', '3', 'admin/banner/info', '輪播廣告管理', '輪播圖', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('113', '0', '', '幣鏈管理', '幣鏈管理', 'bi-x-diamond', '1', '5', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('114', '113', 'admin/currency/index', '貨幣管理', '貨幣管理', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('115', '113', 'admin/chain/index', '公鏈管理', '公鏈管理', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('116', '113', 'admin/currencychain/index', '幣鏈管理', '幣鏈管理', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('117', '114', 'admin/currency/add', '新建', '貨幣管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('118', '114', 'admin/currency/edit', '編輯', '貨幣管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('119', '114', 'admin/currency/delete', '刪除', '貨幣管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('120', '115', 'admin/chain/delete', '刪除', '公鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('121', '115', 'admin/chain/edit', '編輯', '公鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('122', '115', 'admin/chain/add', '新建', '公鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('123', '116', 'admin/currencychain/add', '新建', '幣鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('125', '116', 'admin/currencychain/delete', '刪除', '幣鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('126', '0', '', '資產管理', '資產管理', 'bi-window-desktop', '1', '6', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('127', '126', 'admin/account/index', '資產列表', '資產列表', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('128', '126', 'admin/account_log/index', '資產日誌', '資產日誌', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('129', '126', 'admin/withdraw/index', '提現列表', '提現列表', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('130', '126', 'admin/recharge/index', '充值列表', '充值列表', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('131', '126', 'admin/transfer/index', '內轉列表', '內轉列表', '', '1', '9999', '0', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('132', '126', 'admin/reward/index', '獎勵列表', '獎勵列表', '', '1', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('133', '127', 'admin/account/edit', '編輯', '資產列表', '', '2', '9999', '1', '', '', '2023-02-06 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('134', '129', 'admin/withdraw/edit', '編輯', '提現列表', '', '2', '9999', '1', '', '', '2023-02-06 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('135', '116', 'admin/currencychain/edit', '編輯', '幣鏈管理', '', '2', '9999', '1', '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('153', '20', 'admin/admin_role/edit', '編輯', '角色管理', '', '2', '9999', '1', '', '', '2023-02-21 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('154', '17', 'admin/admin_menu/edit', '編輯', '功能菜單', '', '2', '1', '1', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_menu` VALUES ('158', '29', 'admin/admin/edit', '修改', '系統用戶', '', '2', '9999', '1', '', '', '2023-02-21 22:50:32', '2023-02-21 22:50:32');
INSERT INTO `xw_admin_menu` VALUES ('159', '0', '', '錢包管理', '錢包管理', 'bi-wallet', '1', '9', '1', '', '', '2023-02-22 19:54:15', '2023-03-10 00:15:04');
INSERT INTO `xw_admin_menu` VALUES ('160', '159', 'admin/wallet/list', '地址管理', '錢包管理', '', '1', '9999', '1', '', '', '2023-02-22 19:54:40', '2023-02-22 19:54:40');
INSERT INTO `xw_admin_menu` VALUES ('173', '126', 'admin/account_pair/list', '資產交易對', '資產管理', '', '1', '9999', '1', '', '', '2023-02-27 19:43:47', '2023-02-27 19:43:47');
INSERT INTO `xw_admin_menu` VALUES ('174', '173', 'admin/account_pair/add', '新建', '資產管理', '', '2', '9999', '1', '', '', '2023-02-27 19:44:06', '2023-02-27 19:44:06');
INSERT INTO `xw_admin_menu` VALUES ('175', '173', 'admin/account_pair/edit', '編輯', '資產管理', '', '2', '9999', '1', '', '', '2023-02-27 19:44:23', '2023-02-27 19:44:23');
INSERT INTO `xw_admin_menu` VALUES ('176', '173', 'admin/account_pair/delete', '刪除', '資產管理', '', '2', '9999', '1', '', '', '2023-02-27 19:44:42', '2023-02-27 19:44:42');
INSERT INTO `xw_admin_menu` VALUES ('177', '0', '', '房產管理', '房產管理', 'bi-house', '1', '10', '1', '', '', '2023-03-09 23:45:54', '2023-03-10 00:15:13');
INSERT INTO `xw_admin_menu` VALUES ('178', '177', 'admin/house_cate/index', '地區管理', '地區管理', '', '1', '1', '1', '', '', '2023-03-09 23:47:34', '2023-03-10 00:21:04');
INSERT INTO `xw_admin_menu` VALUES ('179', '177', 'admin/house/index', '房產列表', '房產列表', '', '1', '2', '1', '', '', '2023-03-10 00:26:24', '2023-03-10 00:26:24');
INSERT INTO `xw_admin_menu` VALUES ('180', '177', 'admin/house_order/index', '訂單列表', '訂單列表', '', '1', '3', '1', '', '', '2023-03-10 00:27:57', '2023-03-10 00:27:57');
INSERT INTO `xw_admin_menu` VALUES ('181', '0', '', '彩金池管理', '彩金池管理', 'bi-currency-dollar', '1', '11', '1', '', '', '2023-03-10 00:39:23', '2023-03-10 00:39:23');
INSERT INTO `xw_admin_menu` VALUES ('182', '178', 'admin/house_cate/add', '新建', '地區分類', '', '2', '0', '1', '', '', '2023-03-10 10:14:29', '2023-03-10 10:15:17');
INSERT INTO `xw_admin_menu` VALUES ('183', '178', 'admin/house_cate/edit', '編輯', '地區分類', '', '2', '0', '1', '', '', '2023-03-10 10:16:13', '2023-03-10 10:16:13');
INSERT INTO `xw_admin_menu` VALUES ('184', '178', 'admin/house_cate/delete', '刪除', '地區分類', '', '2', '0', '1', '', '', '2023-03-10 10:17:57', '2023-03-10 10:17:57');
INSERT INTO `xw_admin_menu` VALUES ('185', '179', 'admin/house/add', '新建', '房產列表', '', '2', '0', '1', '', '', '2023-03-10 16:12:05', '2023-03-10 16:12:05');
INSERT INTO `xw_admin_menu` VALUES ('186', '179', 'admin/house/edit', '編輯', '房產列表', '', '2', '0', '1', '', '', '2023-03-10 16:19:35', '2023-03-10 16:19:35');
INSERT INTO `xw_admin_menu` VALUES ('187', '179', 'admin/house/delete', '刪除', '房產列表', '', '2', '0', '1', '', '', '2023-03-10 16:20:52', '2023-03-10 16:20:52');
INSERT INTO `xw_admin_menu` VALUES ('188', '181', 'admin/bonus_pool/index', '資金日誌', '彩金池管理', '', '1', '0', '1', '', '', '2023-03-11 00:22:32', '2023-03-12 17:33:06');
INSERT INTO `xw_admin_menu` VALUES ('189', '188', 'admin/bonus_pool/add', '新建', '彩金池管理', '', '2', '0', '1', '', '', '2023-03-11 00:24:44', '2023-03-11 00:24:44');
INSERT INTO `xw_admin_menu` VALUES ('190', '0', '', '掛賣寶', '掛賣寶', 'bi-cart-dash', '1', '12', '1', '', '', '2023-03-11 21:33:24', '2023-03-13 15:11:27');
INSERT INTO `xw_admin_menu` VALUES ('191', '190', 'admin/sell_card/index', '掛賣寶列表', '掛賣寶', '', '1', '0', '1', '', '', '2023-03-11 21:38:41', '2023-03-13 21:01:50');
INSERT INTO `xw_admin_menu` VALUES ('192', '190', 'admin/sell_card_order/index', '掛賣寶訂單', '掛賣寶', '', '1', '0', '1', '', '', '2023-03-11 21:39:07', '2023-03-14 16:29:59');
INSERT INTO `xw_admin_menu` VALUES ('193', '179', 'admin/house/read', '查看', '房產列表', '', '2', '0', '1', '', '', '2023-03-12 23:54:02', '2023-03-12 23:54:02');
INSERT INTO `xw_admin_menu` VALUES ('194', '4', 'admin/member_sieve/index', '骰寶使用記錄', '用戶管理', '', '1', '4', '1', '', '', '2023-03-13 15:03:37', '2023-03-13 15:05:01');
INSERT INTO `xw_admin_menu` VALUES ('195', '190', 'admin/sell_card_use/index', '掛賣寶使用記錄', '掛賣寶', '', '1', '0', '1', '', '', '2023-03-13 15:15:00', '2023-03-14 16:51:23');
INSERT INTO `xw_admin_menu` VALUES ('196', '0', '', '搶房寶', '搶房寶', 'bi-cart-plus', '1', '13', '1', '', '', '2023-03-13 15:17:26', '2023-03-13 15:17:26');
INSERT INTO `xw_admin_menu` VALUES ('197', '196', 'admin/buy_card/index', '搶房寶列表', '搶房寶', '', '1', '0', '1', '', '', '2023-03-13 15:19:10', '2023-03-14 17:18:18');
INSERT INTO `xw_admin_menu` VALUES ('198', '196', 'admin/buy_card_order/index', '搶房寶訂單', '搶房寶', '', '1', '0', '1', '', '', '2023-03-13 15:20:40', '2023-03-14 21:30:58');
INSERT INTO `xw_admin_menu` VALUES ('199', '196', 'admin/buy_card_use/index', '搶房寶使用記錄', '搶房寶', '', '1', '0', '1', '', '', '2023-03-13 15:23:08', '2023-03-14 22:27:34');
INSERT INTO `xw_admin_menu` VALUES ('200', '191', 'admin/sell_card/add', '新建', '掛賣寶列表', '', '2', '0', '1', '', '', '2023-03-13 21:39:36', '2023-03-13 21:39:36');
INSERT INTO `xw_admin_menu` VALUES ('201', '191', 'admin/sell_card/edit', '編輯', '掛賣寶列表', '', '2', '0', '1', '', '', '2023-03-13 21:40:19', '2023-03-13 21:40:19');
INSERT INTO `xw_admin_menu` VALUES ('202', '191', 'admin/sell_card/delete', '刪除', '掛賣寶列表', '', '2', '0', '1', '', '', '2023-03-13 21:41:01', '2023-03-13 21:41:01');
INSERT INTO `xw_admin_menu` VALUES ('203', '197', 'admin/buy_card/add', '新建', '搶房寶列表', '', '2', '0', '1', '', '', '2023-03-14 17:40:37', '2023-03-14 17:40:37');
INSERT INTO `xw_admin_menu` VALUES ('204', '197', 'admin/buy_card/edit', '編輯', '搶房寶列表', '', '2', '0', '1', '', '', '2023-03-14 17:41:16', '2023-03-14 17:41:16');
INSERT INTO `xw_admin_menu` VALUES ('205', '197', 'admin/buy_card/delete', '刪除', '搶房寶列表', '', '2', '0', '1', '', '', '2023-03-14 17:41:56', '2023-03-14 17:41:56');

-- ----------------------------
-- Table structure for xw_admin_position
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_position`;
CREATE TABLE `xw_admin_position` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '岗位名称',
  `remark` varchar(1000) DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：-1删除 0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='岗位职称';

-- ----------------------------
-- Records of xw_admin_position
-- ----------------------------
INSERT INTO `xw_admin_position` VALUES ('1', '董事長', '董事長', '1', '2023-01-30 15:44:12', '2023-01-30 15:44:12');
INSERT INTO `xw_admin_position` VALUES ('2', '行政長官', '行政長官', '1', '2023-01-30 15:44:12', '2023-01-30 15:44:12');
INSERT INTO `xw_admin_position` VALUES ('3', '開發工程師', '開發工程師', '1', '2023-01-30 15:44:12', '2023-01-30 15:44:12');
INSERT INTO `xw_admin_position` VALUES ('4', '新聞編輯', '新聞編輯人员', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_position` VALUES ('5', 'sdfa', 'sdfasdf', '1', '2023-02-21 22:31:17', '2023-02-21 22:31:17');

-- ----------------------------
-- Table structure for xw_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_role`;
CREATE TABLE `xw_admin_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(1000) DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  `desc` text COMMENT '备注',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='权限分组表';

-- ----------------------------
-- Records of xw_admin_role
-- ----------------------------
INSERT INTO `xw_admin_role` VALUES ('1', '超级管理员', '1', '1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,194,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,177,178,182,183,184,179,185,186,187,193,180,181,188,189,190,191,200,201,202,192,195,196,197,203,204,205,198,199', '超级管理员，系统自动分配所有可操作权限及菜单。', '2023-01-30 21:09:03', '2023-03-14 17:43:42');
INSERT INTO `xw_admin_role` VALUES ('2', '测试角色', '1', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,81,83', '测试角色', '2023-01-30 21:09:08', '2023-01-30 21:09:10');

-- ----------------------------
-- Table structure for xw_admin_role_access
-- ----------------------------
DROP TABLE IF EXISTS `xw_admin_role_access`;
CREATE TABLE `xw_admin_role_access` (
  `uid` int(11) unsigned DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限分组和管理员的关联表';

-- ----------------------------
-- Records of xw_admin_role_access
-- ----------------------------
INSERT INTO `xw_admin_role_access` VALUES ('2', '3', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `xw_admin_role_access` VALUES ('1', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for xw_article
-- ----------------------------
DROP TABLE IF EXISTS `xw_article`;
CREATE TABLE `xw_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(20) NOT NULL,
  `cate_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属分类',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(1000) DEFAULT '' COMMENT '摘要',
  `image` int(11) NOT NULL DEFAULT '0' COMMENT '缩略图:附件id',
  `content` text NOT NULL COMMENT '内容',
  `read` int(11) NOT NULL DEFAULT '0' COMMENT '阅读量',
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '属性:1~10',
  `sort_order` int(114) NOT NULL DEFAULT '9999' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态:1正常,0下架',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='文章詳情';

-- ----------------------------
-- Records of xw_article
-- ----------------------------
INSERT INTO `xw_article` VALUES ('13', '', '6', '12', '22', '0', '<p>2222</p>', '0', '0', '0', '1', '1', '2023-03-10 14:43:54', '2023-03-10 14:43:54');

-- ----------------------------
-- Table structure for xw_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `xw_article_cate`;
CREATE TABLE `xw_article_cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `desc` varchar(1000) DEFAULT '' COMMENT '描述',
  `sort_order` int(5) NOT NULL DEFAULT '9999' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL COMMENT '添加时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='文章分类';

-- ----------------------------
-- Records of xw_article_cate
-- ----------------------------
INSERT INTO `xw_article_cate` VALUES ('6', '0', '公告', '', '0', '1', '2023-02-15 16:30:26', '2023-02-15 16:30:26');
INSERT INTO `xw_article_cate` VALUES ('7', '0', '最新資訊', '', '0', '1', '2023-02-26 10:57:13', '2023-02-26 10:57:13');
INSERT INTO `xw_article_cate` VALUES ('8', '0', '促銷活動', '促銷活動', '0', '1', '2023-03-09 15:52:22', '2023-03-09 15:52:22');

-- ----------------------------
-- Table structure for xw_banner
-- ----------------------------
DROP TABLE IF EXISTS `xw_banner`;
CREATE TABLE `xw_banner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(30) NOT NULL,
  `cate_id` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `desc` varchar(1000) DEFAULT NULL,
  `img` varchar(255) NOT NULL DEFAULT '',
  `src` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1可用-1禁用',
  `sort_order` int(4) NOT NULL DEFAULT '9999',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片详情表';

-- ----------------------------
-- Records of xw_banner
-- ----------------------------

-- ----------------------------
-- Table structure for xw_banner_cate
-- ----------------------------
DROP TABLE IF EXISTS `xw_banner_cate`;
CREATE TABLE `xw_banner_cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1可用-1禁用',
  `desc` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- ----------------------------
-- Records of xw_banner_cate
-- ----------------------------
INSERT INTO `xw_banner_cate` VALUES ('1', '首页轮播', '1', '首页轮播组。', '2023-02-08 19:47:40', '2023-02-11 00:00:00');
INSERT INTO `xw_banner_cate` VALUES ('2', '测试', '1', '11', '2023-02-08 00:00:00', '2023-02-10 00:00:00');

-- ----------------------------
-- Table structure for xw_bonus_pool
-- ----------------------------
DROP TABLE IF EXISTS `xw_bonus_pool`;
CREATE TABLE `xw_bonus_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `operate_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0后台操作、1前端操作',
  `flow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0流出、1流进',
  `price` decimal(30,4) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_bonus_pool
-- ----------------------------
INSERT INTO `xw_bonus_pool` VALUES ('1', '0', '1', '0', '1', '32.0000', '2023-03-30 00:16:50');
INSERT INTO `xw_bonus_pool` VALUES ('2', '0', '1', '0', '0', '100.0000', '2023-03-11 20:48:02');

-- ----------------------------
-- Table structure for xw_buy_card
-- ----------------------------
DROP TABLE IF EXISTS `xw_buy_card`;
CREATE TABLE `xw_buy_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(1) NOT NULL COMMENT '个数',
  `price` decimal(30,4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '上下架：0下架、1上架',
  `admin_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '9999',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_buy_card
-- ----------------------------
INSERT INTO `xw_buy_card` VALUES ('1', '10', '9.9000', '1', '1', '0', '2023-03-14 17:54:03');
INSERT INTO `xw_buy_card` VALUES ('2', '20', '14.9000', '1', '1', '0', '2023-03-14 17:54:42');
INSERT INTO `xw_buy_card` VALUES ('3', '30', '19.9000', '1', '1', '0', '2023-03-14 17:54:58');

-- ----------------------------
-- Table structure for xw_buy_card_order
-- ----------------------------
DROP TABLE IF EXISTS `xw_buy_card_order`;
CREATE TABLE `xw_buy_card_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `buy_card_id` int(11) NOT NULL,
  `order_no` varchar(255) NOT NULL,
  `num` int(11) NOT NULL,
  `price` decimal(30,4) NOT NULL,
  `used_num` int(11) NOT NULL COMMENT '已使用个数',
  `member_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0待支付、1已支付',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_buy_card_order
-- ----------------------------
INSERT INTO `xw_buy_card_order` VALUES ('1', '1', 'qwqw12121', '10', '9.9000', '0', '6', '0', '2023-03-14 16:15:27');

-- ----------------------------
-- Table structure for xw_buy_card_use
-- ----------------------------
DROP TABLE IF EXISTS `xw_buy_card_use`;
CREATE TABLE `xw_buy_card_use` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_buy_card_use
-- ----------------------------
INSERT INTO `xw_buy_card_use` VALUES ('1', '1', '13', '6', '2023-03-01 16:54:33');

-- ----------------------------
-- Table structure for xw_chain
-- ----------------------------
DROP TABLE IF EXISTS `xw_chain`;
CREATE TABLE `xw_chain` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `chain_name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '链名称',
  `base_chain` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '底层链名称',
  `base_chain_protocol` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '底层链协议',
  `has_0x` tinyint(1) NOT NULL,
  `rpc_url` varchar(250) CHARACTER SET utf8 NOT NULL COMMENT '节点地址',
  `sort_order` int(4) NOT NULL,
  `text_color` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '字颜色',
  `address_color` varchar(10) CHARACTER SET utf8 NOT NULL,
  `bg_color` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '背景色',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '链的状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_chain
-- ----------------------------
INSERT INTO `xw_chain` VALUES ('1', '以太坊链', 'ETH', 'ERC20', '1', '', '9997', '#FFFFFF', '#d1d5db', '#3e5bf2', '1', null, null);
INSERT INTO `xw_chain` VALUES ('2', '波場', 'TRX', 'TRC20', '0', '', '9998', '#FFFFFF', '#d1d5db', '#d80917', '1', null, null);
INSERT INTO `xw_chain` VALUES ('3', '幣安智能鏈', 'BSC', 'BEP20', '1', '', '9999', '#181A20', '#707A8A', '#f3ba2f', '1', null, null);

-- ----------------------------
-- Table structure for xw_config
-- ----------------------------
DROP TABLE IF EXISTS `xw_config`;
CREATE TABLE `xw_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '配置名称',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '配置标识',
  `content` text COMMENT '配置内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- ----------------------------
-- Records of xw_config
-- ----------------------------
INSERT INTO `xw_config` VALUES ('1', '基本配置', 'base', 'a:3:{s:2:\"id\";s:1:\"1\";s:11:\"admin_title\";s:15:\"大富翁後台\";s:5:\"title\";s:9:\"大富翁\";}', '1', '2023-01-28 15:25:55', '2023-03-09 09:15:21');
INSERT INTO `xw_config` VALUES ('2', 'apiToken', 'token', 'a:5:{s:2:\"id\";s:1:\"2\";s:3:\"iss\";s:6:\"234234\";s:3:\"aud\";s:5:\"23423\";s:7:\"secrect\";s:6:\"dsfsdf\";s:7:\"exptime\";s:5:\"36000\";}', '1', '2023-01-28 15:25:55', '2023-02-21 21:45:12');
INSERT INTO `xw_config` VALUES ('3', '大富翁參數', 'parameter', 'a:6:{s:2:\"id\";s:1:\"3\";s:11:\"total_money\";s:3:\"400\";s:12:\"z_proportion\";s:4:\"0.02\";s:12:\"m_proportion\";s:4:\"0.02\";s:12:\"p_proportion\";s:5:\"0.005\";s:12:\"c_proportion\";s:5:\"0.015\";}', '1', '2023-03-09 16:33:36', '2023-03-12 21:27:34');

-- ----------------------------
-- Table structure for xw_currency
-- ----------------------------
DROP TABLE IF EXISTS `xw_currency`;
CREATE TABLE `xw_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '代表图片',
  `name_cn` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '中文名',
  `name_en` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '英文名',
  `code` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '标识符',
  `decimal` int(2) NOT NULL COMMENT '货币精度',
  `desc` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '简介',
  `link` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '详情链接',
  `start_at` date NOT NULL COMMENT '发行时间',
  `explorer` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '浏览器',
  `turnover` decimal(20,4) NOT NULL COMMENT '流通',
  `account_type` int(2) NOT NULL DEFAULT '1' COMMENT '账户类型：1、地址模式；2、账户模式；',
  `recharge_address` varchar(120) CHARACTER SET utf8 NOT NULL COMMENT '充值地址',
  `is_trade` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启交易',
  `is_recharge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启充值',
  `is_withdraw` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启提现',
  `is_transfer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持劃轉',
  `sort_order` int(4) NOT NULL COMMENT '排序',
  `status` tinyint(1) NOT NULL COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name_en` (`name_en`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='币种设置';

-- ----------------------------
-- Records of xw_currency
-- ----------------------------
INSERT INTO `xw_currency` VALUES ('2', 'coin/20210224/7736c3471b3514851627cf9d1abcb374.png', '泰達幣', 'USDT', 'USDT', '4', '', '', '0000-00-00', '', '0.0000', '1', '', '1', '1', '1', '1', '997', '0', '2021-06-05 21:40:17', '2021-06-05 21:40:17');
INSERT INTO `xw_currency` VALUES ('3', '19', '比特币', 'BITCOIN', 'BTC', '0', '中本聰創建', '32423', '2020-10-01', '234342', '0.0000', '0', '', '0', '0', '0', '1', '999', '1', '2021-06-05 21:40:17', '2023-02-26 13:29:26');
INSERT INTO `xw_currency` VALUES ('4', '20', '以太坊', 'etherum', 'ETH', '6', '簡介簡介簡介簡介簡介簡介', 'https://etherscan.io/', '2017-03-01', 'https://etherscan.io/', '352342342.0000', '0', '', '1', '1', '1', '1', '998', '1', '2021-06-05 21:41:42', '2023-02-15 21:39:47');
INSERT INTO `xw_currency` VALUES ('5', '', '波场', 'tron', 'TRX', '6', '', '', '0000-00-00', '', '0.0000', '0', '', '1', '1', '1', '1', '996', '1', '2021-06-05 21:42:50', '2021-06-05 21:42:50');
INSERT INTO `xw_currency` VALUES ('6', '', '狗狗币', 'doge', 'DOGE', '6', '', '', '0000-00-00', '', '0.0000', '0', '', '1', '1', '1', '1', '996', '1', '2021-06-05 21:42:50', '2021-06-05 21:42:50');
INSERT INTO `xw_currency` VALUES ('7', '', 'Link', 'ChainLink', 'LINK', '4', '', '', '0000-00-00', '', '0.0000', '1', '', '0', '0', '0', '0', '0', '1', '2021-06-10 18:30:04', '2021-06-10 18:30:04');
INSERT INTO `xw_currency` VALUES ('8', '', '萊特幣', 'ltccoin', 'LTC', '4', '', '', '0000-00-00', '', '0.0000', '1', '', '0', '0', '0', '0', '0', '1', '2021-06-10 20:19:02', '2021-06-10 20:19:02');
INSERT INTO `xw_currency` VALUES ('9', '', '柚子幣', 'Eoscoin', 'EOS', '4', '', '', '0000-00-00', '', '0.0000', '1', '', '1', '0', '0', '0', '0', '1', '2021-06-10 20:21:16', '2022-03-08 20:23:41');
INSERT INTO `xw_currency` VALUES ('10', '', '幣安幣', 'BNB', 'BNB', '6', '', '', '0000-00-00', '', '0.0000', '1', '', '1', '0', '0', '0', '0', '1', '2021-06-10 20:21:16', '2022-03-08 20:23:41');

-- ----------------------------
-- Table structure for xw_currency_chain
-- ----------------------------
DROP TABLE IF EXISTS `xw_currency_chain`;
CREATE TABLE `xw_currency_chain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` int(8) NOT NULL,
  `chain_id` int(8) NOT NULL,
  `decimal` int(20) NOT NULL COMMENT '链上小数位',
  `display_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `contract_address` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '合约地址',
  `is_dynamic` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否动态手续费（仅对固定类型有效，withdrawFeeType=fixed）',
  `num_confirmations` int(4) NOT NULL COMMENT '安全上账所需确认次数（达到确认次数后允许提币）',
  `num_fast_confirmations` int(4) NOT NULL COMMENT '快速上账所需确认次数（达到确认次数后允许交易但不允许提币）',
  `min_recharge_amount` decimal(32,4) NOT NULL COMMENT '单次最小充币金额',
  `is_recharge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充币状态 1可以，0不可以',
  `min_withdraw_amount` decimal(32,4) NOT NULL COMMENT '单次最小提币金额',
  `max_withdraw_amount` decimal(32,4) NOT NULL COMMENT '单次最大提币金额',
  `withdraw_quota_perday` decimal(32,4) NOT NULL COMMENT '当日提币额度（新加坡时区）',
  `withdraw_quota_peryear` decimal(32,4) NOT NULL COMMENT '当年提币额度',
  `withdraw_quota_total` decimal(32,4) NOT NULL COMMENT '总提币额度',
  `withdraw_precision` int(2) NOT NULL COMMENT '提币精度',
  `withdraw_fee_type` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '提币手续费类型（特定币种在特定链上的提币手续费类型唯一）fixed,circulated,ratio',
  `transact_fee_fithdraw` decimal(32,4) NOT NULL COMMENT '单次提币手续费（仅对固定类型有效，withdrawFeeType=fixed）',
  `min_transact_fee_withdraw` decimal(32,4) NOT NULL COMMENT '最小单次提币手续费（仅对区间类型和有下限的比例类型有效，withdrawFeeType=circulated or ratio）	',
  `max_transact_fee_withdraw` decimal(32,4) NOT NULL COMMENT '最大单次提币手续费（仅对区间类型和有上限的比例类型有效，withdrawFeeType=circulated or ratio）	',
  `transact_fee_rate_withdraw` decimal(32,4) NOT NULL COMMENT '单次提币手续费率（仅对比例类型有效，withdrawFeeType=ratio）',
  `is_withdraw` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提币状态',
  `rpc_url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '节点地址',
  `wallet_api` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '地址生成平台',
  `sort_order` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `currency_id` (`currency_id`),
  KEY `chain_id` (`chain_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_currency_chain
-- ----------------------------
INSERT INTO `xw_currency_chain` VALUES ('1', '2', '1', '6', 'usdt_erc20', '0xdac17f958d2ee523a2206206994597c13d831ec7', '0', '12', '12', '1.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);
INSERT INTO `xw_currency_chain` VALUES ('2', '2', '2', '6', 'usdt_trc20', 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t', '0', '12', '12', '1.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);
INSERT INTO `xw_currency_chain` VALUES ('3', '5', '2', '0', 'trx_trc20', '', '0', '12', '12', '100.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);
INSERT INTO `xw_currency_chain` VALUES ('4', '4', '1', '0', 'eth_erc20', '', '0', '12', '12', '1.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);
INSERT INTO `xw_currency_chain` VALUES ('5', '2', '3', '18', 'usdt_bep20', '0x55d398326f99059fF775485246999027B3197955', '0', '12', '12', '1.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);
INSERT INTO `xw_currency_chain` VALUES ('6', '10', '3', '18', 'bnb_bep20', '', '0', '12', '12', '1.0000', '1', '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', '6', 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', '1', '', 'ud', '999', '1', null, null);

-- ----------------------------
-- Table structure for xw_exchange
-- ----------------------------
DROP TABLE IF EXISTS `xw_exchange`;
CREATE TABLE `xw_exchange` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '交易所名称',
  `code` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '代码',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用',
  `sort_order` int(4) NOT NULL COMMENT '排序',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `status` (`status`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_exchange
-- ----------------------------
INSERT INTO `xw_exchange` VALUES ('1', '自营', 'owner', '1', '0', '2023-02-09 18:49:42', '2023-02-09 18:49:42');
INSERT INTO `xw_exchange` VALUES ('2', '火币', 'Huobi', '1', '0', '2023-02-09 18:49:42', '2023-02-09 18:49:42');
INSERT INTO `xw_exchange` VALUES ('3', '币安', 'Binance', '1', '0', null, '2023-02-09 18:49:42');
INSERT INTO `xw_exchange` VALUES ('4', 'dex', 'dex', '1', '0', '2023-02-09 18:49:42', '2023-02-09 18:49:42');

-- ----------------------------
-- Table structure for xw_file
-- ----------------------------
DROP TABLE IF EXISTS `xw_file`;
CREATE TABLE `xw_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(15) NOT NULL DEFAULT '' COMMENT '所属模块',
  `sha1` varchar(60) NOT NULL COMMENT 'sha1',
  `md5` varchar(60) NOT NULL COMMENT 'md5',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `filepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径+文件名',
  `filesize` int(10) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `fileext` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT '文件类型',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传会员ID',
  `uploadip` varchar(15) NOT NULL DEFAULT '' COMMENT '上传IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未审核1已审核-1不通过',
  `created_at` datetime NOT NULL,
  `admin_id` int(11) NOT NULL COMMENT '审核者id',
  `audit_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '来源模块功能',
  `use` varchar(255) DEFAULT NULL COMMENT '用处',
  `download` int(11) NOT NULL DEFAULT '0' COMMENT '下载量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='文件表';

-- ----------------------------
-- Records of xw_file
-- ----------------------------
INSERT INTO `xw_file` VALUES ('1', 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', 'f95982689eb222b84e999122a50b3780.jpg', 'f95982689eb222b84e999122a50b3780.jpg', 'https://blog.gougucms.com/storage/202202/f95982689eb222b84e999122a50b3780.jpg', '62609', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '0000-00-00 00:00:00', '1', '1645057433', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('2', 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', 'e729477de18e3be7e7eb4ec7fe2f821e.jpg', 'e729477de18e3be7e7eb4ec7fe2f821e.jpg', 'https://blog.gougucms.com/storage/202202/e729477de18e3be7e7eb4ec7fe2f821e.jpg', '62609', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '0000-00-00 00:00:00', '1', '1645057433', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('3', 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', '1193f7a1585b9f6e8a97ae17718018b3.jpg', 'images/1193f7a1585b9f6e8a97ae17718018b3.jpg', 'https://blog.gougucms.com/storage/202204/1193f7a1585b9f6e8a97ae17718018b3.jpg', '62609', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '0000-00-00 00:00:00', '1', '1645057433', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('4', 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', '0f22a5ba4797b2fa22049ea73e6f779c.jpg', 'images/0f22a5ba4797b2fa22049ea73e6f779c.jpg', 'https://blog.gougucms.com/storage/202202/0f22a5ba4797b2fa22049ea73e6f779c.jpg', '62609', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '0000-00-00 00:00:00', '1', '1645057433', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('5', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '::1', '1', '2023-02-07 21:37:18', '1', '1675777038', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('6', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-08 21:05:18', '1', '1675861518', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('7', 'admin', '5101d69389ee607456a74ff4d6bf142b677f2174', 'a173b6c611cc3347c232e2607cef096e', 'photo_2023-02-03_22-43-17.jpg', '202302/a173b6c611cc3347c232e2607cef096e.jpg', '/storage/202302/a173b6c611cc3347c232e2607cef096e.jpg', '81371', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-08 21:05:34', '1', '1675861534', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('8', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-09 21:25:40', '1', '1675949140', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('9', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-10 21:49:09', '1', '1676036949', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('10', 'admin', 'e9aa863e59d974b5914a426fe99b84828ec18f9d', '62e583c9f8219ba594cf2cf7d425a0ef', 'photo_2023-02-03_19-40-18.jpg', '202302/62e583c9f8219ba594cf2cf7d425a0ef.jpg', '/storage/202302/62e583c9f8219ba594cf2cf7d425a0ef.jpg', '138589', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-10 21:51:28', '1', '1676037088', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('11', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-10 21:55:27', '1', '1676037327', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('12', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-10 21:58:37', '1', '1676037517', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('13', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 10:06:08', '1', '1676081168', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('14', 'admin', '5101d69389ee607456a74ff4d6bf142b677f2174', 'a173b6c611cc3347c232e2607cef096e', 'photo_2023-02-03_22-43-17.jpg', '202302/a173b6c611cc3347c232e2607cef096e.jpg', '/storage/202302/a173b6c611cc3347c232e2607cef096e.jpg', '81371', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 10:08:16', '1', '1676081296', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('15', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 10:10:56', '1', '1676081456', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('16', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 10:25:17', '1', '1676082317', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('17', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 10:26:35', '1', '1676082395', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('18', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-11 17:34:04', '1', '1676108044', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('19', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-15 21:39:06', '1', '1676468346', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('20', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-15 21:39:46', '1', '1676468386', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('21', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-15 21:41:44', '1', '1676468504', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('22', 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '74305', 'jpg', 'image/jpeg', '1', '127.0.0.1', '1', '2023-02-21 20:51:10', '1', '1676983870', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('23', 'admin', '01a4574e9f61e9084f6449f768fcfa540033bd42', '35673c037d4d3dca6277214105992003', 'pic-80.png', '202302/35673c037d4d3dca6277214105992003.png', '/storage/202302/35673c037d4d3dca6277214105992003.png', '322324', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 10:58:25', '1', '1677380305', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('24', 'admin', '0e745fff7a108d6bc5f544faddb7d384ff5271a9', '7e5dde1f7f327ec686e4cba28b136b51', 'default_bg.png', '202302/7e5dde1f7f327ec686e4cba28b136b51.png', '/storage/202302/7e5dde1f7f327ec686e4cba28b136b51.png', '83983', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 10:58:43', '1', '1677380323', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('25', 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '304264', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 10:59:22', '1', '1677380362', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('26', 'admin', '8fbb623cb96085171402130af41a85f4d5bb6131', 'b5408110499a88bd67120115f47e6336', 'member_bg.png', '202302/b5408110499a88bd67120115f47e6336.png', '/storage/202302/b5408110499a88bd67120115f47e6336.png', '70859', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 10:59:31', '1', '1677380371', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('27', 'admin', '0e745fff7a108d6bc5f544faddb7d384ff5271a9', '7e5dde1f7f327ec686e4cba28b136b51', 'default_bg.png', '202302/7e5dde1f7f327ec686e4cba28b136b51.png', '/storage/202302/7e5dde1f7f327ec686e4cba28b136b51.png', '83983', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 10:59:36', '1', '1677380376', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('28', 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '304264', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 13:28:31', '1', '1677389311', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('29', 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '304264', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-02-26 13:44:51', '1', '1677390291', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('30', 'admin', 'cd842160f692d3841927040320b1d76e5e2caaa0', '291c0ad63c1a64ceaf8668eff0473c9e', '20230130221912_550.png', '202303/291c0ad63c1a64ceaf8668eff0473c9e.png', '/storage/202303/291c0ad63c1a64ceaf8668eff0473c9e.png', '536036', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-03-10 17:00:28', '1', '1678438828', 'upload', 'thumb', '0');
INSERT INTO `xw_file` VALUES ('31', 'admin', 'cd842160f692d3841927040320b1d76e5e2caaa0', '291c0ad63c1a64ceaf8668eff0473c9e', '20230130221912_550.png', '202303/291c0ad63c1a64ceaf8668eff0473c9e.png', '/storage/202303/291c0ad63c1a64ceaf8668eff0473c9e.png', '536036', 'png', 'image/png', '1', '127.0.0.1', '1', '2023-03-10 17:35:58', '1', '1678440958', 'upload', 'thumb', '0');

-- ----------------------------
-- Table structure for xw_house
-- ----------------------------
DROP TABLE IF EXISTS `xw_house`;
CREATE TABLE `xw_house` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '裂变的上级id 0表示原始房子',
  `cate_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属房产分类',
  `owner_id` int(11) NOT NULL DEFAULT '0' COMMENT '当前所属人 0属于系统 其它用member表主键',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `price` decimal(30,4) DEFAULT NULL,
  `desc` varchar(1000) DEFAULT '' COMMENT '摘要',
  `image` int(11) NOT NULL DEFAULT '0' COMMENT '缩略图:附件id',
  `content` text NOT NULL COMMENT '内容',
  `read` int(11) NOT NULL DEFAULT '0' COMMENT '阅读量',
  `sort_order` int(11) NOT NULL DEFAULT '9999' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否回收:1是、0否',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '挂卖状态:1挂卖、0不挂卖',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='文章詳情';

-- ----------------------------
-- Records of xw_house
-- ----------------------------
INSERT INTO `xw_house` VALUES ('13', '0', '11', '1', '1212', '210.0000', '', '0', '', '0', '0', '1', '0', '1', '2023-03-10 17:35:43', '2023-03-10 17:35:43');
INSERT INTO `xw_house` VALUES ('14', '0', '11', '6', '22323', '240.0000', '', '31', '', '0', '0', '1', '0', '1', '2023-03-10 17:36:02', '2023-03-10 17:36:02');
INSERT INTO `xw_house` VALUES ('15', '0', '12', '0', '11', '260.0000', '', '0', '', '0', '0', '1', '0', '1', '2023-03-10 21:05:25', '2023-03-10 21:05:25');
INSERT INTO `xw_house` VALUES ('21', '13', '11', '1', '1212', '50.0000', '', '0', '', '0', '0', '0', '1', '0', '2023-03-12 00:35:05', '0000-00-00 00:00:00');
INSERT INTO `xw_house` VALUES ('22', '13', '11', '1', '1212', '50.0000', '', '0', '', '0', '0', '1', '0', '0', '2023-03-12 00:35:05', '0000-00-00 00:00:00');
INSERT INTO `xw_house` VALUES ('23', '13', '11', '1', '1212', '50.0000', '', '0', '', '0', '0', '1', '1', '0', '2023-03-12 00:35:05', '0000-00-00 00:00:00');
INSERT INTO `xw_house` VALUES ('24', '23', '11', '2', '来生缘', '60.0000', '', '0', '', '0', '0', '0', '0', '1', '2023-03-12 00:35:05', '2023-03-12 23:41:54');

-- ----------------------------
-- Table structure for xw_house_cate
-- ----------------------------
DROP TABLE IF EXISTS `xw_house_cate`;
CREATE TABLE `xw_house_cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '地區名',
  `min_price` decimal(30,4) NOT NULL,
  `max_price` decimal(30,4) NOT NULL,
  `sort_order` int(5) NOT NULL DEFAULT '9999',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1可用、-1禁用',
  `desc` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- ----------------------------
-- Records of xw_house_cate
-- ----------------------------
INSERT INTO `xw_house_cate` VALUES ('11', '0', '巴黎', '50.0000', '200.0000', '0', '1', '', '2023-03-10 14:43:16', '2023-03-10 14:43:16');
INSERT INTO `xw_house_cate` VALUES ('12', '0', '倫敦', '50.0000', '230.0000', '0', '1', '', '2023-03-10 17:55:27', '2023-03-10 17:55:27');
INSERT INTO `xw_house_cate` VALUES ('13', '0', '東京', '30.0000', '200.0000', '0', '1', '', '2023-03-10 17:55:38', '2023-03-10 17:55:38');

-- ----------------------------
-- Table structure for xw_house_order
-- ----------------------------
DROP TABLE IF EXISTS `xw_house_order`;
CREATE TABLE `xw_house_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `price` decimal(30,4) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_house_order
-- ----------------------------
INSERT INTO `xw_house_order` VALUES ('1', 'Mn1676345094', '11', '13', '7', '25.0000', '2023-03-10 21:36:46');

-- ----------------------------
-- Table structure for xw_lang
-- ----------------------------
DROP TABLE IF EXISTS `xw_lang`;
CREATE TABLE `xw_lang` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '名稱',
  `code` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '代號',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否啟動',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_lang
-- ----------------------------
INSERT INTO `xw_lang` VALUES ('1', '简体中文', 'cn', '1', '2021-06-08 11:36:24');
INSERT INTO `xw_lang` VALUES ('2', '繁體中文', 'tw', '1', '2021-06-08 11:36:46');
INSERT INTO `xw_lang` VALUES ('3', 'English', 'en', '1', '2021-06-08 11:37:55');

-- ----------------------------
-- Table structure for xw_member
-- ----------------------------
DROP TABLE IF EXISTS `xw_member`;
CREATE TABLE `xw_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '推荐人ID,默认是0',
  `role_id` int(2) NOT NULL DEFAULT '0',
  `invite_code` int(8) NOT NULL DEFAULT '0' COMMENT '邀請碼',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `safe_password` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机（也可以作为登录账号)',
  `sieve_total` int(10) NOT NULL DEFAULT '0' COMMENT '总共可用次数',
  `sieve_today` int(10) NOT NULL DEFAULT '0' COMMENT '今天可用次数',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '个人简介',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态 0禁用 1正常',
  `last_login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `login_num` int(11) NOT NULL DEFAULT '0',
  `register_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '注册IP',
  `created_at` datetime NOT NULL COMMENT '注册时间',
  `last_login_at` datetime DEFAULT NULL COMMENT '最后登录时间',
  `updated_at` datetime NOT NULL COMMENT '信息更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `pid` (`pid`),
  KEY `invite_code` (`invite_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of xw_member
-- ----------------------------
INSERT INTO `xw_member` VALUES ('1', '0', '4', '882326', 'demo333', '88316675d7882e3fdbe066000273842c', 'e10adc3949ba59abbe56e057f20f883e', '333@gmail.com', '', '0', '0', '', '1', '127.0.0.1', '72', '127.0.0.1', '2023-02-08 14:16:33', '2023-03-05 16:35:41', '2023-03-05 16:35:41');
INSERT INTO `xw_member` VALUES ('2', '1', '3', '206042', 'dem3o', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '0', '0', '', '1', '', '0', '127.0.0.1', '2023-02-08 14:19:38', null, '2023-02-08 14:19:38');
INSERT INTO `xw_member` VALUES ('3', '2', '2', '331213', 'de3m43o', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '0', '0', '', '1', '127.0.0.1', '2', '127.0.0.1', '2023-02-08 14:20:24', '2023-02-08 15:29:04', '2023-02-08 15:29:04');
INSERT INTO `xw_member` VALUES ('4', '3', '1', '525005', 'de3m433o', 'e10adc3949ba59abbe56e057f20f883e', '', 'de3mo@gmail.com', '', '0', '0', '', '1', '', '0', '127.0.0.1', '2023-02-08 14:21:54', null, '2023-02-08 15:07:10');
INSERT INTO `xw_member` VALUES ('5', '1', '1', '411695', 'de3m433o3', 'e10adc3949ba59abbe56e057f20f883e', '', 'demo.com', '', '0', '0', '', '1', '', '0', '127.0.0.1', '2023-02-08 15:10:02', null, '2023-02-08 15:10:02');
INSERT INTO `xw_member` VALUES ('6', '2', '1', '212907', 'de3o3', 'fcea920f7412b5da7be0cf42b8c93759', 'e10adc3949ba59abbe56e057f20f883e', 'demo@gmail.com', '', '0', '0', '', '1', '127.0.0.1', '1', '127.0.0.1', '2023-02-08 15:10:31', '2023-02-08 15:30:08', '0000-00-00 00:00:00');
INSERT INTO `xw_member` VALUES ('7', '1', '1', '716938', 'sdfasdf', 'e10adc3949ba59abbe56e057f20f883e', '', 'demo@gmail.com', '', '0', '0', '', '1', '', '0', '127.0.0.1', '2023-02-09 16:39:03', null, '2023-02-09 16:39:03');
INSERT INTO `xw_member` VALUES ('12', '2', '0', '159085', 'sdfasdfs', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '0', '0', '', '0', '', '0', '127.0.0.1', '2023-02-17 11:37:04', null, '2023-02-21 11:39:40');

-- ----------------------------
-- Table structure for xw_member_address
-- ----------------------------
DROP TABLE IF EXISTS `xw_member_address`;
CREATE TABLE `xw_member_address` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `chain_id` int(4) NOT NULL,
  `member_id` int(8) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 NOT NULL,
  `client_id` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '客戶端id',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chain_id` (`chain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_member_address
-- ----------------------------
INSERT INTO `xw_member_address` VALUES ('1', '1', '0', '測試', '23423423423423', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '23423', '2022-05-26 20:12:53', '2022-05-26 20:12:53');
INSERT INTO `xw_member_address` VALUES ('2', '2', '0', 'trxdemo', '23423423423', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '3242', '2022-05-26 20:43:36', '2022-05-26 20:43:36');
INSERT INTO `xw_member_address` VALUES ('3', '1', '0', 'ethdemo', 'sdfsdfsdfsadfasdfasdf', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', 'sf', '2022-05-26 20:43:51', '2022-05-26 20:43:51');
INSERT INTO `xw_member_address` VALUES ('4', '2', '0', '测试', 'kjkjnon', '356ea582-dfb8-4440-b4a5-f80a3c7e081a', '', '2022-05-27 10:51:48', '2022-05-27 10:51:48');
INSERT INTO `xw_member_address` VALUES ('5', '1', '0', '23423', '0x4e8b9a637753b5ab166d4812c3898e69cd4325f1', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '234234', '2022-08-09 12:03:48', '2022-08-09 12:03:48');
INSERT INTO `xw_member_address` VALUES ('6', '2', '0', 'ceshi', 'sdfsdfsdfasdfas', '', '234234', '2023-02-13 13:20:44', '2023-02-13 13:20:44');
INSERT INTO `xw_member_address` VALUES ('7', '2', '1', 'SDFSDFSA', '234234', '', '2342342', '2023-02-13 13:22:05', '2023-02-13 13:22:05');

-- ----------------------------
-- Table structure for xw_member_log
-- ----------------------------
DROP TABLE IF EXISTS `xw_member_log`;
CREATE TABLE `xw_member_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `type` varchar(80) NOT NULL DEFAULT '' COMMENT '操作类型',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '操作标题',
  `content` text COMMENT '操作描述',
  `module` varchar(32) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(32) NOT NULL DEFAULT '' COMMENT '控制器',
  `function` varchar(32) NOT NULL DEFAULT '' COMMENT '方法',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录ip',
  `item_id` int(11) unsigned NOT NULL COMMENT '操作ID',
  `param` text COMMENT '参数json格式',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0删除 1正常',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作日志表';

-- ----------------------------
-- Records of xw_member_log
-- ----------------------------

-- ----------------------------
-- Table structure for xw_member_role
-- ----------------------------
DROP TABLE IF EXISTS `xw_member_role`;
CREATE TABLE `xw_member_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '等級名稱',
  `accumulate` int(8) NOT NULL COMMENT '累積經驗值',
  `maintenance` int(8) NOT NULL COMMENT '等級維護',
  `dice_num` int(8) DEFAULT NULL COMMENT '每日骰寶數',
  `layer_num` int(8) DEFAULT NULL COMMENT '代數',
  `reward_ratio` float(5,3) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL,
  `reward_fee` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '狀態:0禁用,1正常',
  `created_at` datetime NOT NULL COMMENT '創建時間',
  `updated_at` datetime NOT NULL COMMENT '更新時間',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='會員等級表';

-- ----------------------------
-- Records of xw_member_role
-- ----------------------------
INSERT INTO `xw_member_role` VALUES ('1', 'L1', '500000', '20000', '6', '10', '0.100', '備註', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:48:01');
INSERT INTO `xw_member_role` VALUES ('2', 'L2', '250000', '10000', '5', '8', '0.100', '', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:47:55');
INSERT INTO `xw_member_role` VALUES ('3', 'L3', '50000', '5000', '4', '6', '0.100', '', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:47:49');
INSERT INTO `xw_member_role` VALUES ('4', 'L4', '10000', '2000', '3', '4', '0.100', '', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:47:43');
INSERT INTO `xw_member_role` VALUES ('5', 'L5', '2500', '500', '2', '2', '0.100', '', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:47:37');
INSERT INTO `xw_member_role` VALUES ('6', 'L6', '0', '0', '1', '1', '0.100', '', '0.00', '1', '2023-02-02 10:12:21', '2023-03-12 22:43:01');

-- ----------------------------
-- Table structure for xw_member_sieve
-- ----------------------------
DROP TABLE IF EXISTS `xw_member_sieve`;
CREATE TABLE `xw_member_sieve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_member_sieve
-- ----------------------------
INSERT INTO `xw_member_sieve` VALUES ('1', '1', '2023-03-08 00:07:48');
INSERT INTO `xw_member_sieve` VALUES ('2', '2', '2023-03-23 00:08:01');

-- ----------------------------
-- Table structure for xw_page
-- ----------------------------
DROP TABLE IF EXISTS `xw_page`;
CREATE TABLE `xw_page` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '页面名称',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '页面摘要',
  `content` text NOT NULL COMMENT '内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '页面状态:0下架,1正常',
  `read` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '阅读量',
  `sort_order` int(4) unsigned NOT NULL DEFAULT '9999' COMMENT '排序',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT 'url文件名',
  `template` varchar(200) NOT NULL DEFAULT '' COMMENT '前端模板',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '编辑时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='单页面';

-- ----------------------------
-- Records of xw_page
-- ----------------------------
INSERT INTO `xw_page` VALUES ('1', '关于我们', '', '<p>&nbsp;</p>\n<p>3<img src=\"/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg\" alt=\"\" width=\"960\" height=\"1280\" /></p>', '1', '1', '0', '', 'default', '0000-00-00 00:00:00', '2023-02-21 21:42:10');

-- ----------------------------
-- Table structure for xw_sell_card
-- ----------------------------
DROP TABLE IF EXISTS `xw_sell_card`;
CREATE TABLE `xw_sell_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` int(1) NOT NULL,
  `price` decimal(30,4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '上下架：0下架、1上架',
  `admin_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '9999',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_sell_card
-- ----------------------------
INSERT INTO `xw_sell_card` VALUES ('1', '7', '9.9000', '1', '1', '0', '2023-03-13 22:33:41');
INSERT INTO `xw_sell_card` VALUES ('2', '15', '17.9000', '1', '1', '0', '2023-03-13 22:35:05');
INSERT INTO `xw_sell_card` VALUES ('3', '30', '29.9000', '0', '1', '0', '2023-03-13 22:35:24');

-- ----------------------------
-- Table structure for xw_sell_card_order
-- ----------------------------
DROP TABLE IF EXISTS `xw_sell_card_order`;
CREATE TABLE `xw_sell_card_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sell_card_id` int(11) NOT NULL,
  `order_no` varchar(255) NOT NULL,
  `day` int(11) NOT NULL,
  `price` decimal(30,4) NOT NULL,
  `member_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0待支付、1已支付',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_sell_card_order
-- ----------------------------
INSERT INTO `xw_sell_card_order` VALUES ('1', '1', 'qwqw12121', '7', '9.9000', '6', '0', '2023-03-14 16:15:27');

-- ----------------------------
-- Table structure for xw_sell_card_use
-- ----------------------------
DROP TABLE IF EXISTS `xw_sell_card_use`;
CREATE TABLE `xw_sell_card_use` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_end` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xw_sell_card_use
-- ----------------------------
INSERT INTO `xw_sell_card_use` VALUES ('1', '1', '13', '6', '2023-03-01 16:54:20', '2023-03-31 16:54:29', '2023-03-01 16:54:33');

-- ----------------------------
-- Table structure for xw_spot_pair
-- ----------------------------
DROP TABLE IF EXISTS `xw_spot_pair`;
CREATE TABLE `xw_spot_pair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '交易對',
  `last_price` decimal(30,16) NOT NULL,
  `exchange_id` int(2) NOT NULL COMMENT '所属交易所',
  `cate_id` int(8) NOT NULL COMMENT '分类',
  `delimiter` varchar(4) CHARACTER SET utf8 NOT NULL DEFAULT '-' COMMENT '交易对连接符',
  `base_id` int(11) NOT NULL COMMENT '基础币种ID',
  `quote_id` int(11) NOT NULL COMMENT '报价币种ID',
  `fee_type` int(2) NOT NULL DEFAULT '1' COMMENT '1比例，2固定',
  `fee` decimal(8,4) NOT NULL COMMENT '手续费',
  `price_decimal` int(2) NOT NULL COMMENT '交易对报价精度',
  `amount_decimal` int(2) NOT NULL COMMENT '交易对基础币种计数精度',
  `order_decimal` int(2) NOT NULL COMMENT '交易金额的精度',
  `order_min_price` decimal(32,2) NOT NULL COMMENT '最低订单金额',
  `order_max_price` decimal(32,2) NOT NULL COMMENT '最大订单金额',
  `limit_min_amount` decimal(32,2) NOT NULL COMMENT '限价最小订单量',
  `limit_max_amount` decimal(32,2) NOT NULL COMMENT '限价最大订单量',
  `market_buy_min_price` decimal(32,2) NOT NULL COMMENT '市价最小买单金额',
  `market_buy_max_price` decimal(32,2) NOT NULL COMMENT '市价最大买单金额',
  `market_sell_min_amount` decimal(32,2) NOT NULL COMMENT '市价最小卖单数量',
  `market_sell_max_amount` decimal(32,2) NOT NULL COMMENT '市价最大卖单数量',
  `sort_order` int(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `is_show` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否前端显示',
  `is_trade` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可交易',
  `is_market_buy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '市价买',
  `is_market_sell` tinyint(1) NOT NULL DEFAULT '0' COMMENT '市价卖',
  `is_limit_buy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '现价买',
  `is_limit_sell` tinyint(1) NOT NULL DEFAULT '0' COMMENT '现价卖',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pair` (`code`),
  KEY `exchange_id` (`exchange_id`),
  KEY `cate_id` (`cate_id`),
  KEY `base_currency_id` (`base_id`),
  KEY `quote_currency_id` (`quote_id`),
  KEY `is_recommend` (`is_recommend`),
  KEY `is_show` (`is_show`),
  KEY `is_trade` (`is_trade`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='币币设置';

-- ----------------------------
-- Records of xw_spot_pair
-- ----------------------------
INSERT INTO `xw_spot_pair` VALUES ('1', 'btcusdt', '23931.6100000000000000', '3', '1', '/', '3', '2', '1', '0.0000', '6', '2', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9999', '1', '1', '1', '0', '0', '0', '0', '2021-06-10 17:55:17', '2023-02-22 10:34:34');
INSERT INTO `xw_spot_pair` VALUES ('2', 'ethusdt', '1628.7700000000000000', '3', '1', '/', '4', '2', '1', '0.0000', '4', '2', '0', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '9998', '1', '1', '1', '0', '0', '0', '0', '2021-06-10 17:55:31', '2023-02-22 10:34:34');
INSERT INTO `xw_spot_pair` VALUES ('3', 'trxusdt', '0.0684300000000000', '3', '1', '/', '5', '2', '1', '0.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '9997', '1', '1', '1', '0', '0', '1', '1', '2021-06-10 17:55:50', '2023-02-22 10:34:34');
INSERT INTO `xw_spot_pair` VALUES ('4', 'dogeusdt', '0.0000000000000000', '3', '1', '/', '6', '2', '2', '2.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '0', '0', '1', '0', '0', '0', '0', '0', '2021-06-10 17:55:50', '2022-03-09 02:53:35');
INSERT INTO `xw_spot_pair` VALUES ('5', 'ltcusdt', '93.8800000000000000', '3', '1', '/', '8', '2', '1', '1.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '0', '0', '1', '0', '0', '0', '0', '0', '2021-06-10 17:55:50', '2023-02-22 10:34:35');
INSERT INTO `xw_spot_pair` VALUES ('6', 'linkusdt', '7.4200000000000000', '3', '1', '/', '7', '2', '1', '0.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '0', '0', '1', '0', '0', '0', '0', '0', '2021-06-10 17:55:50', '2023-02-22 10:34:34');
INSERT INTO `xw_spot_pair` VALUES ('7', 'eosusdt', '1.1860000000000000', '3', '1', '/', '9', '2', '1', '0.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '0', '0', '1', '0', '0', '0', '0', '0', '2021-06-10 17:55:50', '2023-02-22 10:34:34');
INSERT INTO `xw_spot_pair` VALUES ('8', 'bnbusdt', '1.1860000000000000', '3', '1', '/', '10', '2', '1', '0.0000', '6', '2', '6', '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', '0', '2021-06-10 17:55:50', '2023-02-22 10:34:34');

-- ----------------------------
-- Table structure for xw_task_log
-- ----------------------------
DROP TABLE IF EXISTS `xw_task_log`;
CREATE TABLE `xw_task_log` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `item` varchar(50) CHARACTER SET utf8 NOT NULL,
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '备注',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finished_at` datetime NOT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  KEY `item` (`item`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_task_log
-- ----------------------------
INSERT INTO `xw_task_log` VALUES ('1', 'reward_swap_fee', 'a:3:{s:9:\"startTime\";s:19:\"2023-02-21 00:00:00\";s:7:\"endTime\";s:19:\"2023-02-21 23:59:59\";s:5:\"total\";i:2;}', '2023-02-22 12:57:01', '2023-02-22 12:57:01');

-- ----------------------------
-- Table structure for xw_wallet
-- ----------------------------
DROP TABLE IF EXISTS `xw_wallet`;
CREATE TABLE `xw_wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '客户端id',
  `chain_id` int(11) NOT NULL COMMENT '币链id',
  `member_id` int(11) NOT NULL COMMENT '用户ID',
  `wallet_id` varchar(128) CHARACTER SET utf8 NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '钱包名称',
  `password` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '密码',
  `password_tip` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '密码提示',
  `address` varchar(128) CHARACTER SET utf8 NOT NULL COMMENT '钱包地址',
  `memo` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '地址标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为默认',
  `has_mnemonic` tinyint(1) NOT NULL DEFAULT '0',
  `eye` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT 'open' COMMENT '眼睛',
  `is_import` tinyint(1) NOT NULL COMMENT '是否导入',
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `is_back` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否備份',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wallet_id` (`wallet_id`),
  UNIQUE KEY `currency_chain_id_2` (`chain_id`,`member_id`,`address`),
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `currency_chain_id` (`chain_id`),
  KEY `client_id` (`client_id`),
  KEY `address` (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of xw_wallet
-- ----------------------------
INSERT INTO `xw_wallet` VALUES ('1', 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', '2', '1', '2996cff3-7105-4693-9a90-2754cef82e8e', 'aaa', 'e10adc3949ba59abbe56e057f20f883e', '1', 'TG4YUkqW7kNWarjvSriuFV3omCThMfMwaf', '', '0', '0', 'close', '0', '1', '0', '0', '2023-02-13 22:01:38', '2023-02-27 19:34:09');
INSERT INTO `xw_wallet` VALUES ('2', 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', '3', '1', '3541d065-ef4e-4cc6-9ddb-5670d8c897ad', 'demo6', 'e10adc3949ba59abbe56e057f20f883e', '1', '0xae5fedf5a1f20d266aa40186fa60d2eedc82a54a', '', '1', '0', 'close', '0', '1', '0', '0', '2023-02-14 11:30:45', '2023-02-28 12:35:40');
INSERT INTO `xw_wallet` VALUES ('3', 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', '3', '1', 'd963fa58-db40-4bc8-b7e6-68e0134adea9', 'demo2', 'e10adc3949ba59abbe56e057f20f883e', '1', '0xa352c79d2acf0af83eb07aa132c0c038a3dd0dea', '', '0', '0', 'close', '0', '1', '0', '0', '2023-02-23 23:20:31', '2023-02-28 12:24:57');
