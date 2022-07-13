apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  repositories: |
    - url: ${GITHUB_REPO_URL}
      passwordSecret:
        name: github-token
        key: token
      usernameSecret:
        name: github-token
        key: username
  resource.exclusions: |
    - apiGroups:
      - "velero.io"
      kinds:
      - "Backup"
      clusters:
      - "*"