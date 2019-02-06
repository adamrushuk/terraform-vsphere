# Assign variables
# vSphere vars
vsphere = {
  # Connection details
  vcenter_server = "vcsa.lab.local"
  user           = "administrator@vsphere.local"
  password       = "Pa55word!"

  # Cluster details (where cloned VMs will be created)
  datacenter_name = "Datacenter"
  cluster_name    = "VSAN-Cluster"
  datastore_name  = "vsanDatastore"
  network_name    = "VM Network"
}

# VM vars
vm = {
  count          = "3"
  template_name  = "w2012r2-base"
  admin_user     = "Administrator"
  admin_password = "Pa55word!"
  folder_name    = "DeployedVMs"
  name_prefix    = "winclone"
  subnet_prefix  = "10.0.0."
  ipv4_gateway   = "10.0.0.10"
}
