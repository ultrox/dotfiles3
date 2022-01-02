SHELL := /bin/bash
.POSIX:
# .PHONY: help

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Runs stow first clean them all and then add them
	for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
	do
    		stow -D $folder
    		stow $folder
	done

env-clean: ## delete all symlinks
	for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
	do
    		echo "Removing $folder"
    		stow -D $folder
	done
