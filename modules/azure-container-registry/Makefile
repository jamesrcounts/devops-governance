default: validate

fmt:
	terraform fmt

init:
	terraform init -upgrade -backend=false
	terraform -v
	terraform providers

validate: init fmt
	terraform validate