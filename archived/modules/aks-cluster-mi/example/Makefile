default: plan

instance_id := moral-hound

init:
	terraform init -upgrade
	terraform -v
	terraform providers

plan: fmt config init
	terraform plan -out plan.tfplan 

apply:
	terraform apply plan.tfplan

fmt:
	cd .. && terraform fmt -recursive

config:
	@echo 'instance_id="$(instance_id)"' > terraform.auto.tfvars

clean: 
	terraform destroy -auto-approve