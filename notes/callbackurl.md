# Why callback URL

### Purpose of the Callback URL in OAuth 2.0

The **callback URL (redirect URI)** is a crucial part of the OAuth 2.0 flow. It is the URL where the **OAuth provider (e.g., Keycloak, Google, GitHub)** sends the user **after they authenticate and authorize** access.

## How It Works in OAuth 2.0 Flow

1. **User Initiates Login**  
   - The application redirects the user to the **OAuth authorization server** (Keycloak in this case).
   
2. **User Logs In & Grants Permission**  
   - The user enters their credentials on the authorization server.
   - If authentication is successful, Keycloak **issues an authorization code**.

3. **OAuth Server Redirects to the Callback URL**  
   - The authorization server sends the **authorization code** to the **callback URL**.  
   - Example:
     ```
     http://localhost:5000/callback?code=AUTH_CODE
     ```

4. **App Exchanges Code for Access Token** 
   - The app takes the authorization code and **requests an access token** from the OAuth server.

5. **Access Token is Used for API Requests**  
   - The app now uses the **access token** to request user data from APIs.

## Why is the Callback URL Important?

✔ **Ensures the response is sent to the correct app**  
✔ **Prevents unauthorized redirects to malicious websites**  
✔ **Used to securely exchange the authorization code for an access token**  
