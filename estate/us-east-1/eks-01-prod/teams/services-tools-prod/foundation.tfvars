### Foundation ###
team_name                                    = "services-tools-prod"
cluster_name                                 = "eks-01-prod"
vpc_id                                       = "vpc-08da98ccc5c16daeb"
dedicated_resource_account_role              = "arn:aws:iam::149006038495:role/TeamRole"
enable_subnet_share                          = true
dedicated_security_group_enable              = true
network_policy_enable                        = true
allowed_rules_in_ops_namespace               = []
allowed_rules_in_dev_namespace               = []
dedicated_resource_account                   = "149006038495"
additional_security_groups                   = {}
additional_security_groups_k8s_configuration = {}
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