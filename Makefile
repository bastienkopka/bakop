DOCKER_COMPOSE=docker compose

# Include .env file
ifneq ("$(wildcard ./.env)","")
	include ./.env
else
	include ./conf/env/init.env
endif

docker-init:
	@bash ./scripts/init.sh

docker-up:
	$(DOCKER_COMPOSE) up -d --remove-orphans --build

docker-install: docker-init docker-up
	$(DOCKER_COMPOSE) exec -u $(DOCKER_USERNAME) php bash ./scripts/install.sh

docker-stop:
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) down

docker-shell:
	$(DOCKER_COMPOSE) exec -u $(DOCKER_USERNAME) php sh

### Quality tools.
quality-phpcs:
	$(DOCKER_COMPOSE) exec -u $(DOCKER_USERNAME) php ./vendor/bin/phpcs \
		--standard=./scripts/tools/phpcs/phpcs.xml.dist

quality-phpstan:
	$(DOCKER_COMPOSE) exec -u $(DOCKER_USERNAME) php ./vendor/bin/phpstan \
		analyse \
		--configuration ./scripts/tools/phpstan/phpstan.neon

run-phpunit:
	$(DOCKER_COMPOSE) exec php bash ./scripts/run-phpunit.sh
