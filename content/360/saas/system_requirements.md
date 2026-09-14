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

Chef 360 SaaS nodes must meet network and connectivity requirements before you can enroll them, and skills must run on a supported platform. You can enroll a node with a Chef Infra cookbook or with server-side or client-side enrollment directly from Chef 360 SaaS. Each enrollment method has its own connectivity, port, and credential requirements.

## Node requirements

### Ports

Open the following default ports for outbound connections from each node.

| Port    | Description                  |
| ------- | ---------------------------- |
| `443`   | HTTPS                        |
| `31050` | RabbitMQ AMQP/AMQP-TLS       |
| `31000` | Nginx reverse proxy NodePort |

### Node requirements for cookbook-based enrollment

Nodes enrolled with Chef 360 SaaS using a Chef Infra cookbook must meet the following requirements:

- Chef Infra Client must be installed on the node.
- The node must have a public DNS name or public IP address that `https://CUSTOMER_SUBDOMAIN.cloud.chef.io` can reach.
- The node must allow outbound and inbound communication with `https://bldr.habitat.sh`.
- The node's IP address can't be localhost (`127.0.0.1`).
- You must have sudo privileges on the node.

{{< note >}}

Cookbook-based enrollment requires Chef Infra Server, or Chef Infra Client running in zero mode. For Chef 360 SaaS, zero mode requires Chef 360 SaaS Enterprise.

{{< /note >}}

### Node requirements for server-side enrollment

In server-side enrollment, Chef 360 SaaS initiates the connection to the target node using SSH or WinRM. Because Chef 360 SaaS connects remotely to the node, the target system must satisfy the following connectivity, authentication, and access prerequisites:

- The node must be accessible with SSH or WinRM from `https://CUSTOMER_SUBDOMAIN.cloud.chef.io`.
- The node must have a public DNS name or public IP address that `https://CUSTOMER_SUBDOMAIN.cloud.chef.io` can reach.
- The node must allow outbound and inbound communication with `https://bldr.habitat.sh`.
- The node's IP address can't be localhost (`127.0.0.1`).
- The node's CIDR address can't be in the same range as the Chef 360 SaaS services. The default CIDR range for Chef 360 SaaS services is `10.244.0.0/16` or `10.96.0.0/12`.
- The node's ports for RabbitMQ (`31050`) and the Nginx API gateway (`31000`) must be open to Chef 360 SaaS.

#### SSH connection requirements

- Port `22` must be open.
- You must have sudo privileges on the node.
- You must connect with an ed25519 or RSA (2048-bit) login key that doesn't have a passphrase.

#### WinRM connection requirements

- Ports `5985` and `5986` must be open.
- Configure WinRM by running the following commands.

    <!-- TODO: Port 5986 is only partially configured here. The netsh rule opens the firewall for 5986, but no HTTPS listener is created, so WinRM doesn't actually listen on that port yet. -->

    This starts the WinRM service, enables Basic authentication, allows unencrypted traffic over HTTP so Basic authentication can work on port `5985`, and opens the firewall for ports `5985` and `5986`.

    ```ps1
    winrm quickconfig   # select Yes
    winrm set winrm/config/service/Auth '@{Basic="true"}'
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
    netsh advfirewall firewall add rule name="WinRM-HTTPS" dir=in localport=5986 protocol=TCP action=allow
    ```

### Node requirements for client-side enrollment

In client-side enrollment, the target node initiates the enrollment process and connects to Chef 360 SaaS. Because Chef 360 SaaS doesn't establish a remote connection to the node, SSH and WinRM connectivity requirements don't apply.

## Skill requirements

Chef 360 Platform skills are supported on the following platforms.

| OS      | Architecture | Version                       |
| ------- | ------------ | ----------------------------- |
| Linux   | x86_64       | Kernel 2.6.32 or later        |
| Windows | x86_64       | Windows Server 2019 and later |

Skills have the following dependencies:

- The Chef Infra Client interpreter requires [Chef Infra Client](/client/latest/overview/chef_overview/) on the node.
- The InSpec interpreter requires [Chef InSpec](/inspec/) on the node.
