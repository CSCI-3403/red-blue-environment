#!/bin/bash
set -e

mysql <<-EOSQL
   CREATE USER 'dbadmin'@'%' IDENTIFIED BY 'dbaccess';
   GRANT ALL PRIVILEGES ON *.* TO 'dbadmin'@'%' WITH GRANT OPTION;

   CREATE DATABASE IF NOT EXISTS hatdb;
   USE hatdb;

   CREATE TABLE reviews (
      name TEXT,
      message TEXT,
      attachment TEXT
   );

   CREATE TABLE contact (
      name TEXT,
      email TEXT,
      message TEXT
   );

   CREATE TABLE creditcards (
      number TEXT,
      exp TEXT,
      code TEXT
   );

   INSERT INTO reviews VALUES ('alice', 'Test message', 'test.pdf');
   INSERT INTO creditcards VALUES ('123456789012', '10/26', '152');
EOSQL