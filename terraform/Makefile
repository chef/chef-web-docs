# Existing environments: dev, acceptance, union, rehearsal, delivered.
TF_DIRECTORY ?= .
TF_STATE ?= $(TF_ENVIRONMENT).tfstate

remote-state:
	# We make sure that existing local state is deleted before configuring
	# the remote state. If it is not removed state gets contaminated between
	# environments.
	cd $(TF_DIRECTORY) && \
	rm -rf .terraform && \
	terraform init -backend-config="key=chef-web-docs/$(TF_STATE)"

plan: remote-state
	cd $(TF_DIRECTORY) && terraform plan -var-file=vars/$(TF_ENVIRONMENT).tfvars

apply: remote-state
	cd $(TF_DIRECTORY) && terraform apply -auto-approve -var-file=vars/$(TF_ENVIRONMENT).tfvars

.PHONY: init remote-state plan apply
