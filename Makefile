.PRONY: build
build:
	./.deploy/build.sh

.PRONY: up
up:
	docker compose --env-file .env up -d

.PRONY: down
down:
	docker compose down

.PRONY: migrate-build
migrate-build:
	docker build -t tweteroocsharp-migrate -f Dockerfile.migrations .

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

# K6
.PRONY: k6-build
k6-build:
	docker build -t tweteroo-k6 -f ./Dockerfile.k6 .

.PRONY: k6 
k6:
	docker run --network=host -v ./.k6:/app tweteroo-k6 $(FILEPATH)

# CERTIFICATES
.PRONY: new-cert
new-cert:
	docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d $(DOMAIN)

.PRONY: renew-cert
renew-cert:
	docker compose run --rm certbot renew