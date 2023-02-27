# output "AWS-lb-dns" {
#   value = module.aws.Lb_DNS
# }

# output "Azure-lb-ip" {
#   value = module.azure.Lb-ip
# }

# show external ip address of load balancer
output "load-balancer-ip-address" {
  value = module.gcp.load-balancer-ip-address
}