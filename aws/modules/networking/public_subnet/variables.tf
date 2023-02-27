variable "environment" {
  type = string
  description = "Deployment Environment"
}

variable "vpc_id" {
  type = string
  description = "id of the vpc"
}

variable "public_subnets_cidr" {
  type        = list
  description = "CIDR block for Public Subnet"
}

variable "availability_zones" {
  type        = list
  description = "AZ in which all the resources will be deployed"
}