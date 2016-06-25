
build:
	bundle exec middleman build --verbose

server: build
	bundle exec middleman


.PHONY: build server deploy
