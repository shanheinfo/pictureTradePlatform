CREATE DATABASE IF NOT EXISTS pictureTradePlatform CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

USE pictureTradePlatform;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `picture_user`;
DROP TABLE IF EXISTS `picture_admin`;
DROP TABLE IF EXISTS `picture_file`;
DROP TABLE IF EXISTS `picture_data`;
DROP TABLE IF EXISTS `picture_info`;
DROP TABLE IF EXISTS `picture_category`;
DROP TABLE IF EXISTS `picture_tag`;
DROP TABLE IF EXISTS `picture_order_bill_recharge`;
DROP TABLE IF EXISTS `picture_order_bill_credits`;
DROP TABLE IF EXISTS `picture_order_bill_buy`;
DROP TABLE IF EXISTS `picture_auction`;
DROP TABLE IF EXISTS `picture_tag_relation`;

#----------------------
# 用户表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_user`(
     `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
     `user_id` varchar(90) NOT NULL COMMENT '用户id',
     `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账号',
     `user_mail` varchar(320) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
     `user_phone` varchar(320) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '手机号',
     `user_pwd` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
     `money_data` decimal(12,2) default 0 NULL COMMENT '积分余额',
     `user_icon` int(11) NULL DEFAULT 1 COMMENT '头像id,默认为默认头像地址',
     `user_create_ip` varchar(30) NOT NULL DEFAULT 0 COMMENT '创建时IP',
     `user_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `user_status` tinyint(1) DEFAULT 0 COMMENT '用户是否封禁 0 封禁',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE (`user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '用户表';


#----------------------
# 管理员表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_admin`(
     `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
     `user_id` varchar(90) NOT NULL COMMENT '用户id',
     `status` int(6) NOT NULL COMMENT '管理所属版块 0是全部版块',
     PRIMARY KEY (`id`) USING BTREE
)ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '管理员表';

#----------------------
# 图片地址表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_file`(
        `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
        `img_id` bigint(20) UNSIGNED NOT NULL COMMENT '图片id',
        `img_addr` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 0 COMMENT '图片地址',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE (`img_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '图片表';

#----------------------
# 图片表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_data`(
        `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
        `img_index` varchar(90) NOT NULL COMMENT '图片索引id',
        `img_id` bigint(20) UNSIGNED NOT NULL COMMENT '图片id',
        `user_id` varchar(90) NOT NULL COMMENT '发布图片的用户id',
        `img_money` decimal(12,2) default '0.00' NULL COMMENT '图片价格',
        `img_key` tinyint(1) default 1 NOT NULL COMMENT '是否是唯一版权',
        `img_buy_count` int(11) default 0 NULL COMMENT '购买次数',
        `img_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE KEY `user_img_id` (`img_id`,`user_id`),
        UNIQUE (`img_index`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '图片表';

#----------------------
# 图片其他信息表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_info` (
      `img_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图片id',
      `img_name` varchar(360) NOT NULL COMMENT '图片名',
      `img_type_id` int(11) NOT NULL COMMENT '图片分类id',
      `img_desc` varchar(500) NOT NULL COMMENT '图片描述',
      PRIMARY KEY (`img_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=Compact COMMENT '图片其他信息表';



#----------------------
# 图片分类表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_category`(
     `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
     `category_key_id` varchar(90) NOT NULL COMMENT '分类索引id',
     `category_id` int(11) UNSIGNED NOT NULL COMMENT '分类id',
     `category_name` varchar(255) NOT NULL COMMENT '分类名称',
     `category_english_name` varchar(255) NOT NULL COMMENT '分类英文名',
     `category_keywords` varchar(255) NOT NULL COMMENT '分类关键词，用,分割',
     `category_description` text NOT NULL COMMENT '分类描述',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE (`category_key_id`)
)ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '分类板块表';

INSERT INTO picture_category VALUES(1,'aaaaaaaaaaaaa',1,'默认分类','default','default,默认','默认分类');
INSERT INTO picture_category VALUES(2,'aaaaaaaaaaaa6',2,'默认默认分类','default','default,默认','默认分类');
INSERT INTO picture_category VALUES(3,'aaaaaaaaaaaa5',3,'默认默认分类','default','default,默认','默认分类');

#----------------------
# 标签表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_tag` (
     `tag_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
     `tag_name` varchar(191) NOT NULL COMMENT '标签名称',
     PRIMARY KEY (`tag_id`) USING BTREE,
     UNIQUE INDEX `unique_tag_name` (`tag_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=Compact COMMENT '标签表';

#----------------------
# 图片标签关联表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_tag_relation` (
      `img_id` bigint(20) UNSIGNED NOT NULL COMMENT '图片id',
      `tag_id` bigint(20) UNSIGNED NOT NULL COMMENT '标签id',
      PRIMARY KEY (`img_id`, `tag_id`) USING BTREE
) ENGINE=InnoDB CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=Compact COMMENT '图片标签关联表';


#----------------------
# 充值流水表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_order_bill_recharge`(
          `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
          `user_id` varchar(90) NOT NULL COMMENT '用户id',
          `bill_recharge_money_data` decimal(12,2) NOT NULL COMMENT '订单金额',
          `bill_recharge_info` text NOT NULL COMMENT '订单描述',
          `bill_recharge_addr` tinyint(1) NOT NULL COMMENT '充值来源0（支付宝）',
          `bill_recharge_data` text NOT NULL COMMENT '订单号',
          PRIMARY KEY (`id`) USING BTREE,
          UNIQUE (`user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '充值流水表';

#----------------------
# 积分流水表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_order_bill_credits`(
         `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
         `user_id` varchar(90) NOT NULL COMMENT '用户id',
         `bill_credits_data` text NOT NULL COMMENT '积分流水信息',
         `bill_credits_money_data` decimal(12,2) NOT NULL COMMENT '流水金额数据',
         PRIMARY KEY (`id`) USING BTREE,
         INDEX (`user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '积分流水表';

#----------------------
# 购买流水表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_order_bill_buy`(
         `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
         `img_id` bigint(20) NOT NULL COMMENT '图片id',
         `user_id` varchar(90) NOT NULL COMMENT '用户id',
         `bill_credits_money_data` decimal(12,2) NOT NULL COMMENT '流水金额数据',
         PRIMARY KEY (`id`) USING BTREE,
         INDEX (`img_id`),
         INDEX (`user_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '购买流水表';

#----------------------
# 拍卖表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_auction`(
     `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键Id',
     `img_id` bigint(20) NOT NULL COMMENT '图片id',
     `user_id` varchar(90) NOT NULL COMMENT '最高价格的用户id',
     `money_top` decimal(12,2) NOT NULL COMMENT '最高价格',
     `img_create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '拍卖开始时间',
     `img_end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '拍卖结束时间',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE (`img_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact COMMENT '拍卖表';







# 图片信息
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (1, '65962c2f2587d4310e69027e', 1742756602617925632, '65962bc52587d4310e69027d', 10.00, 1, 0, '2024-01-04 11:55:27');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (2, '65962c542587d4310e69027f', 1742756759409397760, '65962bc52587d4310e69027d', 50.00, 0, 0, '2024-01-04 11:56:04');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (3, '65962c772587d4310e690280', 1742756902825234432, '65962bc52587d4310e69027d', 99.99, 1, 0, '2024-01-04 11:56:39');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (4, '65962caf2587d4310e690281', 1742757141145587712, '65962bc52587d4310e69027d', 99.99, 0, 0, '2024-01-04 11:57:35');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (5, '65962d102587d4310e690282', 1742757544436305920, '65962bc52587d4310e69027d', 666.00, 1, 0, '2024-01-04 11:59:12');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (6, '65962da12587d4310e690283', 1742758152388087808, '65962bc52587d4310e69027d', 666.00, 0, 0, '2024-01-04 12:01:37');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (7, '65962daf2587d4310e690284', 1742758211792015360, '65962bc52587d4310e69027d', 111.00, 0, 0, '2024-01-04 12:01:51');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (8, '65962e182587d4310e690285', 1742758653531918336, '65962bc52587d4310e69027d', 36.75, 0, 0, '2024-01-04 12:03:36');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (9, '65962e692587d4310e690286', 1742758991127252992, '65962bc52587d4310e69027d', 99.85, 0, 0, '2024-01-04 12:04:57');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (10, '65962ea92587d4310e690287', 1742759260468678656, '65962bc52587d4310e69027d', 87.60, 1, 0, '2024-01-04 12:06:01');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (11, '65962f922587d4310e690288', 1742760239595393024, '65962bc52587d4310e69027d', 78.67, 0, 0, '2024-01-04 12:09:54');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (12, '659633b82587e1acf78992e0', 1742764692629229568, '659633982587e1acf78992df', 689.00, 0, 0, '2024-01-04 12:27:36');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (13, '659633c02587e1acf78992e1', 1742764726439514112, '659633982587e1acf78992df', 689.00, 0, 0, '2024-01-04 12:27:44');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (14, '659633cb2587e1acf78992e2', 1742764772656549888, '659633982587e1acf78992df', 689.00, 1, 0, '2024-01-04 12:27:55');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (15, '659633df2587e1acf78992e3', 1742764857024974848, '659633982587e1acf78992df', 689.00, 0, 0, '2024-01-04 12:28:15');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (16, '659633f22587e1acf78992e4', 1742764935861112832, '659633982587e1acf78992df', 689.00, 1, 0, '2024-01-04 12:28:34');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (17, '659634072587e1acf78992e5', 1742765025438863360, '659633982587e1acf78992df', 77.00, 0, 0, '2024-01-04 12:28:55');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (18, '6596342a2587e1acf78992e6', 1742765172734431232, '659633982587e1acf78992df', 98.00, 0, 0, '2024-01-04 12:29:30');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (19, '6596347e2587e1acf78992e7', 1742765521692135424, '659633982587e1acf78992df', 98.00, 0, 0, '2024-01-04 12:30:54');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (20, '6596349e2587e1acf78992e8', 1742765657856020480, '659633982587e1acf78992df', 87.00, 1, 0, '2024-01-04 12:31:26');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (21, '659634bd2587e1acf78992e9', 1742765787225133056, '659633982587e1acf78992df', 168.00, 1, 0, '2024-01-04 12:31:57');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (22, '659634c32587e1acf78992ea', 1742765813930266624, '659633982587e1acf78992df', 168.00, 1, 0, '2024-01-04 12:32:03');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (23, '659634cb2587e1acf78992eb', 1742765846603894784, '659633982587e1acf78992df', 1687.00, 0, 0, '2024-01-04 12:32:11');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (24, '659634d52587e1acf78992ec', 1742765888551129088, '659633982587e1acf78992df', 687.44, 0, 0, '2024-01-04 12:32:21');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (25, '659634db2587e1acf78992ed', 1742765915604389888, '659633982587e1acf78992df', 687.44, 0, 0, '2024-01-04 12:32:27');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (26, '659634e32587e1acf78992ee', 1742765949255290880, '659633982587e1acf78992df', 687.44, 0, 0, '2024-01-04 12:32:35');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (27, '65963e0325879bf5c87f9541', 1742775743798185984, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:11:31');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (28, '65963f6d258774b6846d2f55', 1742777260756307968, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:17:32');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (29, '65963f71258774b6846d2f56', 1742777282105315328, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:17:37');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (30, '65963f77258774b6846d2f57', 1742777304968466432, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:17:43');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (31, '65963f7c258774b6846d2f58', 1742777327047282688, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:17:48');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (32, '65963f81258774b6846d2f59', 1742777347662286848, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:17:53');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (33, '65963f8a258774b6846d2f5a', 1742777383028658176, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:18:02');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (34, '65963f92258774b6846d2f5b', 1742777416511787008, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:18:09');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (35, '65963f99258774b6846d2f5c', 1742777446840799232, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:18:17');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (36, '65963fa8258774b6846d2f5d', 1742777509411426304, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:18:32');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (37, '65963fb5258774b6846d2f5e', 1742777566097444864, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:18:45');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (38, '65963fcb258774b6846d2f5f', 1742777657994645504, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:07');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (39, '65963fd0258774b6846d2f60', 1742777680207679488, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:12');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (40, '65963fd5258774b6846d2f61', 1742777697949585408, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:17');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (41, '65963fdc258774b6846d2f62', 1742777729935347712, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:24');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (42, '65963fe1258774b6846d2f63', 1742777751724756992, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:29');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (43, '65963fec258774b6846d2f64', 1742777795236466688, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:40');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (44, '65963ff6258774b6846d2f65', 1742777838492323840, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:50');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (45, '65963ffe258774b6846d2f66', 1742777870847184896, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:19:58');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (46, '65964002258774b6846d2f67', 1742777889377619968, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:02');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (47, '65964007258774b6846d2f68', 1742777909103431680, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:07');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (48, '65964011258774b6846d2f69', 1742777953269452800, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:17');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (49, '65964015258774b6846d2f6a', 1742777968977121280, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:21');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (50, '65964019258774b6846d2f6b', 1742777986748387328, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:25');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (51, '6596401e258774b6846d2f6c', 1742778006818131968, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:30');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (52, '65964024258774b6846d2f6d', 1742778029140217856, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:36');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (53, '6596402c258774b6846d2f6e', 1742778063818723328, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:44');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (54, '65964030258774b6846d2f6f', 1742778082722451456, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:48');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (55, '65964035258774b6846d2f70', 1742778102439874560, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:53');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (56, '6596403a258774b6846d2f71', 1742778123600138240, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:20:58');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (57, '65964044258774b6846d2f72', 1742778163181785088, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:08');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (58, '65964049258774b6846d2f73', 1742778187521331200, '65963dc225879bf5c87f9540', 9999.00, 1, 0, '2024-01-04 13:21:13');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (59, '6596404f258774b6846d2f74', 1742778211617607680, '65963dc225879bf5c87f9540', 9999.00, 1, 0, '2024-01-04 13:21:19');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (60, '65964055258774b6846d2f75', 1742778237576155136, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:25');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (61, '6596405b258774b6846d2f76', 1742778262637121536, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:31');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (62, '65964065258774b6846d2f77', 1742778303477059584, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:41');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (63, '6596406a258774b6846d2f78', 1742778322535976960, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:46');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (64, '6596406f258774b6846d2f79', 1742778343629131776, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:21:51');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (65, '65964075258774b6846d2f7a', 1742778369210191872, '65963dc225879bf5c87f9540', 9999.00, 1, 0, '2024-01-04 13:21:57');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (66, '6596407f258774b6846d2f7b', 1742778412772233216, '65963dc225879bf5c87f9540', 9999.00, 0, 0, '2024-01-04 13:22:07');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (67, '65964084258774b6846d2f7c', 1742778435211759616, '65963dc225879bf5c87f9540', 9999.00, 1, 0, '2024-01-04 13:22:12');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (68, '6596408e258774b6846d2f7d', 1742778473514143744, '65963dc225879bf5c87f9540', 9998.00, 1, 0, '2024-01-04 13:22:22');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (69, '65964099258774b6846d2f7e', 1742778522935627776, '65963dc225879bf5c87f9540', 8888.00, 1, 0, '2024-01-04 13:22:33');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (70, '659640a1258774b6846d2f7f', 1742778555718307840, '65963dc225879bf5c87f9540', 888.00, 1, 0, '2024-01-04 13:22:41');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (71, '659640aa258774b6846d2f80', 1742778591755767808, '65963dc225879bf5c87f9540', 777.00, 1, 0, '2024-01-04 13:22:50');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (72, '659640b4258774b6846d2f81', 1742778635305226240, '65963dc225879bf5c87f9540', 455.00, 0, 0, '2024-01-04 13:23:00');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (73, '659640bf258774b6846d2f82', 1742778679022456832, '65963dc225879bf5c87f9540', 200.56, 1, 0, '2024-01-04 13:23:11');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (74, '659640cd258774b6846d2f83', 1742778739210719232, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:23:25');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (75, '659640d2258774b6846d2f84', 1742778762262614016, '65963dc225879bf5c87f9540', 100.56, 1, 0, '2024-01-04 13:23:30');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (76, '6596441c258774b6846d2f85', 1742782292759285760, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:37:32');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (77, '6596442b258774b6846d2f86', 1742782353668968448, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:37:47');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (78, '65964437258774b6846d2f87', 1742782403744763904, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:37:59');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (79, '65964449258774b6846d2f88', 1742782480827682816, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:38:17');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (80, '65964452258774b6846d2f89', 1742782519096512512, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:38:26');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (81, '6596445d258774b6846d2f8a', 1742782567041601536, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:38:37');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (82, '65964475258774b6846d2f8b', 1742782666215919616, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:01');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (83, '6596447b258774b6846d2f8c', 1742782691293663232, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:07');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (84, '65964480258774b6846d2f8d', 1742782713640914944, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:12');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (85, '65964486258774b6846d2f8e', 1742782735648428032, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:18');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (86, '6596448b258774b6846d2f8f', 1742782757140041728, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:23');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (87, '65964492258774b6846d2f90', 1742782787267727360, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:30');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (88, '6596449a258774b6846d2f91', 1742782819039580160, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:38');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (89, '659644a4258774b6846d2f92', 1742782862601621504, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:48');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (90, '659644a9258774b6846d2f93', 1742782884420390912, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:53');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (91, '659644ae258774b6846d2f94', 1742782905920393216, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:39:58');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (92, '659644b4258774b6846d2f95', 1742782931493064704, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:40:04');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (93, '659644bc258774b6846d2f96', 1742782962010820608, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:40:12');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (94, '659644c1258774b6846d2f97', 1742782986295840768, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:40:17');
INSERT INTO `picture_data` (`id`, `img_index`, `img_id`, `user_id`, `img_money`, `img_key`, `img_buy_count`, `img_create_time`) VALUES (95, '659644c6258774b6846d2f98', 1742783006780821504, '65963dc225879bf5c87f9540', 100.56, 0, 0, '2024-01-04 13:40:22');

# 图片概览
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742756602617925632, '欧陆风云4-神圣罗马帝国照片', 1, '这是欧陆风云4神圣罗马帝国统一的照片，极具收藏价值');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742756759409397760, '安卓作业', 1, '这是一个安卓作业');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742756902825234432, '贝尔足球运动员', 1, '大圣贝尔照片');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742757141145587712, '欧陆风云4-奥地利和匈牙利', 1, '欧陆风云4奥地利和匈牙利');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742757544436305920, '代码图', 1, '这是一个代码图片');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742758152388087808, '代码图', 1, '代码图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742758211792015360, '代码图', 1, '代码');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742758653531918336, '安卓代码', 1, '123456789');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742758991127252992, '游戏照片', 1, '123456789');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742759260468678656, 'JavaFx', 1, '这是一个Javafx');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742760239595393024, 'ping', 1, '这是一个ping页面');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742764692629229568, 'java', 1, 'java代码');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742764726439514112, 'java', 1, '安安安安安安安安安安安安安安安');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742764772656549888, 'java测试', 3, 'java测试java测试java测试java测试java测试java测试java测试');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742764857024974848, '安卓代码', 1, '安卓代码安卓代码安卓代码安卓代码安卓代码安卓代码');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742764935861112832, 'postman', 1, 'postmanpostmanpostmanpostmanpostmanpostman');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765025438863360, 'postman', 1, 'postmanpostman');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765172734431232, '阿劳霍', 1, '阿劳霍足球,明星');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765521692135424, '巴萨罗那', 1, '巴萨罗那合照');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765657856020480, '风景', 1, '风景图风景图风景图风景图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765787225133056, '风景', 1, '风景图风景图风景图风景图风景图风景图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765813930266624, '风景', 1, '风景图风景图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765846603894784, '风景', 2, '风景图风景图风景图风景图风景图风景图风景图风景图风景图风景图风景图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765888551129088, '风景', 1, '风景图');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765915604389888, '风景', 1, 'aaaaaaaaaaaa');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742765949255290880, '风景aa', 2, '风景图风景图风景图aaa');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742775743798185984, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777260756307968, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777282105315328, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777304968466432, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777327047282688, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777347662286848, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777383028658176, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777416511787008, '梅西', 2, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777446840799232, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777509411426304, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777566097444864, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777657994645504, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777680207679488, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777697949585408, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777729935347712, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777751724756992, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777795236466688, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777838492323840, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777870847184896, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777889377619968, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777909103431680, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777953269452800, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777968977121280, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742777986748387328, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778006818131968, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778029140217856, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778063818723328, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778082722451456, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778102439874560, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778123600138240, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778163181785088, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778187521331200, '梅西', 2, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778211617607680, '梅西', 3, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778237576155136, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778262637121536, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778303477059584, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778322535976960, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778343629131776, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778369210191872, '梅西', 3, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778412772233216, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778435211759616, '梅西', 2, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778473514143744, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778522935627776, '梅西', 2, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778555718307840, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778591755767808, '梅西', 3, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778635305226240, '梅西', 3, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778679022456832, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778739210719232, '梅西', 1, 'messi梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742778762262614016, '梅西', 1, '梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰梅西,巴萨,巴萨罗那,阿根廷,潘帕斯雄鹰');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782292759285760, '哈维', 1, '哈维');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782353668968448, '菲利克斯', 1, '菲利克斯');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782403744763904, '拉菲尼亚', 1, '拉菲尼亚');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782480827682816, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782519096512512, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782567041601536, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782666215919616, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782691293663232, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782713640914944, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782735648428032, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782757140041728, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782787267727360, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782819039580160, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782862601621504, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782884420390912, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782905920393216, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782931493064704, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782962010820608, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742782986295840768, '巴萨球员', 1, '巴萨球员');
INSERT INTO `picture_info` (`img_id`, `img_name`, `img_type_id`, `img_desc`) VALUES (1742783006780821504, '巴萨球员', 1, '巴萨球员');


#用户信息
INSERT INTO `picture_user` (`id`, `user_id`, `user_name`, `user_mail`, `user_phone`, `user_pwd`, `money_data`, `user_icon`, `user_create_ip`, `user_create_time`, `user_status`) VALUES (1, '65962bc52587d4310e69027d', 'shanhe', 'shanhe@chorme.com', NULL, '2c70547dd007234d5b80df086af2786d', 0.00, 1, '0:0:0:0:0:0:0:1', '2024-01-05 11:53:42', 1);
INSERT INTO `picture_user` (`id`, `user_id`, `user_name`, `user_mail`, `user_phone`, `user_pwd`, `money_data`, `user_icon`, `user_create_ip`, `user_create_time`, `user_status`) VALUES (2, '659633982587e1acf78992df', 'admin', 'admin@qq.com', NULL, '2c70547dd007234d5b80df086af2786d', 0.00, 1, '0:0:0:0:0:0:0:1', '2024-01-05 12:27:05', 1);
INSERT INTO `picture_user` (`id`, `user_id`, `user_name`, `user_mail`, `user_phone`, `user_pwd`, `money_data`, `user_icon`, `user_create_ip`, `user_create_time`, `user_status`) VALUES (3, '65963dc225879bf5c87f9540', 'messi', 'messi@messi.com', NULL, '2c70547dd007234d5b80df086af2786d', 0.00, 1, '0:0:0:0:0:0:0:1', '2024-01-05 13:10:26', 1);
# 管理员
INSERT INTO `picture_admin` (`id`, `user_id`, `status`) VALUES (1, '659633982587e1acf78992df', 1);

# 图片关键词关联
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756602617925632, 1);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756602617925632, 2);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756602617925632, 3);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756759409397760, 4);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756759409397760, 5);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756759409397760, 6);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756902825234432, 7);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756902825234432, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742756902825234432, 9);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742757141145587712, 1);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742757141145587712, 2);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742757544436305920, 10);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742757544436305920, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758152388087808, 10);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758152388087808, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758211792015360, 10);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758211792015360, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758653531918336, 4);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758653531918336, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758653531918336, 12);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758653531918336, 13);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758991127252992, 2);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742758991127252992, 14);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742759260468678656, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742759260468678656, 15);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742759260468678656, 16);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742759260468678656, 17);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742760239595393024, 18);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742760239595393024, 19);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742760239595393024, 20);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764692629229568, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764692629229568, 15);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764692629229568, 16);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764726439514112, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764726439514112, 15);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764726439514112, 16);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764772656549888, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764772656549888, 15);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764772656549888, 16);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764857024974848, 4);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764857024974848, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764857024974848, 12);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764857024974848, 13);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764935861112832, 10);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742764935861112832, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765025438863360, 10);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765025438863360, 11);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765172734431232, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765172734431232, 21);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765521692135424, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765521692135424, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765521692135424, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765657856020480, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765787225133056, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765813930266624, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765846603894784, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765888551129088, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765915604389888, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742765949255290880, 24);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742775743798185984, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742775743798185984, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742775743798185984, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742775743798185984, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742775743798185984, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777260756307968, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777260756307968, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777260756307968, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777260756307968, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777260756307968, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777282105315328, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777282105315328, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777282105315328, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777282105315328, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777282105315328, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777304968466432, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777304968466432, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777304968466432, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777304968466432, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777304968466432, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777327047282688, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777327047282688, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777327047282688, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777327047282688, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777327047282688, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777347662286848, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777347662286848, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777347662286848, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777347662286848, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777347662286848, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777383028658176, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777383028658176, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777383028658176, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777383028658176, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777383028658176, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777416511787008, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777416511787008, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777416511787008, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777416511787008, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777416511787008, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777446840799232, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777446840799232, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777446840799232, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777446840799232, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777446840799232, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777509411426304, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777509411426304, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777509411426304, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777509411426304, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777509411426304, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777566097444864, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777566097444864, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777566097444864, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777566097444864, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777566097444864, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777657994645504, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777657994645504, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777657994645504, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777657994645504, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777657994645504, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777680207679488, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777680207679488, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777680207679488, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777680207679488, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777680207679488, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777697949585408, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777697949585408, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777697949585408, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777697949585408, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777697949585408, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777729935347712, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777729935347712, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777729935347712, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777729935347712, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777729935347712, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777751724756992, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777751724756992, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777751724756992, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777751724756992, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777751724756992, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777795236466688, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777795236466688, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777795236466688, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777795236466688, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777795236466688, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777838492323840, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777838492323840, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777838492323840, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777838492323840, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777838492323840, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777870847184896, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777870847184896, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777870847184896, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777870847184896, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777870847184896, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777889377619968, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777889377619968, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777889377619968, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777889377619968, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777889377619968, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777909103431680, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777909103431680, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777909103431680, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777909103431680, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777909103431680, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777953269452800, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777953269452800, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777953269452800, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777953269452800, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777953269452800, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777968977121280, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777968977121280, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777968977121280, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777968977121280, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777968977121280, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777986748387328, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777986748387328, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777986748387328, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777986748387328, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742777986748387328, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778006818131968, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778006818131968, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778006818131968, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778006818131968, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778006818131968, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778029140217856, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778029140217856, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778029140217856, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778029140217856, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778029140217856, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778063818723328, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778063818723328, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778063818723328, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778063818723328, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778063818723328, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778082722451456, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778082722451456, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778082722451456, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778082722451456, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778082722451456, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778102439874560, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778102439874560, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778102439874560, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778102439874560, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778102439874560, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778123600138240, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778123600138240, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778123600138240, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778123600138240, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778123600138240, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778163181785088, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778163181785088, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778163181785088, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778163181785088, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778163181785088, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778187521331200, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778187521331200, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778187521331200, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778187521331200, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778187521331200, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778211617607680, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778211617607680, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778211617607680, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778211617607680, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778211617607680, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778237576155136, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778237576155136, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778237576155136, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778237576155136, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778237576155136, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778262637121536, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778262637121536, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778262637121536, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778262637121536, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778262637121536, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778303477059584, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778303477059584, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778303477059584, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778303477059584, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778303477059584, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778322535976960, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778322535976960, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778322535976960, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778322535976960, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778322535976960, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778343629131776, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778343629131776, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778343629131776, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778343629131776, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778343629131776, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778369210191872, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778369210191872, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778369210191872, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778369210191872, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778369210191872, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778412772233216, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778412772233216, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778412772233216, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778412772233216, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778412772233216, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778435211759616, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778435211759616, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778435211759616, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778435211759616, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778435211759616, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778473514143744, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778473514143744, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778473514143744, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778473514143744, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778473514143744, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778522935627776, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778522935627776, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778522935627776, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778522935627776, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778522935627776, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778555718307840, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778555718307840, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778555718307840, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778555718307840, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778555718307840, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778591755767808, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778591755767808, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778591755767808, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778591755767808, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778591755767808, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778635305226240, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778635305226240, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778635305226240, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778635305226240, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778635305226240, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778679022456832, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778679022456832, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778679022456832, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778679022456832, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778679022456832, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778739210719232, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778739210719232, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778739210719232, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778739210719232, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778739210719232, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778762262614016, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778762262614016, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778762262614016, 25);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778762262614016, 26);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742778762262614016, 27);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782292759285760, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782292759285760, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782292759285760, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782353668968448, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782353668968448, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782353668968448, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782403744763904, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782403744763904, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782403744763904, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782480827682816, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782480827682816, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782480827682816, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782519096512512, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782519096512512, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782519096512512, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782567041601536, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782567041601536, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782567041601536, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782666215919616, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782666215919616, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782666215919616, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782691293663232, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782691293663232, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782691293663232, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782713640914944, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782713640914944, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782713640914944, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782735648428032, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782735648428032, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782735648428032, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782757140041728, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782757140041728, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782757140041728, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782787267727360, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782787267727360, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782787267727360, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782819039580160, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782819039580160, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782819039580160, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782862601621504, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782862601621504, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782862601621504, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782884420390912, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782884420390912, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782884420390912, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782905920393216, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782905920393216, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782905920393216, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782931493064704, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782931493064704, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782931493064704, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782962010820608, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782962010820608, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782962010820608, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782986295840768, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782986295840768, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742782986295840768, 23);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742783006780821504, 8);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742783006780821504, 22);
INSERT INTO `picture_tag_relation` (`img_id`, `tag_id`) VALUES (1742783006780821504, 23);


# 图片地址
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (1, 1742756602617925632, '244d05e7-bbb5-4145-a369-e7749af0996a.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (2, 1742756759409397760, '6dd6126c-bfe1-4708-8fbf-a992f5fb5530.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (3, 1742756902825234432, '440e3c63-bada-48b0-9031-8129a677b532.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (4, 1742757141145587712, 'f3d330ad-1946-4576-8cf7-ecc3caa6e405.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (5, 1742757544436305920, 'bacdcf10-348f-4968-a7e3-51f0ff6b7d35.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (6, 1742758152388087808, '5db65058-2bd4-4a5a-a1ae-6943f9524a6d.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (7, 1742758211792015360, '0ea07595-26c2-4907-945c-50245f550ab1.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (8, 1742758653531918336, '6c0c5a34-c514-4df9-8518-bc688f5f608b.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (9, 1742758991127252992, '9ec9bdd2-57ee-423c-b4c8-a1427510f0e9.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (10, 1742759260468678656, '58159d76-ef4b-409a-b3b7-d41660f3e8f1.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (11, 1742760239595393024, '36cf8c3a-5808-479a-98aa-644b0355029e.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (12, 1742764692629229568, '6c0b2507-a3fc-44de-9728-f583dc87d666.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (13, 1742764726439514112, '638d5b82-c40a-4215-a8da-a8c95d35717a.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (14, 1742764772656549888, 'f93d3feb-c8da-4363-a5d8-8070619448e4.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (15, 1742764857024974848, '86ef2579-c1b5-439a-95e6-d919518714cd.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (16, 1742764935861112832, '2956ee3a-7821-4c3e-90fa-4943f9271e0d.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (17, 1742765025438863360, '4153e945-721d-449d-b9fa-9bef8f635557.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (18, 1742765172734431232, '827333c2-49a1-4bfc-b1c0-35cedb2ba051.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (19, 1742765521692135424, '4d226f77-ef43-4741-8c29-94fa6b7c2021.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (20, 1742765657856020480, 'e9646884-1721-44ee-b658-2d25db65b14d.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (21, 1742765787225133056, '84169153-da76-40ce-acc2-5c533023a6ea.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (22, 1742765813930266624, '75d0e7e1-f072-4a5d-ac43-9c5ea58b75e2.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (23, 1742765846603894784, '293f8515-731c-47bc-b5af-48d4b2d2383e.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (24, 1742765888551129088, '132ae0fb-a2e4-4d43-a380-2441a4100ae8.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (25, 1742765915604389888, 'fd005ea2-92de-44bf-8709-6843bf7dfee6.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (26, 1742765949255290880, 'e099a222-6736-4daf-ab6c-82d791d6393e.jpg');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (27, 1742775743798185984, '45ab774e-d9e2-4894-a1a8-2476834fa6d1.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (28, 1742777260756307968, 'e3a6e917-f844-4e0c-899e-9424be985b11.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (29, 1742777282105315328, 'cf1f7921-58db-46a0-bebe-c46acc8b2ec6.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (30, 1742777304968466432, '99aee398-3fd0-4e59-84d8-e7a04e679259.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (31, 1742777327047282688, '0f377e95-52cc-4347-8329-22373ba6b2b2.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (32, 1742777347662286848, 'b1329ed2-c87d-40bf-a0f9-cd1d1ce6a510.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (33, 1742777383028658176, '92550cef-00dd-4e2d-874d-35824cc216a9.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (34, 1742777416511787008, '9ec1aa37-365e-4335-a131-47e39e6a4be4.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (35, 1742777446840799232, '7cfef303-af9b-43e4-9c84-269aead1229a.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (36, 1742777509411426304, 'de3d8e90-c874-4605-9ce5-5ee352555dd1.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (37, 1742777566097444864, '9981e82b-1236-40ee-83be-5a41ad004e57.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (38, 1742777657994645504, '0e521042-e1e7-4d79-bd3b-3f92e16407d3.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (39, 1742777680207679488, '2379e8c2-7b42-4fd0-826b-5783538dfd30.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (40, 1742777697949585408, '9489be5a-84b0-41aa-958a-fc24b393a05e.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (41, 1742777729935347712, '10b5938c-d1c3-4a50-a232-c5ad40c1a4a8.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (42, 1742777751724756992, 'bb0c6e58-4570-4612-8238-7d03b614b34e.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (43, 1742777795236466688, '5552256b-665f-41fe-9750-cd4a2e4b15d7.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (44, 1742777838492323840, '7e62bb19-61c9-4bf2-8b31-06b086596bb1.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (45, 1742777870847184896, 'c8b8b57a-1315-49ed-9b1a-eca4ffb8f84b.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (46, 1742777889377619968, 'd74b7039-c01e-4347-8333-dc499856d56f.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (47, 1742777909103431680, '3a54eab7-bdd7-4484-959f-e3aded964a61.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (48, 1742777953269452800, '7faf01b9-4328-4197-a69c-1df148756759.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (49, 1742777968977121280, '41f4a846-705f-4f99-9299-6978d3f35abf.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (50, 1742777986748387328, '6c37515e-e2b6-46d3-8269-5164ebe61df1.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (51, 1742778006818131968, '3bc2a98e-6c73-4e7b-984c-23e8518450d0.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (52, 1742778029140217856, '5c5e3676-05d0-4ff5-9e3c-3ae0d952c6a9.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (53, 1742778063818723328, '5437426f-bd25-4e69-bd2f-152dec071f68.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (54, 1742778082722451456, 'bab22e01-a603-4224-844a-7b972e2939c0.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (55, 1742778102439874560, 'aad16ce6-1332-461e-b62e-1bd343d8a2ec.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (56, 1742778123600138240, '01f965b8-3e4b-436c-8b04-451003ede1a7.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (57, 1742778163181785088, 'b7c969d5-731a-41aa-993e-e289776834ac.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (58, 1742778187521331200, '89d62d13-91f1-4eef-aaae-ad27a1c3fad1.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (59, 1742778211617607680, '2696a23e-ce36-4dfa-828c-11693df4d46a.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (60, 1742778237576155136, '39a8f395-7a98-483f-b2d7-90b8a5425e06.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (61, 1742778262637121536, '46771e06-2ceb-45d4-99bd-a8eb170293a2.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (62, 1742778303477059584, '9a6966bb-7f8e-453b-9547-09aad590b162.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (63, 1742778322535976960, '66ba5a24-b3b7-4011-9bf6-342bc1507ee7.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (64, 1742778343629131776, '8472d4ab-3209-432d-8f62-7cefd0c84a5b.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (65, 1742778369210191872, 'b874ef6f-92b1-4413-ab60-1e1d6cc9d932.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (66, 1742778412772233216, '241911a5-92e5-4152-86eb-aa053451caa5.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (67, 1742778435211759616, 'a37d8123-ea86-4f53-a568-1e94480cd6f0.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (68, 1742778473514143744, '5998107e-849f-4976-a9aa-2df7e54b09f2.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (69, 1742778522935627776, '1651c1c5-fb92-4d79-8056-89c14b3c787d.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (70, 1742778555718307840, 'f855b505-b46f-4161-9ab2-3e1f831b7940.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (71, 1742778591755767808, 'aac0c620-9ca7-43f2-b809-e2668666cc0d.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (72, 1742778635305226240, '34f6653f-d5d5-48d5-b233-04b7118a441b.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (73, 1742778679022456832, '230ae1b6-b3e4-4135-9b9d-56454a50cb6e.webp');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (74, 1742778739210719232, 'c8c0af69-4943-4ff1-94bd-b8a37aae5ddd.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (75, 1742778762262614016, 'a45fd393-6334-4306-b542-9fc3e3bcc5a1.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (76, 1742782292759285760, '504f8cc4-ec54-443a-9133-a0cd3c0afaee.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (77, 1742782353668968448, 'accf217a-e2b8-4409-bead-ed870c748298.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (78, 1742782403744763904, 'e3a5f04e-71d7-4354-81c8-5be33c11059a.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (79, 1742782480827682816, '3461a3b3-ce0a-4314-a0b4-6caaf2c0dd56.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (80, 1742782519096512512, '7f6f77c4-48da-419d-bff2-9ee14493918d.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (81, 1742782567041601536, '3cf0b185-68b4-4984-9837-c4a7013b4914.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (82, 1742782666215919616, '68be38b2-378c-40e2-9a2e-7e046662bb41.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (83, 1742782691293663232, '18eeed92-203c-4c2c-8ca1-46cd980e6b87.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (84, 1742782713640914944, 'ce577af2-c156-44f9-a4db-6bef1a8dadcb.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (85, 1742782735648428032, '7d1b9094-b1e8-45ee-b6c4-cabefed7e744.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (86, 1742782757140041728, '8b8c1fe1-120d-4958-a57d-897108a6bcfc.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (87, 1742782787267727360, '7e7b661d-441c-4602-a64d-a08f93e834a7.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (88, 1742782819039580160, '197276c7-dc04-43ca-a506-5e471f727648.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (89, 1742782862601621504, 'dde59ed7-fc5d-4bf7-bf34-44d209e5179c.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (90, 1742782884420390912, 'cab92140-c07c-4347-a2a9-98b683130f6f.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (91, 1742782905920393216, 'e185ce54-2aeb-4c3d-935e-c294b0c8b0ed.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (92, 1742782931493064704, 'f0215334-f418-411a-bf23-7d8afd245d19.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (93, 1742782962010820608, '847c1f13-3e40-458b-a8ce-1bd990e70fd4.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (94, 1742782986295840768, 'cee4f266-ec32-44e4-adad-b7babd5d61a3.png');
INSERT INTO `picture_file` (`id`, `img_id`, `img_addr`) VALUES (95, 1742783006780821504, 'b04cea21-61a7-42f7-a962-d2d69e48e999.png');


# 关键词
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (19, 'cmd');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (15, 'java');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (18, 'ping');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (10, 'postman');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (11, '代码');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (4, '作业');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (12, '安卓');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (5, '安卓作业');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (23, '巴萨');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (22, '巴萨罗那');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (17, '广告');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (6, '截图');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (20, '控制台');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (13, '效果图');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (21, '明星');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (25, '梅西');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (1, '欧陆风云');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (2, '游戏');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (14, '游戏制作');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (27, '潘帕斯雄鹰');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (3, '罗马帝国');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (7, '贝尔');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (8, '足球');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (9, '足球明星');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (26, '阿根廷');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (16, '预览图');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (24, '风景图');
