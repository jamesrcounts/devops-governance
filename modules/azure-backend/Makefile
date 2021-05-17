default: validate

fmt:
	terraform fmt

init:
	terraform init -upgrade -backend=false

validate: init fmt
	terraform validate