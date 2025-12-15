SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS `concept_platform` DEFAULT CHARSET utf8mb4;
USE `concept_platform`;

-- 2. 表结构：用户表
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '账号',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `real_name` varchar(50) NOT NULL COMMENT '姓名',
  `role` varchar(20) NOT NULL COMMENT '角色',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 3. 表结构：项目表 (包含 tech_domain 字段)
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(200) NOT NULL COMMENT '项目名称',
  `tech_domain` varchar(50) DEFAULT NULL COMMENT '技术领域',
  `description` text COMMENT '项目简介',
  `status` int DEFAULT '0' COMMENT '0-草稿, 1-待初审, 2-已入库, 9-驳回',
  `applicant_id` int NOT NULL COMMENT '申报人ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目表';

-- 4. 初始化数据：用户
INSERT INTO `sys_user` (`username`, `password`, `real_name`, `role`) VALUES 
('student', '123456', '张同学', 'APPLICANT'),
('expert', '123456', '李教授', 'EXPERT'),
('admin', '123456', '王老师', 'ADMIN');

-- 5. 初始化数据：项目
INSERT INTO `project` (`project_name`, `tech_domain`, `description`, `status`, `applicant_id`) VALUES 
('基于AI的数据库助手', '人工智能/数据库', '这是一个非常有前景的项目...', 1, 1);

SET FOREIGN_KEY_CHECKS = 1;