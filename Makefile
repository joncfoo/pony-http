.PHONY: test build docs watch

test: build
	@./bin/test --noprog

build:
	docker run \
		--rm \
		-u $(shell id -u):$(shell id -g) \
		-v $(shell pwd):/src/main \
		ponylang/ponyc:release \
		sh -c 'ponyc -p . -o ./bin $(DOC_ARGS) ./test'

docs: DOC_ARGS=--docs-public
docs: build

watch:
	@./scripts/watch.sh
