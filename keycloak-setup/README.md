# Keycloak Setup 


## Project Structure

```bash
keycloak-setup/
├── docker-compose.yml
├── keycloak/
│   └── Dockerfile
├── terraform/
    ├── main.tf                 
    ├── provider.tf             
    ├── variables.tf            
    └── modules/
        ├── realm/
        │   └── main.tf        
        ├── client/
        │   └── main.tf         
        └── user/
            └── main.tf        

└── .env

```

## Commands

```bash
❯ make help

Available commands:
  apply.terraform Apply terraform confirguration
  create.network  Create a network
  help            Print help message
  init.keycloak   Provision Keycloak Service
  init.terraform  Initialize terraform Provider
  start.keycloak  Start Keycloak Service
  stop.keycloak   Start Keycloak Service
```

## 🔐 Identity Client Provisioning

We use Terraform to provision OAuth2 clients, users, and roles in the identity provider.

➡️ [View the Terraform setup for OAuth2 Clients](./auth-client-provisioning.md)

```bash
make init.terraform

make apply.terraform
```

The init combines provisioning `Keycloak` and also applying terraform.

```bash
❯ make init
[INFO] Creating docker network oauth2.
Error response from daemon: network with name oauth2 already exists
[+] Running 2/2
 ✔ Volume "authx_keycloak_data"  Created                                                                                                                                                                                                                                   0.0s
 ✔ Container authx               Started                                                                                                                                                                                                                                   0.1s
⏳ Waiting for Keycloak...
..
✅ Keycloak is ready.

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of mrparkers/keycloak from the dependency lock file
- Installing mrparkers/keycloak v4.4.0...
- Installed mrparkers/keycloak v4.4.0 (self-signed, key ID C50867915E116CD2)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # keycloak_openid_client.demo_client will be created
  + resource "keycloak_openid_client" "demo_client" {
      + access_token_lifespan                     = (known after apply)
      + access_type                               = "CONFIDENTIAL"
      + admin_url                                 = (known after apply)
      + backchannel_logout_session_required       = true
      + base_url                                  = (known after apply)
      + client_authenticator_type                 = "client-secret"
      + client_id                                 = "demo-client"
      + client_offline_session_idle_timeout       = (known after apply)
      + client_offline_session_max_lifespan       = (known after apply)
      + client_secret                             = (sensitive value)
      + client_session_idle_timeout               = (known after apply)
      + client_session_max_lifespan               = (known after apply)
      + consent_required                          = (known after apply)
      + consent_screen_text                       = (known after apply)
      + description                               = (known after apply)
      + direct_access_grants_enabled              = true
      + display_on_consent_screen                 = (known after apply)
      + enabled                                   = true
      + exclude_session_state_from_auth_response  = (known after apply)
      + frontchannel_logout_enabled               = (known after apply)
      + full_scope_allowed                        = true
      + id                                        = (known after apply)
      + implicit_flow_enabled                     = (known after apply)
      + import                                    = false
      + name                                      = "Demo Client"
      + oauth2_device_authorization_grant_enabled = false
      + realm_id                                  = (known after apply)
      + resource_server_id                        = (known after apply)
      + root_url                                  = (known after apply)
      + service_account_user_id                   = (known after apply)
      + service_accounts_enabled                  = true
      + standard_flow_enabled                     = true
      + use_refresh_tokens                        = true
      + use_refresh_tokens_client_credentials     = false
      + valid_post_logout_redirect_uris           = (known after apply)
      + valid_redirect_uris                       = [
          + "authx.provider.local:8080/*",
        ]
      + web_origins                               = (known after apply)
    }

  # keycloak_realm.demo will be created
  + resource "keycloak_realm" "demo" {
      + access_code_lifespan                     = (known after apply)
      + access_code_lifespan_login               = (known after apply)
      + access_code_lifespan_user_action         = (known after apply)
      + access_token_lifespan                    = (known after apply)
      + access_token_lifespan_for_implicit_flow  = (known after apply)
      + action_token_generated_by_admin_lifespan = (known after apply)
      + action_token_generated_by_user_lifespan  = (known after apply)
      + browser_flow                             = (known after apply)
      + client_authentication_flow               = (known after apply)
      + client_session_idle_timeout              = (known after apply)
      + client_session_max_lifespan              = (known after apply)
      + direct_grant_flow                        = (known after apply)
      + docker_authentication_flow               = (known after apply)
      + duplicate_emails_allowed                 = (known after apply)
      + edit_username_allowed                    = (known after apply)
      + enabled                                  = true
      + id                                       = (known after apply)
      + internal_id                              = (known after apply)
      + login_with_email_allowed                 = (known after apply)
      + oauth2_device_code_lifespan              = (known after apply)
      + oauth2_device_polling_interval           = (known after apply)
      + offline_session_idle_timeout             = (known after apply)
      + offline_session_max_lifespan             = (known after apply)
      + offline_session_max_lifespan_enabled     = false
      + realm                                    = "demo"
      + refresh_token_max_reuse                  = 0
      + registration_allowed                     = (known after apply)
      + registration_email_as_username           = (known after apply)
      + registration_flow                        = (known after apply)
      + remember_me                              = (known after apply)
      + reset_credentials_flow                   = (known after apply)
      + reset_password_allowed                   = (known after apply)
      + revoke_refresh_token                     = false
      + ssl_required                             = "external"
      + sso_session_idle_timeout                 = (known after apply)
      + sso_session_idle_timeout_remember_me     = (known after apply)
      + sso_session_max_lifespan                 = (known after apply)
      + sso_session_max_lifespan_remember_me     = (known after apply)
      + user_managed_access                      = false
      + verify_email                             = (known after apply)
    }

  # keycloak_role.admin_role will be created
  + resource "keycloak_role" "admin_role" {
      + id       = (known after apply)
      + name     = "admin"
      + realm_id = (known after apply)
    }

  # keycloak_user.testuser will be created
  + resource "keycloak_user" "testuser" {
      + email          = "testuser@demo.com"
      + email_verified = true
      + enabled        = true
      + id             = (known after apply)
      + realm_id       = (known after apply)
      + username       = "testuser"

      + initial_password {
          + temporary = false
          + value     = (sensitive value)
        }
    }

  # keycloak_user_roles.testuser_roles will be created
  + resource "keycloak_user_roles" "testuser_roles" {
      + exhaustive = true
      + id         = (known after apply)
      + realm_id   = (known after apply)
      + role_ids   = (known after apply)
      + user_id    = (known after apply)
    }

Plan: 5 to add, 0 to change, 0 to destroy.
keycloak_realm.demo: Creating...
keycloak_realm.demo: Creation complete after 0s [id=demo]
keycloak_role.admin_role: Creating...
keycloak_user.testuser: Creating...
keycloak_openid_client.demo_client: Creating...
keycloak_role.admin_role: Creation complete after 0s [id=9d97d608-4adb-450b-81c8-f25dfae65271]
keycloak_user.testuser: Creation complete after 0s [id=1cdd3c5f-7e52-4a08-8fcf-6f572f577ff6]
keycloak_user_roles.testuser_roles: Creating...
keycloak_openid_client.demo_client: Creation complete after 0s [id=2962059b-1bf4-4238-999d-419aa8206475]
keycloak_user_roles.testuser_roles: Creation complete after 0s [id=demo/1cdd3c5f-7e52-4a08-8fcf-6f572f577ff6]
```


## Reference


1. [Terraform Keycloak Provider](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs)