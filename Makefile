default: plan

# There is only one module here.
module := workspaces/root

SECRETS := ./$(module)/terraform.secrets.auto.tfvars

$(SECRETS):
	@echo "github_pat=\"${GH_TOKEN}\""                          > $(SECRETS)
	@echo "tfe_token=\"${TFE_TOKEN}\""                         >> $(SECRETS)
	@echo "aws_access_key_id=\"${AWS_ACCESS_KEY_ID}\""         >> $(SECRETS)
	@echo "aws_secret_access_key=\"${AWS_SECRET_ACCESS_KEY}\"" >> $(SECRETS)


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