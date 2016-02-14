VERSION := $(shell cmd -c 'git describe --always --tags')
ifdef GOBIN
PATH := $(GOBIN):$(PATH)
else
PATH := $(subst :,/bin:,$(GOPATH))/bin:$(PATH)
endif

# Standard Telegraf build
default: prepare build

build:
	go build -o telegraf.exe -ldflags \
		"-X main.Version=$(VERSION)" \
		./cmd/telegraf/telegraf.go

# Build with race detector
dev: prepare
	go build -race -o telegraf -ldflags \
		"-X main.Version=$(VERSION)" \
		./cmd/telegraf/telegraf.go

prepare:
	go get github.com/tools/godep
	godep restore

save:
    godep save "github.com/dennisbappert/telegraf/cmd/telegraf"
    
test:
	go test -race ./...

.PHONY: test
