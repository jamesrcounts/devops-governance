module "azure_devops_project" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-devops-project?ref=azure-devops"

  project = local.project
}