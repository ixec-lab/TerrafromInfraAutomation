variable "environment" {
  type = string
  description = "Deployment Environment"
}

variable "vpc_id" {
  type = string
  description = "id of the vpc"
}

variable "instance_count" {
  type = number
  description = "How many vm we need to create"
}

variable "private_subnet_id" {
  type = list
}