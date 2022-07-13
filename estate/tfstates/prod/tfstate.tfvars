environment = "prod"
allowed_users = [
  "juho.arenius"
]
allowed_roles = [
    "sc-us-east-1-tf-codebuild-role-estate",
    "AWSReservedSSO_aws_kube_clusters_a93a70f1ea24f904",       #MCE IAM role
    "AWSReservedSSO_aws_kube_administrators_86be104b123abdcf"  #CA IAM role
]