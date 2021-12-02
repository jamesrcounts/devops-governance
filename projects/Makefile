default: all

CONFIG := github.secrets.auto.tfvars azdo.secrets.auto.tfvars aws.secrets.auto.tfvars terraform.auto.tfvars

backend_instance_id := grateful-aphid

backend_config:
	az keyvault secret download \
		--name azurerm-backend-tfvars \
		--vault-name kv-$(backend_instance_id) \
		--file azurerm.backend.tfvars

aad_script:
	az keyvault secret download \
		--name add-azuread-roles-sh \
		--vault-name kv-$(backend_instance_id) \
		--file add-azuread-roles.sh

github.secrets.auto.tfvars:
	@echo "github_pat=\"${AZDO_GITHUB_SERVICE_CONNECTION_PAT}\"" > github.secrets.auto.tfvars

azdo.secrets.auto.tfvars:
	@echo "azuredevops_pat=\"${AZDO_PERSONAL_ACCESS_TOKEN}\"" > azdo.secrets.auto.tfvars
	@echo "azuredevops_url=\"${AZDO_ORG_SERVICE_URL}\""      >> azdo.secrets.auto.tfvars

aws.secrets.auto.tfvars:
	@echo "aws_access_key_id=\"${AWS_ACCESS_KEY_ID}\""          > aws.secrets.auto.tfvars
	@echo "aws_secret_access_key=\"${AWS_SECRET_ACCESS_KEY}\"" >> aws.secrets.auto.tfvars

terraform.auto.tfvars:
	@echo "generate_scripts=\"true\"" > terraform.auto.tfvars

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade -backend-config azurerm.backend.tfvars
	terraform -v
	terraform providers
	
clean: 
	terraform plan -destroy -out plan.tfplan
	
validate:
	terraform validate

plan: $(CONFIG) fmt validate
	terraform plan -out plan.tfplan
	
apply:
	terraform apply plan.tfplan
	rm plan.tfplan

all: init plan

login:
	az login --use-device-code
	az account set --subscription "Jim Counts (Personal)"
	az account show --output table