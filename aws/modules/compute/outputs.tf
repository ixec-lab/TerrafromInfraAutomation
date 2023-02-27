output "private_vm_id" {
  value = aws_instance.private_vm.*.id
}