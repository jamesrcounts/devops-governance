# DevOps Governance

Using Terraform to manage projects that use Terraform.

- [DevOps Governance](#devops-governance)
  - [Bootstrapping](#bootstrapping)
    - [Prerequesites](#prerequesites)
    - [Initial Run](#initial-run)
    - [Setup Azure Credentials](#setup-azure-credentials)
    - [Setup github credentials](#setup-github-credentials)
    - [Setup pipeline](#setup-pipeline)

## Bootstrapping

### Prerequesites

* A repository (this)
* Terraform
* Azure Subscription

### Initial Run

* Start with local state to build the root project to create backend for the root. 
* The root project tries to setup a variable group for the azure pipeline to use when locating its azurerm backend, but this info will not be available until the initial run completes.  One workaround is to pass fake data, or comment out the callsite.  Maybe a feature flag or another dynamic will work here.
* The outputs will indicate the storage account details, setup an `azurerm.backend.tfvars` file which includes
  * container_name
  * resource_group_name
  * storage_account_name
  * key
* Add the `backend azurerm {}` line to the `terraform` block.
* Run `terraform init -backend-config azurerm.backend.tfvars` and move the local state into remote storage
* Update the makefile topass the backend configuration to `terraform apply` as well: `terraform apply -var-file azurerm.backend.tfvars`

### Setup Azure Credentials

* Terraform needs a set of credentials to manage Azure Resources. 
* These credentials can be scoped to a subscription, a resource group, or several resource groups depending on your needs.
* For the bootstrapping phase, Terraform just needs access to manage the root project's backend resource group.

### Setup github credentials

* Azure DevOps needs a github service connection to connect the pipeline to the repository.
* The easiest way to set this up is with a GitHub PAT.
  * For local runs load this into the env as AZDO_GITHUB_SERVICE_CONNECTION_PAT
  * to inject into an azure devops secret, load as a TF_VAR_ in the makefile, and update the pipeline appropriately

### Setup pipeline

* Goal of setting up pipeline is to get ready to move to private build agents.  Which in turn enables us to put up the storage account firewalls.
* To get the pipeline working, start with microsoft hosted agents.  But you will need a devops project for that.
* Generate a PAT and add it to your environment according to the azuredevops provider [instructions][1]
* But to have a pipeline you'll need a service connection, so go back and setup your Azure Credentials first.


[1]: https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs