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

![Target Mode overview](/images/TargetMode.png)

## Host System
This is the system where Chef Infra Client will be executing from, the host system must have networking connectivity and credentials to connect with the target system. Cookbooks, or policy files can be retried from InfraServer, Supermarket, locally, or a Git repo (the same as any other Infra Client) For purposes of the description we will use Chef Workstation as the host system. Production deployments should either follow either a digital twin, pool, or Chef-360 Courier managed architecture.

### Requirements
There are two prerequisites to start using Chef Target Mode. The first is a credentials file, this provides the host with connectivity information to a target node. The second is a recipe compatible with target mode, which means it only contains resources that work with target mode.

### Credentials file
This credentials file located in chef configuration directory `~/.chef/` on linux (and Mac) or `c:\Users\<username>\.chef` on windows hosts. In that directory a file named credentials (`~/.chef/credentials`) is required. The credentials file is the inventory or catalog of target nodes the host is permitted to connect to.

> If running from a workstation host, this configuration will be shared with other workstation commands.

SSH protocol is the primary protocol to connect with target systems. All other protocols as supported in the [Transport Interface](https://github.com/inspec/train) should also work.

#### Sample credentials file

##### SSH

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

##### WinRM

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

transport_protocol = winrm
ssl: true
self_signed: true

~~~

Credentials for target system include following parameters:

`host`      -> IP address of the target system

`user`      -> username to execute on target system

`password`  -> password of user to authenticate with target system

### Target mode enabled resource

Target mode needs to be enabled in all resources which needs to execute in target system. (see Custom resource below for more details). As an example

~~~
resource_name :example_resource
resource_name :example_resource 
provides :example_resource, target_mode: true
....
...
..

~~~

#### Using Target Mode

To enable target mode you have two prerequisites. First you require a credentials file on the host node, then you can add the -t command line argument to a check client run.

~~~
chef-client -t <credential_file_name parameter>

~~~

where,

`-t` or `--target`  -> Target is the name of the target as mentioned in the credentials file.

#### Using Target mode with Chef Zero

To execute specific cookbook we need to provide an absolute path where the cookbook is available, like:

~~~
chef-client -z -t <target> /chef-repo/my-cookbooks/cookbook1.rb

~~~

## Target system

This is the remote system where resources will be executed in target mode of operation. This system can be any remote system, edge device or cloud resource which can be reached by the host. 

> Installation of Chef Infra Client on target system is not required.

This system does not communicates back with Chef Infra Server.

Example of target systems could be any edge device, wifi-routers, switches, relays, cloud resources, ip phones, router hubs, network management peripherals, etc.

## Resources

These are available in the host system. Resources which need to run on target systems using target mode method of execution need to have target mode enabled. Limited resources of Chef Infra Client currently support target mode of operation. Custom resources can be created for the type of system or target which needs to be monitored using target mode of operation for agent-less management of the target system.

A resource will have the definition of what actions needs to be performed to bring the target system under management to desired state. Some resources are available as a part of Infra Client and there is also a mechanism to create custom resources. Depending on the specifics of the target system, either an available resource can be utilised or a custom resource can be written to manage the target system.

To learn more about resources refer to [About Resources](https://docs.chef.io/resource/) page.

### Custom resource

Depending on the platform architecture of the remote system, custom resource can be created or defined. These custom resources should have `target_mode: true`. Custom resources can also be grouped into recipes which can be used to run on target systems.

#### Example custom resource

An example of a custom resource for an embedded system is given below:

~~~
resource_name :example_directory
provides :example_directory, target_mode: true
unified_mode true

property :directory, String

load_current_value do |new_resource|
  dir = new_resource.directory
  parsed = dir.match(%r{([^/]+$)})
  path = ''
  if parsed
    path = dir[0..(dir.length - parsed[1].length - 1)]
    dir = parsed[1]
  end

  tmp = __transport_connection.run_command( sprintf('ls -l %s | grep %s || echo -n', path, dir) )
  
  if tmp.match(Regexp.new(dir))
    directory new_resource.directory
  end
end

action :create do
  converge_if_changed do
    __transport_connection.run_command( sprintf('mkdir %s', new_resource.directory) )
  end
end

~~~

The above customer resource is an example of how to check and create a new directory. 

To learn more on writing and using custom resources refer to the [Custom Resource Guide](https://docs.chef.io/custom_resources/).

## Work with Chef Automate and Infra Server

### Chef Infra Client
Chef does not include a way to schedule Chef runs in target mode on itself. For each device you want to remotely manage (With Infra Server), you need to create a new node in Chef - for example inside the Chef Server itself. You should safely store the private key of that new device. A Target Mode-compatible runlist can be assigned.

### Add Devices
First, we will add the client credentials to our `credentials` file with its target name being the section heading. To authenticate against the server, we then add the private key of the new device under `/etc/chef/nodename/client.pem`, so the Chef client can easily find it. In your `/etc/chef/client.rb`. specifying the `chef_server_url` or any other settings you require.

### Set Schedule
Without a Target Mode runner inside the Chef server we can use cron jobs instead.

~~~
cat > /etc/cron.d/nodename.cron <<EOF
PATH="/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.6.0"

0,30 * * * * * chef-runner /usr/bin/chef-client -t targetname
EOF

~~~

> Please ensure you manage splay appropriately when using this method
You could use the `RANDOM_DELAY` variable (if your cron implementation features it) or have a random offset sleep `sleep $(numrandom 0..30)m` as a prefix to your command.

Afterwards, you will see your node pop up in Chef Server/Chef Automate just like a regular node.

## Errors and troubleshoot

Common errors and their potential troubleshooting steps are discussed here:

### Chef client execute command is throwing an error
Please check if `-z` or `--zero` is specified in the execution command. If so, please specify `-t` or `--target` in the execution command. Both are mandatory for `chef-client` command to execute.

In case both are specified, then please check for correctness of hostname or IP address of the target system. Ensure that the `host` is accessible via SSH to the `user` specified in the credentials fils with the provided `password`.

### Custom resource is not executing
Please refer to a custom resource example above. Ensure that `target_mode` is specified to `true`. If this resource is being used in a recipe, please ensure that all resources in the recipe have `target_mode` set to `true`.

### OHAI data is not reporting back for target system
As target systems are not reporting to Chef Infra Server, network latency becomes very important. Ensure that the OHAI plugin is enabled to report data back by having the target mode enabled using `ohai --target ssh://foobar.example.org/` command.

In case, you have received some data and are not reporting other, then it is a case of network latency. Please upgrade your infrastructure and network speed to receive all data as soon as it is generated.

