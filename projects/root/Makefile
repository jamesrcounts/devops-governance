default: apply

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

apply: fmt connect validate
	terraform apply -var-file azurerm.backend.tfvars
