### GLOBAL CICD ###
project_name       = "sc-china"
environment        = "NONPROD"
git_owner          = "supercell"
git_repository     = "kube-foundation"
git_branch         = "master"
global_cicd_region = "cn-northwest-1"

#
clusters = {
  cn-northwest-1 = {
    "eks-02-nonprod-china" = {
      description = "Non-Production cluster in China region"
      teams       = []
    }
  }
}

### CICD VPC ###
vpc_cidr               = "10.0.0.0/24"
vpc_azs                = ["a", "b", "c"]
vpc_private_subnets    = ["10.0.0.32/27", "10.0.0.64/27", "10.0.0.96/27"]
vpc_public_subnets     = ["10.0.0.128/27", "10.0.0.160/27", "10.0.0.192/27"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = true
#vpc_tags = 

### CICD ###

terraform_state_bucket         = "s3-tf-state-sc-nonprod-china"
terraform_state_bucket_kms_key = "alias/s3-tf-state-sc-nonprod-china"

allowed_roles = [
  "cn-kube-dev-write"
]
allowed_users = [
  "juho.arenius",
  "ext-dbladzich.nc",
  "ext-mstankevic.nc"
]

### SSO ###
sso_ingress_nginx_name            = "830619862888.dkr.ecr.cn-northwest-1.amazonaws.com.cn/supercell/sso.nginx:1.0.44-patch3"
cluster_autoscaler_repository     = "830619862888.dkr.ecr.cn-northwest-1.amazonaws.com.cn/sc-china-k8s-cluster-images"
cluster_autoscaler_image_tag      = "cluster-autoscaler-v1.20.0"
ingress_controller_repository     = "830619862888.dkr.ecr.cn-northwest-1.amazonaws.com.cn/ingress-nginx/controller"
ingress_controller_image_tag      = "v0.40.2"
ingress_controller_image_digest   = "sha256:0100c173327bbb124c76ea1511dade4cec718234c23f8e7a41f27ad03f361431"
ingress_defaultbackend_repository = "830619862888.dkr.ecr.cn-northwest-1.amazonaws.com.cn/defaultbackend-amd64"
ingress_defaultbackend_image_tag  = "1.5"