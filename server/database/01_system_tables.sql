SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `sys_site`;
CREATE TABLE `sys_site` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_name` VARCHAR(100) NOT NULL DEFAULT '',
  `site_code` VARCHAR(50) NOT NULL DEFAULT '',
  `domain` VARCHAR(200) NOT NULL DEFAULT '',
  `wildcard_domain` VARCHAR(200) NOT NULL DEFAULT '',
  `logo` VARCHAR(255) NOT NULL DEFAULT '',
  `contact_name` VARCHAR(50) NOT NULL DEFAULT '',
  `contact_phone` VARCHAR(20) NOT NULL DEFAULT '',
  `level` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '0停用 1正常 2到期',
  `expire_time` DATETIME DEFAULT NULL,
  `feature_switch` JSON DEFAULT NULL,
  `pay_config` JSON DEFAULT NULL,
  `sort` INT UNSIGNED NOT NULL DEFAULT 0,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_code` (`site_code`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分站信息表';

DROP TABLE IF EXISTS `sys_admin`;
CREATE TABLE `sys_admin` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL DEFAULT '',
  `password` VARCHAR(255) NOT NULL DEFAULT '',
  `real_name` VARCHAR(50) NOT NULL DEFAULT '',
  `avatar` VARCHAR(255) NOT NULL DEFAULT '',
  `phone` VARCHAR(20) NOT NULL DEFAULT '',
  `email` VARCHAR(100) NOT NULL DEFAULT '',
  `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `is_super` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `login_ip` VARCHAR(50) NOT NULL DEFAULT '',
  `login_time` DATETIME DEFAULT NULL,
  `login_fail_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `lock_time` DATETIME DEFAULT NULL,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员账号表';

DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL DEFAULT '',
  `role_code` VARCHAR(50) NOT NULL DEFAULT '',
  `description` VARCHAR(255) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `is_system` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `sort` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_code` (`site_id`, `role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `permission_code` VARCHAR(100) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_perm` (`role_id`, `permission_code`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限关联表';

DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `admin_name` VARCHAR(50) NOT NULL DEFAULT '',
  `module` VARCHAR(50) NOT NULL DEFAULT '',
  `action` VARCHAR(50) NOT NULL DEFAULT '',
  `method` VARCHAR(10) NOT NULL DEFAULT '',
  `url` VARCHAR(500) NOT NULL DEFAULT '',
  `params` JSON DEFAULT NULL,
  `ip` VARCHAR(50) NOT NULL DEFAULT '',
  `user_agent` VARCHAR(500) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_module` (`module`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

DROP TABLE IF EXISTS `sys_audit_log`;
CREATE TABLE `sys_audit_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `module` VARCHAR(50) NOT NULL DEFAULT '',
  `action` VARCHAR(50) NOT NULL DEFAULT '',
  `target_type` VARCHAR(50) NOT NULL DEFAULT '',
  `target_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `before_value` JSON DEFAULT NULL,
  `after_value` JSON DEFAULT NULL,
  `ip` VARCHAR(50) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_target` (`target_type`, `target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='敏感操作审计日志表';

INSERT INTO `sys_site` (`id`,`site_name`,`site_code`,`domain`,`level`,`status`) VALUES (1,'主站','main','',1,1);
INSERT INTO `sys_admin` (`username`,`password`,`real_name`,`role_id`,`site_id`,`is_super`,`status`) VALUES ('admin','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uhejRzFg8','超级管理员',1,1,1,1);
INSERT INTO `sys_role` (`id`,`role_name`,`role_code`,`site_id`,`is_system`,`status`) VALUES (1,'超级管理员','super_admin',1,1,1),(2,'运营岗','operator',1,1,1),(3,'审核岗','auditor',1,1,1),(4,'财务岗','finance',1,1,1);
