HOST ?= $(shell hostname)

HOST_DIR := hosts/$(HOST)

KNOWN_HOSTS := $(shell find hosts -maxdepth 1 -mindepth 1 -type d -printf "%f\n")

.PHONY: help install bootstrap switch update clean

help:
	@echo "Available commands:"
	@echo "  make install HOST=<host>  Bootstrap and apply Home Manager config"
	@echo "  make switch HOST=<host>   Apply Home Manager config"
	@echo "  make update               Update flake inputs"
	@echo ""
	@echo "Known hosts: $(KNOWN_HOSTS)"

bootstrap:
	@if ! command -v nix >/dev/null 2>&1; then \
		echo "Nix is not installed."; \
		echo "Install Nix first: https://nixos.org/download/"; \
		exit 1; \
	fi
	@if ! command -v home-manager >/dev/null 2>&1; then \
		echo "Installing Home Manager..."; \
		nix run home-manager/master -- init --switch; \
	fi

check-host:
	@if ! echo "$(KNOWN_HOSTS)" | grep -qw "$(HOST)"; then \
		echo "Unknown host: $(HOST)"; \
		echo "Known hosts: $(KNOWN_HOSTS)"; \
		exit 1; \
	fi

install: bootstrap check-host switch

switch: check-host
	home-manager switch --flake .#$(HOST)

update:
	nix flake update

clean:
	rm -rf result
