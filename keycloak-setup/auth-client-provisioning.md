# 🔐 OAuth2 / OIDC Client Provisioning with Terraform

This Terraform module sets up an OAuth2-compliant client, a authx realm, a user, and associated roles within Keycloak. It is intended to simulate a real-world client configuration for testing OAuth2/OIDC-based authentication and authorization flows.

Here’s a clean, well-formatted `README` for your Terraform setup that provisions Keycloak/OAuth2 clients, users, and roles. Let's call the file: **`auth-client-provisioning.md`**


## 📦 What This Setup Includes

This configuration sets up:

* A new realm: `authx-realm`
* A backend OpenID client: `authx-client`
* An admin role: `admin`
* A user: `testuser` with password login enabled
* Assigns the admin role to the user


| Resource                 | Purpose                                                    |
| ------------------------ | ---------------------------------------------------------- |
| `keycloak_realm`         | Creates a new isolated realm: `authx-realm`                 |
| `keycloak_openid_client` | Configures a confidential OAuth2 client with redirect URIs |
| `keycloak_user`          | Creates a test user with username/password login           |
| `keycloak_role`          | Defines a realm-level role (`admin`)                       |
| `keycloak_user_roles`    | Assigns the `admin` role to the test user                  |


This Terraform configuration sets up a basic **Keycloak** environment with the following resources:


### 🔐 1. **Realm**

```hcl
resource "keycloak_realm" "authx"
```

* **Creates a new realm** called `authx-realm`.
* A *realm* in Keycloak is like a tenant — it manages users, credentials, roles, clients, etc.
* `enabled = true` activates the realm.

### ⚙️ 2. **OpenID Client**

```hcl
resource "keycloak_openid_client" "authx_client"
```

* **Registers a confidential client** in the `authx-realm`.
* Key fields:

  * `client_id = "authx-client"`: ID used by the application to connect.
  * `access_type = "CONFIDENTIAL"`: Indicates the client is a backend service (requires `client_secret`).
  * `valid_redirect_uris = ["authx.provider.local:8080/*"]`: Permitted redirect URIs.
  * `standard_flow_enabled = true`: Enables **Authorization Code Flow**.
  * `direct_access_grants_enabled = true`: Allows **Resource Owner Password Credentials Grant** (useful for username/password login).
  * `service_accounts_enabled = true`: Enables **client credentials grant** (useful for service-to-service calls).
  * `client_secret = "authx-client-secret"`: Secret for confidential access.

### 👮 3. **Role**

```hcl
resource "keycloak_role" "admin_role"
```

* **Creates a realm role** named `admin`.
* Realm roles are global to the realm and can be assigned to any user or client.

### 👤 4. **User**

```hcl
resource "keycloak_user" "testuser"
```

* **Creates a user** in the `authx-realm` with:

  * Username: `testuser`
  * Password: `testpassword` (not temporary)


### 🧾 5. **Assign Role to User**

```hcl
resource "keycloak_user_roles" "testuser_roles"
```

* **Assigns the `admin` role** to `testuser`.
