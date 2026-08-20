SET NAMES utf8mb4;

DROP TABLE IF EXISTS `notification_template`;
CREATE TABLE `notification_template` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_name` VARCHAR(100) NOT NULL DEFAULT '',
  `template_code` VARCHAR(50) NOT NULL DEFAULT '',
  `scene` VARCHAR(50) NOT NULL DEFAULT '',
  `channel` VARCHAR(20) NOT NULL DEFAULT 'wechat',
  `content_template` TEXT,
  `wx_template_id` VARCHAR(100) NOT NULL DEFAULT '',
  `is_enabled` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_template_code` (`site_id`, `template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知模板表';

DROP TABLE IF EXISTS `notification_log`;
CREATE TABLE `notification_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `template_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `scene` VARCHAR(50) NOT NULL DEFAULT '',
  `content` TEXT,
  `send_status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `error_msg` VARCHAR(500) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_scene` (`scene`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知发送日志表';

DROP TABLE IF EXISTS `backup_record`;
CREATE TABLE `backup_record` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `backup_name` VARCHAR(100) NOT NULL DEFAULT '',
  `backup_type` VARCHAR(20) NOT NULL DEFAULT '',
  `backup_size` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `file_path` VARCHAR(500) NOT NULL DEFAULT '',
  `tables_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_backup_type` (`backup_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='备份记录表';

DROP TABLE IF EXISTS `storage_cleanup_log`;
CREATE TABLE `storage_cleanup_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_path` VARCHAR(500) NOT NULL DEFAULT '',
  `file_size` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `reason` VARCHAR(255) NOT NULL DEFAULT '',
  `admin_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='存储清理日志表';

DROP TABLE IF EXISTS `image_audit_log`;
CREATE TABLE `image_audit_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(500) NOT NULL DEFAULT '',
  `audit_source` VARCHAR(30) NOT NULL DEFAULT '',
  `audit_result` VARCHAR(20) NOT NULL DEFAULT '',
  `confidence` DECIMAL(5,2) NOT NULL DEFAULT 0,
  `detail` JSON DEFAULT NULL,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_audit_result` (`audit_result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片审核日志表';
