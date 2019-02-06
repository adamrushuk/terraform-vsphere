output "vm_tools_status" {
  description = "VMware Tools Status for the provisoned VM."
  value       = "${vsphere_virtual_machine.vm.*.vmware_tools_status}"
}

output "vm_ips" {
  description = "All IP Addresses for the provisoned VM."
  value       = "${vsphere_virtual_machine.vm.*.guest_ip_addresses}"
}

output "vm_default_ip_address" {
  description = "Default IP Address of the provisoned VM."
  value       = "${vsphere_virtual_machine.vm.*.default_ip_address}"
}
