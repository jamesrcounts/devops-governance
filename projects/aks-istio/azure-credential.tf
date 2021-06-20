// module "azure_credentials" {
//   source = "github.com/jamesrcounts/devops-governance.git//modules/azure-credentials?ref=aks-istio"

//   aad_roles        = ["Directory Readers", "Groups Administrator"]
//   active_password  = "secondary"
//   generate_scripts = var.generate_scripts
//   project          = var.project

//   owner_scope = {
//     backend = module.azure_backend.resource_group.id
//     env     = module.azure_env.resource_group.id
//   }

//   update_triggers = {
//     primary   = "2021-06-10T00:00:00Z"
//     secondary = "2021-06-05T00:00:00Z"
//   }
// }