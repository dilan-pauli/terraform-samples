provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  tenant_id                  = var.tenant_id

  features {
    app_configuration {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }
  }
}

variable "provider_token" {
  type = string
  sensitive = true
}

provider "fakewebservices" {
  token = var.provider_token
}