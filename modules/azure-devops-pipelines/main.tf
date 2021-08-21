locals {
  terraform_shas = {
    "0.15.1" = "1ff798791abf518fb0b5d9958ec8327b7213f1c91fb5235923e91cc96c59ef2c"
    "0.15.3" = "5ce5834fd74e3368ad7bdaac847f973e66e61acae469ee86b88da4c6d9f933d4"
    "0.15.4" = "ddf9b409599b8c3b44d4e7c080da9a106befc1ff9e53b57364622720114e325c"
    "1.0.0"  = "8be33cc3be8089019d95eb8f546f35d41926e7c1e5deff15792e969dde573eb5"
    "1.0.1"  = "da94657593636c8d35a96e4041136435ff58bb0061245b7d0f82db4a7728cef3"
    "1.0.4"  = "5c0be4d52de72143e2cd78e417ee2dd582ce229d73784fd19444445fa6e1335e"
  }

  pipelines = var.pipelines != null ? var.pipelines : { "infrastructure" = "azure-pipelines.yml" }
}