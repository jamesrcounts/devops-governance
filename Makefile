default: plan

SECRETS := terraform.secrets.auto.tfvars

$(SECRETS):
	@cd $(module) && echo "github_pat=\"${GH_TOKEN}\"" > $(SECRETS)

fmt:
	cd $(module) && terraform fmt -recursive

init:
	cd $(module) && terraform init

plan: fmt $(SECRETS)
	cd $(module) && terraform plan

apply: fmt $(SECRETS)
	cd $(module) && terraform apply