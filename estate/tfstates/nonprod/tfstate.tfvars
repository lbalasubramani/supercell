environment = "nonprod"
allowed_users = [
  "juho.arenius"
]
allowed_roles = [
  "sc-us-east-1-tf-codebuild-role-estate",
  "AWSReservedSSO_aws_kube_clusters_6db1c626c9440ead",        #MCE IAM role
  "AWSReservedSSO_aws_kube_administrators_73728a338a92772c"   #CA IAM role
]