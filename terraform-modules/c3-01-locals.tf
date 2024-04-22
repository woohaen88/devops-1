locals {
  owners      = var.owners
  environment = terraform.workspace
  name        = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
    name        = local.name
  }
}
