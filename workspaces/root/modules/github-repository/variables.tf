variable "name" {
  description = "The repository name."
  type        = string
}

variable "template" {
  description = "The module will seed this repository from the specified GitHub template repository."
  type = object({
    owner      = string
    repository = string
  })
}