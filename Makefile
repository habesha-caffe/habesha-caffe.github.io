.DELETE_ON_ERROR:
.ONESHELL:
SHELL=bash
.SHELLFLAGS := -e -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: help rust__all check test fmt clippy npm__install start clean npm__build firefox

help: # Generates a list of all targets with their descriptions
	@grep ":" ./Makefile | awk "/#/ && !/grep/" | sed -E 's/(.+:).*#(.+)/\x1b[36m\1\x1b[0m\2/g'

restart_module: themes/** # reinitialises submodule after cloning repo
	git submodule init && git submodule update

serve_mobile_laptop: # serves a website from the laptop accessible from the network
	IPADDR=$$(ip -4 addr show wlp0s20f3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}') && hugo server --buildDrafts --bind $$IPADDR --baseURL http://$$IPADDR
