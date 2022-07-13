### GLOBAL CICD ###
project_name       = "sc"
environment        = "PROD"
git_owner          = "supercell"
git_repository     = "kube-foundation"
git_branch         = "master"
global_cicd_region = "us-east-1"

#
clusters = {
  us-east-1 = {
    "eks-01-prod" = {
      description = "Production cluster"
      teams       = ["services-tools-prod","ps-tools-prod","analytics-tools-prod","game-tools-prod","community-tools-prod"]
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

### CICD ###

terraform_state_bucket         = "s3-tf-state-sc-prod"
terraform_state_bucket_kms_key = "alias/s3-tf-state-sc-prod"

allowed_roles = [
  "AWSReservedSSO_aws_kube_clusters_a93a70f1ea24f904",
  "AWSReservedSSO_aws_kube_administrators_86be104b123abdcf"
]
allowed_users = [
  "juho.arenius"
]

### SSO ###
sso_ingress_nginx_name            = "755069680103.dkr.ecr.us-east-1.amazonaws.com/supercell/sso.nginx:1.0.44-patch3"
cluster_autoscaler_repository     = "us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler"
cluster_autoscaler_image_tag      = "v1.18.1"
ingress_controller_repository     = "k8s.gcr.io/ingress-nginx/controller"
ingress_controller_image_tag      = "v0.40.2"
ingress_controller_image_digest   = "sha256:46ba23c3fbaafd9e5bd01ea85b2f921d9f2217be082580edc22e6c704a83f02f"
ingress_defaultbackend_repository = "k8s.gcr.io/defaultbackend-amd64"
ingress_defaultbackend_image_tag  = "1.5"
