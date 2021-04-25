variable "project" {
  description = "(Required) Specifies the Azure DevOps project name."
  type        = string
}

variable "service_principal" {
 description = "(Required) An Azure service principal.  Used to configure a an AzureRM service connection in Azure DevOps." 
 sensitive = true
 type = object({
   client_id=string
   client_secret=string
   subscription_id=string
   subscription_name=string
   tenant_id=string
 })
}