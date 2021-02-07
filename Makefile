docker:
	docker run -i --name=progrium.com -p=3001:2368 -v=$(shell pwd):/var/lib/ghost/content ghost:1-alpine

dev:
	docker run --name=progrium.com -p=3001:2368 -v=$(shell pwd):/var/lib/ghost/content ghost:1-alpine

run:
	docker run -p=3002:2368 -v=$(shell pwd)/ghost:/var/lib/ghost/content ghost:1-alpine

stop:
	docker rm -f progrium.com