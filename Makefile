.DEFAULT_GOAL := help
.PHONY: help up
.ONESHELL:

WARNING='\033[0;33m'
INFO='\033[0;32m'
NC='\033[0m'

help: ## show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ -> 🐳 Docker Utils: start/stop, ...
up: ## start all containers
	docker compose up -d
	$(MAKE) kibana-up

down: ## stop all the containers
	docker compose down --remove-orphans

logs: ## tail on docker logs
	docker compose logs -f

##@ -> 🔩️ Start services
kibana-up: ## start kibana
	./kibana/setup-kibana.sh

stress-test: ## run stress test simulating 200, 404, and 500 errors
	./stress-test/stress-test.sh

stress-test-500: ## run stress test simulating 500 errors only
	./stress-test/stress-test-500.sh
