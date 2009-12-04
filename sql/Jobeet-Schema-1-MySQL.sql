-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Dec  4 19:34:03 2009
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS `jobeet_affiliate`;

--
-- Table: `jobeet_affiliate`
--
CREATE TABLE `jobeet_affiliate` (
  `id` INTEGER unsigned NOT NULL auto_increment,
  `url` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `is_active` TINYINT NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE `jobeet_affiliate_email` (`email`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `jobeet_category`;

--
-- Table: `jobeet_category`
--
CREATE TABLE `jobeet_category` (
  `id` INTEGER unsigned NOT NULL auto_increment,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE `jobeet_category_name` (`name`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `jobeet_job`;

--
-- Table: `jobeet_job`
--
CREATE TABLE `jobeet_job` (
  `id` INTEGER unsigned NOT NULL auto_increment,
  `category_id` INTEGER unsigned NOT NULL,
  `type` VARCHAR(255),
  `position` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `description` text NOT NULL,
  `how_to_apply` text NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `is_public` TINYINT NOT NULL DEFAULT '1',
  `is_activated` TINYINT NOT NULL DEFAULT '0',
  `email` VARCHAR(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  INDEX jobeet_job_idx_category_id (`category_id`),
  PRIMARY KEY (`id`),
  UNIQUE `jobeet_job_token` (`token`),
  CONSTRAINT `jobeet_job_fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `jobeet_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `jobeet_category_affiliate`;

--
-- Table: `jobeet_category_affiliate`
--
CREATE TABLE `jobeet_category_affiliate` (
  `category_id` INTEGER unsigned NOT NULL,
  `affiliate_id` INTEGER unsigned NOT NULL,
  INDEX jobeet_category_affiliate_idx_affiliate_id (`affiliate_id`),
  INDEX jobeet_category_affiliate_idx_category_id (`category_id`),
  PRIMARY KEY (`category_id`, `affiliate_id`),
  CONSTRAINT `jobeet_category_affiliate_fk_affiliate_id` FOREIGN KEY (`affiliate_id`) REFERENCES `jobeet_affiliate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobeet_category_affiliate_fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `jobeet_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

SET foreign_key_checks=1;

