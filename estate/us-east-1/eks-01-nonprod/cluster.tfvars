### Tigera operator deployment with calico upgrade ###
### GENERAL ###
name                      = "eks-01-nonprod"
ingress_nginx_domain_name = "eks-01-nonprod.labycore.net"

### VPC ###
vpc_cidr               = "10.155.0.0/17"
vpc_azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_private_subnets    = ["10.155.4.0/23", "10.155.6.0/23", "10.155.8.0/23"]
vpc_pod_subnets        = ["10.155.16.0/20", "10.155.32.0/20", "10.155.48.0/20"]
vpc_team_subnets       = ["10.155.72.0/21", "10.155.80.0/21", "10.155.88.0/21"]
vpc_public_subnets     = ["10.155.0.0/24", "10.155.1.0/24", "10.155.2.0/24"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = false
vpc_tags = {
  Terraform   = "true"
  Environment = "nonprod"
}
### EKS CLUSTER ###
aws_account     = "322838227624"
aws_region      = "us-east-1"
cluster_version = "1.21"
enable_irsa     = true
cluster_enabled_log_types = [
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler"
]
workers_additional_policies   = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
worker_groups_launch_template = []
k8s_service_account_namespace = "kube-system"
k8s_service_account_name      = "cluster-autoscaler-aws-cluster-autoscaler"
enable_refresh_asg            = false
fluentd_roles_in_resource_account = [
  "arn:aws:iam::641077518693:role/Fluentd",
  "arn:aws:iam::824587598002:role/Fluentd",
  "arn:aws:iam::707619760283:role/Fluentd",
  "arn:aws:iam::220244140799:role/Fluentd",
  "arn:aws:iam::331512493740:role/Fluentd", ##game-tools-nonprod
  "arn:aws:iam::233271746422:role/Fluentd"  #community-tools-nonprod
]
enable_external_dns = true
map_accounts        = []
map_roles = [
  {
    rolearn = "arn:aws:iam::322838227624:role/sc-us-east-1-tf-codebuild-role-estate"
    username = "supercell-tf-codebuild-role-foundation"
    groups   = ["system:masters"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_clusters_6db1c626c9440ead"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-mce"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_administrators_73728a338a92772c"
    username = "{{SessionName}}"
    groups   = ["kubefoundation-ca"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_team_services_19eb60a91ec2c3d4"
    username = "{{SessionName}}"
    groups   = ["services-tools-nonprod-sva"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_team_player_support_095fdc82e4d4ed3a"
    username = "{{SessionName}}"
    groups   = ["ps-tools-nonprod-sva"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_developers_b1eca665bf713ad3"
    username = "{{SessionName}}"
    groups   = ["supercell:developers"]
  },
  {
    rolearn = "arn:aws:iam::322838227624:role/AWSReservedSSO_aws_kube_root_1ccd62b8a079f744"
    username = "{{SessionName}}"
    groups   = ["system:masters"]
  }
]
map_users = [
  {
    userarn = "arn:aws:iam::322838227624:user/ext-david.bladzich"
    username = "ext-david.bladzich"
    groups   = ["kubefoundation-ca"]
  },
  {
    userarn = "arn:aws:iam::322838227624:user/ext-gergo.nagy"
    username = "ext-gergo.nagy"
    groups   = ["kubefoundation-ca"]
  },
  {
    userarn = "arn:aws:iam::322838227624:user/juho.arenius"
    username = "juho.arenius"
    groups   = ["system:masters"]
  }
]
nordcloud_whitelisted_vpn_addresses = [
  "52.214.217.132/32",
  "52.212.230.104/32"
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
  "112.64.156.34/32",
  "193.110.108.35/32" # f-secure consultants
]

enable_application_load_balancer_controller = true

node_group_template = [
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = "--node-labels=nodepool=general"
    max_capacity       = 10
    min_capacity       = 2
    name               = "us-east-1a-supercell-general"
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
    availability_zone  = "us-east-1a"
    additional_tags = {
      "NodePoolId" = "general-us-east-1a"
    }
  },
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = "--node-labels=nodepool=general"
    max_capacity       = 10
    min_capacity       = 2
    name               = "us-east-1b-supercell-general"
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
    availability_zone  = "us-east-1b"
    additional_tags = {
      "NodePoolId" = "general-us-east-1b"
    }
  },
  {
    instance_types     = ["m5.xlarge"]
    kubelet_extra_args = "--node-labels=nodepool=general"
    max_capacity       = 10
    min_capacity       = 2
    name               = "us-east-1c-supercell-general"
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
    availability_zone  = "us-east-1c"
    additional_tags = {
      "NodePoolId" = "general-us-east-1c"
    }
  }
]
fargate_profiles = {
  gitops-tools-nonprod = {
    name = "gitops-tools-nonprod"
    selectors = [
      {
        namespace = "gitops-tools-nonprod-ops"
        labels = {
          run_on_fargate = "true"
        }
      },
      {
        namespace = "gitops-tools-nonprod-dev"
        labels = {
          run_on_fargate = "true"
        }
      }
    ]
  }
}
opa_namespace                       = "opa"
argocd_namespace                    = "argocd"
opa_repository                      = "https://github.com/supercell/kube-foundation"
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
  "322838227624.dkr.ecr.us-east-1.amazonaws.com/fluentd-kubernetes-daemonset",
  "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/coredns",
  "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/kube-proxy",
  "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon-k8s-cni-init",
  "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon-k8s-cni",
  "602401143452.dkr.ecr.us-west-2.amazonaws.com/cni-metrics-helper",
  "755069680103.dkr.ecr.us-east-1.amazonaws.com/supercell/sso.nginx",
  "argoproj/argocd",
  "bitnami/external-dns",
  "docker.io/bitnami/external-dns",
  "docker.io/jimmidyson/configmap-reload",
  "ghcr.io/dexidp/dex",
  "grafana/grafana",
  "immidyson/configmap-reload",
  "k8s.gcr.io",
  "kiwigrid/k8s-sidecar",
  "kubernetesui/dashboard",
  "kubernetesui/metrics-scraper",
  "openpolicyagent",
  "quay.io/calico",
  "quay.io/coreos",
  "quay.io/prometheus",
  "quay.io/tigera",
  "us.gcr.io",
  "755069680103.dkr.ecr.us-east-1.amazonaws.com",
  "205603863622.dkr.ecr.us-east-1.amazonaws.com",
  "322838227624.dkr.ecr.us-east-1.amazonaws.com",
  "amazon/aws-cli",
  "public.ecr.aws/aws-observability/aws-sigv4-proxy",
  "velero/velero",
  "velero/velero-plugin-for-aws",
  "garo5",
  "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon/aws-load-balancer-controller",
  "707619760283.dkr.ecr.us-east-1.amazonaws.com",
  "argoprojlabs/argocd-notifications",
  "redis",
  "busybox"
]
rules_network_force_https_enabled                                = false
rules_network_policies_enabled                                   = true
network_allow_all_network_policy_whitelisted_namespaces          = ["argocd", "monitoring", "kubernetes-dashboard", "kube-system", "managed-service-team", "ingress-nginx", "aws-load-balancer-controller", "traefik-api", "kf-opa", "cert-manager", "traefik"]
network_allow_all_network_policy_whitelisted_networkpolicy_names = ["allow-argocd-ns", "allow-managed-service-team-prometheus-kube-proxy", "allow-kubernetes-dashboard-ns", "allow-monitoring-ns", "allow-managed-service-team-ns", "allow-dashboard-metrics-scraper", "access-nginx", "traefik-api", "traefik-plain", "cert-manager", "traefik-secure",  "traefik-plain-test", "traefik-secure-test", "traefik-test"]
rules_node_port_service_enabled                                  = true
network_node_port_service_whitelisted_namespaces                 = ["cluster-testing"]
network_node_port_service_whitelisted_services_names             = ["dawid-example-kubernetes-app", "example-kubernetes-app"]
rules_load_balancer_service_enabled                              = true
network_load_balancer_service_whitelisted_namespaces             = ["ingress-nginx", "aws-load-balancer-controller", "traefik-api", "traefik"]
network_load_balancer_service_whitelisted_services_names         = ["ingress-nginx-controller", "aws-load-balancer-controller", "traefik-api", "traefik-plain", "traefik-secure",  "traefik-plain-test", "traefik-secure-test"]
rules_resources_limits_enabled                                   = true
resources_limits_whitelisted_namespaces                          = ["argocd", "kube-system", "velero", "aws-load-balancer-controller"]
rules_argocd_enabled                                             = true
kubernetes_foundation_namespaces                                 = ["argocd", "aws-load-balancer-controller", "ingress-nginx", "kube-system", "kubernetes-dashboard", "managed-service-team", "monitoring", "velero", "kf-opa", "cert-manager", "traefik"]
rules_backup_restore_enabled                                     = true
rules_backup_create_enabled                                      = true
sc_groups_with_global_ns_listing_perms = [
        {
                name = "supercell:developers"
                kind = "Group"
                api_group = "rbac.authorization.k8s.io"
        }
        ]
### cert-manager ###
cert_manager_namespace              = "cert-manager"
cert_manager_repository             = "https://github.com/supercell/kube-foundation"
cert_manager_repository_path        = "k8s_components/cert-manager"
cert_manager_repository_revision    = "master"
is_prune_enabled_cert_manager       = true
is_selfheal_enabled_cert_manager    = true

### traefik ###
traefik_namespace              = "traefik"
traefik_repository             = "https://github.com/supercell/kube-foundation"
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
