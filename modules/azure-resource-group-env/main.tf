locals {
  instance_id = random_pet.instance_id.id
  tags        = merge(var.required_tags, var.optional_tags, local.generated_tags)

  generated_tags = {
    instance_id = local.instance_id
  }
}

resource "random_pet" "instance_id" {}
