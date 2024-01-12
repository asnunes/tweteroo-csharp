.PRONY: dev-db
dev-db:
	docker compose up -d db

.PRONY: build
build:
	docker build -t tweteroocsharp .

.PRONY: run
run:
	docker run -it --rm -p 8080:8080 --name tweteroocsharp tweteroocsharp

# DEVELOPMENT
dev_compose = docker compose -f docker-compose.development.yml

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
