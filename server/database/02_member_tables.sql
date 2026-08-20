SET NAMES utf8mb4;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `unionid` VARCHAR(64) NOT NULL DEFAULT '',
  `openid_customer` VARCHAR(64) NOT NULL DEFAULT '',
  `openid_model` VARCHAR(64) NOT NULL DEFAULT '',
  `nickname` VARCHAR(100) NOT NULL DEFAULT '',
  `avatar` VARCHAR(255) NOT NULL DEFAULT '',
  `phone` VARCHAR(20) NOT NULL DEFAULT '',
  `is_phone_verified` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `phone_bind_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `identity_tags` VARCHAR(50) NOT NULL DEFAULT '',
  `verify_status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `verify_reward_granted` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `vip_status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `vip_expire_time` DATETIME DEFAULT NULL,
  `score` INT UNSIGNED NOT NULL DEFAULT 0,
  `score_frozen` INT UNSIGNED NOT NULL DEFAULT 0,
  `invite_code` VARCHAR(32) NOT NULL DEFAULT '',
  `invite_user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `custom_tags` VARCHAR(255) NOT NULL DEFAULT '',
  `real_name` VARCHAR(50) NOT NULL DEFAULT '',
  `id_card` VARCHAR(50) NOT NULL DEFAULT '',
  `unlock_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `service_area` JSON DEFAULT NULL,
  `cancel_status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `cancel_apply_time` DATETIME DEFAULT NULL,
  `cancel_complete_time` DATETIME DEFAULT NULL,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_unionid` (`site_id`, `unionid`),
  UNIQUE KEY `uk_site_phone` (`site_id`, `phone`),
  KEY `idx_verify_status` (`verify_status`),
  KEY `idx_vip_status` (`vip_status`),
  KEY `idx_status` (`status`),
  KEY `idx_invite_code` (`invite_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户主表';

DROP TABLE IF EXISTS `user_custom_tag`;
CREATE TABLE `user_custom_tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(50) NOT NULL DEFAULT '',
  `tag_color` VARCHAR(20) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tag_name` (`site_id`, `tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义标签表';

DROP TABLE IF EXISTS `user_cancel_log`;
CREATE TABLE `user_cancel_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `action` VARCHAR(20) NOT NULL DEFAULT '',
  `reason` VARCHAR(500) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='注销日志表';

DROP TABLE IF EXISTS `user_score_frozen_log`;
CREATE TABLE `user_score_frozen_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `admin_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `action` VARCHAR(20) NOT NULL DEFAULT '',
  `amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `reason` VARCHAR(500) NOT NULL DEFAULT '',
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分冻结日志表';
