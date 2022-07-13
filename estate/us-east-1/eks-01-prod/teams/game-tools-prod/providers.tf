terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path    = "/root/.kube/config"
  config_context = "arn:aws:eks:us-east-1:630693865763:cluster/eks-01-prod"
}