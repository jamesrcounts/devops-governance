default: validate

fmt:
	terraform fmt

init:
	terraform init -upgrade -backend=false
	terraform providers

validate: init fmt
	terraform validate