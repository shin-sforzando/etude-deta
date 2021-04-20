# -*- coding: utf-8 -*-

CMD_DOCKER := docker
CMD_DOCKER_COMPOSE := docker-compose
MAIN_CONTAINER_APP := app
MAIN_CONTAINER_SHELL := bash
PREVIEW_URL := http://0.0.0.0:3000/

.PHONY: ps up setup restart renew shell logs follow open hide reveal build start lint test doc generate deploy stop down clean prune help

ps: ## 監視
	$(CMD_DOCKER_COMPOSE) ps

up: ## 起動
	$(CMD_DOCKER_COMPOSE) up ${ARGS} --detach --remove-orphans

setup: up ## 初回
	echo "TODO: Not Implemented Yet!"

restart: stop up ; ## 再起

renew: down clean setup ; ## 転生

shell: up ## 接続
	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) $(MAIN_CONTAINER_SHELL)

logs: ## 記録
	$(CMD_DOCKER_COMPOSE) logs ${ARGS} --timestamp

follow: ## 追跡
	$(CMD_DOCKER_COMPOSE) logs ${ARGS} --timestamp --follow

open: ## 閲覧
	open ${PREVIEW_URL}

hide: ## 秘匿
	git secret hide -v

reveal: ## 暴露
	git secret reveal -v

# build: up ## 構築
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) yarn build

# start: build ## 開始
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} --detach $(MAIN_CONTAINER_APP) yarn start

# lint: up ## 検証
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) yarn lint

# test: up ## 試験
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) yarn test

# doc: up ## 文書
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) yarn test

# generate: up ## 生成
# 	$(CMD_DOCKER_COMPOSE) exec ${ARGS} $(MAIN_CONTAINER_APP) yarn generate

deploy: generate ## 配備
	echo "TODO: Not Implemented Yet!"

stop: ## 停止
	$(CMD_DOCKER_COMPOSE) stop ${ARGS}

down: ## 削除
	$(CMD_DOCKER_COMPOSE) down ${ARGS} --rmi all --remove-orphans

clean: down ## 掃除
	rm -rf log/*

prune: ## 破滅
	$(CMD_DOCKER) system prune ${ARGS} --all --force --volumes

help: ## 助言
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
