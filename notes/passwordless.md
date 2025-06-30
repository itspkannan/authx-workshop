# PKCE Flow - Implementing OAuth 2.0 Without Password (PKCE Flow)

If you want to implement OAuth **without using a client secret** (e.g., in a frontend or mobile app), you should use **PKCE (Proof Key for Code Exchange)** instead of the traditional authorization code flow.

## 1. Why PKCE?

✅ **No client secret needed** – Suitable for frontend & mobile apps.  
✅ **More secure** – Prevents interception attacks.  
✅ **Recommended for SPA (Single Page Apps) & Mobile apps** – No risk of exposing credentials.

## 2. How PKCE Flow Works

PKCE (Proof Key for Code Exchange) adds an **extra security layer** by using a **code challenge and verifier**.

### PKCE Steps

1. **User clicks "Login with Keycloak"**

   - The frontend generates a **random string** called the **code_verifier**.
   - It then hashes it using SHA-256 to create a **code_challenge**.
   - Redirects user to Keycloak with `code_challenge`.

2. **User logs in on Keycloak**

   - Keycloak authenticates and sends an **authorization code** to the callback URL.

3. **Exchange Authorization Code for Token**

   - The app sends **authorization code + original code_verifier**.
   - Keycloak verifies if `code_challenge` matches `code_verifier`.
   - If valid, Keycloak returns the **access token**.

## 3. Implementing PKCE with Keycloak (Flask Example)

Modify your `app.py` to implement PKCE.

### Step 1: Install `pkce` Library

```sh
pip install flask requests pkce
```

### Step 2: Update Flask App (`app.py`)

```python
from flask import Flask, redirect, request, session, jsonify
import requests
import pkce
import base64
import os

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Keycloak Configuration
KEYCLOAK_SERVER = "http://localhost:8080"
REALM = "myrealm"
CLIENT_ID = "myclient"
REDIRECT_URI = "http://localhost:5000/callback"

# Generate PKCE Code Verifier and Challenge
def generate_pkce():
    code_verifier = pkce.generate_code_verifier(length=64)
    code_challenge = pkce.get_code_challenge(code_verifier)
    return code_verifier, code_challenge

@app.route("/")
def home():
    return '<a href="/login">Login with Keycloak (PKCE)</a>'

@app.route("/login")
def login():
    # Generate a new PKCE challenge for each login
    code_verifier, code_challenge = generate_pkce()
    session["code_verifier"] = code_verifier  # Store code verifier in session

    auth_url = f"{KEYCLOAK_SERVER}/realms/{REALM}/protocol/openid-connect/auth" \
               f"?client_id={CLIENT_ID}" \
               f"&response_type=code" \
               f"&scope=openid" \
               f"&redirect_uri={REDIRECT_URI}" \
               f"&code_challenge={code_challenge}" \
               f"&code_challenge_method=S256"
    
    return redirect(auth_url)

@app.route("/callback")
def callback():
    code = request.args.get("code")  # Extract the authorization code
    code_verifier = session.get("code_verifier")  # Retrieve the original code verifier

    if not code_verifier:
        return jsonify({"error": "Missing PKCE code verifier"}), 400

    # Step 1: Exchange the authorization code for an access token
    token_url = f"{KEYCLOAK_SERVER}/realms/{REALM}/protocol/openid-connect/token"
    
    data = {
        "client_id": CLIENT_ID,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": REDIRECT_URI,
        "code_verifier": code_verifier,  # Send the original verifier
    }

    response = requests.post(token_url, data=data, headers={"Content-Type": "application/x-www-form-urlencoded"})
    token_info = response.json()

    if "access_token" in token_info:
        session["access_token"] = token_info["access_token"]
        return jsonify(token_info)
    else:
        return jsonify({"error": "Failed to get access token"}), 400

# Protected Route: Get User Info
@app.route("/userinfo")
def userinfo():
    access_token = session.get("access_token")
    if not access_token:
        return jsonify({"error": "User not authenticated"}), 401

    user_info_url = f"{KEYCLOAK_SERVER}/realms/{REALM}/protocol/openid-connect/userinfo"
    headers = {"Authorization": f"Bearer {access_token}"}
    response = requests.get(user_info_url, headers=headers)

    return jsonify(response.json())

if __name__ == "__main__":
    app.run(debug=True, port=5000)
```

## 4. Key Changes in PKCE Flow

🔹 **No Client Secret** → Unlike regular OAuth, PKCE does not require a client secret.  
🔹 **Uses `code_challenge` and `code_verifier`** → To prevent interception attacks.  
🔹 **Session Stores `code_verifier`** → Needed to validate token exchange.


## 6. Why PKCE is Better?

| Feature | Traditional OAuth | PKCE |
|---------|----------------|------|
| Requires Client Secret | ✅ Yes | ❌ No |
| Secure for Frontend Apps | ❌ No | ✅ Yes |
| Prevents Code Interception | ❌ No | ✅ Yes |
| Suitable for Mobile Apps | ❌ No | ✅ Yes |

### Recommended Use Cases for PKCE

- 🌐 **Single Page Apps (React, Vue, Angular)**
- 📱 **Mobile Apps (iOS, Android)**
- 🔒 **Public Clients (Apps that cannot store secrets securely)**