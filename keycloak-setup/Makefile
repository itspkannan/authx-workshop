TERRAFORM_DIR := terraform
TERRAFORM_IMAGE = hashicorp/terraform:1.8
DOCKER_NETWORK = auth_network
PROJECT = authx
DOCKER_COMPOSE_CMD = docker compose -p $(PROJECT)
TF_LOG = ERROR
KEYCLOAK_HOSTNAME=authx.provider.local
KEYCLOAK_PORT=8080
KEYCLOAK_URL=http://$(KEYCLOAK_HOSTNAME):$(KEYCLOAK_PORT)

include .env
export $(shell sed 's/=.*//' .env)

.DEFAULT_GOAL := help

.PHONY: help
help: ## 📖 Print help message
	@echo "\n\033[1;33mAvailable commands:\033[0m" \
	    && awk -F ':.*## ' '/^[a-zA-Z0-9_.-]+:.*## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) \
	    | sort && echo ""

.PHONY: create.network
create.network: ## 🌐 Create a network
	@echo "[INFO] Creating docker network $(DOCKER_NETWORK)."
	@docker network create $(DOCKER_NETWORK) || true

init.keycloak: create.network ## 🛠️ Provision Keycloak Service
	@DOCKER_NETWORK=$(DOCKER_NETWORK) $(DOCKER_COMPOSE_CMD)  up -d

debug.env:
	@cd terraform && docker run --rm --env-file $(PWD)/.env --network $(DOCKER_NETWORK) busybox env

wait.keycloak:
	@echo "⏳ Waiting for Keycloak..."
	@until docker run --env-file .env --rm --network $(DOCKER_NETWORK) curlimages/curl:latest \
		-s $(KEYCLOAK_URL)/realms/master/.well-known/openid-configuration > /dev/null; do \
		printf "."; sleep 5; \
	done; \
	echo "\n✅ Keycloak is ready."

start.keycloak: create.network ## ▶️ Start Keycloak Service
	@DOCKER_NETWORK=$(DOCKER_NETWORK) $(DOCKER_COMPOSE_CMD)  up -d

stop.keycloak: ## ⏹️ Stop Keycloak Service
	@DOCKER_NETWORK=$(DOCKER_NETWORK) $(DOCKER_COMPOSE_CMD) down

init.terraform: ## 📦 Initialize terraform Provider
	@docker run --rm -v $(PWD)/terraform:/workspace -e TF_LOG=$(TF_LOG) \
		 -w /workspace --network $(DOCKER_NETWORK) --env-file $(PWD)/.env $(TERRAFORM_IMAGE) init

plan.terraform: ## 📦 Plan to check the changes
	@docker run --rm -v $(PWD)/terraform:/workspace -e TF_LOG=$(TF_LOG) \
		 -w /workspace --network $(DOCKER_NETWORK) --env-file $(PWD)/.env $(TERRAFORM_IMAGE) plan

apply.terraform: ## ⚙️ Apply terraform configuration
	@docker run --rm -v $(PWD)/terraform:/workspace \
		-e TF_LOG=$(TF_LOG) -w /workspace --network $(DOCKER_NETWORK) $(TERRAFORM_IMAGE) apply -auto-approve

taint.user:
	@docker run --rm -v $(PWD)/terraform:/workspace \
		-e TF_LOG=$(TF_LOG) -w /workspace --network $(DOCKER_NETWORK) $(TERRAFORM_IMAGE) taint module.user.keycloak_user.testuser


output.terraform: ## ⚙️ Output terraform configuration
	@docker run --rm -v $(PWD)/terraform:/workspace \
		-e TF_LOG=$(TF_LOG) -w /workspace --network $(DOCKER_NETWORK) $(TERRAFORM_IMAGE) output

generate.env: ## 🧪 Generate .env file from Terraform outputs
	@echo "[INFO] Generating .env from terraform output..."
	@docker run --rm -v $(PWD)/terraform:/workspace -w /workspace \
		$(TERRAFORM_IMAGE) output -json \
		| jq -r 'to_entries[] | "\(.key | ascii_upcase)=\(.value.value)"' > .env.generated
	@echo "[INFO] Generated .env.generated"
	
init: init.keycloak wait.keycloak init.terraform plan.terraform apply.terraform

clean.terraform:  ## 🧼 Cleanup all the terraform files created
	@docker run --rm -v $(PWD)/terraform:/workspace -w /workspace \
	--network $(DOCKER_NETWORK) --env-file $(PWD)/.env $(TERRAFORM_IMAGE) init && \
	docker run --rm -v $(PWD)/terraform:/workspace -w /workspace \
	--network $(DOCKER_NETWORK) --env-file $(PWD)/.env $(TERRAFORM_IMAGE) destroy -auto-approve || true
	@rm -rf terraform/.terraform terraform/terraform.tfstate*

clean.keycloak: ## 🧼 Clean up Keycloak container and volume
	@docker volume rm keycloak_data || true

clean: clean.terraform stop.keycloak clean.keycloak ## 🧼 Cleanup all the resources created

.PHONY: test
test: ## 🧪 Test the setup
	echo "🚀 Attempting token retrieval..."
	max_retries=3; \
	count=0; \
	while true; do \
	  response=$$(docker run --env-file .env --rm --network $(DOCKER_NETWORK) curlimages/curl:latest \
	    -s -o /dev/null -w "%{http_code}" \
	    -X POST ${KEYCLOAK_URL}/realms/${REALM}/protocol/openid-connect/token \
	    -H "Content-Type: application/x-www-form-urlencoded" \
	    -d "client_id=${CLIENT_ID}" \
	    -d "client_secret=${CLIENT_SECRET}" \
	    -d "username=${USERNAME}" \
	    -d "password=${PASSWORD}" \
	    -d "grant_type=password"); \
		echo  response ;\
	  if [ "$$response" = "200" ]; then \
	    echo "✅ Token retrieval successful!"; \
	    break; \
	  fi; \
	  count=$$((count + 1)); \
	  if [ $$count -ge $$max_retries ]; then \
	    echo "❌ Token retrieval failed after $$max_retries attempts."; \
	    exit 1; \
	  fi; \
	  echo "⏳ Retry $$count of $$max_retries..."; \
	  sleep 2; \
	done