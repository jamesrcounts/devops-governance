default: all

config:
	@echo "github_pat=\"${AZDO_GITHUB_SERVICE_CONNECTION_PAT}\"" > github.secrets.auto.tfvars
	@echo "azuredevops_pat=\"${AZDO_PERSONAL_ACCESS_TOKEN}\"" > azdo.secrets.auto.tfvars
	@echo "azuredevops_url=\"${AZDO_ORG_SERVICE_URL}\"" >> azdo.secrets.auto.tfvars

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade -backend-config azurerm.backend.tfvars
	terraform -v
	terraform providers
	
clean:
	terraform destroy -auto-approve
	
validate:
	terraform validate

plan: config fmt validate
	terraform plan -var "backend_config_filename=azurerm.backend.tfvars" -var "terraform_root_aad_script_name=Add-AzureAdRoles.terraform-root.ps1" -var "container_pipelines_aad_script_name=Add-AzureAdRoles.container-pipelines.ps1" -out plan.tfplan
	
apply:
	terraform apply plan.tfplan
	rm plan.tfplan

all: init plan