# CI/CD Prod account

This Terraform module consists from submodules:

* VPC For Codebuild projects to avoid Github, Docker public repository and Terraform registry rate limiting
* Global CI/CD resources
* Regional CI/CD resources for Clusters, Teams and RBAC governance