
build:
	bundle exec middleman build

server: build
	bundle exec middleman

deploy:
	bundle exec middleman deploy

.PHONY: build server deploy