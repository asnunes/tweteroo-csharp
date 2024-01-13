.PRONY: build
build:
	./.deploy/build.sh

.PRONY: up
up:
	docker compose up -d

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

# CERTIFICATES
.PRONY: new-cert
new-cert:
	docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d $(DOMAIN)

.PRONY: renew-cert
renew-cert:
	docker compose run --rm certbot renew