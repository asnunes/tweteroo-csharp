.PRONY: dev-db
dev-db:
	docker compose up -d db

.PRONY: build
build:
	docker build -t tweteroocsharp .

.PRONY: run
run:
	docker run -it --rm -p 8080:8080 --name tweteroocsharp tweteroocsharp