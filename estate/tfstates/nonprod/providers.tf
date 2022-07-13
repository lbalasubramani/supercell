provider "aws" {
  region  = "us-east-1"
  profile = "supercell-eks-nonprod"
}

terraform {
  required_version = ">= 0.12.0"
}

provider "template" {
  version = "~> 2.1"
}