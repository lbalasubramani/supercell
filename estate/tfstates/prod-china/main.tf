module "tfstate" {
  source        = "../../../modules/logical/tf-state"
  environment   = var.environment
  allowed_users = var.allowed_users
  allowed_roles = var.allowed_roles
}

