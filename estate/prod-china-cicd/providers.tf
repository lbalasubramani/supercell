provider "aws" {
  region = "cn-northwest-1"
}

provider "github" {
  owner = "supercell"
}

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    github = {
      version = "4.0.1"
      source  = "github"
    }
    random = {
      version = "~> 3.0.0"
    }
    aws = {
      version = "~> 3.16.0"
    }
  }
}
