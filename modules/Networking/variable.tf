variable "location" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "South Central US"
}

variable "resource_group_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "1-d0fcea80-playground-sandbox"
}


variable "subscription_id" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "4cedc5dd-e3ad-468d-bf66-32e31bdb9148"
}

#le contenu de cette variable permet d'installer apache et d'eployer web-app 
variable "provisionning"{
    description = "To insall apache and show hello world and host name"
    type = string
    default = "#!/bin/bash\nsudo apt-get update\nsudo apt-get install -y apache2\nsudo sh -c 'echo \"<h1>Hello world from Azure $(hostname)</h1>\" > /var/www/html/index.html'"
}

