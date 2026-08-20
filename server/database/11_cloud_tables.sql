SET NAMES utf8mb4;

DROP TABLE IF EXISTS `cloud_service_config`;
CREATE TABLE `cloud_service_config` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `service_code` VARCHAR(30) NOT NULL DEFAULT '',
  `service_name` VARCHAR(50) NOT NULL DEFAULT '',
  `is_enabled` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `access_key_id` VARCHAR(100) NOT NULL DEFAULT '',
  `access_key_secret` VARCHAR(200) NOT NULL DEFAULT '',
  `endpoint` VARCHAR(200) NOT NULL DEFAULT '',
  `extra_config` JSON DEFAULT NULL,
  `daily_limit` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_used` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_check_time` DATETIME DEFAULT NULL,
  `health_status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service` (`site_id`, `service_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云服务配置表';

DROP TABLE IF EXISTS `cloud_usage_log`;
CREATE TABLE `cloud_usage_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `service_code` VARCHAR(30) NOT NULL DEFAULT '',
  `call_date` DATE DEFAULT NULL,
  `call_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `success_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `fail_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `estimated_cost` DECIMAL(10,4) NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_service_date` (`service_code`, `call_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云服务调用量日志表';
