NAME     := demo
BIN      := bin/$(NAME)
VERSION  := v0.1.0
REVISION := $(shell git rev-parse --short HEAD)

SRCS    := $(shell find . -type f -name '*.go')
LDFLAGS := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""

# make or make bin/NAME
$(BIN): $(SRCS)
	go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o $(BIN)

# make install
.PHONY: install
install:
	glide install
	go install $(LDFLAGS)

# make run
.PHONY: run
run: $(BIN)
	@echo "Running"
	@$(BIN)

# make clean
.PHONY: clean
clean:
	rm -rf bin/*
	rm -rf vendor/*

# make test
.PHONY: test
test:
	go test -cover -v `glide novendor`
