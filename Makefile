MAKEFLAGS += --silent

.PHONY: dev
dev:
	cargo watch -x run

.PHONY: install-dev-deps
install-dev-deps:
	# Watch is used as part of the dev experience.
	## https://crates.io/crates/cargo-watch
	cargo install cargo-watch 
	
	# Allows for more conventional dependency management a la npm or dotnet
	## https://github.com/killercup/cargo-edit
	cargo install cargo-edit