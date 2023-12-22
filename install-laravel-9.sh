docker info > /dev/null 2>&1

# Ensure that Docker is running...
if [ $? -ne 0 ]; then
    echo "Docker is not running."

    exit 1
fi

docker run --rm \
    --pull=always \
    -v "$(pwd)":/opt \
    -w /opt \
    laravelsail/php82-composer:latest \
    bash -c "composer create-project laravel/laravel lvl9-clean 9.* && cd lvl9-clean && php ./artisan sail:install --with=mysql,redis,meilisearch,mailpit,selenium "

cd lvl9-clean

# Allow build with no additional services..
if [ "mysql redis meilisearch mailpit selenium" == "none" ]; then
    ./vendor/bin/sail build
else
    ./vendor/bin/sail pull mysql redis meilisearch mailpit selenium
    ./vendor/bin/sail build
fi

CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""

if sudo -n true 2>/dev/null; then
    sudo chown -R $USER: .
    echo -e "${BOLD}Get started with:${NC} cd lvl9-clean && ./vendor/bin/sail up"
else
    echo -e "${BOLD}Please provide your password so we can make some final adjustments to your application's permissions.${NC}"
    echo ""
    sudo chown -R $USER: .
    echo ""
    echo -e "${BOLD}Thank you! We hope you build something incredible. Dive in with:${NC} cd lvl9-clean && ./vendor/bin/sail up"
    echo ""
    echo ""
    echo "${LIGHT_CYAN} Change PHP version in ${NC} docker-compose.yml"
    echo "after that ${NC} ./vendor/bin/sail build --no-cache && ./vendor/bin/sail up"
    echo ""
    
fi