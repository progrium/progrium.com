docker:
	docker run -d --name=progrium.com -p=3001:2368 -v=$(shell pwd):/var/lib/ghost/content ghost:1-alpine

stop:
	docker rm -f progrium.com