SET NAMES utf8mb4;

DROP TABLE IF EXISTS `agreement`;
CREATE TABLE `agreement` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `agreement_type` VARCHAR(50) NOT NULL DEFAULT '',
  `title` VARCHAR(100) NOT NULL DEFAULT '',
  `version` VARCHAR(20) NOT NULL DEFAULT '',
  `content` LONGTEXT,
  `is_effective` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `force_resign` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_agreement_type` (`site_id`, `agreement_type`),
  KEY `idx_is_effective` (`is_effective`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='协议主表';

DROP TABLE IF EXISTS `agreement_version`;
CREATE TABLE `agreement_version` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `agreement_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `version` VARCHAR(20) NOT NULL DEFAULT '',
  `content` LONGTEXT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_agreement_id` (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='协议版本表';

DROP TABLE IF EXISTS `user_agreement_log`;
CREATE TABLE `user_agreement_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `agreement_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `version` VARCHAR(20) NOT NULL DEFAULT '',
  `agree_type` VARCHAR(20) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_agreement_id` (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户同意协议记录表';
