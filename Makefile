THIS_FILE := $(lastword $(MAKEFILE_LIST))

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: cleanup
cleanup: ## Stops all containers, and removes temp files created by build/test
	rm -rf $$(find . -type d -name .terragrunt-cache)

.PHONY: lint
lint: ## Runs lint, assumes tflint(https://github.com/terraform-linters/tflint) is installed
	@tflint --recursive

.PHONY: docs 
docs: ## Runs terraform-docs assumers terraform-docs(https://github.com/terraform-docs/terraform-docs) is installed
	@for module_dir in ./modules/*; do [ -d "$$module_dir" ] && terraform-docs markdown --output-file README.md "$$module_dir"; done
  	

.DEFAULT_GOAL := help
