RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [[ true ]]; then
    status="${RED}No${NC}"
else
    status="${GREEN}Yes${NC}"
fi

printf "Thing we are testing: ${status}\n"