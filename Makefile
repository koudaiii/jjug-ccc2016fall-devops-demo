NAME     := demo
BIN      := bin/$(NAME)
VERSION  := v0.1.0
REVISION := $(shell git rev-parse --short HEAD)

SRCS    := $(shell find . -type f -name '*.go')
LDFLAGS := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""

# make glide
.PHONY: glide
glide:
ifeq ($(shell command -v glide 2> /dev/null),)
  curl https://glide.sh/get | sh
endif

# make deps
.PHONY: deps
deps: glide
  glide install

# make or make bin/NAME
$(BIN): $(SRCS)
  go build -a -tags netgo -installsuffix netgo build $(LDFLAGS) -o bin/$(NAME)

# make install
.PHONY: install
install:
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
