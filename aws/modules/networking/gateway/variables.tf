variable "vpc_id" {
  type = string
  description = "id of the vpc"
}

variable "environment" {
  type = string
  description = "Deployment Environment"
}

variable "public_route_table_id" {
  type = string
  description = "public route table id"
}
