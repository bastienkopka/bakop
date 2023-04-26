#!/bin/bash

rm -rf app/sites/simpletest
mkdir -p app/sites/simpletest
chmod -R 0777 app/sites/simpletest
ls -l app/sites/simpletest

sudo -u "www-data" -E ./vendor/bin/phpunit --configuration /var/www/scripts/tools/phpunit/phpunit.xml
