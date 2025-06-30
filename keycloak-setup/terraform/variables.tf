variable "keycloak_url" {
  type        = string
  description = "Keycloak server URL"
}

variable "username" {
  type        = string
  description = "Keycloak admin user"
}

variable "password" {
  type        = string
  description = "Keycloak admin password"
}

variable "client_id" {
  type        = string
  description = "Keycloak client id"
}

variable "master_realm" {
  description = "Keycloak master realm"
  type        = string
}

variable "admin_client_id" {
  description = "Keycloak admin client id"
  type        = string
}