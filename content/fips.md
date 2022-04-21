+++
title = "FIPS (Federal Information Processing Standards)"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/fips.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "FIPS"
    identifier = "chef_infra/security/fips.md FIPS"
    parent = "chef_infra/security"
    weight = 30
+++

## What is FIPS?

Federal Information Processing Standards (FIPS) are federal standards
for computer systems used by contractors of government agencies and
non-military government agencies.

FIPS 140-2 is a specific federal government security standard used to
approve cryptographic modules. Chef Automate uses the OpenSSL FIPS
Object Module, which satisfies the requirements of software
cryptographic modules under the FIPS 140-2 standard. The OpenSSL Object
Module provides an API for invoking FIPS approved cryptographic
functions from calling applications.

### Who Ahould Enable FIPS?

You may be legally required to enable FIPS if you are a United States
non-military government agency, or are contracting with one. If you are
not sure if you need to enable FIPS, please check with your compliance
department.

### Who Should Not Enable FIPS?

You will only need to enable FIPS if you are a US non-military
government agency, or contracting with one, and you are contractually
obligated to meet federal government security standards. If you are not
a US non-military governmental agency, or you are not contracting with
one, and you are not contractually obligated to meet federal government
security standards, then do not enable FIPS. Chef products have robust
security standards even without FIPS, and FIPS prevents the use of
certain hashing algorithms you might want to use, so we only recommend
enabling FIPS if it is contractually necessary.

## Supported Products

**Supported:**

- [Chef Infra Client](/fips/#how-to-enable-fips-mode-for-the-chef-client)
- [Chef Workstation](/fips/#how-to-enable-fips-mode-for-workstations)
- [Chef Infra Server](/fips/#how-to-enable-fips-mode-for-the-chef-server)

**Unsupported:**

FIPS mode is not supported for Chef Infra Server add-ons. This includes Chef Manage.

## How to Enable FIPS Mode in the Operating System

### FIPS Kernel Settings

Windows and Red Hat Enterprise Linux can both be configured for FIPS
mode using a kernel-level setting. After FIPS mode is enabled at the
kernel level, the operating system will only use FIPS approved
algorithms and keys during operation.

All of the tools Chef produces that have FIPS support read this kernel
setting and default their mode of operation to match it with the
exception of the workstation, which requires designating a port in the
`fips_git_port` setting of the `cli.toml`. For the other Chef Infra tools,
Chef Infra Client, for example, if `chef-client` is run on an operating
system configured into FIPS mode and you run, that Chef Infra run will
automatically be in FIPS mode unless the user disables it.

To enable FIPS on your platform follow these instructions:

- [Red Hat Enterprise Linux 6](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/sect-Security_Guide-Federal_Standards_And_Regulations-Federal_Information_Processing_Standard.html)
- [Red Hat Enterprise Linux 7](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/chap-Federal_Standards_and_Regulations.html#sec-Enabling-FIPS-Mode)
- [Red Hat Enterprise Linux 8](https://www.redhat.com/en/blog/how-rhel-8-designed-fips-140-2-requirements)
- [Windows](https://technet.microsoft.com/en-us/library/cc750357.aspx)
- [Ubuntu](https://security-certs.docs.ubuntu.com/en/fips)

## How to Enable FIPS Mode for the Chef Infra Server

### Prerequisites

- Supported Systems - CentOS or Red Hat Enterprise Linux 6 or greater
- Chef Infra Server version 12.13 or greater

### Configuration

If you have FIPS compliance enabled at the kernel level and install or
reconfigure the Chef Infra Server then it will default to running in
FIPS mode.

To enable FIPS manually for the Chef Infra Server, can add `fips true`
to the `/etc/opscode/chef-server.rb` and reconfigure. For more
configuration information see [chef-server.rb Optional Settings](/server/config_rb_server_optional_settings/).

## How to Enable FIPS Mode for the Chef Infra Client

### Prerequisites

- Supported Systems - CentOS, Oracle Linux, Red Hat Enterprise Linux 6 or later, and Ubuntu
- Chef Infra Client 16.13 or later for Ubuntu systems

### Configuration

If you have FIPS compliance enabled at the kernel level, Chef Infra Client will default to running in FIPS mode. Otherwise, add `fips true` to the `/etc/chef/client.rb` or `C:\\chef\\client.rb`.

#### Bootstrap a Node Using FIPS

{{% knife_bootstrap_node_fips %}}
