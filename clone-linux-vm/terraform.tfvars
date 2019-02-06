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
  count          = "2"
  template_name  = "centos7-base"
  admin_user     = "root"
  admin_password = "Pa55word!"
  folder_name    = "DeployedVMs"
  name_prefix    = "linux-clone"
  subnet_prefix  = "10.0.0."
  ipv4_gateway   = "10.0.0.10"
}
