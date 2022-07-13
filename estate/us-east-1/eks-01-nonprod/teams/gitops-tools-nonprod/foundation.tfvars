### Foundation ###
team_name                       = "gitops-tools-nonprod"
cluster_name                    = "eks-01-nonprod"
vpc_id                          = "vpc-09264ec9160cfe7b5"
dedicated_resource_account_role = "arn:aws:iam::824587598002:role/TeamRole"
enable_subnet_share             = true
dedicated_security_group_enable = false
network_policy_enable           = true
allowed_rules_in_ops_namespace = [
  {
    protocol = "ALL",
    port     = "ALL"
    ns_label = {
      name = "gitops-tools-nonprod-dev"
    }
    ns_selector  = "true"
    pod_label    = {}
    pod_selector = "false"
  }
]
allowed_rules_in_dev_namespace               = []
dedicated_resource_account                   = "824587598002"
additional_security_groups                   = {}
additional_security_groups_k8s_configuration = {}
team_subnets                                 = {}
permissive_rbac_dev                          = false
permissive_rbac_ops                          = false
team_jenkins_service_account_name            = "jenkins"
extended_rbac_rules_dev                      = {}
extended_rbac_rules_ops                      = {}
additional_sc_groups                         = [
        {
		    name = "supercell:developers"
		    kind = "Group"
		    api_group = "rbac.authorization.k8s.io"
	    }
    ]