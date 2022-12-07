variable "aws_access_key_id" {
  description = "Specifies the AWS access key ID for the AWS Terraform provider."
  type        = string
}

variable "aws_secret_access_key" {
  description = "Specifies the AWS access key secret for the AWS Terraform provider."
  sensitive   = true
  type        = string
}

variable "github_pat" {
  description = "A github personal access token to create the VCS connection."
  sensitive   = true
  type        = string
}

variable "tfe_token" {
  description = "A Terraform Cloud token to manage the organization."
  sensitive   = true
  type        = string
}

variable "client_id" {
  default     = null
  description = "The AzureAD Appication Client ID"
  type        = string
}

variable "client_secret" {
  default     = null
  description = "The AzureAD Application Password"
  sensitive   = true
  type        = string
}

variable "subscription_id" {
  default     = null
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  default     = null
  description = "The Azure AD tenant ID"
  type        = string
}