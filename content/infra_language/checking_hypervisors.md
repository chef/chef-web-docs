+++
title = "Chef Infra Language: Checking Hypervisors"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Checking Hypervisors"
    identifier = "chef_infra/infra_language/checking_hypervisors.md Checking Hypervisors"
    parent = "chef_infra/infra_language"
+++

Chef Infra Client 15.8 and later include a number of helper methods for checking if a hypervisor host or guest.

## guest?

Determine if the current node is running under any virtualization environment.

## hypervisor?

Determine if the current node supports running guests under any virtualization environment.

## physical?

Determine if the current node is NOT running under any virtualization environment (bare-metal or hypervisor on metal).

## hyperv?

Determine if the current node is a Hyper-V guest.

## kvm?

Determine if the current node is a KVM guest.

## kvm_host?

Determine if the current node is a KVM host.

## lxc?

Determine if the current node is a LXC-based container.

## lxc_host?

Determine if the current node is a LXC host.

## parallels?

Determine if the current node is running under Parallels Desktop.

## parallels_host?

Determine if the current node is a Parallels Desktop host.

## vbox?

Determine if the current node is a VirtualBox guest.

## vbox_host?

Determine if the current node is a VirtualBox host.

## vmware?

Determine if the current node is a VMWare guest.

## vmware_host?

Determine if the current node is VMware host.

## vmware_desktop?

Determine if the current node is a guest on VMware desktop products (Fusion, Player, Workstation).

## vmware_vsphere?

Determine if the current node is a guest on VMware vSphere (aka ESXi).

## openvz?

Determine if the current node is an openvz guest.

## openvz_host?

Determine if the current node is an openvz host.

## vagrant?

Determine if the current node is running as a vagrant guest.

## vagrant_key?

Check if the `vagrant` key exists on the +node+ object. Note: This key is no longer populated by vagrant, but it is kept around for legacy purposes.

## vagrant_domain?

Check if `vagrantup.com` is included in the node's domain.

## vagrant_user?

Check if the system contains a `vagrant` user.
