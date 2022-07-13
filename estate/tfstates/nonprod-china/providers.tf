provider "aws" {
  region  = "cn-northwest-1"
  profile = "supercell-eks-nonprod-china"
}

terraform {
  required_version = ">= 0.12.0"
}

provider "template" {
  version = "~> 2.1"
}