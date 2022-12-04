/**
 * # Project Workspace
 *
 * Workspaces connect Terraform Cloud to a GitHub Repository and an Azure
 * Environment.
 *
 * However, other combinations _are_ possible!  For example you could use GCP
 * instead, or Azure DevOps.  But you would have to write your own module for
 * that ;).
 *
 * This module implements the specific pattern:
 *  GitHub <=> Terraform Cloud <=> Azure
 *
 * - (GitHub)[./github.tf]
 * - (Azure)[./azure.tf]
 */

locals {
  name                         = "tf-gs-${local.namespace}"
  namespace                    = random_pet.instance_id.id
  repository_working_directory = "infrastructure"
}

data "azurerm_subscription" "current" {}

resource "random_pet" "instance_id" {}