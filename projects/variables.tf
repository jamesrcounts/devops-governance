variable "azuredevops_pat" {
  description = "(Required) An Azure DevOps personal access token. Used to configure a variable group for the Azure DevOps Terraform Provider."
  sensitive   = true
  type        = string
}

variable "azuredevops_url" {
  description = "(Required) An Azure DevOps organization URL. Used to configure a variable group for the Azure DevOps Terraform Provider."
  type        = string
}

variable "aws_access_key_id" {
  description = "(Required) Specifies the AWS access key ID for the AWS Terraform provider."
  type        = string
}

variable "aws_secret_access_key" {
  description = "(Required) Specifies the AWS access key secret for the AWS Terraform provider."
  sensitive   = true
  type        = string
}

variable "backend_config_filename" {
  default     = null
  description = "(Optional) When provided a filename this module will write the backend config to that file in tfvars format.  Defaults to null."
}

# Todo replace with local flag and generate names
variable "container_pipelines_aad_script_name" {
  default     = null
  description = "(Optional) When provided a filename this module will write a powershell script to assign AAD roles to the container-pipelines credentials.  Defaults to null."
}
variable "terraform_root_aad_script_name" {
  default     = null
  description = "(Optional) When provided a filename this module will write a powershell script to assign AAD roles to the terraform-root credentials.  Defaults to null."
}

variable "github_pat" {
  description = "(Required) A GitHub personal access token. Used to configure an Azure DevOps service connection."
  sensitive   = true
  type        = string
}