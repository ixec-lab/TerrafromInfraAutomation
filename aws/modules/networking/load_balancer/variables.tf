variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
  description = "id of the vpc"
}

variable "instance_count" {
  type = number
}

variable "public_subnet_id" {
  type = list
}

variable "private_vm_id" {
  type = list
}