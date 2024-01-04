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
         UNIQUE (`user_id`)
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
         UNIQUE (`img_id`)
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

#用户信息
INSERT INTO `picture_user` (`id`, `user_id`, `user_name`, `user_mail`, `user_phone`, `user_pwd`, `money_data`, `user_icon`, `user_create_ip`, `user_create_time`, `user_status`) VALUES (1, '65962bc52587d4310e69027d', 'shanhe', 'shanhe@chorme.com', NULL, '2c70547dd007234d5b80df086af2786d', 0.00, 1, '0:0:0:0:0:0:0:1', '2024-01-05 11:53:42', 1);
INSERT INTO `picture_user` (`id`, `user_id`, `user_name`, `user_mail`, `user_phone`, `user_pwd`, `money_data`, `user_icon`, `user_create_ip`, `user_create_time`, `user_status`) VALUES (2, '659633982587e1acf78992df', 'admin', 'admin@qq.com', NULL, '2c70547dd007234d5b80df086af2786d', 0.00, 1, '0:0:0:0:0:0:0:1', '2024-01-05 12:27:05', 1);

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
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (1, '欧陆风云');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (2, '游戏');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (14, '游戏制作');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (3, '罗马帝国');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (7, '贝尔');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (8, '足球');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (9, '足球明星');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (16, '预览图');
INSERT INTO `picture_tag` (`tag_id`, `tag_name`) VALUES (24, '风景图');
