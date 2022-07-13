variable "environment" {
  description = "Environment name where S3 state bucket will be created"
  type        = string
}

variable "allowed_users" {
  description = "List of allowed users to make rw operation on state bucket"
  type        = list
}

variable "allowed_roles" {
  description = "List of allowed roles to make rw operation on state bucket"
  type        = list
}