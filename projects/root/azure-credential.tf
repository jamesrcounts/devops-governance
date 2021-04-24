module "azure_credentials" {
  source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=credentials"

  project = local.project
  update_triggers = {
    primary   = "20210424"
    secondary = "20210424"
  }
}