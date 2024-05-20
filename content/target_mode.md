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

Target Mode uses [Transport Interface (Train)](https://github.com/inspec/train) to connect to nodes and execute Chef Infra Client runs.

Target Mode supports the SSH Train protocol. The other Train protocols are experimental.

## Requirements

Target Mode has the following requirements:

- A network-enabled system to execute Target Mode.
- The `chef-client` CLI. This is included with Chef Workstation.
- A credentials file which provides the system with information to connect to a target node.
- A recipe that only includes Target Mode-enabled resources.

## Credentials file

The credentials file defines the connection settings for each node in TOML format.

The credentials file is located in `.chef/credentials` on Linux and Mac systems, or `c:\Users\<USERNAME>\.chef/credentials` on Windows.

### Examples

Define the list of nodes in the credentials file using the TOML format.
The connection settings for each node are defined using a [TOML Inline Table](https://toml.io/en/v1.0.0#inline-table).

For example, this adds credentials for three nodes using SSH:

```toml
['HOST-1']
host = 'target.system.host.1.com'
user = 'root'
key_files = '~/.keys/key-pair.pem'

['HOST-2']
host = 'target.system.host.2.com'
user = 'root'
password = '123456'

['192.168.0.252']
host = '192.168.0.252'
user = 'root'
password = '123456'

protocol = ssh
```

The following example includes all possible connection options for a single node:

```toml
# Set <TARGET_NAME> to a name for the target node. This could be the node IP address or FQDN.
['<TARGET_NAME>']

# ==== Target node connection settings ====
# host: The IP address or FQDN of a node. (Required)
# port: The port number of a node. Default is '22'
# ====

host = '<IP_ADDRESS OR FQDN>'
# port = '22'

# ==== User authentication settings ====
# user: The user used to connect to and execute Cookbooks on a node. Default is "root".
# key_files: If connecting with a secret key, the path to a secret key used to connect to a node.
# password: If connecting with a password, the password string to connect to a node.
# ====

# user = 'root'
# key_files = '<PATH_TO_SECRET_FILE>'
# password = '<PASSWORD_STRING>'

# ssh_config_file: Whether to use settings from a local SSH config file. Default is 'true'.
# ssh_config_file = true

# ==== Keepalive settings ====
# keepalive: Whether to keep the session alive. Default is true.
# keepalive_interval: The keepalive interval. Default is 60 seconds.
# ====

# keepalive = true
# keepalive_interval = '60'

# ==== Connection attempt/delay settings ====
# connection_timeout: The timeout (in seconds) used when connecting to the SSH target. Default is 15 seconds.
# connection_retries: The number of connection retries. Default is 5.
# connection_retry_sleep: The connection retry delay in seconds. Default is 1.
# max_wait_until_ready: The maximum wait time for the SSH service to connect. Default is 600.
# ====

# connection_timeout = '15'
# connection_retries = '5'
# connection_retry_sleep = '1'
# max_wait_until_ready = '600'

# compression: Whether to use compression. Default is false.
# compression = false

# pty: Wether to use PTY to connect. Default is false.
# pty = false

# proxy_command: A proxy command to use to connect to the server. Default is 'nil'.
# proxy_command = 'nil'

# ==== Bastion host settings ====
# bastion_host: A bastion host to connect to the target through. Default is 'nil'.
# bastion_user: The bastion host user. Default is 'root'.
# bastion_port: The port to connect to the bastion host. Default is '22'.
# ====

# bastion_host = 'nil'
# bastion_user = 'root'
# bastion_port = '22'

# non_interactive: Whether to use a non-interactive session. Default is false.
# non_interactive = false

# verify_host_key: Whether to verify the host key. Default is false
# verify_host_key = false

# forward_agent: Whether the connection to the authentication agent (if any) will be forwarded to the remote machine. Default is false.
# forward_agent = false

# protocol: The protocol to use to connect to a node. Define this once for all nodes in the credentials file. Set to 'ssh'. (Required)
protocol = ssh
```

### SSH properties

<!-- markdownlint-disable MD007 MD006 -->

Target Mode supports the following SSH connection properties in a credentials file:

`host`
: (Required) The IP address or FQDN of a node.

`port`
: The port number of a node.

  Default value: `22`

`user`
: The user used to connect to and execute Cookbooks on a node. For example, `root`.

  Default value: `root`

`key_files`
: If connecting with a secret key, the path to a secret key used to connect to a node.

`password`
: If connecting with a password, the password string to connect to a node.

`protocol`
: (Required) The protocol to use to connect to a node. Define this once for all nodes in the credentials file. Set to `ssh`.

`ssh_config_file`
: Whether to use an SSH config file. For example:

  - `~/.ssh/config`
  - `/etc/ssh_config`
  - `/etc/ssh/ssh_config`

  Settings defined in the credentials file override settings in the SSH config file.

  Default value: `true`

`keepalive`
: Whether to keep the session alive.

  Default value: `true`

`keepalive_interval`
: The keepalive interval.

  Default value: `60`

`connection_timeout`
: The timeout (in seconds) used when connecting to the SSH target.

  Default value: `15`

`connection_retries`
: The number of connection retries.

  Default value: `5`

`connection_retry_sleep`
: The connection retry delay in seconds.

  Default value: `1`

`max_wait_until_ready`
: The maximum wait time for the SSH service to connect.

  Default value: `600`

`compression`
: Whether to use compression.

  Default value: `false`

`pty`
: Wether to use PTY to connect.

  Default value: `false`

`proxy_command`
: A proxy command to use to connect to the server.

  Default value: `nil`

`bastion_host`
: A bastion host to connect to the target through.

  Default value: `nil`

`bastion_user`
: A bastion host user.

  Default value: `"root"`

`bastion_port`
: A bastion host port.

  Default value: `22`

`non_interactive`
: Whether to use a non-interactive session.

  Default value: `false`

`verify_host_key`
: Whether to verify the host key.

  Default value: `false`

`forward_agent`
: Whether the connection to the authentication agent (if any) will be forwarded to the remote machine.

  Default value: `false`

<!-- markdownlint-enable MD007 MD006 -->

## Resources

All resources included in a Cookbook must be enabled in Target Mode to run in Target Mode.

The following Chef Infra Client resources are supported in Target Mode starting in Chef Infra Client 15.1.36:

- [apt_package]({{< relref "/resources/apt_package" >}})
- [breakpoint]({{< relref "/resources/breakpoint" >}})
- [execute]({{< relref "/resources/execute" >}})
- [log]({{< relref "/resources/log" >}})
- [ruby_block]({{< relref "/resources/ruby_block" >}})
- [service]({{< relref "/resources/service" >}})
- [systemd_unit]({{< relref "/resources/systemd_unit" >}})

### Custom resources

To enable a custom resource to run in Target Mode, add `target_mode: true` to the resource definition. For example:

```ruby
provides :<RESOURCE_NAME>, target_mode: true
...
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

Replace `<TARGET_NAME>` with the name of the host as defined in the credentials file. For example, `HOST-1` in the [credential file example](#examples).

To execute a specific Cookbook in Target Mode, run:

```sh
chef-client -t <TARGET_NAME> <PATH/TO/COOKBOOK/COOKBOOK_NAME>
```

Replace the following:

- `<TARGET_NAME>` with the name of the host as defined in the credentials file.
- `<PATH/TO/COOKBOOK/COOKBOOK_NAME>` with the path to the Cookbook on your system. For example, `/chef-repo/cookbooks/example_cookbook.rb`

### Target Mode in Local Mode

You can run Target Mode in [Local Mode]({{< relref "/ctl_chef_client#run-in-local-mode" >}}).
Local Mode runs chef-zero locally as a lightweight instance of Chef Infra Server to execute a Client run on target nodes.

Use `-z` and `-t` to run Target Mode in Local Mode:

```sh
chef-client -z -t <TARGET_NAME>
```

Replace `<TARGET_NAME>` with the name of the host as defined in the credentials file. For example, `HOST-1` in the [credential file example](#examples).

## Run Target Mode with Chef Automate or Chef Infra Server

You can configure Chef Automate or Chef Infra Server to run Target Mode on a regular schedule.

Target Mode doesn't have a way to schedule Chef Infra Client runs on a node, but you can create a cron file that executes Target Mode on a regular schedule.

For example, this create a cron file that executes Target Mode every thirty minutes:

```ruby
cat > /etc/cron.d/nodename.cron <<EOF
PATH="/opt/chefdk/bin:/opt/chefdk/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.6.0"

0,30 * * * * * chef-runner /usr/bin/chef-client -t <TARGET_NAME>
EOF
```

After the cron file is created, your node appears in Chef Infra Server or Chef Automate just like a regular node.

{{< note >}}

Use splay to reduce the load on a server that's executing many Client runs. You could use the `RANDOM_DELAY` variable (if your cron implementation features it) or set a random sleep offset as a prefix to your command. For example, with Ubuntu's num-utils package: `sleep $(numrandom 0..30)m`.

{{< /note >}}

## Troubleshooting

The following are the common errors and their potential troubleshooting steps.

### `chef-client` execute error

Verify that the target node's hostname or IP address is correct, that the host accessible using SSH, and that the user and password specified in the credentials file are correct.

### Custom resources don't execute

Verify that all resources have `target_mode` set to `true`. For example:

```ruby
provides :<RESOURCE_NAME>, target_mode: true
```

For more information, see the [custom resource example](#custom-resources).

### Ohai data doesn't report data from the target

Verify that Ohai can report data back by targeting the node:

```sh
ohai --target ssh://foobar.example.org/
```

Network latency can affect the ability of nodes to report data to Chef Infra Server.

If Ohai reports some data but not other data, it's a case of network latency.
Upgrade your infrastructure and network speed to receive all data as it's generated.
