# Declare variables
variable "vsphere" {
  type = "map"

  default = {
    vcenter_server = ""
    user           = "administrator@vsphere.local"
    password       = "Pa55word!"
  }
}

variable "vm" {
  type = "map"

  default = {
    template_name  = "centos7-base"
    admin_user     = "root"
    admin_password = "Pa55word!"
    count          = "2"
  }
}
