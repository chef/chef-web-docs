# Existing environments: dev, acceptance, union, rehearsal, delivered.
TF_ENVIRONMENT ?= dev
TF_DIRECTORY ?= .
TF_STATE ?= $(TF_ENVIRONMENT).tfstate

ifeq ($(TF_ENVIRONMENT), dev)
	# We have 4 isolated dev environments
	export TF_STATE=dev-$(TF_ENVIRONMENT_INDEX).tfstate
	export TF_VAR_environment=dev-$(TF_ENVIRONMENT_INDEX)

	export TF_VAR_aws_key_name ?= $(USER)
	export TF_VAR_aws_private_key ?= $(HOME)/.ssh/id_rsa
endif

$(TF_VAR_aws_private_key):
	$(error Oops, looks like you are missing your AWS private key \($(TF_VAR_aws_private_key)\). Please make sure the file exists, has the correct permissions \(0600\), and is not password protected.)

init: $(TF_VAR_aws_private_key)
	$(info ===============================================================)
ifeq ($(TF_ENVIRONMENT), dev)
ifeq ($(TF_ENVIRONMENT_INDEX),)
	$(error The dev environment requires an index! Please export $$TF_ENVIRONMENT_INDEX and try again.)
endif
	$(info Environment........$(TF_VAR_environment))
else
	$(info Environment........$(TF_ENVIRONMENT))
endif
	$(info Terraform State....$(TF_STATE))
	$(info AWS Keypair Name...$(TF_VAR_aws_key_name))
	$(info AWS Private Key....$(TF_VAR_aws_private_key))
	$(info ===============================================================)
	$(info )

remote-state: init
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

destroy: remote-state
ifeq ($(TF_ENVIRONMENT), dev)
	cd $(TF_DIRECTORY) && terraform destroy -var-file=vars/$(TF_ENVIRONMENT).tfvars
else
	@echo "The destroy target is only supported for dev environments."
endif

output: remote-state
	cd $(TF_DIRECTORY) && terraform output

console: remote-state
	cd $(TF_DIRECTORY) && terraform console

show: remote-state
	cd $(TF_DIRECTORY) && terraform show

.PHONY: init remote-state plan apply show output console lint