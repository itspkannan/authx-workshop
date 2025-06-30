# OAuth 2

OAuth 2.0 (Open Authorization) is an authorization framework that allows applications to securely access resources on behalf of a user without exposing their credentials. It is widely used for authentication and authorization in APIs, web applications, and microservices.


## How OAuth 2.0 Works

Imagine you want to log in to a third-party app using your Google account. Instead of sharing your Google password with that app, OAuth 2.0 allows Google to give the app limited access to your account securely.

### Key Players in OAuth 2.0

1. **Resource Owner** – The user (you) who wants to give access to their data.
2. **Client** – The app that wants to access the user’s data (e.g., a fitness app connecting to your Google account).
3. **Authorization Server** – The system that authenticates the user and grants access (e.g., Google).
4. **Resource Server** – The API or service that holds the user’s data (e.g., Google Drive, GitHub, etc.).


### Basic OAuth 2.0 Flow

1. **User Requests Access**  
   - You click “Login with Google” on an app.

2. **Authorization Request**  
   - The app redirects you to Google (Authorization Server) and asks for permission to access your data.

3. **User Grants Permission**  
   - You log in to Google and approve the access request.

4. **Authorization Code Issued**  
   - Google sends a temporary **authorization code** to the app.

5. **App Exchanges Code for Token**  
   - The app sends this authorization code to Google and requests an **access token**.

6. **Google Issues an Access Token**  
   - If the request is valid, Google sends back an **access token**.

7. **App Uses Access Token to Access Data**  
   - The app sends the access token to Google APIs (Resource Server) to fetch user data.


### Example Analogy

Think of OAuth 2.0 as a **hotel keycard system**:

1. You (user) go to the front desk (authorization server) and ask for a keycard (authorization).
2. The hotel staff (Google) verifies your booking (authentication).
3. You get a keycard (access token) that lets you access only your room (limited access).
4. You swipe the card (use the token) at your room door (API).
5. When your stay ends (token expires), the card stops working.


### Why OAuth 2.0?

✅ Secure – Users don’t share passwords.  
✅ Limited Access – Apps get only specific permissions (e.g., read-only, no delete access).  
✅ Token Expiry – If compromised, the token becomes useless after expiry.  
✅ Scalable – Works across web, mobile, and microservices.
