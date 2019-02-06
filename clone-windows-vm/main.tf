# vSphere connection
provider "vsphere" {
  vsphere_server = "${var.vsphere["server"]}"
  user           = "${var.vsphere["user"]}"
  password       = "${var.vsphere["password"]}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# Data sources
data "vsphere_datacenter" "dc" {
  name = "${var.vsphere["datacenter_name"]}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere["datastore_name"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere["cluster_name"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere["network_name"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vm["template_name"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Clone VM from template
resource "vsphere_virtual_machine" "vm" {
  count            = "${var.vm["count"]}"
  name             = "${var.vm["name_prefix"]}${count.index + 1}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.vm["folder_name"]}"
  num_cpus         = 2
  memory           = 4096
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "Hard disk 1"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone  = true

    customize {
      windows_options {
        computer_name  = "${var.vm["name_prefix"]}${count.index + 1}"
        workgroup      = "workgroup"
        admin_password = "${var.vm["admin_password"]}"
      }

      network_interface {
        ipv4_address = "${var.vm["subnet_prefix"]}${count.index + 100}"
        ipv4_netmask = 24
      }

      ipv4_gateway = "${var.vm["ipv4_gateway"]}"
    }
  }

  # Remote exec will not work until you configure WinRM to accept insecure connections
  # Unfortunately vSphere clears these insecure settings during customisation (sysprep)
  # provisioner "remote-exec" {
  #   inline = [
  #     "'$(Get-Date) test text from terraform remote-exec' | Set-Content -Path '~\test.txt'",
  #   ]

  #   connection {
  #     type     = "winrm"
  #     user     = "${var.vm["admin_user"]}"
  #     password = "${var.vm["admin_password"]}"
  #     insecure = true
  #   }
  # }

  # Uncomment to not wait for an available IP address on the virtual machine
  # wait_for_guest_net_timeout = 0
}
