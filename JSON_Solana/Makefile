GO := go
GOFLAGS := -v
BINARY := json_solana
MAIN := ./src

.PHONY: all build clean test setup

all: build

setup:
	cd src && $(GO) mod tidy
	cd src && $(GO) build $(GOFLAGS) -o ../$(BINARY) .

build:
	cd src && $(GO) build $(GOFLAGS) -o ../$(BINARY) .

test:
	./$(BINARY) 1234

clean:
	@echo "Cleaning..."
	-rm -f $(BINARY)
	-rm -f block_*.json
