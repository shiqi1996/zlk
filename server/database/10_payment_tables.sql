SET NAMES utf8mb4;

DROP TABLE IF EXISTS `pay_channel`;
CREATE TABLE `pay_channel` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `channel_code` VARCHAR(30) NOT NULL DEFAULT '',
  `channel_name` VARCHAR(50) NOT NULL DEFAULT '',
  `is_enabled` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `sort` INT UNSIGNED NOT NULL DEFAULT 0,
  `config` JSON DEFAULT NULL,
  `fee_rate` DECIMAL(5,4) NOT NULL DEFAULT 0.0000,
  `single_limit_min` INT UNSIGNED NOT NULL DEFAULT 0,
  `single_limit_max` INT UNSIGNED NOT NULL DEFAULT 0,
  `daily_limit` INT UNSIGNED NOT NULL DEFAULT 0,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_time` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_channel` (`site_id`, `channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付通道配置表';

DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `order_no` VARCHAR(64) NOT NULL DEFAULT '',
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `channel_code` VARCHAR(30) NOT NULL DEFAULT '',
  `trade_no` VARCHAR(128) NOT NULL DEFAULT '',
  `amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `pay_status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `business_type` VARCHAR(30) NOT NULL DEFAULT '',
  `business_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `pay_time` DATETIME DEFAULT NULL,
  `refund_amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `notify_data` JSON DEFAULT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_channel_code` (`channel_code`),
  KEY `idx_trade_no` (`trade_no`),
  KEY `idx_pay_status` (`pay_status`),
  KEY `idx_business` (`business_type`, `business_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付订单表';

DROP TABLE IF EXISTS `pay_refund`;
CREATE TABLE `pay_refund` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `refund_no` VARCHAR(64) NOT NULL DEFAULT '',
  `order_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `refund_amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `reason` VARCHAR(255) NOT NULL DEFAULT '',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `channel_code` VARCHAR(30) NOT NULL DEFAULT '',
  `refund_time` DATETIME DEFAULT NULL,
  `admin_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_refund_no` (`refund_no`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款记录表';

DROP TABLE IF EXISTS `pay_reconciliation`;
CREATE TABLE `pay_reconciliation` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
  `reconcile_date` DATE DEFAULT NULL,
  `channel_code` VARCHAR(30) NOT NULL DEFAULT '',
  `local_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `local_amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `third_count` INT UNSIGNED NOT NULL DEFAULT 0,
  `third_amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `diff_count` INT NOT NULL DEFAULT 0,
  `diff_amount` INT NOT NULL DEFAULT 0,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_reconcile_date` (`reconcile_date`),
  KEY `idx_channel` (`channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对账记录表';
