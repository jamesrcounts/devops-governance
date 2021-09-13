module "istio_azure_sql" {
  source = "./istio-azure-sql"

  github_pat = var.github_pat
  project    = "istio-azure-sql"
  repository = "jamesrcounts/istio-azure-sql"
}