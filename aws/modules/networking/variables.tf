


variable "environment" {
  type = string
  description = "Deployment Environment"
}



variable "public_subnets_cidr" {
  type        = list
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list
  description = "CIDR block for Private Subnet"
}

variable "region" {
  type = string
  description = "Region in which the bastion host will be launched"
}

variable "availability_zones" {
  type        = list
  description = "AZ in which all the resources will be deployed"
}


variable "vpc_cidr" {
  type = string
  description = "Cidr of the vpc"
}

variable "instance_count" {
  type = number
}

variable "private_vm_id" {
  type = list
}