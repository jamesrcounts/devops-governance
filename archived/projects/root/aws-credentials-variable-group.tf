resource "azuredevops_variable_group" "aws" {
  project_id   = module.azure_devops_pipelines.devops_project_id
  name         = "aws"
  description  = "Specifies the credentials for the AWS Terraform provider."
  allow_access = false

  variable {
    name  = "AWS_ACCESS_KEY_ID"
    value = var.aws.id
  }

  variable {
    is_secret    = true
    name         = "AWS_SECRET_ACCESS_KEY"
    secret_value = var.aws.key
  }
}