SECRET_VARS := secrets.auto.tfvars
default: apply

config:
	@echo "github_pat=\"${AZDO_GITHUB_SERVICE_CONNECTION_PAT}\"" > $(SECRET_VARS)

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
