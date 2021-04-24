# DevOps Governance

Using Terraform to manage projects that use Terraform.

- [DevOps Governance](#devops-governance)
  - [Bootstrapping](#bootstrapping)
    - [Prerequesites](#prerequesites)
    - [Initial Run](#initial-run)
    - [Setup Azure Credentials](#setup-azure-credentials)
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

### Setup Azure Credentials

* Terraform needs a set of credentials to manage Azure Resources. 
* These credentials can be scoped to a subscription, a resource group, or several resource groups depending on your needs.
* For the bootstrapping phase, Terraform just needs access to manage the root project's backend resource group.

### Setup pipeline

* Goal of setting up pipeline is to get ready to move to private build agents.  Which in turn enables us to put up the storage account firewalls.
* To get the pipeline working, start with microsoft hosted agents.  But you will need a devops project for that.
* Generate a PAT and add it to your environment according to the azuredevops provider [instructions][1]
* But to have a pipeline you'll need a service connection, so go back and setup your Azure Credentials first.


[1]: https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs