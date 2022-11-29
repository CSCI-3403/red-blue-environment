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
      name TEXT,
      number TEXT,
      exp TEXT,
      code TEXT
   );

   INSERT INTO reviews VALUES ('alex', 'I ordered a hat but I got a cat instead. 10/10 no regrets', 'attachments/oliver.jpg');
   INSERT INTO reviews VALUES ('alice', 'This is the best website since Yahoo Answers', NULL);
   INSERT INTO creditcards VALUES ('alice', '123456789012', '10/26', '152');
EOSQL