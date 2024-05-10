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

Target Mode, a powerful feature introduced in Chef 15, liberates system administrators and DevOps engineers from the need to install Chef Infra Client on remote systems. You can effortlessly manage the desired state of remote systems, edge devices, and cloud targets without the hassle of client or agent installation.

Target mode flexibly manages any system, target, or device's desired state, eliminating the need for specific platform support. Whether you're working with compatible native resources or custom resources, once you write the target mode-compatible recipe, you gain the power to remotely manage that node from any server, workstation, container, or pipeline. Target mode is compatible with systems, regardless of whether they have native Chef Infra Client builds.

The host connects via the unified interface of the [transport interface (train)](https://github.com/inspec/train) to any agent using one of the train protocols and ensures that the agent or target system is in the desired state and manageable from the host system.

{{< note >}} Target mode (agent-less) is a way to execute resources on the nodes remotely. {{< /note >}}

![Target Mode overview](/images/TargetMode.png)

## Host System

The host system used to execute the Chef Infra Client will be crucial in Target Mode. It must have networking connectivity and credentials to connect with the target system. Cookbooks or policy files can be retrieved from InfraServer, Supermarket, locally, or a Git repo, just like any other Infra Client. For this documentation, we will use Chef Workstation as the host system. However, in production deployments, you can follow either a digital twin, pool or Chef-360 Courier-managed architecture.

### Requirements

Two prerequisites are needed to start using Chef Target Mode. The first is a credentials file, which provides the host with connectivity information to a target node. The second is a recipe compatible with the target mode, which only contains resources that work with the target mode.

### Credentials file

The credentials file, a crucial system component, is securely located in the chef configuration directory `/.chef/` on Linux (and Mac) or `c:\Users\<username>\.chef` on Windows hosts. This file, named credentials (`/.chef/credentials`), serves as the inventory or catalog of target nodes the host can connect to, ensuring the security and integrity of your system.

{{< note >}} The configuration is shared with other workstation commands if it is running from a workstation host. {{< /note >}}

The SSH protocol is the primary protocol for connecting with target systems. All other protocols should also work as supported in the [Transport Interface](https://github.com/inspec/train).

#### Sample credentials file

##### SSH

Sample config is below:

```ruby
['target.system.host.1.com']
host = 'target.system.host.1.com'
user = 'root'
key_files = '~/.keys/key-pair.pem'"

['target.system.host.2.com']
host = 'target.system.host.2.com'
user = 'root'
password = '123456'

['192.168.0.252']
host = '192.168.0.252'
user = 'root'
password = '123456'

protocol = ssh
```

Credentials for the target system include the following parameters:

- `host`: IP address of the target system.
- `user`: username to execute on the target system.
- `password`: password of the user to authenticate with the target system.

{{< note >}} Each key-value pair of credentials for each target system is used by train protocol for authentication during execution. {{< /note >}}

### Target mode enabled resource

Enable the Target mode in all resources executed in the target system. (see Custom resource below for more details). As an example:

```ruby
resource_name :example_resource
resource_name :example_resource
provides :example_resource, target_mode: true
....
...
..
```

#### Using Target Mode

To enable target mode, two prerequisites are needed. First, a credentials file on the host node must be created. Then, you can add the—t command line argument to a check client run.

```ruby
chef-client -t <credential_file_name parameter>
```

In the above code, `-t` or `--target` is the target's name, as the credentials file mentions.

#### Using Target mode with Chef Zero

To execute a specific cookbook, we need to provide an absolute path where the cookbook is available, like:

```ruby
chef-client -z -t <target> /chef-repo/my-cookbooks/cookbook1.rb
```

## Target system

The Target system is the remote system to execute the resources in the target mode of operation. It can be any remote system, edge device, or cloud resource that the host can reach.

{{< note >}} Installation of Chef Infra Client on the target system is not required. {{< /note >}}

This system does not communicate back with the Chef Infra Server.

Target systems could include any edge device, Wi-Fi routers, switches, relays, cloud resources, IP phones, router hubs, network management peripherals, etc.

## Resources

These are available in the host system. Resources that need to run on target systems using the target mode method of execution need to have target mode enabled. Chef Infra Client's limited resources currently support the target mode of operation. Create Custom resources for the type of system or target that needs to be monitored using the target mode of operation for agent-less management of the target system.

A resource defines the actions needed to bring the target system under management to the desired state. Some resources are available as part of Infra Client, and a mechanism exists to create custom resources. Depending on the specifics of the target system, you can utilize the available resource or write a custom resource to manage it.

Refer to the [About Resources] page (https://docs.chef.io/resource/) to learn about resources.

### Custom resource

Depending on the platform architecture of the remote system, custom resources can be created or defined. These custom resources should have `target_mode: true.` You can group the Custom resources into recipes, which you can use to run on target systems.

#### Example custom resource

An example of a custom resource for an embedded system is:

```ruby
resource_name :example_directory
provides :example_directory, target_mode: true
unified_mode true

property:directory, String

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
```

The above customer resource is an example of how to check and create a new directory. 

Refer to the [Custom Resource Guide](https://docs.chef.io/custom_resources/) to learn more about writing and using custom resources.

## Work with Chef Automate and Infra Server

### Chef Infra Client

Chef does not include a way to schedule runs in target mode. For each device you want to manage (with Infra Server) remotely, you must create a new node in Chef—for example, inside the Chef Server. You should safely store the private key of that new device. A Target Mode-compatible runlist can be assigned.

### Add Devices

First, we will add the client credentials to our `credentials` file, with its target name being the section heading. To authenticate against the server, we add the new device's private key under `/etc/chef/nodename/client.pem` so the Chef client can easily find it. In your `/etc/chef/client.rb`, specify the `chef_server_url` or any other settings you require.

### Set Schedule

Without a Target Mode runner inside the Chef server, we can use cron jobs instead.

```ruby
cat > /etc/cron.d/nodename.cron <<EOF
PATH="/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.6.0"

0,30 * * * * * chef-runner /usr/bin/chef-client -t targetname
EOF
```

{{< note >}} Please ensure you manage splay appropriately when using this method. You could use the `RANDOM_DELAY` variable (if your cron implementation features it) or have a random offset sleep `sleep $(numrandom 0..30)m` as a prefix to your command. {{< /note >}}

Afterward, your node will appear in Chef Server/Chef Automate, just like a regular node.

## Errors and troubleshoot

Following are the Common errors and their potential troubleshooting steps:

### The Chef client execute command is throwing an error

Please check if `-z` or `--zero` is specified in the execution command. If not, please select `-t` or `—target`. Both are mandatory for the `chef-client` command to execute.

If both are specified, please check for the correctness of the target system's hostname or IP address. Ensure the `host` is accessible via SSH to the `user` specified in the credentials file with the provided `password`.

### Custom resources are not executing

Please refer to the example of a custom resource above. Ensure that `target_mode` is specified to `true`. If you use the resource in a recipe, please ensure all resources have `target_mode` set to `true`.

### OHAI data is not reporting back for the target system

Network latency becomes very important as target systems need to report to the Chef Infra Server. Ensure the OHAI plugin can report data back by enabling the target mode using the `ohai --target ssh://foobar.example.org/` command.

If you have received some data and are not reporting others, it is a case of network latency. Upgrade your infrastructure and network speed to receive all the data as soon as it gets generated.
