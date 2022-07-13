module "cluster" {
  source = "../../../modules/service/eks-cluster"
  name   = var.name

  ### VPC ###
  vpc_cidr                             = var.vpc_cidr
  vpc_azs                              = var.vpc_azs
  vpc_private_subnets                  = var.vpc_private_subnets
  vpc_public_subnets                   = var.vpc_public_subnets
  vpc_pod_subnets                      = var.vpc_pod_subnets
  vpc_team_subnets                     = var.vpc_team_subnets
  vpc_enable_nat_gateway               = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway               = var.vpc_single_nat_gateway
  vpc_tags                             = var.vpc_tags
  enable_ecr_dkr_endpoint              = var.enable_ecr_dkr_endpoint
  ecr_dkr_endpoint_private_dns_enabled = var.ecr_dkr_endpoint_private_dns_enabled

  ### EKS CLUSTER ###
  aws_region                                  = var.aws_region
  aws_account                                 = var.aws_account
  cluster_version                             = var.cluster_version
  enable_irsa                                 = var.enable_irsa
  cluster_enabled_log_types                   = var.cluster_enabled_log_types
  workers_additional_policies                 = var.workers_additional_policies
  k8s_service_account_namespace               = var.k8s_service_account_namespace
  k8s_service_account_name                    = var.k8s_service_account_name
  worker_groups_launch_template               = var.worker_groups_launch_template
  enable_refresh_asg                          = var.enable_refresh_asg
  fluentd_roles_in_resource_account           = var.fluentd_roles_in_resource_account
  enable_external_dns                         = var.enable_external_dns
  map_accounts                                = var.map_accounts
  map_roles                                   = var.map_roles
  map_users                                   = var.map_users
  supercell_whitelisted_vpn_addresses         = var.supercell_whitelisted_vpn_addresses
  nordcloud_whitelisted_vpn_addresses         = var.nordcloud_whitelisted_vpn_addresses
  enable_application_load_balancer_controller = var.enable_application_load_balancer_controller
  node_group_template                         = var.node_group_template
  fargate_profiles                            = var.fargate_profiles
  sc_groups_with_global_ns_listing_perms      = var.sc_groups_with_global_ns_listing_perms
}

module "opa" {
  source                                                           = "../../../modules/service/terraform-opa"
  prefix_name                                                      = "kf"
  argocd_namespace                                                 = var.argocd_namespace
  opa_namespace                                                    = var.opa_namespace
  opa_repository                                                   = var.opa_repository
  opa_repository_path                                              = var.opa_repository_path
  opa_repository_revision                                          = var.opa_repository_revision
  opa_overwrite_values                                             = var.opa_overwrite_values
  is_selfheal_enabled                                              = var.is_selfheal_enabled
  is_prune_enabled                                                 = var.is_prune_enabled
  rules_labels_enabled                                             = var.rules_labels_enabled
  owner_label_excluded_namespaces                                  = var.owner_label_excluded_namespaces
  rules_security_dockersocket_enabled                              = var.rules_security_dockersocket_enabled
  rules_security_host_aliases_enabled                              = var.rules_security_host_aliases_enabled
  rules_security_sysadmin_enabled                                  = var.rules_security_sysadmin_enabled
  rules_trusted_registries_enabled                                 = var.rules_trusted_registries_enabled
  trusted_registries                                               = var.trusted_registries
  rules_network_force_https_enabled                                = var.rules_network_force_https_enabled
  rules_network_policies_enabled                                   = var.rules_network_policies_enabled
  network_allow_all_network_policy_whitelisted_namespaces          = var.network_allow_all_network_policy_whitelisted_namespaces
  network_allow_all_network_policy_whitelisted_networkpolicy_names = var.network_allow_all_network_policy_whitelisted_networkpolicy_names
  rules_node_port_service_enabled                                  = var.rules_node_port_service_enabled
  network_node_port_service_whitelisted_namespaces                 = var.network_node_port_service_whitelisted_namespaces
  network_node_port_service_whitelisted_services_names             = var.network_node_port_service_whitelisted_services_names
  rules_load_balancer_service_enabled                              = var.rules_load_balancer_service_enabled
  network_load_balancer_service_whitelisted_namespaces             = var.network_load_balancer_service_whitelisted_namespaces
  network_load_balancer_service_whitelisted_services_names         = var.network_load_balancer_service_whitelisted_services_names
  rules_resources_limits_enabled                                   = var.rules_resources_limits_enabled
  resources_limits_whitelisted_namespaces                          = var.resources_limits_whitelisted_namespaces
  rules_argocd_enabled                                             = var.rules_argocd_enabled
  kubernetes_foundation_namespaces                                 = var.kubernetes_foundation_namespaces
  rules_backup_restore_enabled                                     = var.rules_backup_restore_enabled
  rules_backup_create_enabled                                      = var.rules_backup_create_enabled
}

module "cert-manager" {
  source                                                           = "../../../modules/service/terraform-cert-manager"
  argocd_namespace                                                 = var.argocd_namespace
  cert_manager_namespace                                           = var.cert_manager_namespace
  cert_manager_repository                                          = var.cert_manager_repository
  cert_manager_repository_path                                     = var.cert_manager_repository_path
  cert_manager_repository_revision                                 = var.cert_manager_repository_revision
  cert_manager_overwrite_values                                    = var.cert_manager_overwrite_values
  is_selfheal_enabled_cert_manager                                 = var.is_selfheal_enabled_cert_manager
  is_prune_enabled_cert_manager                                    = var.is_prune_enabled_cert_manager
}

module "traefik" {
  source                                                           = "../../../modules/service/terraform-traefik"
  argocd_namespace                                                 = var.argocd_namespace
  traefik_namespace                                                = var.traefik_namespace
  traefik_repository                                               = var.traefik_repository
  traefik_repository_path                                          = var.traefik_repository_path
  traefik_repository_revision                                      = var.traefik_repository_revision
  is_selfheal_enabled_traefik                                      = var.is_selfheal_enabled_traefik
  is_prune_enabled_traefik                                         = var.is_prune_enabled_traefik
  traefik_instances                                                = var.traefik_instances
}