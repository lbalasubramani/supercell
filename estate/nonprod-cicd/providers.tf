provider "aws" {
  version = "~> 3.15.0"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.13.0"
}

provider "github" {
  owner   = "supercell"
}

provider "random" {
  version = "~> 3.0.0"
}