terraform {
  required_version = ">= 0.12.9, != 0.13.0"
  required_providers {
    aws        = "= 3.44.0"
    github     = "= 4.0.1"
    local      = "= 1.4.0"
    null       = "= 2.1.2"
    template   = "= 2.2.0"
    random     = "= 3.0.1"
    kubernetes = "= 2.2.0"
    helm       = "= 2.1.2"
    cloudinit  = "= 2.2.0"
    kubectl    = {
        version = "= 1.11.1"
        source  = "gavinbunney/kubectl"
   }
    http    = {
         version = "= 2.4.1"
         source  = "terraform-aws-modules/http"
    }
 }
}