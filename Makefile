default: plan

SECRETS := ./$(module)/terraform.secrets.auto.tfvars

$(SECRETS):
	@echo "github_pat=\"${GH_TOKEN}\""  > $(SECRETS)
	@echo "tfe_token=\"${TFE_TOKEN}\"" >> $(SECRETS)

fmt:
	cd $(module) && terraform fmt -recursive

init:
	cd $(module) && terraform init

validate:
	cd $(module) && terraform validate

plan: validate fmt $(SECRETS)
	cd $(module) && terraform plan

apply: validate fmt $(SECRETS)
	cd $(module) && terraform apply