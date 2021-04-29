default: apply

config:
	@echo "github_pat=\"${AZDO_GITHUB_SERVICE_CONNECTION_PAT}\"" > github.secrets.auto.tfvars
	@echo "azdo_pat=\"${AZDO_PERSONAL_ACCESS_TOKEN}\"" > azdo.secrets.auto.tfvars

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade -backend-config azurerm.backend.tfvars
	
clean:
	terraform destroy -auto-approve

connect:
	terraform init -get=false -backend-config azurerm.backend.tfvars
	
validate:
	terraform validate

apply: config fmt connect validate
	terraform apply -var-file azurerm.backend.tfvars

fresh: init apply
