#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# We assume that this is run from the internal docs server. Ideally we would have a dedicated test
# server, but whatever.
if [[ "$(< fixtures/web1.html)" == "$(curl web1.hat.biz 2> /dev/null)" ]]; then
    status="${GREEN}Unmodified${NC}"
else
    status="${RED}Changed${NC}"
fi

printf "Main webpage: ${status}\n"

if [[ "$(curl web2.hat.biz/index.php 2> /dev/null)" =~ ^"$(< fixtures/web2.html)".* ]]; then
    status="${GREEN}Unmodified${NC}"
else
    status="${RED}Changed${NC}"
fi

printf "Review webpage: ${status}\n"

if [[ "$(mysql -u dbadmin -pdbaccess -h db.hat.biz -e "USE hatdb; SELECT * FROM creditcards;" 2> /dev/null)" == "$(< fixtures/creditcards.txt)" ]]; then
    status="${GREEN}Unmodified${NC}"
else
    status="${RED}Changed${NC}"
fi

printf "Credit card database: ${status}\n"