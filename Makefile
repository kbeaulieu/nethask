.PHONY: build check lint test run

build:
	stack build

check: lint test

lint:
	hlint .

test:
	@echo whoops no tests yet

run:
	stack run

