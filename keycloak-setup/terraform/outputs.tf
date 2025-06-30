output "client_id" {
  value = module.client.authx_client_id
}

output "client_secret" {
  value     = module.client.authx_client_secret
  sensitive = true
}