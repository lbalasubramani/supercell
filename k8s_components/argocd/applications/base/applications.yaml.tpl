apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: calico
  namespace: argocd
spec:
  project: default

  source:
    repoURL: ${GITHUB_REPO_URL}
    targetRevision: HEAD
    path: k8s_components/calico/overlays/${EKS_CLUSTER_NAME}

  destination:
    server: https://kubernetes.default.svc

  syncPolicy:
    automated:
      selfHeal: true
