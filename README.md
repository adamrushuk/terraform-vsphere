# Terraform vSphere

## Purpose

Test **VMware vSphere** provisioning using **Terraform**.

> HashiCorp Terraform enables you to safely and predictably create, change, and improve infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.

## Preparation

Before you can use Terraform with vSphere, you will need to action the following steps:

1. Gain access to an existing vSphere environment, or [build your own vSphere environment](https://adamrushuk.github.io/nested-vsphere-on-physical-esxi/).
1. Clone this repo: `git clone git@github.com:adamrushuk/terraform-vsphere.git`
1. From the repo root, `cd` into a sub folder, eg `clone-windows-vm`
1. Update all variables in `terraform.tfvars` for your own vSphere environment.
1. Install Terraform with [Chocolatey](https://adamrushuk.github.io/commands/chocolatey/#installing-chocolatey): `choco install -y terraform`
1. Initialise Terraform (download plugins): `terraform init`

**NOTE**: To clone an existing VM using linked-clones, there is an assumption that you have created a VM with a
**single snapshot**: [https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#linked_clone](https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#linked_clone)

## Provisioning

Now that Terraform is installed and initialised, you can start provisioning into your vSphere environment.

### Plan

First, find out what will be provisioned _before_ applying the Terraform configuration:

`terraform plan`

### Apply

Now you can apply the Terraform configuration:

`terraform apply`

If you don't want to get prompted for your approval, use the `-auto-approve` option:

`terraform apply -auto-approve`
