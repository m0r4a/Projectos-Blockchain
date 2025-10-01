FORGE := forge
CAST := cast
ANVIL := anvil

PROJECT_DIR := greet-contract
CONTRACT_NAME := GreetingContract
CONTRACT_PATH := src/greetingContract.sol:$(CONTRACT_NAME)
PRIVATE_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
RPC_URL := http://127.0.0.1:8545
DEPLOYER := 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

.PHONY: all build test clean deploy node interact help

all: build

help:
	@echo "Available commands:"
	@echo "  make build      - Compile contracts"
	@echo "  make test       - Run tests"
	@echo "  make test-v     - Run tests with verbose output"
	@echo "  make gas        - Run tests with gas report"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make deploy     - Deploy contract to local node"
	@echo "  make interact   - Interactive contract demo"
	@echo "  make fmt        - Format Solidity code"
	@echo "  make setup      - Install forge-std dependency"

build:
	@echo "Building contracts..."
	cd $(PROJECT_DIR) && $(FORGE) build

test:
	@echo "Running tests..."
	cd $(PROJECT_DIR) && $(FORGE) test

test-v:
	@echo "Running tests (verbose)..."
	cd $(PROJECT_DIR) && $(FORGE) test -vvv

gas:
	@echo "Running tests with gas report..."
	cd $(PROJECT_DIR) && $(FORGE) test --gas-report

clean:
	@echo "Cleaning..."
	cd $(PROJECT_DIR) && $(FORGE) clean
	-rm -f $(PROJECT_DIR)/deploy.log

deploy:
	@echo "Deploying $(CONTRACT_NAME)..."
	@cd $(PROJECT_DIR) && $(FORGE) create $(CONTRACT_PATH) \
		--private-key $(PRIVATE_KEY) \
		--rpc-url $(RPC_URL) \
		--broadcast | tee deploy.log
	@echo "Check $(PROJECT_DIR)/deploy.log for contract address"

interact:
	@echo "Automatic Contract Demo"
	@if [ -z "$(CONTRACT)" ]; then \
		echo "Error: CONTRACT address not set"; \
		echo "Usage: make interact CONTRACT=0x..."; \
		exit 1; \
	fi

	@echo ""
	@echo "1. Storing name 'Astrid'"
	@$(CAST) send $(CONTRACT) "storeName(string)" "Astrid" \
		--private-key $(PRIVATE_KEY) \
		--rpc-url $(RPC_URL)

	@echo ""
	@echo "2. Getting greeting..."
	@$(CAST) call $(CONTRACT) "greetMe()" \
		--from $(DEPLOYER) \
		--rpc-url $(RPC_URL) | $(CAST) --to-ascii

	@echo ""
	@echo "3. Getting stored name..."
	@$(CAST) call $(CONTRACT) "getName(address)" $(DEPLOYER) \
		--rpc-url $(RPC_URL) | $(CAST) --to-ascii

fmt:
	@echo "Formatting Solidity code..."
	cd $(PROJECT_DIR) && $(FORGE) fmt

setup:
	@echo "Setting up Foundry project..."
	@if [ ! -d "$(PROJECT_DIR)/lib/forge-std" ]; then \
		cd $(PROJECT_DIR) && $(FORGE) install foundry-rs/forge-std --no-commit; \
	fi
	@echo "Setup complete"
