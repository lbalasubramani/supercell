variable "project_name" {
  description = "All resources will be prepended with this name"
  type        = string
}

variable "environment" {
  description = "Environment eg. NON-PROD, PROD"
  type        = string
}

variable "code_build_image" {
  description = "Docker image to use for CodeBuild container - Use http://amzn.to/2mjCI91 for reference"
  type        = string
  default     = "aws/codebuild/standard:4.0"
}

variable "git_owner" {
  description = "Git repository owner"
  type        = string
}

variable "git_repository" {
  description = "Git repository to checkout"
  type        = string
}

variable "git_branch" {
  description = "Git branch to use for creating EKS clusters"
  type        = string
}

variable "github_secret_name" {
  description = "Secret Manager Github secret name"
  type        = string
  default     = "/cicd/estate/github_secret/tokens"
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 90
}

variable "global_cicd_region" {
  description = "Region where global CI/CD resources are located (ECR, Github IAM user)"
  type        = string
}

variable "clusters" {}

### CICD VPC ###
variable "vpc_cidr" {}
variable "vpc_azs" {}
variable "vpc_private_subnets" {}
variable "vpc_public_subnets" {}
variable "vpc_enable_nat_gateway" {}
variable "vpc_single_nat_gateway" {}
#variable "vpc_tags" {}

### CICD ###
variable "allowed_roles" {}
variable "allowed_users" {}
variable "terraform_state_bucket" {}
variable "terraform_state_bucket_kms_key" {}

variable "nonproduction_account_id" {}

### SSO ###
variable "sso_ingress_nginx_name" {
  type = string
}

variable "cluster_autoscaler_repository" {
  type = string
}

variable "cluster_autoscaler_image_tag" {
  type = string
}

variable "ingress_controller_repository" {
  type = string
}

variable "ingress_controller_image_tag" {
  type = string
}

variable "ingress_controller_image_digest" {
  type = string
}

variable "ingress_defaultbackend_repository" {
  type = string
}

variable "ingress_defaultbackend_image_tag" {
  type = string
}