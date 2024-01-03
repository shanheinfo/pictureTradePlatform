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
-- 创建前缀索引
CREATE INDEX mail_index ON picture_user (user_mail(9));
-- 创建前缀索引
CREATE INDEX name_index ON picture_user (user_name(10));

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
     `tag_name` varchar(255) NOT NULL COMMENT '标签名称',
     PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=Compact COMMENT '标签表';

#----------------------
# 图片标签关联表
#----------------------
CREATE TABLE IF NOT EXISTS `picture_tag_relation` (
      `img_id` bigint(20) UNSIGNED NOT NULL COMMENT '图片id',
      `tag_id` bigint(20) UNSIGNED NOT NULL COMMENT '标签id',
      PRIMARY KEY (`img_id`, `tag_id`) USING BTREE,
      FOREIGN KEY (`img_id`) REFERENCES `picture_info` (`img_id`) ON DELETE CASCADE,
      FOREIGN KEY (`tag_id`) REFERENCES `picture_tag` (`tag_id`) ON DELETE CASCADE
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