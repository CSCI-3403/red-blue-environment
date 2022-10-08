#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
   CREATE USER dev WITH PASSWORD '{flag1-internal-use-only}';
   CREATE USER alice WITH PASSWORD '{flag3-Sw0rdf1sh}';
   CREATE USER bob WITH PASSWORD '{flag2-L33T}';
   CREATE USER carol WITH PASSWORD 'letmein';

   CREATE TABLE customers (
      name TEXT
   );

   CREATE TABLE creditcards (
      customer TEXT,
      cardno TEXT
   );

   CREATE TABLE orders (
      name TEXT,
      product TEXT
   );

   INSERT INTO customers VALUES ('eve');
   INSERT INTO creditcards VALUES ('eve', '{flag5-test}');
   INSERT INTO orders VALUES ('eve', 'tiny-hat-1');

   GRANT CONNECT ON DATABASE sales TO dev, alice;
   GRANT SELECT ON customers,creditcards,orders TO dev, alice;
EOSQL