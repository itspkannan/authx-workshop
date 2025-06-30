# TODO - OIDC/Ouath2 - Project Work Tracker

| #   | Task Description                                                         | 🛠️ Status    | 🔍 Notes                                   |
| --- | ------------------------------------------------------------------------ | ------------- | ------------------------------------------ |
| 1️⃣ | 🛡️ Create **Keycloak Instance**                                         | ✅  | Set up via Docker Compose or Helm chart    |
| 2️⃣ | 🔐 Create **Realm/User (Password Grant)** via Terraform                  | ✅  | Use Terraform with Keycloak provider       |
| 3️⃣ | 📥 Test **Token Retrieval** using created user (access + refresh tokens) | ✅  | Use `curl` or Postman                      |
| 4️⃣ | 🧩 Build **Microservice** (Sanic / Spring Boot)                          | 🔄  | Choose stack and scaffold project          |
|     | └ 🔁 Test healthcheck endpoint                                           | ❌ | `/health` or `/ping`                       |
|     | └ 🐳 Create Docker image                                                 | ❌  | Dockerfile + `.dockerignore` setup         |
|     | └ 💻 Test locally via CLI                                                | ❌ | Manual run: `python app.py` or `java -jar` |
|     | └ 🚀 Deploy via Docker Compose or K8s                                    | ❌ | Use `docker compose up` or `kubectl`       |
| 5️⃣ | 🔗 Integrate with **OAuth2 Provider** (Keycloak)                         | ❌ | Protect routes using token validation      |
| 6️⃣ | 🧪 End-to-End **Flow Test** with real token                              | ❌  | Login → Token → API Access                 |


* ✅ `Done`
* 🔄 `In Progress`
* ❌ `Not Started`

