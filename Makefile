# -*- coding: utf-8 -*-

CMD_DOCKER := docker
CMD_DOCKER_COMPOSE := docker-compose
MAIN_CONTAINER_APP := app
MAIN_CONTAINER_SHELL := bash
PREVIEW_URL := http://0.0.0.0:8000/

.PHONY: start setup open hide reveal build deploy clean help

start: ## 起動
	hypercorn --access-logfile - --debug --reload main:app

setup: reveal ## 初回
	pip install -r requirements.txt

open: ## 閲覧
	open ${PREVIEW_URL}

hide: ## 秘匿
	git secret hide -v

reveal: ## 暴露
	git secret reveal -v

deploy: reveal ## 配備
	deta update -e .env
	deta deploy

clean: ## 掃除
	rm -rf log/*

help: ## 助言
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
