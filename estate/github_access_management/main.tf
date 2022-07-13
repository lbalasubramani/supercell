resource "github_repository_collaborator" "gh_access_management" {
  for_each   = var.outside_collaborators
  repository = "kube-foundation"
  username   = each.key
  permission = each.value
}