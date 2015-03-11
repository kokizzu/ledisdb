INSTALL_PATH ?= $(CURDIR)

$(shell ./tools/build_config.sh build_config.mk $INSTALL_PATH)

include build_config.mk

export CGO_CFLAGS
export CGO_CXXFLAGS
export CGO_LDFLAGS
export LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH
export GO_BUILD_TAGS

all: build  

build:
	$(GO) install -tags '$(GO_BUILD_TAGS)' ./...

build_use_lmdb:
	$(GO) install -tags '$(GO_BUILD_TAGS) lmdb' ./...	

clean:
	$(GO) clean -i ./...

test:
	$(GO) test --race -tags '$(GO_BUILD_TAGS)' ./...

test_use_lmdb:
	$(GO) test --race -tags '$(GO_BUILD_TAGS) lmdb' ./...	

test_ledis:
	$(GO) test --race -tags '$(GO_BUILD_TAGS)' ./ledis

test_server:
	$(GO) test --race -tags '$(GO_BUILD_TAGS)' ./server

test_store:
	$(GO) test --race -tags '$(GO_BUILD_TAGS)' ./store

test_rpl:
	$(GO) test --race -tags '$(GO_BUILD_TAGS)' ./rpl

fmt:
	go fmt ./...