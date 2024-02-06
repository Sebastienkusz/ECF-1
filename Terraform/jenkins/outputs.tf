output "admin_ssh" {
  value = " ssh -i ${local_file.admin_rsa_file.filename} ${local.admin_username}@${module.vm.vm_fqdn} "
}

output "vm_fqdn" {
  value = " http://${module.vm.vm_fqdn}:8080 "
}

output "first_password" {
  value = " ssh -i ${local_file.admin_rsa_file.filename} ${local.admin_username}@${module.vm.vm_fqdn} sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}