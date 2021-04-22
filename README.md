# DevOps Governance

Using Terraform to manage projects that use Terraform.

- [DevOps Governance](#devops-governance)
  - [Bootstrapping](#bootstrapping)
    - [Prerequesites](#prerequesites)
    - [Initial Run](#initial-run)
    - [Setup pipeline](#setup-pipeline)

## Bootstrapping

### Prerequesites

* A repository (this)
* Terraform
* Azure Subscription

### Initial Run

* Start with local state to build the root project to create backend for the root. 
* The outputs will indicate the storage account details, setup an `azurerm.backend.tfvars` file which includes
  * container_name
  * resource_group_name
  * storage_account_name
  * key
* Run `terraform init -backend-config azurerm.backend.tfvars` and move the local state into remote storage

### Setup pipeline

* Goal of setting up pipeline is to get ready to move to private build agents.  Which in turn enables us to put up the storage account firewalls.