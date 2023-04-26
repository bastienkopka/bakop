# Requirements

Tested on Ubuntu 20.04 LTS and Ubuntu 22.04 LTS.

* [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)
* [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)
* Make (``sudo apt install make``)

If you are using a Ubuntu < 22.04 LTS, please modify the first line of Makefile by ``DOCKER_COMPOSE=docker-compose``
and in ./scripts/grumphp/grumphp.yml ``EXEC_GRUMPHP_COMMAND: docker-compose run -T --rm --no-deps php``


## Installation

To install the website from config :
```bash
  make docker-install
```
