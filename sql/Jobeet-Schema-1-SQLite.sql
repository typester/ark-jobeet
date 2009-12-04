-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Dec  4 19:34:03 2009
-- 


BEGIN TRANSACTION;

--
-- Table: jobeet_affiliate
--
DROP TABLE jobeet_affiliate;

CREATE TABLE jobeet_affiliate (
  id INTEGER PRIMARY KEY NOT NULL,
  url VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  token VARCHAR(255) NOT NULL,
  is_active TINYINT NOT NULL DEFAULT '0',
  created_at DATETIME NOT NULL
);

CREATE UNIQUE INDEX jobeet_affiliate_email ON jobeet_affiliate (email);

--
-- Table: jobeet_category
--
DROP TABLE jobeet_category;

CREATE TABLE jobeet_category (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX jobeet_category_name ON jobeet_category (name);

--
-- Table: jobeet_job
--
DROP TABLE jobeet_job;

CREATE TABLE jobeet_job (
  id INTEGER PRIMARY KEY NOT NULL,
  category_id INTEGER NOT NULL,
  type VARCHAR(255),
  position VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  how_to_apply TEXT NOT NULL,
  token VARCHAR(255) NOT NULL,
  is_public TINYINT NOT NULL DEFAULT '1',
  is_activated TINYINT NOT NULL DEFAULT '0',
  email VARCHAR(255) NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

CREATE INDEX jobeet_job_idx_category_id ON jobeet_job (category_id);

CREATE UNIQUE INDEX jobeet_job_token ON jobeet_job (token);

--
-- Table: jobeet_category_affiliate
--
DROP TABLE jobeet_category_affiliate;

CREATE TABLE jobeet_category_affiliate (
  category_id INTEGER NOT NULL,
  affiliate_id INTEGER NOT NULL,
  PRIMARY KEY (category_id, affiliate_id)
);

CREATE INDEX jobeet_category_affiliate_idx_affiliate_id ON jobeet_category_affiliate (affiliate_id);

CREATE INDEX jobeet_category_affiliate_idx_category_id ON jobeet_category_affiliate (category_id);

COMMIT;
