.PHONY: help
.DEFAULT_GOAL := help

help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
build: ## docker-compose build
	@docker-compose build
server: ## docker-compose run --rm --name %app_name%_rails_1 -p 3000:3000 rails
	@docker-compose run --rm --name %app_name%_rails_1 -p 3000:3000 rails
delete: ## docker conrainer rm %app_name%_rails_1
	@docker container rm %app_name%_rails_1
console: ## docker exec -it %app_name%_rails_1 /bin/bash
	@docker exec -it %app_name%_rails_1 /bin/bash    
dbconsole: ## docker exec -it %app_name%_rails_1 /bin/bash
	@docker exec -it %app_name%_db_1 /bin/bash    
redisconsole: ## docker exec -it %app_name%_redis_1 /bin/bash
	@docker exec -it %app_name%_redis_1 /bin/bash    
