#!/bin/bash
set -e

mysql <<-EOSQL
   CREATE USER dbadmin WITH PASSWORD 'dbadmin';

   CREATE DATABASE IF NOT EXISTS feedback;
   USE feedback;

   CREATE TABLE feedback (
      name TEXT,
      message TEXT,
      attachment TEXT
   );

   INSERT INTO feedback VALUES ('alice', 'Test message', 'test.pdf');

   GRANT * ON DATABASE sales TO dbadmin;
EOSQL