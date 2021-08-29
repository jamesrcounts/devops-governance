locals {
  location = "centralus"
  shared_tags = {
    project    = var.project
    repository = var.repository
  }

  # env_tags = merge(
  #   local.shared_tags,
  #   {
  #     backend_instance_id = module.azure_backend.resource_group.tags["instance_id"]
  #   }
  # )
}