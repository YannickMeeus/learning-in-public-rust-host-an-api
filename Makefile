MAKEFLAGS += --silent

help: ## Show all help information
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: dev
dev: ## Start development server, watches for changes and restarts process
	cargo watch -x run

.PHONY: build
build: ## Build a development version - unoptimized but faster compilation
	cargo build

.PHONY: build-release
build-release: ## Build a production release - fully optimised, but slower compilation
	cargo build --release

.PHONY: install-dev-deps
install-dev-deps: ## Install implicit dependencies for development
	# Watch is used as part of the dev experience.
	## https://crates.io/crates/cargo-watch
	cargo install cargo-watch 
	
	# Allows for more conventional dependency management a la npm or dotnet
	## https://github.com/killercup/cargo-edit
	cargo install cargo-edit