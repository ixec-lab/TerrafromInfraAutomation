#le contenu de cette variable permet d'installer apache et d'eployer web-app 
variable "provisionning"{
    description = "To insall apache and show hello world and host name"
    type = string
    default = "#!/bin/bash\nsudo apt-get update\nsudo apt-get install -y apache2\nsudo sh -c 'echo \"<h1>Hello world from Azure $(hostname)</h1>\" > /var/www/html/index.html'"
}

variable "location" {
    type = string
  
}

variable "resource_group_name" {
    type = string

}

variable "subnet_id" {
    type = string
  
}

variable "vm1_name" {
    type = string
  
}

variable "vm2_name" {
    type = string
  
}