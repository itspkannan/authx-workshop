
terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "~> 4.0"
    }
  }
}


provider "keycloak" {
  client_id     = var.admin_client_id
  username      = var.username
  password      = var.password
  url           = var.keycloak_url
  realm         = "master"
}