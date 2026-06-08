+++
title = "Deploy Desktop Cookbook to a Node"
draft = false

[menu]
  [menu.desktop]
    title = "Set up Nodes"
    identifier = "desktop/install/nodes.md Set up Nodes"
    parent = "desktop/install"
    weight = 60
+++

## Configure the node

Once you have uploaded the policy to server, now you are ready to try out your Chef Desktop cookbook on your first test node. Before you begin, you need to:

### Bootstrap the First Test Node

1. Create a [`client.rb` file](https://docs.chef.io/config_rb_client/#example) with the basic information needed to connect to the Chef Infra Server instance
1. Identify a 'test node' - a virtual machine or laptop/desktop that you can test your working cookbook against
1. Get the serial number of your 'test node'

From your workstation, configure the server and the `client.rb` file for your node. `S90T7HK2` is an example node serial number.

### Create a client.rb

Create a local `client.rb` file with settings similar to:

```ruby
validation_client_name 'my_org-validator'
validation_key         File.expand_path('c:\chef\my_org-validator.pem')
chef_server_url        "https://my.fqdn.com/my_chef_server_instance"
ssl_verify_mode        :verify_peer
local_key_generation   true
rest_timeout           30
http_retry_count       3
chef_license           'accept'
node_name              'S90T7HK2'
```

### Install the Chef Infra Client

Go to your test node and install the Chef Infra Client from an elevated PowerShell window, or use `sudo` if you are installing it from MacOS. For additional information, see the [Chef Install Script](https://docs.chef.io/chef_install_script/) documentation.

#### On Windows

```powershell
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -project chef
```

#### On macOS

```bash
sudo bash -c "$(curl -sL https://chef.io/chef/install.sh)"
```

### Load the client.rb

After Chef Infra Client finishes installing, copy the `client.rb` file with the correct data for your node and Chef Infra Server, and place that in `c:\chef`.

### Load the Key

Then copy the `validator.pem` file you downloaded from your Chef Infra Server at the beginning of the guide and put it in the same folder.

## Deploy the Chef Desktop Cookbook to Your Test Node

Run the client:

```powershell
chef-client
```

- Next: [Zero-touch Deployment with Azure]({{< relref "zero_touch/windows/_index.md" >}})
- Last: [Chef Desktop Cookbook Development Environment]({{< relref "cookbook_repository.md" >}})
