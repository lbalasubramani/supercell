# Common resources for all regions
# * Github IAM User, keys and secret
# * Codebuild projects for custom images
# * ECR repositories for custom images

module "global-cicd-resources" {
  source = "../../modules/service/global-cicd-resources"

  project_name                           = var.project_name
  environment                            = var.environment
  git_owner                              = var.git_owner
  git_repository                         = var.git_repository
  git_branch                             = var.git_branch
  region                                 = var.global_cicd_region
  vpc_id                                 = module.vpc[var.global_cicd_region].vpc_id
  subnets                                = module.vpc[var.global_cicd_region].private_subnets
  github_action_workflows_directory_path = "../../.github/workflows/"
  nonproduction_account_id               = var.nonproduction_account_id
}

### Regional CICD VPC ###
# * VPC and subnets for Codebuild projects per region
#
module "vpc" {
  for_each           = var.clusters
  source             = "../../modules/service/terraform-aws-vpc"
  name               = "codebuild-${var.project_name}"
  cidr               = var.vpc_cidr
  azs                = [for az in var.vpc_azs : join("", [each.key, az])]
  private_subnets    = var.vpc_private_subnets
  public_subnets     = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway
  tags = {
    Terraform   = "true"
    Project     = var.project_name
    Environment = var.environment
  }
}

### Regional CI/CD ###
# * Codebuild projects per Cluster
# * Codebuild projects for teams
module "cicd" {
  for_each = var.clusters
  source   = "../../modules/service/cicd"

  project_name                           = "${var.project_name}-${each.key}"
  environment                            = var.environment
  region                                 = each.key
  code_build_image                       = var.code_build_image
  git_owner                              = var.git_owner
  git_repository                         = var.git_repository
  git_branch                             = var.git_branch
  allowed_users                          = var.allowed_users
  allowed_roles                          = var.allowed_roles
  vpc_id                                 = module.vpc[each.key].vpc_id
  subnets                                = module.vpc[each.key].private_subnets
  clusters                               = each.value
  terraform_state_bucket                 = var.terraform_state_bucket
  terraform_state_bucket_kms_key         = var.terraform_state_bucket_kms_key
  github_action_workflows_directory_path = "../../.github/workflows/"

  # 
  #
  #
  github_actions_iam_user_name                               = module.global-cicd-resources.github_actions_iam_user_name
  github_actions_secret_aws_access_key_name                  = module.global-cicd-resources.github_actions_secret_aws_access_key_name
  github_actions_secret_aws_secret_access_key_name           = module.global-cicd-resources.github_actions_secret_aws_secret_access_key_name
  aws_ecr_repository_codebuild_image_arn                     = module.global-cicd-resources.aws_ecr_repository_codebuild_image_arn
  aws_ecr_repository_codebuild_image_repository_url          = module.global-cicd-resources.aws_ecr_repository_codebuild_image_repository_url

  #
  #
  #
  sso_ingress_nginx_name            = var.sso_ingress_nginx_name
  cluster_autoscaler_repository     = var.cluster_autoscaler_repository
  cluster_autoscaler_image_tag      = var.cluster_autoscaler_image_tag
  ingress_controller_repository     = var.ingress_controller_repository
  ingress_controller_image_tag      = var.ingress_controller_image_tag
  ingress_controller_image_digest   = var.ingress_controller_image_digest
  ingress_defaultbackend_repository = var.ingress_defaultbackend_repository
  ingress_defaultbackend_image_tag  = var.ingress_defaultbackend_image_tag
}

