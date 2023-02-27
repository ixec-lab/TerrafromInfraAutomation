provider "aws" {
    region = "us-east-1"
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
}

provider "azurerm" {
    features{}
    skip_provider_registration = true
    subscription_id = var.subscription_id
}

module "aws" {
  source = "./aws"
}

module "azure" {
  source = "./azure"
  resource_group_name = var.resource_group_name
}

module "gcp" {
  source = "./gcp"
}
