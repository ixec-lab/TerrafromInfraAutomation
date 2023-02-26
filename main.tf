module "Networking" {
  source = "./modules/Networking"
  location = "South Central US"
  resource_group_name = "1-d5cbb08a-playground-sandbox"
  provisionning = "#!/bin/bash\nsudo apt-get update\nsudo apt-get install -y apache2\nsudo sh -c 'echo \"<h1>Hello world from Azure $(hostname)</h1>\" > /var/www/html/index.html'"
}
