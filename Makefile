
build:
	bundle exec middleman build --verbose

server: build
	bundle exec middleman

deploy:
	bundle exec middleman deploy

.PHONY: build server deploy
