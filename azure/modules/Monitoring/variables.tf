variable "resource_group_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "1-d0fcea80-playground-sandbox"
}

variable "Request_Count_Alert_name" {
  type        = string
  default     = "Request_Count_Alert"
}

variable "Action_group_name" {
  type        = string
  default = "Action_group"
}

variable "Lb-id" {
  type        = string
  
}