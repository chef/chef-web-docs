+++
title = "Chef 360 SaaS system requirements"

[menu.cloud]
title = "System requirements"
identifier = "chef_cloud/360/requirements"
parent = "chef_cloud/360"
weight = 20
+++

This reference lists the network, connectivity, and platform requirements for enrolling nodes and running skills in Chef 360 SaaS.

## Description

Chef 360 SaaS nodes must meet network and connectivity requirements before you can enroll them, and skills must run on a supported platform.
You can enroll a node with a Chef Infra cookbook or with server-side or client-side enrollment directly from Chef 360 SaaS.
Each enrollment method has its own connectivity, port, and credential requirements.

## Node requirements

Choose one of the following methods to enroll a node: cookbook-based, server-side, or client-side enrollment.
The requirements in each of the following sections apply only if you use that enrollment method.

### Ports

Open the following default ports for outbound connections from each node.

| Port    | Description                  |
| ------- | ---------------------------- |
| `443`   | HTTPS                        |
| `31050` | RabbitMQ AMQP/AMQP-TLS       |

### Server-side enrollment requirements

Server-side enrollment includes two methods: bulk enrollment and single-node enrollment.
In both methods, Chef 360 SaaS initiates the connection to the target node using SSH or WinRM.
Because Chef 360 SaaS connects to the node remotely, the target node must meet the following connectivity, authentication, and access prerequisites:

- The node must accept SSH or WinRM connections from `https://<CUSTOMER_SUBDOMAIN>.cloud.chef.io`.
- The node must have a public DNS name or public IP address that `https://<CUSTOMER_SUBDOMAIN>.cloud.chef.io` can reach.
- The node must allow outbound and inbound communication with `https://bldr.habitat.sh`.
- The node's IP address can't be localhost (`127.0.0.1`).
- The node's CIDR address can't be in the same range as the Chef 360 SaaS services. The default CIDR range for Chef 360 SaaS services is `10.244.0.0/16` or `10.96.0.0/12`.

#### SSH connection requirements

- Port `22` must be open.
- You must have sudo privileges on the node.
- You must connect with an ed25519 or RSA (2048-bit) login key that doesn't have a passphrase.

#### WinRM connection requirements

- Ports `5985` and `5986` must be open.
- Configure WinRM by running the following commands.

    These commands start and configure the WinRM service, enable basic authentication, allow unencrypted WinRM traffic over HTTP (port `5985`), and add firewall rules for ports `5985` and `5986`.
    These commands don't configure an HTTPS listener on port `5986`.
    To use WinRM over HTTPS, you must configure a server certificate and an HTTPS listener that uses that certificate.

    ```ps1
    winrm quickconfig   # select Yes
    winrm set winrm/config/service/Auth '@{Basic="true"}'
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
    netsh advfirewall firewall add rule name="WinRM-HTTPS" dir=in localport=5986 protocol=TCP action=allow
    ```

### Client-side enrollment requirements

Client-side enrollment includes two methods: self enrollment and cookbook-based enrollment. With these methods, the target node initiates the enrollment process and connects to Chef 360 SaaS.

#### Self enrollment requirements

If you use self enrollment, SSH and WinRM connectivity requirements don't apply because Chef 360 SaaS doesn't establish a remote connection to the node.

#### Cookbook-based enrollment requirements

If you enroll a node with Chef 360 SaaS using a Chef Infra cookbook, the node must meet the following requirements:

- Chef Infra Client must be installed on the node.
- The node must have a public DNS name or public IP address that `https://<CUSTOMER_SUBDOMAIN>.cloud.chef.io` can reach.
- The node must allow outbound and inbound communication with `https://bldr.habitat.sh`.
- The node's IP address can't be localhost (`127.0.0.1`).
- You must have sudo privileges on the node.
- The node is currently managed by Chef Infra Server or Chef Infra Client runs in zero mode.
  This requires Chef 360 SaaS Enterprise.

## Skill requirements

Chef 360 Platform skills are supported on the following platforms.

| OS      | Architecture | Version                       |
| ------- | ------------ | ----------------------------- |
| Linux   | x86_64       | Kernel 2.6.32 or later        |
| Windows | x86_64       | Windows Server 2019 and later |

Skills have the following dependencies:

- The Chef Infra Client interpreter requires [Chef Infra Client](/client/latest/overview/chef_overview/) on the node.
- The Chef InSpec interpreter requires [Chef InSpec](/inspec/) on the node.
