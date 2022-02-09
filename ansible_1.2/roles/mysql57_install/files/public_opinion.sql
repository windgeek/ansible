-- MySQL dump 10.13  Distrib 5.6.39, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: public_opinion
-- ------------------------------------------------------
-- Server version	5.6.39-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `http_job_task`
--

DROP TABLE IF EXISTS `http_job_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `http_job_task` (
  `id` varchar(50) NOT NULL,
  `type` int(10) DEFAULT NULL COMMENT '类型',
  `param` text COMMENT '入参',
  `url` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `status` int(10) DEFAULT NULL COMMENT '0 待处理 1处理中 2成功 3失败',
  `create_time` date DEFAULT NULL COMMENT '创建时间',
  `update_time` date DEFAULT NULL COMMENT '更新时间',
  `del` tinyint(1) DEFAULT NULL COMMENT '删除标识 0未删除 1删除',
  PRIMARY KEY (`id`),
  KEY `INDEX_TYPE` (`type`) USING BTREE,
  KEY `INDEX_STATUS` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `influence_rank`
--

DROP TABLE IF EXISTS `influence_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influence_rank` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `resource_id` varchar(45) NOT NULL COMMENT '账号、人物Id',
  `type` int(1) NOT NULL COMMENT '类型0账号1人物2话题',
  `count_date` varchar(10) NOT NULL,
  `influence` double NOT NULL DEFAULT '0' COMMENT '影响力',
  `rank` int(11) NOT NULL COMMENT '当天排序号',
  `follow_count` int(11) DEFAULT '0',
  `post_count` int(11) DEFAULT '0',
  `like_count` int(11) DEFAULT '0',
  `share_count` int(11) DEFAULT '0',
  `comment_count` int(11) DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`),
  KEY `index2` (`resource_id`,`type`,`count_date`)
) ENGINE=InnoDB AUTO_INCREMENT=243295 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_account`
--

DROP TABLE IF EXISTS `monitor_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_account` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `monitor_user_id` bigint(19) DEFAULT NULL COMMENT '监控用户id（新建为空，只可以关联到一个MonitorUser）',
  `account` varchar(256) DEFAULT NULL COMMENT '账号/主页地址',
  `type` int(11) NOT NULL COMMENT '类型\n0Facebook1Twitter2ins3vk',
  `account_id` varchar(200) DEFAULT NULL COMMENT '账号id（社交软件内唯一标识）',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `account_name` varchar(200) DEFAULT NULL COMMENT '账号名',
  `pic` varchar(500) DEFAULT NULL COMMENT '头像',
  `like_count` int(11) DEFAULT '0' COMMENT '点赞数量',
  `follow_count` int(11) DEFAULT '0' COMMENT '粉丝数量',
  `post_count` int(11) DEFAULT '0' COMMENT '帖子数量',
  `influence` double DEFAULT '0' COMMENT '影响力指数',
  `url_type` varchar(256) DEFAULT NULL COMMENT 'url 类型',
  `visible_range` int(1) DEFAULT NULL COMMENT '可见范围 0:公开 1:部分公开 2:私有',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `verification` int(1) DEFAULT '1' COMMENT '认证 0:YES 1:NO',
  `other_info` varchar(1000) DEFAULT NULL COMMENT '其它信息',
  `status` int(11) DEFAULT '0' COMMENT '预留，监控级别',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) NOT NULL COMMENT '创建者',
  `create_user_id` varchar(45) NOT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3689 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_group`
--

DROP TABLE IF EXISTS `monitor_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_group` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(200) NOT NULL COMMENT '组名',
  `pic` varchar(256) DEFAULT NULL COMMENT '头像',
  `influence` double DEFAULT '0' COMMENT '影响力指数',
  `description` varchar(1024) DEFAULT '' COMMENT '描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_group_res`
--

DROP TABLE IF EXISTS `monitor_group_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_group_res` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tag_id` bigint(19) NOT NULL COMMENT '标签id',
  `resource_id` bigint(19) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`),
  KEY `idx_collect_user_id` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1309 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_sensitive_word`
--

DROP TABLE IF EXISTS `monitor_sensitive_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_sensitive_word` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `word` varchar(100) NOT NULL COMMENT '敏感词',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_collect_user_id` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=1123 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_tag`
--

DROP TABLE IF EXISTS `monitor_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_tag` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(100) NOT NULL COMMENT '标签名称',
  `color` varchar(45) NOT NULL COMMENT '标签颜色',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '标签类型，0账号1用户2话题',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_collect_user_id` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_tag_res`
--

DROP TABLE IF EXISTS `monitor_tag_res`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_tag_res` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tag_id` bigint(19) NOT NULL COMMENT '标签id',
  `resource_id` bigint(19) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`),
  KEY `idx_collect_user_id` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1367 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_topic`
--

DROP TABLE IF EXISTS `monitor_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_topic` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `topic_id` varchar(100) DEFAULT NULL COMMENT '外部调用必填',
  `name` varchar(256) NOT NULL COMMENT '话题名称',
  `keyword` varchar(256) NOT NULL COMMENT '话题关键字 逗号隔开',
  `influence` double(11,2) DEFAULT '0.00' COMMENT '影响力指数',
  `post_count` int(11) DEFAULT '0' COMMENT '帖子数量',
  `like_count` int(11) DEFAULT '0' COMMENT '点赞数量',
  `share_count` int(11) DEFAULT '0' COMMENT '分享数量',
  `comment_count` int(11) DEFAULT '0' COMMENT '评论数量',
  `status` int(1) DEFAULT '0' COMMENT '状态  0:监控 1:不监控',
  `monitoring_start_time` datetime NOT NULL COMMENT '监控开始时间',
  `monitoring_end_time` datetime NOT NULL COMMENT '监控结束时间',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) NOT NULL COMMENT '创建者',
  `create_user_id` varchar(45) NOT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_user`
--

DROP TABLE IF EXISTS `monitor_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_user` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(200) NOT NULL COMMENT '姓名',
  `sex` int(1) DEFAULT '2' COMMENT '性别\n0女1男2未知',
  `pic` varchar(256) DEFAULT NULL COMMENT '头像',
  `influence` double DEFAULT '0' COMMENT '影响力指数',
  `phone` varchar(256) DEFAULT NULL COMMENT '电话\n ["a","b"]',
  `email` varchar(1024) DEFAULT NULL COMMENT '邮箱\n支持多个，半角逗号分隔 ["a","b"]',
  `birthday` varchar(32) DEFAULT NULL COMMENT '生日',
  `nationality` varchar(200) DEFAULT NULL COMMENT '国籍',
  `hometown` varchar(100) DEFAULT NULL COMMENT '籍贯(家乡)',
  `current_city` varchar(200) DEFAULT NULL COMMENT '所在城市',
  `mailing_address` varchar(255) DEFAULT NULL COMMENT '通讯地址 ["a","b"]',
  `personal_website` varchar(255) DEFAULT NULL COMMENT '个人网站 ["a","b"]',
  `relationship_status` int(1) DEFAULT NULL COMMENT '感情状态',
  `places_lived` varchar(255) DEFAULT NULL COMMENT '住过的地方 [{"place":"aaa","timePeriod":"bbb"},{"place":"ccc","timePeriod":"ddd"}]',
  `workplace` varchar(255) DEFAULT NULL COMMENT '工作地 [{"company":"aaa","timePeriod":"bbb"},{"company":"ccc","timePeriod":"ddd"}]',
  `college` varchar(255) DEFAULT NULL COMMENT '大学 [{"college":"aaa","timePeriod":"bbb"},{"college":"ccc","timePeriod":"ddd"}]',
  `high_school` varchar(255) DEFAULT NULL COMMENT '[{"highSchool":"aaa","timePeriod":"bbb"},{"highSchool":"ccc","timePeriod":"ddd"}]',
  `family_member` varchar(255) DEFAULT NULL COMMENT '家庭成员 [{"relationship":"aaa","name":"bbb"},{"relationship":"ccc","name":"ddd"}]',
  `description` varchar(1024) DEFAULT '' COMMENT '描述',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态\n预留，后续设置监控级别',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_user_pic`
--

DROP TABLE IF EXISTS `monitor_user_pic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_user_pic` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `monitor_user_id` bigint(19) NOT NULL COMMENT '被监测用户ID',
  `pic_name` varchar(200) DEFAULT NULL COMMENT '图片名称',
  `pic` varchar(256) NOT NULL COMMENT '图片地址',
  `description` varchar(500) DEFAULT NULL COMMENT '图片描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_collect`
--

DROP TABLE IF EXISTS `user_collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_collect` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` varchar(45) NOT NULL COMMENT '用户id',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '资源类型，0账号1用户2话题',
  `resource_id` varchar(45) NOT NULL COMMENT '资源id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` varchar(200) DEFAULT NULL COMMENT '创建者',
  `create_user_id` varchar(45) DEFAULT NULL COMMENT '创建者ID',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` varchar(200) DEFAULT NULL COMMENT '更新者',
  `update_user_id` varchar(45) DEFAULT NULL COMMENT '更新者ID',
  `del` int(11) NOT NULL DEFAULT '0' COMMENT '删除标识\n0未删除1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_collect_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-16 10:47:42
