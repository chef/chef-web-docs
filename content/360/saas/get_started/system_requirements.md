+++
title = "Chef 360 SaaS system requirements"

[menu.cloud]
title = "System requirements"
identifier = "chef_cloud/360/get_started/requirements"
parent = "chef_cloud/360/get_started"
weight = 20
+++

## Node requirements

This guide describes two methods of enrolling nodes, either with a Chef Infra cookbook or with single-node enrollment from Chef 360 SaaS.
See the node requirements for those methods in the following sections.

### Ports

Open the following default ports for outbound connections.

| Port  | Description                  |
|-------|------------------------------|
| 443   | HTTPS                        |
| 31050 | RabbitMQ AMQP/AMQP-TLS       |
| 31000 | Nginx Reverse Proxy NodePort |
| 22    | SSH (optional)               |
| 80    | HTTP (optional)              |

### Cookbook-based enrollment

Nodes enrolled with Chef 360 Platform using a Chef Infra cookbook have the following requirements:

- Nodes must have Chef Infra Client installed.
- Nodes have a public DNS or public IP address that can be reached from `https://CUSTOMER_SUBDOMAIN.cloud.chef.io`.
- Nodes must allow for outbound and inbound communication with <https://bldr.habitat.sh>
- Nodes can’t have localhost (127.0.0.1) as an IP address.
- You must have sudo privileges on the node.
- Note: Requires Chef Infra Server or running Chef Infra Client in zero mode. For SaaS, this requires Chef 360 SaaS Enterprise.

### Chef 360 platform-based enrollment

Nodes enrolled using single-node enrollment have the following requirements.

Connection requirements:

- Nodes must be accessible with SSH or WinRM from `https://CUSTOMER_SUBDOMAIN.cloud.chef.io`.
- Nodes must have a public DNS or public IP address that can be reached from `https://CUSTOMER_SUBDOMAIN.cloud.chef.io`.
- Nodes must allow for outbound and inbound communication with <https://bldr.habitat.sh>
- A node IP address can’t be localhost (127.0.0.1)
- A node CIDR address can’t be in the same range as the Chef 360 Platform services. The default CIDR range for Chef 360 Platform services is `10.244.0.0/16` or `10.96.0.0/12`.
- The node’s ports for RabbitMQ (31050) and the nginx API gateway (31000) must be open to Chef 360 Platform. Additionally, the Chef 360 Platform should allow inbound connections to these ports from the node.

Nodes connected to with SSH have the following requirements:

- Port 22 must be open.
- The user must have sudo privileges.
- The user must connect with an ed25519 or RSA(2048) login key without a passphrase.

Nodes connected to with WinRM have the following requirements:

- Ports 5985–5986 must be open.
- Configure WinRM by running the following:

    ```ps1
    winrm quickconfig   # select Yes
    winrm set winrm/config/service/Auth '@{Basic="true"}'
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
    ```
