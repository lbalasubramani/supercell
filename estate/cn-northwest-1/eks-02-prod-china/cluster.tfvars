### GENERAL ###
name                      = "eks-02-prod-china"
ingress_nginx_domain_name = "eks-02-prod.labycore.cn"

### VPC ###
vpc_cidr               = "10.156.0.0/16"
vpc_azs                = ["cn-northwest-1a", "cn-northwest-1b", "cn-northwest-1c"]
vpc_private_subnets    = ["10.156.4.0/23", "10.156.6.0/23", "10.156.8.0/23"]
vpc_pod_subnets        = ["10.156.16.0/20", "10.156.32.0/20", "10.156.48.0/20"]
vpc_team_subnets       = ["10.156.72.0/21", "10.156.80.0/21", "10.156.88.0/21"]
vpc_public_subnets     = ["10.156.0.0/24", "10.156.1.0/24", "10.156.2.0/24"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = false
vpc_tags = {
  Terraform   = "true"
  Environment = "prod"
}
enable_ecr_dkr_endpoint              = true
ecr_dkr_endpoint_private_dns_enabled = true

### EKS CLUSTER ###
aws_account     = "830619862888"
aws_region      = "cn-northwest-1"
cluster_version = "1.19"
enable_irsa     = true
cluster_enabled_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler"
]
workers_additional_policies       = ["arn:aws-cn:iam::aws:policy/AmazonSSMManagedInstanceCore"]
worker_groups_launch_template     = []
k8s_service_account_namespace     = "kube-system"
k8s_service_account_name          = "cluster-autoscaler-aws-cluster-autoscaler"
enable_refresh_asg                = false
fluentd_roles_in_resource_account = []
enable_external_dns               = true
map_accounts                      = []
map_roles = [
  {
    rolearn = "arn:aws-cn:iam::830619862888:role/sc-china-cn-northwest-1-tf-codebuild-role-estate"
    username = "supercell-tf-codebuild-role-foundation"
    groups   = ["system:masters"]
  },
  {
    rolearn = "arn:aws-cn:iam::830619862888:role/cn-kube-prod-write"
    username = "{{SessionName}}"
    groups   = ["system:masters"]
  }
]
map_users = [
  {
    userarn = "arn:aws-cn:iam::830619862888:user/ext-ejagyugya.nc"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-ca"]
  },
  {
    userarn = "arn:aws-cn:iam::830619862888:user/ext-mstankevic.nc"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-ca"]
  },
  {
    userarn = "arn:aws-cn:iam::830619862888:user/ext-gergo.nagy"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-ca"]
  },
  {
    userarn = "arn:aws-cn:iam::830619862888:user/ext-svc-account-mce.nc"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-mce"]
  },
  {
    userarn = "arn:aws-cn:iam::830619862888:user/juho.arenius"
    username = "{{SessionName}}"
    groups   = ["system:masters"]
  }
]
worker_ami_owner_id         = "amazon"
worker_ami_owner_id_windows = "amazon"
nordcloud_whitelisted_vpn_addresses = [
  "52.214.217.132/32",
  "52.212.230.104/32",
  "35.173.8.42/32",  #NAT NONPROD
  "34.197.103.6/32", #NAT NONPROD
  "52.71.197.233/32" #NAT NONPROD
]
supercell_whitelisted_vpn_addresses = [
  "194.100.101.0/26",
  "194.100.73.96/28",
  "89.166.49.68/32",
  "194.197.123.204/32",
  "206.169.106.192/26",
  "174.47.30.128/26",
  "222.106.171.1/32",
  "211.177.183.194/32",
  "222.106.171.101/32",
  "211.177.183.201/32",
  "220.248.11.130/32",
  "180.167.188.100/32",
  "112.64.156.35/32",
  "180.167.188.96/28",
  "180.169.217.196/32",
  "220.248.11.134/32",
  "112.64.156.34/32"
]

node_group_template = [
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = ""
    max_capacity       = 10
    min_capacity       = 2
    name               = "cn-northwest-1a-supercell-general"
    pre_userdata       = <<-EOT
          #!/bin/bash
          set -o errexit
          set -o pipefail
          set -o nounset
          yum install -y amazon-ssm-agent
          systemctl enable amazon-ssm-agent
          systemctl start amazon-ssm-agent
          sysctl -w net.netfilter.nf_conntrack_max=524288
    EOT
    availability_zone  = "cn-northwest-1a"
    additional_tags = {
      "NodePoolId" = "general-cn-northwest-1a"
    }
  },
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = ""
    max_capacity       = 10
    min_capacity       = 2
    name               = "cn-northwest-1b-supercell-general"
    pre_userdata       = <<-EOT
          #!/bin/bash
          set -o errexit
          set -o pipefail
          set -o nounset
          yum install -y amazon-ssm-agent
          systemctl enable amazon-ssm-agent
          systemctl start amazon-ssm-agent
          sysctl -w net.netfilter.nf_conntrack_max=524288
    EOT
    availability_zone  = "cn-northwest-1b"
    additional_tags = {
      "NodePoolId" = "general-cn-northwest-1b"
    }
  },
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = ""
    max_capacity       = 10
    min_capacity       = 2
    name               = "cn-northwest-1c-supercell-general"
    pre_userdata       = <<-EOT
          #!/bin/bash
          set -o errexit
          set -o pipefail
          set -o nounset
          yum install -y amazon-ssm-agent
          systemctl enable amazon-ssm-agent
          systemctl start amazon-ssm-agent
          sysctl -w net.netfilter.nf_conntrack_max=524288
    EOT
    availability_zone  = "cn-northwest-1c"
    additional_tags = {
      "NodePoolId" = "general-cn-northwest-1c"
    }
  }
]
opa_namespace                       = "opa"
argocd_namespace                    = "argocd"
opa_repository                      = "https://git-codecommit.cn-northwest-1.amazonaws.com.cn/v1/repos/kube-foundation"
opa_repository_path                 = "k8s_components/gatekeeper"
opa_repository_revision             = "master"
opa_overwrite_values                = "values/opa.yaml"
is_prune_enabled                    = true
is_selfheal_enabled                 = true
rules_labels_enabled                = true
owner_label_excluded_namespaces     = ["argocd", "ingress-nginx", "kube-system", "kubernetes-dashboard", "managed-service-team", "monitoring", "aws-load-balancer-controller", "kf-opa", "cert-manager"]
rules_security_dockersocket_enabled = true
rules_security_host_aliases_enabled = true
rules_security_sysadmin_enabled     = true
rules_trusted_registries_enabled    = true
trusted_registries = [
  "830619862888.dkr.ecr.cn-northwest-1.amazonaws.com.cn",
  "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/amazon-k8s-cni-init",
  "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/amazon-k8s-cni",
  "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/cni-metrics-helper",
  "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/eks/coredns",
  "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn/eks/kube-proxy",
  "docker.io/jimmidyson/configmap-reload",
  "jimmidyson/configmap-reload",
  "quay.io/coreos/kube-state-metrics",
  "quay.io/coreos/prometheus-config-reloader",
  "quay.io/prometheus/node-exporter",
  "508085692393.dkr.ecr.cn-northwest-1.amazonaws.com.cn",
  "public.ecr.aws/aws-observability/aws-sigv4-proxy"
]
rules_network_force_https_enabled                                = false
rules_network_policies_enabled                                   = true
network_allow_all_network_policy_whitelisted_namespaces          = ["argocd", "monitoring", "kubernetes-dashboard", "kube-system", "managed-service-team", "ingress-nginx", "aws-load-balancer-controller", "traefik-api", "kf-opa", "cert-manager", "traefik"]
network_allow_all_network_policy_whitelisted_networkpolicy_names = ["allow-argocd-ns", "allow-managed-service-team-prometheus-kube-proxy", "allow-kubernetes-dashboard-ns", "allow-monitoring-ns", "allow-managed-service-team-ns", "allow-dashboard-metrics-scraper", "access-nginx", "traefik-api", "traefik-plain", "cert-manager", "traefik-secure"]
rules_node_port_service_enabled                                  = true
network_node_port_service_whitelisted_namespaces                 = [""]
network_node_port_service_whitelisted_services_names             = [""]
rules_load_balancer_service_enabled                              = true
network_load_balancer_service_whitelisted_namespaces             = ["ingress-nginx", "aws-load-balancer-controller", "traefik-api", "traefik"]
network_load_balancer_service_whitelisted_services_names         = ["ingress-nginx-controller", "aws-load-balancer-controller", "traefik-api", "traefik-plain", "traefik-secure"]
rules_resources_limits_enabled                                   = true
resources_limits_whitelisted_namespaces                          = ["argocd", "kube-system", "velero", "aws-load-balancer-controller"]
rules_argocd_enabled                                             = true
kubernetes_foundation_namespaces                                 = ["argocd", "aws-load-balancer-controller", "ingress-nginx", "kube-system", "kubernetes-dashboard", "managed-service-team", "monitoring", "velero", "kf-opa", "cert-manager", "traefik"]
rules_backup_restore_enabled                                     = true
rules_backup_create_enabled                                      = true

### cert-manager ###
cert_manager_namespace              = "cert-manager"
cert_manager_repository             = "https://git-codecommit.cn-northwest-1.amazonaws.com.cn/v1/repos/kube-foundation"
cert_manager_repository_path        = "k8s_components/cert-manager"
cert_manager_repository_revision    = "master"
is_prune_enabled_cert_manager       = true
is_selfheal_enabled_cert_manager    = true
cert_manager_overwrite_values       = "values/cert-manager.yaml"

### traefik ###
traefik_namespace              = "traefik"
traefik_repository             = "https://git-codecommit.cn-northwest-1.amazonaws.com.cn/v1/repos/kube-foundation"
traefik_repository_path        = "k8s_components/traefik"
traefik_repository_revision    = "master"
is_prune_enabled_traefik       = true
is_selfheal_enabled_traefik    = true
traefik_instances = {
  "traefik-plain" = {
    values: "values/traefik-plain.yaml"
  },
  "traefik-secure" = {
    values: "values/traefik-secure.yaml"
  }
} 