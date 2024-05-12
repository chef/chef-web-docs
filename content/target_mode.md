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

Target Mode executes Chef Infra Client runs on nodes that don't have Chef Infra Client installed on them.

The target node can be any remote system, edge device, or cloud resource that the host can reach. This includes edge devices, Wi-Fi routers, switches, relays, cloud resources, IP phones, router hubs, and network management peripherals.

## Transport Interface (Train)

Target Mode uses [Transport Interface (Train)](https://github.com/inspec/train) to connect to nodes to and execute Chef Infra Client runs.

Target Mode supports the following Train protocols:

- SSH
- Podman
- VMware

## Requirements

Target Mode has the following requirements:

- A network-enabled system to execute Target Mode. For example, a local workstation with Chef Workstation installed.
- A credentials file which provides the system with information to connect to a target node.
- A recipe that only includes Target Mode-enabled resources.

## Credentials file

The credentials file is located in `.chef/credentials` on Linux and Mac systems, or `c:\Users\<USERNAME>\.chef/credentials` on Windows.
This file contains a list of nodes that the host can connect to.

Define the list of nodes using the TOML file format.

### Properties

Train supports the following target node properties that can be included in a credentials file:

`host`
: The IP address or FQDN of the target node.

`port`
: The port number of the target node. (optional)

`user`
: The user used to log in and execute Cookbooks on the target node. For example, `root`.

`keys`
: The path to a secret key used to log into the target node.

`password`
: A password string to log into the target node.

`protocol`
: The protocol to use to connect to the target node.

### Examples

Define the list of nodes in the credentials file using the TOML format. For example:

```toml
['<TARGET_FQDN>']
host = '<TARGET_FQDN>'
user = '<TARGET_SYSTEM_USER>'
key_files = '<PATH_TO_PEM_FILE>'

['<TARGET_IP_ADDRESS>']
host = '<TARGET_IP_ADDRESS>'
user = '<TARGET_SYSTEM_USER>'
password = '<TARGET_SYSTEM_PASSWORD_STRING>'

protocol = <PROTOCOL>
```

Replace the following:

- `<TARGET_IP_ADDRESS>`: the IP address of the target node.
- `<TARGET_FQDN>`: the fully qualified domain name of the target node.
- `<TARGET_SYSTEM_USER>`: username to log into and execute Cookbooks on the target node.
- `<TARGET_SYSTEM_PASSWORD_STRING>`: the password of the user to authenticate with the target node.
- `<PROTOCOL>`: the Train transport protocol to connect to the target node.

This example targets three nodes using SSH:

```ruby
['target.system.host.1.com']
host = 'target.system.host.1.com'
user = 'root'
key_files = '~/.keys/key-pair.pem'

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

## Resources

All resources included in a Cookbook must be enabled in Target Mode to run in Target Mode.

The following Chef Infra Client resources are supported in Target Mode starting in Chef Infra Client 15.1.36:

- breakpoint
- execute
- log
- ruby_block
- systemd_unit

### Custom resources

To enable a custom resource to run in Target Mode, add `target_mode: true` to the resource definition. For example:

```ruby
provides :<RESOURCE_NAME>, target_mode: true
....
```

See the [Custom Resources documentation]({{< relref "custom_resources" >}}) for more detailed documentation about creating custom resources.

#### Example

The following custom resource example checks for and creates a new directory and runs in Target Mode:

```ruby
provides :example_directory, target_mode: true
unified_mode true

property: directory, String

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

## Run Target Mode

Run the `chef-client` executable using `-t` or `--target` to target a specific node. For example:

```sh
chef-client -t <TARGET_NAME>
```

Replace `<TARGET_NAME>` with the IP address or fully qualified domain name of the host as defined in the credentials file.

### Target Mode in Local Mode

You can run Target Mode in [Local Mode]({{< relref "/ctl_chef_client#run-in-local-mode" >}}).

Local Mode runs chef-zero on a local machine to execute a chef-repo as if it were running on Chef Infra Server.

```sh
chef-client -z -t <TARGET_NAME> /chef-repo/cookbooks/<COOKBOOK_NAME>.rb
```

Replace `<TARGET_NAME>` with the IP address or fully qualified domain name of the host as defined in the credentials file.

## Schedule Target Mode runs

Target Mode doesn't have a way to schedule Chef Infra Client runs on a node, but you can configure Chef Automate or Chef Infra Server to execute Client runs using cron.

### Requirements

The server running Target Mode with cron has the following requirements:

- a private key for the target node
- a credentials file


### Create a schedule

This example creates a cron file that executes the Chef Infra Client run using Target Mode every thirty minutes.

```ruby
cat > /etc/cron.d/nodename.cron <<EOF
PATH="/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.6.0"

0,30 * * * * * chef-runner /usr/bin/chef-client -t <TARGET_NAME>
EOF
```

{{< note >}}

Use splay to reduce the load on a server executing many Client runs. You could use the `RANDOM_DELAY` variable (if your cron implementation features it) or set a random sleep offset `sleep $(numrandom 0..30)m` as a prefix to your command.

{{< /note >}}

Afterwards, your node will appear in Chef Infra Server or Chef Automate just like a regular node.

## Troubleshooting

The following are the common errors and their potential troubleshooting steps.

### `chef-client` execute error

Verify that `-z` or `--zero` is specified in the execution command. If not, use  `-t` or `—target`. Both are required for the `chef-client` command to execute.

If both are specified, verify that the target node's hostname or IP address is correct, that the host accessible using SSH, and that the user and password specified in the credentials file are correct.

### Custom resources don't execute

Verify that all resources have `target_mode` set to `true`. For example:

```ruby
provides :<RESOURCE_NAME>, target_mode: true
```

For more information, see the [custom resource example](#custom-resources).

### Ohai data doesn't report data from the target node

Verify that Ohai can report data back by enabling the Target Mode using the `ohai --target ssh://foobar.example.org/` command.

Network latency can affect the ability of nodes to report data to Chef Infra Server.
Ensure the Ohai plugin can report data back by enabling the Target Mode using the `ohai --target ssh://foobar.example.org/` command.

If you have received some data and aren't reporting others, it's a case of network latency.
Upgrade your infrastructure and network speed to receive all the data as soon as it's generated.
