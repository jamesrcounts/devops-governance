default: validate

fmt:
	terraform fmt

init:
	terraform init -backend=false

validate: init fmt
	terraform validate