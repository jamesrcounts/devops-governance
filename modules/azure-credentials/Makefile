default: validate

fmt:
	terraform fmt

init:
	terraform init -backend=false -upgrade

validate: init fmt
	terraform validate