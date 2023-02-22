variable "project_id" {
  type = string
  description = "This is a project id that contains all resouces"
}

variable "region" {
  type = string
  description = "This is region where my physical machines can be found"
}

variable "zone" {
  type = string
  description = "This is a zone where region can be found"
}

variable "public_subnets_cidr" {
  type = list
  description = "This contains all public subnet ip"
}

variable "private_subnets_cidr" {
  type = list
  description = "This contains all public subnet ip"
}

variable "private_instance_count" {
  type = number
  description = "This is a count varibale to create x private machine"
}

variable "public_instance_count" {
  type = number
  description = "This is a count varibale to create x private machine"
}

variable "disable_health_check" {
  type = bool
  description = "This is boolean var acting like a switch to enable and disable the health check automatically"
}