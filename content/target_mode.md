+++
title = "Target Mode"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Target Mode"
    identifier = "chef_infra/features/Target Mode"
    parent = "chef_infra/features"
    weight = 80
+++

Target Mode was first released in Chef 15. It allows for the execution of Chef resources on remote systems without the need to install Chef Infra Client on those systems. This enables easy management of the desired state of remote systems, edge devices, and cloud targets without the need of installing a client or an agent on them.

Target mode eliminates the need for specific platform support by allowing the management of any system, target, or device's desired state without the need of a native client. Devices can be managed with compatible native resources or through custom resources. Once a target mode compatible recipe has been written it will allow the remote management of that node from any server, workstation, container or pipeline. Essentially, target mode is compatible with systems regardless of whether they have native Chef Infra Client builds.

The host connects via unified interface of [transport interface (train)](https://github.com/inspec/train) to any agent using one of the train protocols and ensures that the agent or target system is in desired state and is manageable from the host system.

> Target mode (also known as agent-less) is a way to remotely execute resources on the nodes.

![Target Mode overview](/images/Target Mode.png)

## Host System
This is the system where Chef Infra Client will be executing from, the host system must have networking connectivity and credentials to connect with the target system. Cookbooks, or policy files can be retried from InfraServer, Supermarket, locally, or a Git repo (the same as any other Infra Client) For purposes of the description we will use Chef Workstation as the host system. Production deployments should either follow either a digital twin, pool, or Chef-360 Courier managed architecture.

### Requirements
There are two prerequisites to start using Chef Target Mode. The first is a credentials file, this provides the host with connectivity information to a target node. The second is a recipe compatible with target mode, which means it only contains resources that work with target mode.

#### Credentials file
This credentials file located in chef configuration directory `~/.chef/` on linux (and Mac) or `c:\Users\<username>\.chef` on windows hosts. In that directory a file named credentials (`~/.chef/credentials`) is required. The credentials file is the inventory or catalog of target nodes the host is permitted to connect to.

> If running from a workstation host, this configuration will be shared with other workstation commands.

SSH protocol is the primary protocol to connect with target systems. All other protocols as supported in the [Transport Interface](https://github.com/inspec/train) should also work.

##### Sample credentials file

###### SSH
Sample config is below:

~~~

['Target-01']
host = '192.168.0.251'
user = 'root'
key_files = '~/.keys/key-pair.pem'"

['Target-02']
host = '192.168.0.252'
user = 'root'
password = '123456'

['Target-03']
host = '192.168.0.252'
user = 'root'
password = '123456'

protocol = ssh

~~~

Credentials for target system include following parameters:

`host`      -> IP address of the target system

`user`      -> username to execute on target system

`password`  -> password of user to authenticate with target system

> Each key-value pair of credential for each target system is used by train protocol for authentication during execution.

###### WinRM
Sample config is below:

~~~

['Target-01']
host = '192.168.0.251'
user = 'Administrator'
key_files = '~/.keys/key-pair.pem'"

['Target-02']
host = '192.168.0.252'
user = 'Administrator'
password = '123456'

['Target-03']
host = '192.168.0.252'
user = 'Administrator'
password = '123456'

protocol = winrm
ssl: true
self_signed: true

~~~

Credentials for target system include following parameters:

`host`      -> IP address of the target system

`user`      -> username to execute on target system

`password`  -> password of user to authenticate with target system



