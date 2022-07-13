### GENERAL ###
variable "name" {}

### VPC ###
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "vpc_pod_subnets" {
  description = "A list of Kubernetes Pod subnets inside the VPC. These subnets should belong to one of the secondary ranges."
  type        = list(string)
  default     = []
}

variable "vpc_team_subnets" {
  description = "A list of subnets inside the VPC. These subnets will be shared with all teams accounts"
  type        = list(string)
  default     = []
}

variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "vpc_tags" {}

variable "enable_ecr_dkr_endpoint" {
  description = "Should be true if you want to provision an ecr dkr endpoint to the VPC"
  type        = bool
  default     = false
}

variable "ecr_dkr_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for ECR DKR endpoint"
  type        = bool
  default     = false
}

### EKS CLUSTER ###
variable "aws_region" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "aws_account" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "enable_irsa" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = false
}

variable "cluster_enabled_log_types" {
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
}

variable "workers_additional_policies" {
  description = "Additional policies to be added to workers"
  type        = list(string)
  default     = []
}

variable "k8s_service_account_namespace" {}

variable "k8s_service_account_name" {}

variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "enable_refresh_asg" {
  description = "Determines if EKS node autoscaling group will be refreshed after cluster deployment. Required for custom CNI configuration to be enabled for nodes"
  type        = bool
  default     = true
}

variable "fluentd_roles_in_resource_account" {
  description = "ARN of IAM Roles with Cloudwatch restricted permissions in resource account to allow fluentd to push logs."
  type        = list(any)
  default     = []
}

variable "ingress_nginx_domain_name" {
  description = "Name of the dns zone for default ingress-nginx"
}

variable "ingress_nginx_alternative_cert_hostnames" {
  description = "List of additional FQDNs for the default ingress-nginx certificate"
  type        = list(string)
  default     = []
}

variable "enable_external_dns" {
  description = "Determine if we want to attach IAM policy with R53 permissions needed for ExternalDNS"
  type        = bool
  default     = true
}

variable "map_accounts" {}
variable "map_roles" {}
variable "map_users" {}
variable "worker_ami_owner_id" {}
variable "worker_ami_owner_id_windows" {}

variable "supercell_whitelisted_vpn_addresses" {
  description = "List of Supercell VPN allowed CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
}

variable "nordcloud_whitelisted_vpn_addresses" {
  description = "List of Nordcloud VPN allowed CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
}

variable "enable_application_load_balancer_controller" {
  description = "Determine if we want to use application load balancer control - will create IAM resources for this component"
  type        = bool
  default     = false
}

variable "node_group_template" {
  description = "A list of maps defining node group configurations to be defined using AWS Launch Templates."
  type        = any
  default     = []
}

variable "fargate_profiles" {
  description = "Fargate profiles to create. See `fargate_profile` keys section in fargate submodule's README.md for more details"
  type        = any
  default     = {}
}

### OPA
variable "prefix_name" {
  description = "Prefix of the resource name"
  type        = string
  default     = null
}

## ArgoCD namespace
variable "argocd_namespace" {
  description = "Name of the ArgoCD namespace"
  type        = string
}

variable "opa_namespace" {
  description = "Name of kubernetes namespaces where all OPA kubernetes foundation components will be deployed"
  type        = string
  default     = "kf-opa"
}

### OPA
variable "opa_repository" {
  description = "OPA github repository to install OPA from"
  type        = string
  default     = "https://github.com/open-policy-agent/gatekeeper"
}

variable "opa_repository_path" {
  description = "Path within the OPA repo where the helm chart is located"
  type        = string
  default     = "charts/gatekeeper"
}

variable "opa_repository_revision" {
  description = "Revision to use for OPA"
  type        = string
  default     = "release-3.4"
}

variable "opa_overwrite_values" {
  description = "Path to file that contains override values for the OPA helm chart"
  type        = any
  default     = null
}

variable "destination_server" {
  description = "Destination server where application will be deployed to"
  type        = string
  default     = "https://kubernetes.default.svc"
}

variable "is_selfheal_enabled" {
  description = "ArgoCD option to selfheal application: true/false"
  type        = bool
  default     = true
}

variable "is_prune_enabled" {
  description = "Determine if ArgoCD can prun resources during sync command: true/false"
  type        = bool
  default     = true
}

### RULES
### OPA
variable "rules_labels_enabled" {
  description = "Determine if we want to enable owner label to be present on pod"
  type        = bool
  default     = true
}

variable "owner_label_excluded_namespaces" {
  description = "List of whitelisted namespaces which are not included in this rule"
  type        = list(any)
  default = [
    "argocd",
    "ingress-nginx",
    "kube-system",
    "kubernetes-dashboard",
    "managed-service-team",
    "monitoring",
    "aws-load-balancer-controller"
  ]
}

variable "rules_security_dockersocket_enabled" {
  description = "Determine if we want to enable gatekeeper rule security/dockerSocket"
  type        = bool
  default     = true
}

variable "rules_security_host_aliases_enabled" {
  description = "Determine if we want to enable gatekeeper rule security/hostAliases"
  type        = bool
  default     = true
}

variable "rules_security_sysadmin_enabled" {
  description = "Determine if we want to enable gatekeeper rule security/sysAdmin"
  type        = bool
  default     = true
}

variable "rules_trusted_registries_enabled" {
  description = "Determine if we want to enable gatekeeper rule trusted_registries"
  type        = bool
  default     = true
}

variable "trusted_registries" {
  description = "List of whitelisted registries we allowed pull images from"
  type        = list(any)
}

variable "rules_network_force_https_enabled" {
  description = "Determine if we want to enable gatekeeper rule network/forceHttps"
  type        = bool
  default     = false
}

variable "rules_network_policies_enabled" {
  description = "Determine if we want to enable gatekeeper rule network/allow_all_network_policy"
  type        = bool
  default     = true
}

variable "network_allow_all_network_policy_whitelisted_namespaces" {
  description = "List of whitelisted namespaces where we can create NetworkPolicy with open all ingress traffic"
  type        = list(any)
  default     = []
}

variable "network_allow_all_network_policy_whitelisted_networkpolicy_names" {
  description = "List of whitelisted  network policies names to be allowed to have open all ingress traffic"
  type        = list(any)
  default     = []
}

variable "rules_node_port_service_enabled" {
  description = "Determine if we want to enable gatekeeper rule network/node_port_service"
  type        = bool
  default     = true
}

variable "network_node_port_service_whitelisted_namespaces" {
  description = "List of whitelisted namespaces where we can create NodePort services names"
  type        = list(any)
  default     = ["cluster-testing"]
}

variable "network_node_port_service_whitelisted_services_names" {
  description = "List of whitelisted NodePort services names"
  type        = list(any)
  default     = ["dawid-example-kubernetes-app", "example-kubernetes-app", "example-kubernetes-app2"]
}

variable "rules_load_balancer_service_enabled" {
  description = "Determine if we want to enable gatekeeper rule network/load_balancer_service"
  type        = bool
  default     = true
}

variable "network_load_balancer_service_whitelisted_namespaces" {
  description = "List of whitelisted namespaces where we can create loadBalancer services names"
  type        = list(any)
  default     = ["cluster-testing"]
}

variable "network_load_balancer_service_whitelisted_services_names" {
  description = "List of whitelisted loadBalancer services names"
  type        = list(any)
  default     = ["dawid-example-kubernetes-app", "example-kubernetes-app", "example-kubernetes-app2"]
}

variable "rules_resources_limits_enabled" {
  description = "Determine if we want to enable gatekeeper rule network/load_balancer_service"
  type        = bool
  default     = true
}

variable "resources_limits_whitelisted_namespaces" {
  description = "List of whitelisted namespaces where we don't have to setup limits for resources"
  type        = list(any)
  default     = []
}

variable "rules_argocd_enabled" {
  description = "Determine if we want to enable gatekeeper rule argocd"
  type        = bool
  default     = true
}

variable "kubernetes_foundation_namespaces" {
  description = "List of namespaces for kubernetes foundation components"
  type        = list(any)
  default     = []
}

variable "rules_backup_restore_enabled" {
  description = "Determine if we want to enable gatekeeper rule backup/restore"
  type        = bool
  default     = true
}

variable "rules_backup_create_enabled" {
  description = "Determine if we want to enable gatekeeper rule backup/create"
  type        = bool
  default     = true
}

### cert-manager

variable "cert_manager_namespace" {
  description = "Name of kubernetes namespaces where all cert-manager kubernetes foundation components will be deployed"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_repository" {
  description = "cert-manager github repository to install OPA from"
  type        = string
  default     = "https://git-codecommit.cn-northwest-1.amazonaws.com.cn/v1/repos/kube-foundation"
}

variable "cert_manager_repository_path" {
  description = "Path within the cert-manager repo where the helm chart is located"
  type        = string
  default     = "k8s_components/cert-manager"
}

variable "cert_manager_repository_revision" {
  description = "Revision to use for cert-manager"
  type        = string
  default     = "master"
}

variable "cert_manager_overwrite_values" {
  description = "Path to file that contains override values for the cert-manager helm chart"
  type        = any
  default     = null
}

variable "is_selfheal_enabled_cert_manager" {
  description = "ArgoCD option to selfheal application: true/false"
  type        = bool
  default     = true
}

variable "is_prune_enabled_cert_manager" {
  description = "Determine if ArgoCD can prun resources during sync command: true/false"
  type        = bool
  default     = true
}

### traefik
variable "traefik_repository" {
  description = "traefik github repository to install OPA from"
  type        = string
  default     = "https://git-codecommit.cn-northwest-1.amazonaws.com.cn/v1/repos/kube-foundation"
}

variable "traefik_namespace" {
  description = "Name of kubernetes namespaces where all traefik kubernetes foundation components will be deployed"
  type        = string
  default     = "traefik"
}

variable "traefik_repository_path" {
  description = "Path within the traefik repo where the helm chart is located"
  type        = string
  default     = "k8s_components/traefik"
}

variable "traefik_repository_revision" {
  description = "Revision to use for traefik"
  type        = string
  default     = "master"
}

variable "traefik_instances" {
  description = "Traefik instances with their specific settings"
  type = map(object({
    values   = string
  }))
  default     = null
}

variable "is_selfheal_enabled_traefik" {
  description = "ArgoCD option to selfheal application: true/false"
  type        = bool
  default     = true
}

variable "is_prune_enabled_traefik" {
  description = "Determine if ArgoCD can prun resources during sync command: true/false"
  type        = bool
  default     = true
}