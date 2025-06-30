# OAuth 2.0 Grant Types

OAuth 2.0 has different **grant types**, depending on the type of application and security requirements.


## 1. OAuth 2.0 Grant Types (Authorization Flows)

### **a) Authorization Code Flow (Most Secure)**
**Used for:** Web apps, mobile apps (recommended for most scenarios)  
**Why?** Uses **authorization code** instead of directly exposing access tokens.  

🔹 **Flow:**
1. User clicks "Login with Google."
2. App redirects the user to Google’s authorization server.
3. User logs in and approves the request.
4. Google sends an **authorization code** back to the app.
5. The app exchanges this code with Google to get an **access token**.
6. The app uses the access token to fetch user data.

✅ **Security**: Tokens are never exposed to the browser.  
✅ **Best Practice**: Use **PKCE (Proof Key for Code Exchange)** for added security in mobile apps.

### b) Client Credentials Flow (Machine-to-Machine)
**Used for:** Backend-to-backend services (e.g., microservices)  
**Why?** No user involvement; uses a **client ID and secret** for authentication.

🔹 **Flow:**
1. The backend service sends a request to the authorization server with **client ID and secret**.
2. The authorization server verifies the credentials and returns an **access token**.
3. The service uses the token to access APIs.

✅ **Example Use Case:** A logging service needs access to a monitoring API.


### c) Implicit Flow (Deprecated)
**Used for:** Single-page applications (SPAs) in the past, but now **not recommended** due to security risks.

🔹 **Flow:** Similar to the Authorization Code Flow, but the **access token is sent directly to the browser** instead of using an authorization code.

🚨 **Why Deprecated?** The token is exposed in the browser’s URL, making it vulnerable to attacks.

### d) Resource Owner Password Credentials Flow (Not Recommended)
**Used for:** Trusted applications (e.g., internal company apps).  
**Why?** Requires users to enter their **username and password** directly, which is a security risk.

🔹 **Flow:**

1. User enters their **username and password** in the app.
2. The app sends credentials to the authorization server.
3. The authorization server returns an **access token**.

🚨 **Risk:** The app handles user credentials, increasing security vulnerabilities.  
🔹 **Better Alternative:** Use **Authorization Code Flow with PKCE** instead.

## 2. Access Tokens and Refresh Tokens

After successful authentication, the authorization server issues:

- **Access Token:** Short-lived (~1 hour), used to access APIs.
- **Refresh Token:** Long-lived, used to get a new access token **without asking the user to log in again**.

🔹 **Flow:**

1. When an access token expires, the app sends a refresh token to the authorization server.
2. The server validates it and issues a **new access token**.

✅ **Why Useful?** Users don’t need to keep logging in.


## 3. OAuth 2.0 Security Best Practices

🔒 **Use PKCE** – Prevents code interception attacks.  
🔒 **Never store tokens in local storage** – Use **HTTP-only** secure cookies.  
🔒 **Rotate access tokens** – Avoid long-lived tokens to reduce risk.  
🔒 **Validate tokens** – Always verify JWT signatures (if using JWT-based OAuth).  
🔒 **Use refresh tokens carefully** – Store them securely (e.g., encrypted).  

## 4. Example Implementation (OAuth 2.0 in a Web App with Google Login)

Let’s say you’re building a web app where users can log in using their Google account.

### Step 1: Register Your App in Google Developer Console

- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Create a project
- Enable **OAuth consent screen**
- Generate **Client ID** and **Client Secret**
- Set **Redirect URI** (e.g., `https://yourapp.com/callback`)

### Step 2: Redirect User to Google for Authorization

Your app redirects users to:
```
https://accounts.google.com/o/oauth2/v2/auth?
  client_id=YOUR_CLIENT_ID
  &redirect_uri=https://yourapp.com/callback
  &response_type=code
  &scope=email profile
  &state=xyz
```

### Step 3: Exchange Authorization Code for Access Token

Your backend sends:
```http
POST https://oauth2.googleapis.com/token
Content-Type: application/x-www-form-urlencoded

client_id=YOUR_CLIENT_ID
&client_secret=YOUR_CLIENT_SECRET
&code=AUTHORIZATION_CODE
&redirect_uri=https://yourapp.com/callback
&grant_type=authorization_code
```
👉 Google responds with:
```json
{
  "access_token": "xyz",
  "expires_in": 3600,
  "refresh_token": "abc",
  "scope": "email profile",
  "token_type": "Bearer"
}
```

### Step 4: Use Access Token to Fetch User Data

Your app sends:
```http
GET https://www.googleapis.com/oauth2/v1/userinfo
Authorization: Bearer ACCESS_TOKEN
```
👉 Response:
```json
{
  "id": "12345",
  "email": "user@example.com",
  "name": "John Doe",
  "picture": "https://example.com/photo.jpg"
}
```

## 5. When to Use OAuth 2.0 vs. Other Auth Methods

| Use Case | Best Auth Method |
|----------|----------------|
| User logs into a web/mobile app | OAuth 2.0 (Authorization Code Flow + PKCE) |
| Backend-to-backend service | OAuth 2.0 (Client Credentials Flow) |
| User logs in with username/password | OAuth 2.0 (but avoid Password Flow) |
| API authentication for users | OAuth 2.0 with JWT tokens |
| API authentication for servers/microservices | OAuth 2.0 Client Credentials |

---

## **Next Steps**

1. **Hands-on practice** – Implement OAuth 2.0 login for a small web app.
2. **Understand JWT** – Many OAuth implementations use JWT (JSON Web Token).
3. **Explore OpenID Connect (OIDC)** – OAuth 2.0 + User Identity (Google, Facebook, etc.).
4. **Try OAuth with API Gateways** – Secure APIs with OAuth 2.0 (e.g., Kong, Apigee).

