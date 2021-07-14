default: all

backend_instance_id := grateful-aphid

backend_config:
	az keyvault secret download \
		--name azurerm-backend-tfvars \
		--vault-name kv-$(backend_instance_id) \
		--file azurerm.backend.tfvars

aad_script:
	az keyvault secret download \
		--name add-azureadroles-ps1 \
		--vault-name kv-$(backend_instance_id) \
		--file Add-AzureAdRoles.terraform-root.ps1


config:
	@echo "github_pat=\"${AZDO_GITHUB_SERVICE_CONNECTION_PAT}\"" > github.secrets.auto.tfvars
	@echo "azuredevops_pat=\"${AZDO_PERSONAL_ACCESS_TOKEN}\"" > azdo.secrets.auto.tfvars
	@echo "azuredevops_url=\"${AZDO_ORG_SERVICE_URL}\"" >> azdo.secrets.auto.tfvars
	@echo "aws_access_key_id=\"${AWS_ACCESS_KEY_ID}\"" > aws.secrets.auto.tfvars
	@echo "aws_secret_access_key=\"${AWS_SECRET_ACCESS_KEY}\"" >> aws.secrets.auto.tfvars
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

plan: config fmt validate
	terraform plan -out plan.tfplan
	
apply:
	terraform apply plan.tfplan
	rm plan.tfplan

all: init plan

login:
	az login
	az account set --subscription "Jim Counts (personal)"
	az account show --output table