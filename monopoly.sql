-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 06, 2023 at 04:11 PM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monopoly`
--

-- --------------------------------------------------------

--
-- Table structure for table `xw_account`
--

CREATE TABLE `xw_account` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL COMMENT '用戶ID',
  `currency_id` int(11) NOT NULL COMMENT '幣種ID',
  `currency_code` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '货币',
  `asset_type` enum('funding','spot','swap','otc') CHARACTER SET utf8 NOT NULL COMMENT '余额类型：funding資金賬戶；spot幣幣賬戶；swap永續合約賬戶；otc',
  `freeze` decimal(30,6) NOT NULL DEFAULT '0.000000' COMMENT '冻结数量',
  `available` decimal(30,6) NOT NULL DEFAULT '0.000000' COMMENT '可用数量',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1启用0冻结',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_account`
--

INSERT INTO `xw_account` (`id`, `member_id`, `currency_id`, `currency_code`, `asset_type`, `freeze`, `available`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'USDT', 'funding', '200.000000', '33319.000000', 1, '2023-02-24 16:15:44', '2023-03-04 18:37:48');

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_log`
--

CREATE TABLE `xw_account_log` (
  `id` int(11) NOT NULL,
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
  `created_at` datetime NOT NULL COMMENT '变更时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_account_log`
--

INSERT INTO `xw_account_log` (`id`, `member_id`, `scene`, `item_id`, `operate_type`, `balance_type`, `asset_type`, `currency_id`, `currency_code`, `amount`, `before_amount`, `after_amount`, `remark`, `created_at`) VALUES
(4, 1, 'funding', 8, 'sub', 'available', 'funding', 2, 'USDT', '33.000000', '33333.000000', '33300.000000', '商戶交易', '2023-02-26 15:15:26'),
(5, 1, 'funding', 9, 'sub', 'available', 'funding', 2, 'USDT', '3.000000', '33300.000000', '33297.000000', '商戶交易', '2023-02-26 15:16:22'),
(6, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33297.000000', '33298.000000', '', '2023-03-04 18:34:20'),
(7, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33298.000000', '33299.000000', '', '2023-03-04 18:34:20'),
(8, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33299.000000', '33300.000000', '', '2023-03-04 18:34:20'),
(9, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33300.000000', '33301.000000', '', '2023-03-04 18:35:21'),
(10, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33301.000000', '33302.000000', '', '2023-03-04 18:35:21'),
(11, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33302.000000', '33303.000000', '', '2023-03-04 18:35:22'),
(12, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '1.000000', '33303.000000', '33304.000000', '', '2023-03-04 18:35:22'),
(13, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '3.000000', '33304.000000', '33307.000000', '', '2023-03-04 18:36:07'),
(14, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '3.000000', '33307.000000', '33310.000000', '', '2023-03-04 18:36:07'),
(15, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '3.000000', '33310.000000', '33313.000000', '', '2023-03-04 18:36:08'),
(16, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '3.000000', '33313.000000', '33316.000000', '', '2023-03-04 18:36:08'),
(17, 1, '後台', 1, 'add', 'available', 'funding', 2, 'USDT', '3.000000', '33316.000000', '33319.000000', '', '2023-03-04 18:37:48');

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_pair`
--

CREATE TABLE `xw_account_pair` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资产交易对';

--
-- Dumping data for table `xw_account_pair`
--

INSERT INTO `xw_account_pair` (`id`, `cc_id`, `name`, `input_address`, `output_address`, `fee_recharge`, `fee_withdraw`, `recharge_price`, `withdraw_price`, `min_recharge`, `max_recharge`, `min_withdraw`, `max_withdraw`, `sort_order`, `status`, `is_recharge`, `is_withdraw`, `created_at`, `updated_at`) VALUES
(1, 5, 'USDT', '0xCe29996800385753dF0db9dAc67A15277b6D54eC', '0x2e4a46d066d98231d3b9a4e8190f430635d0d01b', '0.0200', '0.0000', '0.0500', '5.0000', '0.1000', '99999999.9999', '0.0000', '0.0000', 9999, 0, 1, 0, '2022-07-23 20:27:47', '2022-10-18 13:28:21');

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_recharge`
--

CREATE TABLE `xw_account_recharge` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `cc_id` int(11) NOT NULL COMMENT '币链id',
  `amount` decimal(16,6) NOT NULL COMMENT '充值数量',
  `tx_id` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '链上交易号',
  `from_address` varchar(255) CHARACTER SET utf8 NOT NULL,
  `to_address` varchar(255) CHARACTER SET utf8 NOT NULL,
  `remark` varchar(50) CHARACTER SET utf8 NOT NULL,
  `status` enum('created','finished','reject','') NOT NULL,
  `is_admin` tinyint(1) NOT NULL COMMENT '是否手动添加',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_reward`
--

CREATE TABLE `xw_account_reward` (
  `id` int(8) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_transfer`
--

CREATE TABLE `xw_account_transfer` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='資金劃轉';

-- --------------------------------------------------------

--
-- Table structure for table `xw_account_withdraw`
--

CREATE TABLE `xw_account_withdraw` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_account_withdraw`
--

INSERT INTO `xw_account_withdraw` (`id`, `member_id`, `cc_id`, `amount`, `fee`, `real_amount`, `withdraw_address_id`, `to_address`, `remark`, `tx_id`, `status`, `created_at`, `checked_at`, `refused_at`, `finished_at`, `updated_at`) VALUES
(1, 1, 2, '11.000000', '0.000000', '0.000000', 0, '', '32423', '234', '', '2023-02-15 12:48:10', NULL, '2023-02-21 21:35:29', '0000-00-00 00:00:00', '2023-02-21 21:35:29'),
(2, 1, 2, '11.000000', '0.000000', '0.000000', 0, '', '2342', '234', '', '2023-02-15 12:48:49', '2023-02-21 21:32:25', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2023-02-21 21:32:25');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin`
--

CREATE TABLE `xw_admin` (
  `id` int(11) UNSIGNED NOT NULL,
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
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常,0禁止登录,-1删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

--
-- Dumping data for table `xw_admin`
--

INSERT INTO `xw_admin` (`id`, `username`, `password`, `nickname`, `thumb`, `theme`, `mobile`, `email`, `desc`, `did`, `position_id`, `created_at`, `updated_at`, `last_login_at`, `login_num`, `last_login_ip`, `status`) VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '/static/admin/images/icon.png', 'black', 2343423, '23423', 'dfasd', 1, 1, '2023-01-28 16:04:49', '2023-02-22 09:47:07', '2023-03-06 16:08:25', 70, '127.0.0.1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_department`
--

CREATE TABLE `xw_admin_department` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '部门名称',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `leader_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '部门负责人ID',
  `phone` varchar(60) NOT NULL DEFAULT '' COMMENT '部门联系电话',
  `remark` varchar(1000) DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：-1删除 0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门组织';

--
-- Dumping data for table `xw_admin_department`
--

INSERT INTO `xw_admin_department` (`id`, `title`, `pid`, `leader_id`, `phone`, `remark`, `status`, `created_at`, `updated_at`) VALUES
(1, '谷歌', 0, 0, '13688888888', '', 1, '0000-00-00 00:00:00', '2023-02-21 22:14:44'),
(2, '广州总公司', 1, 0, '13688888889', '', 1, '0000-00-00 00:00:00', '2023-02-21 22:13:59'),
(3, '人事部2', 2, 0, '13688888898', '', 1, '0000-00-00 00:00:00', '2023-01-30 00:00:00'),
(4, '财务部', 2, 0, '13688888898', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, '市场部', 2, 0, '13688888978', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, '销售部', 2, 0, '13688889868', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, '技术部', 2, 0, '13688898858', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, '客服部', 2, 0, '13688988848', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, '销售一部', 6, 0, '13688998838', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, '销售二部', 6, 0, '13688999828', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, '深圳分公司', 1, 0, '13688999918', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, '人事部', 11, 0, '13688888886', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, '市场部', 11, 0, '13688888886', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, '财务部', 11, 0, '13688888876', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, '销售部', 11, 0, '13688888666', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_log`
--

CREATE TABLE `xw_admin_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户ID',
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
  `item_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作数据id',
  `param` text COMMENT '参数json格式',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0删除 1正常',
  `created_at` datetime NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台操作日志表';

--
-- Dumping data for table `xw_admin_log`
--

INSERT INTO `xw_admin_log` (`id`, `uid`, `username`, `type`, `action`, `subject`, `title`, `content`, `module`, `controller`, `function`, `rule_menu`, `ip`, `item_id`, `param`, `status`, `created_at`) VALUES
(1, 1, 'admin', 'delete', '刪除', '功能菜單', '刪除', '超级管理员在2023-03-06 16:10:10刪除了功能菜單', 'admin', 'admin_menu', 'delete', '', '127.0.0.1', 161, '{\"id\":161,\"pid\":0,\"src\":\"\",\"title\":\"\\u5546\\u5bb6\\u7ba1\\u7406\",\"name\":\"\\u5546\\u5bb6\\u7ba1\\u7406\",\"icon\":\"bi-cart3\",\"menu\":1,\"sort_order\":9999,\"status\":1,\"module\":\"\",\"crud\":\"\",\"created_at\":\"2023-02-26 11:18:55\",\"updated_at\":\"2023-02-26 11:18:55\"}', 1, '2023-03-06 16:10:10');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_menu`
--

CREATE TABLE `xw_admin_menu` (
  `id` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父id',
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
  `updated_at` datetime NOT NULL COMMENT '更新時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜單及許可權表';

--
-- Dumping data for table `xw_admin_menu`
--

INSERT INTO `xw_admin_menu` (`id`, `pid`, `src`, `title`, `name`, `icon`, `menu`, `sort_order`, `status`, `module`, `crud`, `created_at`, `updated_at`) VALUES
(1, 0, '', '系統管理', '系統管理', 'bi-gear', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 0, '', '系統工具', '系統工具', 'bi-briefcase', 1, 2, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 0, '', '廣告管理', '廣告管理', 'bi-box', 1, 3, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 0, '', '用戶管理', '用戶管理', 'bi-people', 1, 4, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 0, '', '資訊中心', '資訊中心', 'bi-journal-text', 1, 7, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 0, '', '單 頁 面', '單 頁 面', 'bi-stickies', 1, 8, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 1, 'admin/conf/index', '系統配置', '系統配置', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 9, 'admin/conf/add', '新建/編輯', '配置項', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 9, 'admin/conf/delete', '刪除', '配置項', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 9, 'admin/conf/edit', '編輯', '配置詳情', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 1, 'admin/admin_menu/index', '功能菜單', '功能菜單', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 17, 'admin/admin_menu/add', '新建', '功能菜單', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '2023-02-21 22:38:07'),
(19, 17, 'admin/admin_menu/delete', '刪除', '功能菜單', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, 1, 'admin/admin_role/index', '角色管理', '角色管理', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, 20, 'admin/admin_role/add', '新建', '角色管理', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 20, 'admin/admin_role/delete', '刪除', '角色管理', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 1, 'admin/admin_department/index', '部門架構', '部門', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, 23, 'admin/admin_department/add', '新建/編輯', '部門', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, 23, 'admin/admin_department/delete', '刪除', '部門', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, 1, 'admin/admin_position/index', '崗位職稱', '崗位職稱', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, 26, 'admin/admin_position/add', '新建/編輯', '崗位職稱', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, 26, 'admin/admin_position/delete', '刪除', '崗位職稱', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(29, 1, 'admin/admin/index', '系統用戶', '系統用戶', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(30, 29, 'admin/admin/add', '添加', '系統用戶', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '2023-02-21 22:50:07'),
(31, 29, 'admin/admin/view', '查看', '系統用戶', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, 29, 'admin/admin/delete', '刪除', '系統用戶', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, 2, 'admin/admin_log/index', '操作日誌', '操作日誌', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(58, 3, 'admin/banner/cate_list', '廣告位', '輪播組', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(59, 58, 'admin/banner/cate_add', '新建/編輯', '輪播組', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(60, 58, 'admin/banner/cate_delete', '刪除', '輪播組', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(61, 3, 'admin/banner/list', '輪播廣告管理', '輪播圖', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(62, 61, 'admin/banner/add', '新建/編輯', '輪播圖', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(63, 61, 'admin/banner/delete', '刪除', '輪播圖', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(72, 4, 'admin/role/index', '用戶等級', '用戶等級', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(73, 72, 'admin/role/add', '新建/編輯', '用戶等級', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(74, 72, 'admin/role/disable', '禁用/啟用', '用戶等級', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(75, 4, 'admin/member/index', '用戶管理', '用戶', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(76, 75, 'admin/member/edit', '編輯', '用戶資訊', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(77, 75, 'admin/member/view', '查看', '用戶資訊', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(78, 75, 'admin/member/disable', '禁用/啟用', '用戶', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(80, 4, 'admin/member/log', '操作日誌', '用戶操作日誌', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(81, 5, 'admin/article_cate/index', '文章分類', '文章分類', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, 81, 'admin/article_cate/add', '新建', '文章分類', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(83, 81, 'admin/article_cate/edit', '編輯', '文章分類', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(84, 81, 'admin/article_cate/delete', '刪除', '文章分類', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(85, 5, 'admin/article/index', '文章列表', '文章', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, 85, 'admin/article/add', '新建', '文章', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(87, 85, 'admin/article/edit', '編輯', '文章', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(89, 85, 'admin/article/delete', '刪除', '文章', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(108, 8, 'admin/page/index', '單頁面列表', '單頁面', '', 1, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(109, 108, 'admin/page/add', '新建', '單頁面', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(110, 108, 'admin/page/edit', '編輯', '單頁面', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(111, 108, 'admin/page/delete', '刪除', '單頁面', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(112, 3, 'admin/banner/info', '輪播廣告管理', '輪播圖', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(113, 0, '', '幣鏈管理', '幣鏈管理', 'bi-x-diamond', 1, 5, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(114, 113, 'admin/currency/index', '貨幣管理', '貨幣管理', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(115, 113, 'admin/chain/index', '公鏈管理', '公鏈管理', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(116, 113, 'admin/currencychain/index', '幣鏈管理', '幣鏈管理', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(117, 114, 'admin/currency/add', '新建', '貨幣管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(118, 114, 'admin/currency/edit', '編輯', '貨幣管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(119, 114, 'admin/currency/delete', '刪除', '貨幣管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(120, 115, 'admin/chain/delete', '刪除', '公鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(121, 115, 'admin/chain/edit', '編輯', '公鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(122, 115, 'admin/chain/add', '新建', '公鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(123, 116, 'admin/currencychain/add', '新建', '幣鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(125, 116, 'admin/currencychain/delete', '刪除', '幣鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(126, 0, '', '資產管理', '資產管理', 'bi-window-desktop', 1, 6, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(127, 126, 'admin/account/index', '資產列表', '資產列表', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(128, 126, 'admin/account_log/index', '資產日誌', '資產日誌', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(129, 126, 'admin/withdraw/index', '提現列表', '提現列表', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(130, 126, 'admin/recharge/index', '充值列表', '充值列表', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(131, 126, 'admin/transfer/index', '內轉列表', '內轉列表', '', 1, 9999, 0, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(132, 126, 'admin/reward/index', '獎勵列表', '獎勵列表', '', 1, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(133, 127, 'admin/account/edit', '編輯', '資產列表', '', 2, 9999, 1, '', '', '2023-02-06 00:00:00', '0000-00-00 00:00:00'),
(134, 129, 'admin/withdraw/edit', '編輯', '提現列表', '', 2, 9999, 1, '', '', '2023-02-06 00:00:00', '0000-00-00 00:00:00'),
(135, 116, 'admin/currencychain/edit', '編輯', '幣鏈管理', '', 2, 9999, 1, '', '', '2023-02-02 00:00:00', '0000-00-00 00:00:00'),
(153, 20, 'admin/admin_role/edit', '編輯', '角色管理', '', 2, 9999, 1, '', '', '2023-02-21 00:00:00', '0000-00-00 00:00:00'),
(154, 17, 'admin/admin_menu/edit', '編輯', '功能菜單', '', 2, 1, 1, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(158, 29, 'admin/admin/edit', '修改', '系統用戶', '', 2, 9999, 1, '', '', '2023-02-21 22:50:32', '2023-02-21 22:50:32'),
(159, 0, '', '錢包管理', '錢包管理', 'bi-wallet', 1, 9999, 1, '', '', '2023-02-22 19:54:15', '2023-02-22 19:54:15'),
(160, 159, 'admin/wallet/list', '地址管理', '錢包管理', '', 1, 9999, 1, '', '', '2023-02-22 19:54:40', '2023-02-22 19:54:40'),
(173, 126, 'admin/account_pair/list', '資產交易對', '資產管理', '', 1, 9999, 1, '', '', '2023-02-27 19:43:47', '2023-02-27 19:43:47'),
(174, 173, 'admin/account_pair/add', '新建', '資產管理', '', 2, 9999, 1, '', '', '2023-02-27 19:44:06', '2023-02-27 19:44:06'),
(175, 173, 'admin/account_pair/edit', '編輯', '資產管理', '', 2, 9999, 1, '', '', '2023-02-27 19:44:23', '2023-02-27 19:44:23'),
(176, 173, 'admin/account_pair/delete', '刪除', '資產管理', '', 2, 9999, 1, '', '', '2023-02-27 19:44:42', '2023-02-27 19:44:42');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_position`
--

CREATE TABLE `xw_admin_position` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '岗位名称',
  `remark` varchar(1000) DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：-1删除 0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位职称';

--
-- Dumping data for table `xw_admin_position`
--

INSERT INTO `xw_admin_position` (`id`, `title`, `remark`, `status`, `created_at`, `updated_at`) VALUES
(1, '董事長', '董事長', 1, '2023-01-30 15:44:12', '2023-01-30 15:44:12'),
(2, '行政長官', '行政長官', 1, '2023-01-30 15:44:12', '2023-01-30 15:44:12'),
(3, '開發工程師', '開發工程師', 1, '2023-01-30 15:44:12', '2023-01-30 15:44:12'),
(4, '新聞編輯', '新聞編輯人员', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'sdfa', 'sdfasdf', 1, '2023-02-21 22:31:17', '2023-02-21 22:31:17');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_role`
--

CREATE TABLE `xw_admin_role` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(1000) DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  `desc` text COMMENT '备注',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限分组表';

--
-- Dumping data for table `xw_admin_role`
--

INSERT INTO `xw_admin_role` (`id`, `title`, `status`, `rules`, `desc`, `created_at`, `updated_at`) VALUES
(1, '超级管理员', 1, '1,9,10,11,12,17,18,19,154,20,21,22,153,23,24,25,26,27,28,29,30,31,32,158,2,33,3,58,59,60,61,62,63,112,4,72,73,74,75,76,77,78,80,113,114,117,118,119,115,120,121,122,116,123,125,135,126,127,133,128,129,134,130,132,173,174,175,176,5,81,82,83,84,85,86,87,89,8,108,109,110,111,159,160,161,162,163,164,165,166,167,168,169,170,171,172', '超级管理员，系统自动分配所有可操作权限及菜单。', '2023-01-30 21:09:03', '2023-02-27 19:44:51'),
(2, '测试角色', 1, '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,81,83', '测试角色', '2023-01-30 21:09:08', '2023-01-30 21:09:10');

-- --------------------------------------------------------

--
-- Table structure for table `xw_admin_role_access`
--

CREATE TABLE `xw_admin_role_access` (
  `uid` int(11) UNSIGNED DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限分组和管理员的关联表';

--
-- Dumping data for table `xw_admin_role_access`
--

INSERT INTO `xw_admin_role_access` (`uid`, `role_id`, `created_at`, `updated_at`) VALUES
(2, 3, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `xw_article`
--

CREATE TABLE `xw_article` (
  `id` int(11) UNSIGNED NOT NULL,
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
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建人',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章詳情';

--
-- Dumping data for table `xw_article`
--

INSERT INTO `xw_article` (`id`, `lang`, `cate_id`, `title`, `desc`, `image`, `content`, `read`, `type`, `sort_order`, `status`, `admin_id`, `created_at`, `updated_at`) VALUES
(1, '', 1, '23423', '23423', 15, '<p>23423423</p>', 0, 0, 234, 1, 1, '2023-02-11 10:12:33', '2023-02-11 10:12:43'),
(2, '', 1, '測試', '334322', 16, '<p>23423423423</p>', 0, 0, 3, 1, 1, '2023-02-11 10:25:19', '2023-02-11 10:25:28'),
(3, '', 1, 'sdfsdf', '2342342', 17, '<p>32423423423</p>', 0, 0, 23423, 1, 1, '2023-02-11 10:26:35', '2023-02-11 10:26:35'),
(4, '', 1, 'sdf', 'sdf', 0, '<p>sdfaf</p>', 0, 0, 0, 1, 1, '2023-02-11 10:29:09', '2023-02-11 17:38:51'),
(5, '', 4, '內容1', '', 0, '<p>內容1內容1內容1內容1</p>', 0, 0, 0, 1, 1, '2023-02-13 15:16:39', '2023-02-17 14:55:47'),
(6, '', 4, '內容2', '', 0, '<p>內容2<span style=\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\">內容2</span><span style=\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\">內容2</span><span style=\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\">內容2</span><span style=\"font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, Ubuntu, Cantarell, \'Open Sans\', \'Helvetica Neue\', sans-serif;\">內容2</span></p>', 0, 0, 0, 1, 1, '2023-02-13 15:16:55', '2023-02-13 15:16:55'),
(7, '', 6, '測試公告', '', 0, '<p>測試公告測試公告測試公告測試公告測試公告</p>', 0, 0, 0, 1, 1, '2023-02-15 16:30:46', '2023-02-15 16:30:46'),
(9, '', 2, 'sdfa', 'sdfasdfsdfadsf', 22, '<p>dsfasdf</p>', 0, 0, 0, 1, 1, '0000-00-00 00:00:00', '2023-02-21 20:52:19'),
(10, '', 4, 'sdfas', 'sdfadsf', 0, '<p>sdfsadf</p>', 0, 0, 0, 1, 1, '2023-02-21 20:52:13', '2023-02-21 20:52:13'),
(11, '', 7, '測試最新資訊', '測試最新資訊測試最新資訊', 24, '<p>測試最新資訊測試最新資訊測試最新資訊測試最新資訊測試最新資訊測試最新資訊測試最新資訊測試最新資訊</p>', 0, 0, 0, 1, 1, '2023-02-26 10:58:50', '2023-02-26 10:58:50'),
(12, '', 7, '測試最新資訊2', '測試最新資訊2測試最新資訊2測試最新資訊2', 27, '<p>測試最新資訊2測試最新資訊2測試最新資訊2測試最新資訊2<img src=\"/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png\" alt=\"\" width=\"1000\" height=\"600\" /></p>', 0, 0, 0, 1, 1, '2023-02-26 10:59:37', '2023-02-26 10:59:37');

-- --------------------------------------------------------

--
-- Table structure for table `xw_article_cate`
--

CREATE TABLE `xw_article_cate` (
  `id` int(11) UNSIGNED NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父类ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `desc` varchar(1000) DEFAULT '' COMMENT '描述',
  `sort_order` int(5) NOT NULL DEFAULT '9999' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL COMMENT '添加时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章分类';

--
-- Dumping data for table `xw_article_cate`
--

INSERT INTO `xw_article_cate` (`id`, `pid`, `title`, `desc`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, '測試', '', 999, 1, '2023-02-07 20:56:06', '2023-02-10 21:45:48'),
(2, 1, 'sdf', 'aafs', 0, 1, '2023-02-09 21:23:39', '2023-02-09 21:23:39'),
(3, 0, '幫助中心', '', 0, 1, '2023-02-13 15:15:57', '2023-02-13 15:15:57'),
(4, 3, '分類1', '', 0, 1, '2023-02-13 15:16:12', '2023-02-13 15:16:12'),
(5, 3, '分類2', '', 0, 1, '2023-02-13 15:16:18', '2023-02-13 15:16:18'),
(6, 0, '公告', '', 0, 1, '2023-02-15 16:30:26', '2023-02-15 16:30:26'),
(7, 0, '最新資訊', '', 0, 1, '2023-02-26 10:57:13', '2023-02-26 10:57:13');

-- --------------------------------------------------------

--
-- Table structure for table `xw_banner`
--

CREATE TABLE `xw_banner` (
  `id` int(11) UNSIGNED NOT NULL,
  `lang` varchar(30) NOT NULL,
  `cate_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `desc` varchar(1000) DEFAULT NULL,
  `img` varchar(255) NOT NULL DEFAULT '',
  `src` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1可用-1禁用',
  `sort_order` int(4) NOT NULL DEFAULT '9999',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片详情表';

-- --------------------------------------------------------

--
-- Table structure for table `xw_banner_cate`
--

CREATE TABLE `xw_banner_cate` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1可用-1禁用',
  `desc` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

--
-- Dumping data for table `xw_banner_cate`
--

INSERT INTO `xw_banner_cate` (`id`, `title`, `status`, `desc`, `created_at`, `updated_at`) VALUES
(1, '首页轮播', 1, '首页轮播组。', '2023-02-08 19:47:40', '2023-02-11 00:00:00'),
(2, '测试', 1, '11', '2023-02-08 00:00:00', '2023-02-10 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `xw_chain`
--

CREATE TABLE `xw_chain` (
  `id` int(8) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_chain`
--

INSERT INTO `xw_chain` (`id`, `chain_name`, `base_chain`, `base_chain_protocol`, `has_0x`, `rpc_url`, `sort_order`, `text_color`, `address_color`, `bg_color`, `status`, `created_at`, `updated_at`) VALUES
(1, '以太坊链', 'ETH', 'ERC20', 1, '', 9997, '#FFFFFF', '#d1d5db', '#3e5bf2', 1, NULL, NULL),
(2, '波場', 'TRX', 'TRC20', 0, '', 9998, '#FFFFFF', '#d1d5db', '#d80917', 1, NULL, NULL),
(3, '幣安智能鏈', 'BSC', 'BEP20', 1, '', 9999, '#181A20', '#707A8A', '#f3ba2f', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `xw_config`
--

CREATE TABLE `xw_config` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '配置名称',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '配置标识',
  `content` text COMMENT '配置内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0禁用 1启用',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

--
-- Dumping data for table `xw_config`
--

INSERT INTO `xw_config` (`id`, `title`, `name`, `content`, `status`, `created_at`, `updated_at`) VALUES
(1, '基本配置', 'base', 'a:3:{s:2:\"id\";s:1:\"1\";s:11:\"admin_title\";s:12:\"蜜蜂後台\";s:5:\"title\";s:12:\"蜜蜂錢包\";}', 1, '2023-01-28 15:25:55', '2023-03-01 14:34:14'),
(2, 'apiToken', 'token', 'a:5:{s:2:\"id\";s:1:\"2\";s:3:\"iss\";s:6:\"234234\";s:3:\"aud\";s:5:\"23423\";s:7:\"secrect\";s:6:\"dsfsdf\";s:7:\"exptime\";s:5:\"36000\";}', 1, '2023-01-28 15:25:55', '2023-02-21 21:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `xw_currency`
--

CREATE TABLE `xw_currency` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币种设置';

--
-- Dumping data for table `xw_currency`
--

INSERT INTO `xw_currency` (`id`, `image`, `name_cn`, `name_en`, `code`, `decimal`, `desc`, `link`, `start_at`, `explorer`, `turnover`, `account_type`, `recharge_address`, `is_trade`, `is_recharge`, `is_withdraw`, `is_transfer`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(2, 'coin/20210224/7736c3471b3514851627cf9d1abcb374.png', '泰達幣', 'USDT', 'USDT', 4, '', '', '0000-00-00', '', '0.0000', 1, '', 1, 1, 1, 1, 997, 1, '2021-06-05 21:40:17', '2021-06-05 21:40:17'),
(3, '19', '比特币', 'BITCOIN', 'BTC', 0, '中本聰創建', '32423', '2020-10-01', '234342', '0.0000', 0, '', 1, 0, 0, 1, 999, 1, '2021-06-05 21:40:17', '2023-02-26 13:29:26'),
(4, '20', '以太坊', 'etherum', 'ETH', 6, '簡介簡介簡介簡介簡介簡介', 'https://etherscan.io/', '2017-03-01', 'https://etherscan.io/', '352342342.0000', 0, '', 1, 1, 1, 1, 998, 1, '2021-06-05 21:41:42', '2023-02-15 21:39:47'),
(5, '', '波场', 'tron', 'TRX', 6, '', '', '0000-00-00', '', '0.0000', 0, '', 1, 1, 1, 1, 996, 1, '2021-06-05 21:42:50', '2021-06-05 21:42:50'),
(6, '', '狗狗币', 'doge', 'DOGE', 6, '', '', '0000-00-00', '', '0.0000', 0, '', 1, 1, 1, 1, 996, 1, '2021-06-05 21:42:50', '2021-06-05 21:42:50'),
(7, '', 'Link', 'ChainLink', 'LINK', 4, '', '', '0000-00-00', '', '0.0000', 1, '', 0, 0, 0, 0, 0, 1, '2021-06-10 18:30:04', '2021-06-10 18:30:04'),
(8, '', '萊特幣', 'ltccoin', 'LTC', 4, '', '', '0000-00-00', '', '0.0000', 1, '', 0, 0, 0, 0, 0, 1, '2021-06-10 20:19:02', '2021-06-10 20:19:02'),
(9, '', '柚子幣', 'Eoscoin', 'EOS', 4, '', '', '0000-00-00', '', '0.0000', 1, '', 1, 0, 0, 0, 0, 1, '2021-06-10 20:21:16', '2022-03-08 20:23:41'),
(10, '', '幣安幣', 'BNB', 'BNB', 6, '', '', '0000-00-00', '', '0.0000', 1, '', 1, 0, 0, 0, 0, 1, '2021-06-10 20:21:16', '2022-03-08 20:23:41');

-- --------------------------------------------------------

--
-- Table structure for table `xw_currency_chain`
--

CREATE TABLE `xw_currency_chain` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_currency_chain`
--

INSERT INTO `xw_currency_chain` (`id`, `currency_id`, `chain_id`, `decimal`, `display_name`, `contract_address`, `is_dynamic`, `num_confirmations`, `num_fast_confirmations`, `min_recharge_amount`, `is_recharge`, `min_withdraw_amount`, `max_withdraw_amount`, `withdraw_quota_perday`, `withdraw_quota_peryear`, `withdraw_quota_total`, `withdraw_precision`, `withdraw_fee_type`, `transact_fee_fithdraw`, `min_transact_fee_withdraw`, `max_transact_fee_withdraw`, `transact_fee_rate_withdraw`, `is_withdraw`, `rpc_url`, `wallet_api`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 6, 'usdt_erc20', '0xdac17f958d2ee523a2206206994597c13d831ec7', 0, 12, 12, '1.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL),
(2, 2, 2, 6, 'usdt_trc20', 'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t', 0, 12, 12, '1.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL),
(3, 5, 2, 0, 'trx_trc20', '', 0, 12, 12, '100.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL),
(4, 4, 1, 0, 'eth_erc20', '', 0, 12, 12, '1.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL),
(5, 2, 3, 18, 'usdt_bep20', '0x55d398326f99059fF775485246999027B3197955', 0, 12, 12, '1.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL),
(6, 10, 3, 18, 'bnb_bep20', '', 0, 12, 12, '1.0000', 1, '10.0000', '1000000.0000', '1000000.0000', '0.0000', '0.0000', 6, 'fixed', '2.0000', '1.0000', '10.0000', '1.0000', 1, '', 'ud', 999, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `xw_exchange`
--

CREATE TABLE `xw_exchange` (
  `id` int(8) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '交易所名称',
  `code` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '代码',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用',
  `sort_order` int(4) NOT NULL COMMENT '排序',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_exchange`
--

INSERT INTO `xw_exchange` (`id`, `name`, `code`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, '自营', 'owner', 1, 0, '2023-02-09 18:49:42', '2023-02-09 18:49:42'),
(2, '火币', 'Huobi', 1, 0, '2023-02-09 18:49:42', '2023-02-09 18:49:42'),
(3, '币安', 'Binance', 1, 0, NULL, '2023-02-09 18:49:42'),
(4, 'dex', 'dex', 1, 0, '2023-02-09 18:49:42', '2023-02-09 18:49:42');

-- --------------------------------------------------------

--
-- Table structure for table `xw_file`
--

CREATE TABLE `xw_file` (
  `id` int(11) UNSIGNED NOT NULL,
  `module` varchar(15) NOT NULL DEFAULT '' COMMENT '所属模块',
  `sha1` varchar(60) NOT NULL COMMENT 'sha1',
  `md5` varchar(60) NOT NULL COMMENT 'md5',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `filepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径+文件名',
  `filesize` int(10) NOT NULL DEFAULT '0' COMMENT '文件大小',
  `fileext` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mimetype` varchar(100) NOT NULL DEFAULT '' COMMENT '文件类型',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传会员ID',
  `uploadip` varchar(15) NOT NULL DEFAULT '' COMMENT '上传IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未审核1已审核-1不通过',
  `created_at` datetime NOT NULL,
  `admin_id` int(11) NOT NULL COMMENT '审核者id',
  `audit_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '来源模块功能',
  `use` varchar(255) DEFAULT NULL COMMENT '用处',
  `download` int(11) NOT NULL DEFAULT '0' COMMENT '下载量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件表';

--
-- Dumping data for table `xw_file`
--

INSERT INTO `xw_file` (`id`, `module`, `sha1`, `md5`, `name`, `filename`, `filepath`, `filesize`, `fileext`, `mimetype`, `user_id`, `uploadip`, `status`, `created_at`, `admin_id`, `audit_time`, `action`, `use`, `download`) VALUES
(1, 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', 'f95982689eb222b84e999122a50b3780.jpg', 'f95982689eb222b84e999122a50b3780.jpg', 'https://blog.gougucms.com/storage/202202/f95982689eb222b84e999122a50b3780.jpg', 62609, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '0000-00-00 00:00:00', 1, 1645057433, 'upload', 'thumb', 0),
(2, 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', 'e729477de18e3be7e7eb4ec7fe2f821e.jpg', 'e729477de18e3be7e7eb4ec7fe2f821e.jpg', 'https://blog.gougucms.com/storage/202202/e729477de18e3be7e7eb4ec7fe2f821e.jpg', 62609, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '0000-00-00 00:00:00', 1, 1645057433, 'upload', 'thumb', 0),
(3, 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', '1193f7a1585b9f6e8a97ae17718018b3.jpg', 'images/1193f7a1585b9f6e8a97ae17718018b3.jpg', 'https://blog.gougucms.com/storage/202204/1193f7a1585b9f6e8a97ae17718018b3.jpg', 62609, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '0000-00-00 00:00:00', 1, 1645057433, 'upload', 'thumb', 0),
(4, 'admin', '5125347886f07f48f7003825660117039eb8784f', '563e5e8f48e607ed54461796b0cb4844', '0f22a5ba4797b2fa22049ea73e6f779c.jpg', 'images/0f22a5ba4797b2fa22049ea73e6f779c.jpg', 'https://blog.gougucms.com/storage/202202/0f22a5ba4797b2fa22049ea73e6f779c.jpg', 62609, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '0000-00-00 00:00:00', 1, 1645057433, 'upload', 'thumb', 0),
(5, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '::1', 1, '2023-02-07 21:37:18', 1, 1675777038, 'upload', 'thumb', 0),
(6, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-08 21:05:18', 1, 1675861518, 'upload', 'thumb', 0),
(7, 'admin', '5101d69389ee607456a74ff4d6bf142b677f2174', 'a173b6c611cc3347c232e2607cef096e', 'photo_2023-02-03_22-43-17.jpg', '202302/a173b6c611cc3347c232e2607cef096e.jpg', '/storage/202302/a173b6c611cc3347c232e2607cef096e.jpg', 81371, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-08 21:05:34', 1, 1675861534, 'upload', 'thumb', 0),
(8, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-09 21:25:40', 1, 1675949140, 'upload', 'thumb', 0),
(9, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-10 21:49:09', 1, 1676036949, 'upload', 'thumb', 0),
(10, 'admin', 'e9aa863e59d974b5914a426fe99b84828ec18f9d', '62e583c9f8219ba594cf2cf7d425a0ef', 'photo_2023-02-03_19-40-18.jpg', '202302/62e583c9f8219ba594cf2cf7d425a0ef.jpg', '/storage/202302/62e583c9f8219ba594cf2cf7d425a0ef.jpg', 138589, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-10 21:51:28', 1, 1676037088, 'upload', 'thumb', 0),
(11, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-10 21:55:27', 1, 1676037327, 'upload', 'thumb', 0),
(12, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-10 21:58:37', 1, 1676037517, 'upload', 'thumb', 0),
(13, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 10:06:08', 1, 1676081168, 'upload', 'thumb', 0),
(14, 'admin', '5101d69389ee607456a74ff4d6bf142b677f2174', 'a173b6c611cc3347c232e2607cef096e', 'photo_2023-02-03_22-43-17.jpg', '202302/a173b6c611cc3347c232e2607cef096e.jpg', '/storage/202302/a173b6c611cc3347c232e2607cef096e.jpg', 81371, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 10:08:16', 1, 1676081296, 'upload', 'thumb', 0),
(15, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 10:10:56', 1, 1676081456, 'upload', 'thumb', 0),
(16, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 10:25:17', 1, 1676082317, 'upload', 'thumb', 0),
(17, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 10:26:35', 1, 1676082395, 'upload', 'thumb', 0),
(18, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-11 17:34:04', 1, 1676108044, 'upload', 'thumb', 0),
(19, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-15 21:39:06', 1, 1676468346, 'upload', 'thumb', 0),
(20, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-15 21:39:46', 1, 1676468386, 'upload', 'thumb', 0),
(21, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-15 21:41:44', 1, 1676468504, 'upload', 'thumb', 0),
(22, 'admin', '135232feb2e4d9647d1c9652b262e0c77869183a', '9ef296dcc0f19c6d03caac968ccba23f', 'photo_2023-02-03_22-18-47.jpg', '202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', '/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg', 74305, 'jpg', 'image/jpeg', 1, '127.0.0.1', 1, '2023-02-21 20:51:10', 1, 1676983870, 'upload', 'thumb', 0),
(23, 'admin', '01a4574e9f61e9084f6449f768fcfa540033bd42', '35673c037d4d3dca6277214105992003', 'pic-80.png', '202302/35673c037d4d3dca6277214105992003.png', '/storage/202302/35673c037d4d3dca6277214105992003.png', 322324, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 10:58:25', 1, 1677380305, 'upload', 'thumb', 0),
(24, 'admin', '0e745fff7a108d6bc5f544faddb7d384ff5271a9', '7e5dde1f7f327ec686e4cba28b136b51', 'default_bg.png', '202302/7e5dde1f7f327ec686e4cba28b136b51.png', '/storage/202302/7e5dde1f7f327ec686e4cba28b136b51.png', 83983, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 10:58:43', 1, 1677380323, 'upload', 'thumb', 0),
(25, 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', 304264, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 10:59:22', 1, 1677380362, 'upload', 'thumb', 0),
(26, 'admin', '8fbb623cb96085171402130af41a85f4d5bb6131', 'b5408110499a88bd67120115f47e6336', 'member_bg.png', '202302/b5408110499a88bd67120115f47e6336.png', '/storage/202302/b5408110499a88bd67120115f47e6336.png', 70859, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 10:59:31', 1, 1677380371, 'upload', 'thumb', 0),
(27, 'admin', '0e745fff7a108d6bc5f544faddb7d384ff5271a9', '7e5dde1f7f327ec686e4cba28b136b51', 'default_bg.png', '202302/7e5dde1f7f327ec686e4cba28b136b51.png', '/storage/202302/7e5dde1f7f327ec686e4cba28b136b51.png', 83983, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 10:59:36', 1, 1677380376, 'upload', 'thumb', 0),
(28, 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', 304264, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 13:28:31', 1, 1677389311, 'upload', 'thumb', 0),
(29, 'admin', '2346003a6e9d79ef41e14a5e3fae22f31e8aca57', '3bc6466ed4b5d7a3cfe6ce9e2af5c42c', 'about_bg.png', '202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', '/storage/202302/3bc6466ed4b5d7a3cfe6ce9e2af5c42c.png', 304264, 'png', 'image/png', 1, '127.0.0.1', 1, '2023-02-26 13:44:51', 1, 1677390291, 'upload', 'thumb', 0);

-- --------------------------------------------------------

--
-- Table structure for table `xw_lang`
--

CREATE TABLE `xw_lang` (
  `id` int(2) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '名稱',
  `code` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '代號',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否啟動',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_lang`
--

INSERT INTO `xw_lang` (`id`, `name`, `code`, `status`, `created_at`) VALUES
(1, '简体中文', 'cn', 1, '2021-06-08 11:36:24'),
(2, '繁體中文', 'tw', 1, '2021-06-08 11:36:46'),
(3, 'English', 'en', 1, '2021-06-08 11:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `xw_member`
--

CREATE TABLE `xw_member` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '推荐人ID,默认是0',
  `role_id` int(2) NOT NULL DEFAULT '0',
  `invite_code` int(8) NOT NULL DEFAULT '0' COMMENT '邀請碼',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `safe_password` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机（也可以作为登录账号)',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '个人简介',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态 0禁用 1正常',
  `last_login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `login_num` int(11) NOT NULL DEFAULT '0',
  `register_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '注册IP',
  `created_at` datetime NOT NULL COMMENT '注册时间',
  `last_login_at` datetime DEFAULT NULL COMMENT '最后登录时间',
  `updated_at` datetime NOT NULL COMMENT '信息更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

--
-- Dumping data for table `xw_member`
--

INSERT INTO `xw_member` (`id`, `pid`, `role_id`, `invite_code`, `username`, `password`, `safe_password`, `email`, `mobile`, `desc`, `status`, `last_login_ip`, `login_num`, `register_ip`, `created_at`, `last_login_at`, `updated_at`) VALUES
(1, 0, 4, 882326, 'demo333', '88316675d7882e3fdbe066000273842c', 'e10adc3949ba59abbe56e057f20f883e', '333@gmail.com', '', '', 1, '127.0.0.1', 72, '127.0.0.1', '2023-02-08 14:16:33', '2023-03-05 16:35:41', '2023-03-05 16:35:41'),
(2, 1, 3, 206042, 'dem3o', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '', 1, '', 0, '127.0.0.1', '2023-02-08 14:19:38', NULL, '2023-02-08 14:19:38'),
(3, 2, 2, 331213, 'de3m43o', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '', 1, '127.0.0.1', 2, '127.0.0.1', '2023-02-08 14:20:24', '2023-02-08 15:29:04', '2023-02-08 15:29:04'),
(4, 3, 1, 525005, 'de3m433o', 'e10adc3949ba59abbe56e057f20f883e', '', 'de3mo@gmail.com', '', '', 1, '', 0, '127.0.0.1', '2023-02-08 14:21:54', NULL, '2023-02-08 15:07:10'),
(5, 1, 1, 411695, 'de3m433o3', 'e10adc3949ba59abbe56e057f20f883e', '', 'demo.com', '', '', 1, '', 0, '127.0.0.1', '2023-02-08 15:10:02', NULL, '2023-02-08 15:10:02'),
(6, 2, 1, 212907, 'de3o3', 'fcea920f7412b5da7be0cf42b8c93759', 'e10adc3949ba59abbe56e057f20f883e', 'demo@gmail.com', '', '', 1, '127.0.0.1', 1, '127.0.0.1', '2023-02-08 15:10:31', '2023-02-08 15:30:08', '0000-00-00 00:00:00'),
(7, 1, 1, 716938, 'sdfasdf', 'e10adc3949ba59abbe56e057f20f883e', '', 'demo@gmail.com', '', '', 1, '', 0, '127.0.0.1', '2023-02-09 16:39:03', NULL, '2023-02-09 16:39:03'),
(12, 2, 0, 159085, 'sdfasdfs', 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '', 1, '', 0, '127.0.0.1', '2023-02-17 11:37:04', NULL, '2023-02-21 11:39:40');

-- --------------------------------------------------------

--
-- Table structure for table `xw_member_address`
--

CREATE TABLE `xw_member_address` (
  `id` int(8) NOT NULL,
  `chain_id` int(4) NOT NULL,
  `member_id` int(8) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 NOT NULL,
  `client_id` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '客戶端id',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_member_address`
--

INSERT INTO `xw_member_address` (`id`, `chain_id`, `member_id`, `name`, `address`, `client_id`, `remark`, `created_at`, `updated_at`) VALUES
(1, 1, 0, '測試', '23423423423423', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '23423', '2022-05-26 20:12:53', '2022-05-26 20:12:53'),
(2, 2, 0, 'trxdemo', '23423423423', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '3242', '2022-05-26 20:43:36', '2022-05-26 20:43:36'),
(3, 1, 0, 'ethdemo', 'sdfsdfsdfsadfasdfasdf', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', 'sf', '2022-05-26 20:43:51', '2022-05-26 20:43:51'),
(4, 2, 0, '测试', 'kjkjnon', '356ea582-dfb8-4440-b4a5-f80a3c7e081a', '', '2022-05-27 10:51:48', '2022-05-27 10:51:48'),
(5, 1, 0, '23423', '0x4e8b9a637753b5ab166d4812c3898e69cd4325f1', 'bc5e19a9-cea3-446a-bb91-fef21bcc9149', '234234', '2022-08-09 12:03:48', '2022-08-09 12:03:48'),
(6, 2, 0, 'ceshi', 'sdfsdfsdfasdfas', '', '234234', '2023-02-13 13:20:44', '2023-02-13 13:20:44'),
(7, 2, 1, 'SDFSDFSA', '234234', '', '2342342', '2023-02-13 13:22:05', '2023-02-13 13:22:05');

-- --------------------------------------------------------

--
-- Table structure for table `xw_member_log`
--

CREATE TABLE `xw_member_log` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `member_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '昵称',
  `type` varchar(80) NOT NULL DEFAULT '' COMMENT '操作类型',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '操作标题',
  `content` text COMMENT '操作描述',
  `module` varchar(32) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(32) NOT NULL DEFAULT '' COMMENT '控制器',
  `function` varchar(32) NOT NULL DEFAULT '' COMMENT '方法',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录ip',
  `item_id` int(11) UNSIGNED NOT NULL COMMENT '操作ID',
  `param` text COMMENT '参数json格式',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0删除 1正常',
  `created_at` datetime NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作日志表';

-- --------------------------------------------------------

--
-- Table structure for table `xw_member_role`
--

CREATE TABLE `xw_member_role` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '等級名稱',
  `desc` varchar(50) DEFAULT NULL,
  `reward_fee` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '狀態:0禁用,1正常',
  `created_at` datetime NOT NULL COMMENT '創建時間',
  `updated_at` datetime NOT NULL COMMENT '更新時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='會員等級表';

--
-- Dumping data for table `xw_member_role`
--

INSERT INTO `xw_member_role` (`id`, `name`, `desc`, `reward_fee`, `status`, `created_at`, `updated_at`) VALUES
(1, 'L1', '備註', '0.10', 1, '2023-02-02 10:12:21', '2023-02-21 20:56:51'),
(2, 'L2', '', '0.20', 1, '2023-02-02 10:12:21', '2023-02-21 10:33:09'),
(3, 'L3', '', '0.30', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(4, 'L4', '', '0.40', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(5, 'L5', '', '0.50', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(6, 'L6', '', '0.60', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(7, 'L7', '', '0.70', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(8, 'L8', '', '0.80', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(9, 'L9', '', '0.90', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21'),
(10, 'L10', '', '1.00', 1, '2023-02-02 10:12:21', '2023-02-02 10:12:21');

-- --------------------------------------------------------

--
-- Table structure for table `xw_page`
--

CREATE TABLE `xw_page` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '页面名称',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '页面摘要',
  `content` text NOT NULL COMMENT '内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '页面状态:0下架,1正常',
  `read` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '阅读量',
  `sort_order` int(4) UNSIGNED NOT NULL DEFAULT '9999' COMMENT '排序',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT 'url文件名',
  `template` varchar(200) NOT NULL DEFAULT '' COMMENT '前端模板',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '编辑时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单页面';

--
-- Dumping data for table `xw_page`
--

INSERT INTO `xw_page` (`id`, `title`, `desc`, `content`, `status`, `read`, `sort_order`, `name`, `template`, `created_at`, `updated_at`) VALUES
(1, '关于我们', '', '<p>&nbsp;</p>\n<p>3<img src=\"/storage/202302/9ef296dcc0f19c6d03caac968ccba23f.jpg\" alt=\"\" width=\"960\" height=\"1280\" /></p>', 1, 1, 0, '', 'default', '0000-00-00 00:00:00', '2023-02-21 21:42:10');

-- --------------------------------------------------------

--
-- Table structure for table `xw_spot_pair`
--

CREATE TABLE `xw_spot_pair` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='币币设置';

--
-- Dumping data for table `xw_spot_pair`
--

INSERT INTO `xw_spot_pair` (`id`, `code`, `last_price`, `exchange_id`, `cate_id`, `delimiter`, `base_id`, `quote_id`, `fee_type`, `fee`, `price_decimal`, `amount_decimal`, `order_decimal`, `order_min_price`, `order_max_price`, `limit_min_amount`, `limit_max_amount`, `market_buy_min_price`, `market_buy_max_price`, `market_sell_min_amount`, `market_sell_max_amount`, `sort_order`, `is_recommend`, `is_show`, `is_trade`, `is_market_buy`, `is_market_sell`, `is_limit_buy`, `is_limit_sell`, `created_at`, `updated_at`) VALUES
(1, 'btcusdt', '23931.6100000000000000', 3, 1, '/', 3, 2, 1, '0.0000', 6, 2, 0, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 9999, 1, 1, 1, 0, 0, 0, 0, '2021-06-10 17:55:17', '2023-02-22 10:34:34'),
(2, 'ethusdt', '1628.7700000000000000', 3, 1, '/', 4, 2, 1, '0.0000', 4, 2, 0, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 9998, 1, 1, 1, 0, 0, 0, 0, '2021-06-10 17:55:31', '2023-02-22 10:34:34'),
(3, 'trxusdt', '0.0684300000000000', 3, 1, '/', 5, 2, 1, '0.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 9997, 1, 1, 1, 0, 0, 1, 1, '2021-06-10 17:55:50', '2023-02-22 10:34:34'),
(4, 'dogeusdt', '0.0000000000000000', 3, 1, '/', 6, 2, 2, '2.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 0, 0, 1, 0, 0, 0, 0, 0, '2021-06-10 17:55:50', '2022-03-09 02:53:35'),
(5, 'ltcusdt', '93.8800000000000000', 3, 1, '/', 8, 2, 1, '1.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 0, 0, 1, 0, 0, 0, 0, 0, '2021-06-10 17:55:50', '2023-02-22 10:34:35'),
(6, 'linkusdt', '7.4200000000000000', 3, 1, '/', 7, 2, 1, '0.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 0, 0, 1, 0, 0, 0, 0, 0, '2021-06-10 17:55:50', '2023-02-22 10:34:34'),
(7, 'eosusdt', '1.1860000000000000', 3, 1, '/', 9, 2, 1, '0.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 0, 0, 1, 0, 0, 0, 0, 0, '2021-06-10 17:55:50', '2023-02-22 10:34:34'),
(8, 'bnbusdt', '1.1860000000000000', 3, 1, '/', 10, 2, 1, '0.0000', 6, 2, 6, '10.00', '10000.00', '10.00', '10000.00', '0.00', '0.00', '0.00', '0.00', 0, 0, 0, 0, 0, 0, 0, 0, '2021-06-10 17:55:50', '2023-02-22 10:34:34');

-- --------------------------------------------------------

--
-- Table structure for table `xw_task_log`
--

CREATE TABLE `xw_task_log` (
  `id` int(8) NOT NULL,
  `item` varchar(50) CHARACTER SET utf8 NOT NULL,
  `content` text CHARACTER SET utf8 NOT NULL COMMENT '备注',
  `created_at` timestamp NOT NULL,
  `finished_at` datetime NOT NULL COMMENT '完成时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_task_log`
--

INSERT INTO `xw_task_log` (`id`, `item`, `content`, `created_at`, `finished_at`) VALUES
(1, 'reward_swap_fee', 'a:3:{s:9:\"startTime\";s:19:\"2023-02-21 00:00:00\";s:7:\"endTime\";s:19:\"2023-02-21 23:59:59\";s:5:\"total\";i:2;}', '2023-02-22 04:57:01', '2023-02-22 12:57:01');

-- --------------------------------------------------------

--
-- Table structure for table `xw_wallet`
--

CREATE TABLE `xw_wallet` (
  `id` int(11) NOT NULL,
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
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `xw_wallet`
--

INSERT INTO `xw_wallet` (`id`, `client_id`, `chain_id`, `member_id`, `wallet_id`, `name`, `password`, `password_tip`, `address`, `memo`, `is_default`, `has_mnemonic`, `eye`, `is_import`, `is_show`, `is_back`, `is_delete`, `created_at`, `updated_at`) VALUES
(1, 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', 2, 1, '2996cff3-7105-4693-9a90-2754cef82e8e', 'aaa', 'e10adc3949ba59abbe56e057f20f883e', '1', 'TG4YUkqW7kNWarjvSriuFV3omCThMfMwaf', '', 0, 0, 'close', 0, 1, 0, 0, '2023-02-13 22:01:38', '2023-02-27 19:34:09'),
(2, 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', 3, 1, '3541d065-ef4e-4cc6-9ddb-5670d8c897ad', 'demo6', 'e10adc3949ba59abbe56e057f20f883e', '1', '0xae5fedf5a1f20d266aa40186fa60d2eedc82a54a', '', 1, 0, 'close', 0, 1, 0, 0, '2023-02-14 11:30:45', '2023-02-28 12:35:40'),
(3, 'fc8f9481-ffe0-4fa7-9408-7c09254e65c3', 3, 1, 'd963fa58-db40-4bc8-b7e6-68e0134adea9', 'demo2', 'e10adc3949ba59abbe56e057f20f883e', '1', '0xa352c79d2acf0af83eb07aa132c0c038a3dd0dea', '', 0, 0, 'close', 0, 1, 0, 0, '2023-02-23 23:20:31', '2023-02-28 12:24:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `xw_account`
--
ALTER TABLE `xw_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_id_2` (`member_id`,`currency_id`,`asset_type`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `asset_type` (`asset_type`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Indexes for table `xw_account_log`
--
ALTER TABLE `xw_account_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_id` (`currency_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `scene` (`scene`),
  ADD KEY `asset_type` (`asset_type`);

--
-- Indexes for table `xw_account_pair`
--
ALTER TABLE `xw_account_pair`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_show` (`status`);

--
-- Indexes for table `xw_account_recharge`
--
ALTER TABLE `xw_account_recharge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trx_id` (`tx_id`(255)) USING BTREE,
  ADD KEY `member_id` (`member_id`) USING BTREE;

--
-- Indexes for table `xw_account_reward`
--
ALTER TABLE `xw_account_reward`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `amount` (`amount`),
  ADD KEY `currency_id` (`currency_id`),
  ADD KEY `asset_type` (`asset_type`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `xw_account_transfer`
--
ALTER TABLE `xw_account_transfer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_account` (`from_member`),
  ADD KEY `to_account` (`to_member`),
  ADD KEY `currency_id` (`currency_id`);

--
-- Indexes for table `xw_account_withdraw`
--
ALTER TABLE `xw_account_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`) USING BTREE,
  ADD KEY `currency_chain_id` (`cc_id`);

--
-- Indexes for table `xw_admin`
--
ALTER TABLE `xw_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_department`
--
ALTER TABLE `xw_admin_department`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_log`
--
ALTER TABLE `xw_admin_log`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_menu`
--
ALTER TABLE `xw_admin_menu`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_position`
--
ALTER TABLE `xw_admin_position`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_role`
--
ALTER TABLE `xw_admin_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`) USING BTREE;

--
-- Indexes for table `xw_admin_role_access`
--
ALTER TABLE `xw_admin_role_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`role_id`) USING BTREE;

--
-- Indexes for table `xw_article`
--
ALTER TABLE `xw_article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate_id` (`cate_id`);

--
-- Indexes for table `xw_article_cate`
--
ALTER TABLE `xw_article_cate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `xw_banner`
--
ALTER TABLE `xw_banner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cate_id` (`cate_id`),
  ADD KEY `lang` (`lang`);

--
-- Indexes for table `xw_banner_cate`
--
ALTER TABLE `xw_banner_cate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `xw_chain`
--
ALTER TABLE `xw_chain`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `xw_config`
--
ALTER TABLE `xw_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `xw_currency`
--
ALTER TABLE `xw_currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `name_en` (`name_en`),
  ADD KEY `status` (`status`),
  ADD KEY `sort_order` (`sort_order`);

--
-- Indexes for table `xw_currency_chain`
--
ALTER TABLE `xw_currency_chain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_id` (`currency_id`),
  ADD KEY `chain_id` (`chain_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `xw_exchange`
--
ALTER TABLE `xw_exchange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `status` (`status`),
  ADD KEY `sort_order` (`sort_order`);

--
-- Indexes for table `xw_file`
--
ALTER TABLE `xw_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `xw_lang`
--
ALTER TABLE `xw_lang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `xw_member`
--
ALTER TABLE `xw_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `pid` (`pid`),
  ADD KEY `invite_code` (`invite_code`);

--
-- Indexes for table `xw_member_address`
--
ALTER TABLE `xw_member_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chain_id` (`chain_id`);

--
-- Indexes for table `xw_member_log`
--
ALTER TABLE `xw_member_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `xw_member_role`
--
ALTER TABLE `xw_member_role`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_page`
--
ALTER TABLE `xw_page`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `xw_spot_pair`
--
ALTER TABLE `xw_spot_pair`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pair` (`code`),
  ADD KEY `exchange_id` (`exchange_id`),
  ADD KEY `cate_id` (`cate_id`),
  ADD KEY `base_currency_id` (`base_id`),
  ADD KEY `quote_currency_id` (`quote_id`),
  ADD KEY `is_recommend` (`is_recommend`),
  ADD KEY `is_show` (`is_show`),
  ADD KEY `is_trade` (`is_trade`);

--
-- Indexes for table `xw_task_log`
--
ALTER TABLE `xw_task_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item` (`item`);

--
-- Indexes for table `xw_wallet`
--
ALTER TABLE `xw_wallet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallet_id` (`wallet_id`),
  ADD UNIQUE KEY `currency_chain_id_2` (`chain_id`,`member_id`,`address`),
  ADD KEY `member_id` (`member_id`) USING BTREE,
  ADD KEY `currency_chain_id` (`chain_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `address` (`address`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `xw_account`
--
ALTER TABLE `xw_account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_account_log`
--
ALTER TABLE `xw_account_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `xw_account_pair`
--
ALTER TABLE `xw_account_pair`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_account_recharge`
--
ALTER TABLE `xw_account_recharge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `xw_account_reward`
--
ALTER TABLE `xw_account_reward`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `xw_account_transfer`
--
ALTER TABLE `xw_account_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `xw_account_withdraw`
--
ALTER TABLE `xw_account_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `xw_admin`
--
ALTER TABLE `xw_admin`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_admin_department`
--
ALTER TABLE `xw_admin_department`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `xw_admin_log`
--
ALTER TABLE `xw_admin_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_admin_menu`
--
ALTER TABLE `xw_admin_menu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `xw_admin_position`
--
ALTER TABLE `xw_admin_position`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `xw_admin_role`
--
ALTER TABLE `xw_admin_role`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `xw_article`
--
ALTER TABLE `xw_article`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `xw_article_cate`
--
ALTER TABLE `xw_article_cate`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `xw_banner`
--
ALTER TABLE `xw_banner`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `xw_banner_cate`
--
ALTER TABLE `xw_banner_cate`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `xw_chain`
--
ALTER TABLE `xw_chain`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `xw_config`
--
ALTER TABLE `xw_config`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `xw_currency`
--
ALTER TABLE `xw_currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `xw_currency_chain`
--
ALTER TABLE `xw_currency_chain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `xw_exchange`
--
ALTER TABLE `xw_exchange`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `xw_file`
--
ALTER TABLE `xw_file`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `xw_lang`
--
ALTER TABLE `xw_lang`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `xw_member`
--
ALTER TABLE `xw_member`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `xw_member_address`
--
ALTER TABLE `xw_member_address`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `xw_member_log`
--
ALTER TABLE `xw_member_log`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- AUTO_INCREMENT for table `xw_member_role`
--
ALTER TABLE `xw_member_role`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `xw_page`
--
ALTER TABLE `xw_page`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_spot_pair`
--
ALTER TABLE `xw_spot_pair`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `xw_task_log`
--
ALTER TABLE `xw_task_log`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `xw_wallet`
--
ALTER TABLE `xw_wallet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
