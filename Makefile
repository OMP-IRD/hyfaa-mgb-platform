all: run

run:
	docker-compose -f docker-compose.yml -f docker-compose-production.yml up -d

logs:
	docker-compose -f docker-compose.yml -f docker-compose-production.yml logs -f

run-dev:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up -d