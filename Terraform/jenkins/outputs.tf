# output "admin_ssh" {
#   value = " ssh -i ${local_file.admin_rsa_file.filename} -p ${local.ssh_port} ${local.admin_username}@${module.vm.vm_fqdn} "
# }

output "vm_fqdn" {
  value = " https://${module.vm.vm_fqdn} "
}

output "user_ssh" {
  value = [for user_name, user_value in local.users : " ${user_name} : ssh -i ~/.ssh/${user_value.private_ssh_key_name} -p ${local.ssh_port} ${user_name}@${module.vm.vm_fqdn} "]
}
