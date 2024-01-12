.PRONY: build
build:
	docker build -t tweteroocsharp .

.PRONY: run
run:
	docker run -it --rm -p 8080:8080 --name tweteroocsharp --network host tweteroocsharp 

# DEVELOPMENT
dev_compose = docker compose -f docker-compose.development.yml

.PRONY: dev-db
dev-db:
	$(dev_compose) up -d db


.PRONY: dev
dev:
	$(dev_compose) up

.PRONY: devd
devd:
	$(dev_compose) up -d

.PRONY: dev-build
dev-build:
	docker build -t tweteroocsharp-dev -f Dockerfile.development .

.PRONY: dev-down
dev-down:
	$(dev_compose) down
