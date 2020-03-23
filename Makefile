VERSION:=4

.PHONY: build
build:
	docker build --no-cache --rm --tag udovicic/varnish:${VERSION} .

.PHONY: test
test:
	docker run --rm udovicic/varnish:${VERSION} varnishd -V
