The `agentless` driver works with any Test Kitchen sub-driver. The examples
below cover the two most common combinations---Docker and EC2---each shown
with both `volatility` modes, so you can see how `source_node` and
`remote_nodes` differ between them.

It helps to think of these examples as two independent choices, not four
unrelated setups:

- **Which `sub_driver` creates the source node?** Docker is fast to start
  and needs no cloud account, which makes it a good default for local
  development and for the shared source node even in an otherwise
  cloud-based project. EC2 (or another cloud driver) is a better fit when
  the source node itself needs to sit on the same network, IAM role, or
  security posture as the infrastructure it's testing.
- **Is `volatility` `ephemeral` or `real`?** This choice is about the
  _targets_, not the source node---the source node can be `ephemeral` or
  `local` regardless of what the targets are. Choose `ephemeral` when Test
  Kitchen should own the target's full lifecycle (the common case for
  testing a cookbook against disposable instances). Choose `real` when the
  targets already exist and must not be created or destroyed by Test
  Kitchen---staging servers, appliances, or anything you'd never want an
  automated `kitchen destroy` to touch.

`source_node` and `remote_nodes` are configured independently: `source_node`
always describes how to reach the one shared helper machine, while
`remote_nodes` describes the targets under test. `remote_nodes` is required
for `real` targets---it's where each target's `hostname` and credentials
live---and optional for `ephemeral` targets, where the `sub_driver` creates
them for you. The ephemeral examples below still include it to show per-target
overrides.

## Docker, ephemeral targets

Both the shared source node and every target are Docker containers,
connected over SSH. This is the fastest way to try the `agentless` driver
locally---no cloud account required.

```yaml
driver:
  name: agentless
  sub_driver: docker
  socket: unix:///var/run/docker.sock

  agentless:
    volatility: ephemeral
    source_node:
      mode: instance
      driver:
        image: dokken/ubuntu-22.04
        platform: ubuntu
      transport:
        username: root
        ssh_key: ~/.ssh/id_rsa
    remote_nodes:
      default-ubuntu-2204:
        driver:
          image: dokken/ubuntu-22.04
        transport:
          username: root
          ssh_key: ~/.ssh/id_rsa

provisioner:
  name: chef_infra_agentless
  channel: stable
  install_strategy: once

verifier:
  name: inspec_agentless
  channel: stable
  install_strategy: once

transport:
  name: ssh

platforms:
  - name: ubuntu-2204
    driver:
      image: dokken/ubuntu-22.04
      platform: ubuntu

suites:
  - name: default
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

Here, `remote_nodes[name].driver` matches the top-level `driver:` image, so
it's optional---it's shown for clarity, since a target would normally use a
different image than the source node.

## Docker, real targets

The source node is still an ephemeral Docker container, but the targets are
existing hosts that Test Kitchen only connects to---it never creates or
destroys them.

```yaml
driver:
  name: agentless
  sub_driver: docker            # still used to create the shared source node
  socket: unix:///var/run/docker.sock

  agentless:
    volatility: real
    source_node:
      mode: instance
      driver:
        image: dokken/ubuntu-22.04
      transport:
        username: root
        ssh_key: ~/.ssh/id_rsa
    credential-map-file: credentials.yml
    remote_nodes:
      staging-web-01:
        transport:
          hostname: 10.0.4.11
      staging-web-02:
        transport:
          hostname: 10.0.4.12
          username: admin
          port: 2222

provisioner:
  name: chef_infra_agentless
  channel: stable
  install_strategy: once

verifier:
  name: inspec_agentless
  channel: stable
  install_strategy: once

transport:
  name: ssh

platforms:
  - name: web-01
  - name: web-02

suites:
  - name: staging
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

Every `real` instance needs `transport.hostname`, either directly under
`remote_nodes` (as above) or from `credential-map-file`. Setting
`remote_nodes[name].driver` for a `real` target raises an error, since
`real` targets are never created by `sub_driver`.

Each `real` target also needs its own `platforms` entry, so the instance name
Test Kitchen builds as `<suite>-<platform>` matches the `remote_nodes` key.
Here the `staging` suite combined with the `web-01` and `web-02` platforms
produces the instances `staging-web-01` and `staging-web-02`.

## EC2, ephemeral targets

Both the shared source node and every target are real EC2 instances. Good
for CI pipelines or for testing images that need real cloud networking and
IAM.

```yaml
driver:
  name: agentless
  sub_driver: ec2
  region: us-east-1
  shared_credentials_profile: <aws-profile-name>
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0
  associate_public_ip: true
  interface: dns
  instance_type: t3.medium

  agentless:
    volatility: ephemeral
    source_node:
      mode: instance
      driver:
        image_id: ami-0123456789abcdef0     # a source-friendly AMI (Ubuntu/Amazon Linux)
        instance_type: t3.medium
        block_device_mappings:
          - device_name: /dev/sda1
            ebs:
              volume_type: gp2
              volume_size: 20
              delete_on_termination: true
      transport:
        username: ubuntu
        ssh_key: ~/.ssh/my-keypair.pem
    remote_nodes:
      default-ubuntu-2204:
        driver:
          instance_type: t3.small

provisioner:
  name: chef_infra_agentless
  channel: stable
  install_strategy: once
  version: "19.3.15"

verifier:
  name: inspec_agentless
  channel: stable
  install_strategy: once
  inspec_args:
    - --reporter
    - cli

transport:
  name: ssh

platforms:
  - name: ubuntu-2204
    driver:
      image_id: ami-0123456789abcdef0
    transport:
      username: ubuntu
      ssh_key: ~/.ssh/my-keypair.pem

suites:
  - name: default
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

`remote_nodes[default-ubuntu-2204].driver` overrides just `instance_type` for
this target, while it still inherits `image_id` and everything else from the
top-level `driver:` block.

## EC2, real targets

The source node is still an ephemeral EC2 instance, but the targets are
pre-existing hosts---staging servers, appliances, or other long-lived
infrastructure---that Test Kitchen only connects to, converges, and
verifies.

```yaml
driver:
  name: agentless
  sub_driver: ec2                # still used to create the shared source node
  region: us-east-1
  shared_credentials_profile: <aws-profile-name>
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0
  associate_public_ip: true
  interface: dns

  agentless:
    volatility: real
    source_node:
      mode: instance
      driver:
        image_id: ami-0123456789abcdef0
        instance_type: t3.medium
      transport:
        username: ubuntu
        ssh_key: ~/.ssh/my-keypair.pem
    credential-map-file: credentials.yml
    remote_nodes:
      staging-web-01:
        transport:
          hostname: 10.0.4.11
      staging-web-02:
        transport:
          hostname: 10.0.4.12
          username: admin
          port: 2222

provisioner:
  name: chef_infra_agentless
  channel: stable
  install_strategy: once

verifier:
  name: inspec_agentless
  channel: stable
  install_strategy: once

transport:
  name: ssh

platforms:
  - name: web-01
  - name: web-02

suites:
  - name: staging
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

```yaml
# credentials.yml --- resolves ssh_key for both nodes; staging-web-02's
# username comes from remote_nodes.transport.username above, since this
# entry doesn't set one
credentials:
  staging-web-01:
    type: inline
    protocol: ssh
    username: admin
    ssh_key: ~/.ssh/staging_id_rsa

  staging-web-02:
    type: inline
    protocol: ssh
    ssh_key: ~/.ssh/staging_id_rsa
```

As with the Docker real example, each `real` target has its own `platforms`
entry so the generated `<suite>-<platform>` instance name matches its
`remote_nodes` key---here the `staging` suite with the `web-01` and `web-02`
platforms yields `staging-web-01` and `staging-web-02`.

When both `credential-map-file` and `remote_nodes[name].transport` supply a
value for the same target, `credential-map-file` wins for any field it sets;
`remote_nodes[name].transport` only fills in what `credential-map-file`
leaves out, for example `staging-web-02`'s `username: admin` above, since
`credentials.yml` doesn't set one for it.

All values above are placeholders. Keep real keys, passwords, hostnames, and
account identifiers out of `kitchen.yml`---use a `credential-map-file`,
environment variables, or an SSH agent instead.

## WinRM, Windows source and target

Both the shared source node and the target are Windows EC2 instances, connected
over WinRM. Chef Infra Client and InSpec run on the Windows source node and
reach the Windows target with `chef-client --target winrm://...` and
`inspec exec --target winrm://...`. Use this when your cookbook targets Windows
and you want the source node to also be Windows.

WinRM targets need both a username and a password to authenticate---there's no
SSH-key equivalent. For EC2, the password is the autogenerated Windows
Administrator password, decrypted with the keypair named in `transport.ssh_key`.
The target's security group must allow inbound 5985/5986 (WinRM) from the
workstation running `kitchen`.

```yaml
driver:
  name: agentless
  sub_driver: ec2
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0   # must allow inbound 5985/5986 (WinRM)
  region: us-east-1
  instance_type: t3.medium
  associate_public_ip: true
  interface: dns

  agentless:
    volatility: ephemeral
    connectivity_check_timeout: 5
    source_node:
      mode: instance
      driver:
        image_id: ami-0123456789abcdef0   # Windows Server source AMI
        instance_type: t3.medium
      transport:
        username: Administrator
        ssh_key: ~/.ssh/my-keypair.pem     # decrypts the source's admin password

provisioner:
  name: chef_infra_agentless
  channel: stable
  install_strategy: once

verifier:
  name: inspec_agentless
  channel: stable
  install_strategy: once

transport:
  name: winrm

platforms:
  - name: windows-2022
    driver:
      image_id: ami-0123456789abcdef0     # Windows Server target AMI
      instance_type: t3.medium
    transport:
      username: Administrator
      ssh_key: ~/.ssh/my-keypair.pem       # decrypts the target's admin password

suites:
  - name: default
    run_list:
      - recipe[my_windows_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

Name the platform after the Windows release (for example `windows-2022`) so the
provisioner can use it as a fallback for the target's platform version, since
Ohai only describes the source node, not the `--target`. Override it explicitly
with `provisioner.target_platform_version` if your platform name doesn't follow
that convention.

## Local source node

The machine running `kitchen` acts as the source node, so no separate source
instance is created---only the targets are. This is the fastest option when the
workstation already has Chef Infra Client and InSpec available, for example
through Chef Workstation.

```yaml
driver:
  name: agentless
  sub_driver: ec2
  region: us-east-1
  shared_credentials_profile: MyProfileName
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0
  associate_public_ip: true
  interface: dns
  instance_type: t3.medium

  agentless:
    volatility: ephemeral
    source_node:
      mode: local

provisioner:
  name: chef_infra_agentless

verifier:
  name: inspec_agentless

transport:
  name: ssh

platforms:
  - name: ubuntu-2204
    driver:
      image_id: ami-0123456789abcdef0
    transport:
      username: ubuntu
      ssh_key: ~/.ssh/my-keypair.pem

suites:
  - name: default
    run_list:
      - recipe[my_cookbook::default]
    verifier:
      inspec_tests:
        - path: test/integration/default
```

In `local` mode, `source_node.driver` and `source_node.transport` are unused,
no `agentless-source` state file is created, and version keys like
`product_version` and `inspec_version` have no effect---whatever `chef-client`
and `inspec` are already on `PATH` are used as-is. `kitchen create` and
`kitchen converge` fail immediately with a clear error if `chef-client` isn't
found; if `inspec` isn't on `PATH`, `kitchen verify` fails when it runs.

## Choosing between these examples

In practice, most projects settle on one combination and stay there: local
development and quick iteration favor Docker with `ephemeral` targets,
CI pipelines that need realistic networking favor EC2 with `ephemeral`
targets, and validating already-provisioned infrastructure---in any
cloud or on-prem---favors `real` targets with whichever `sub_driver` is
convenient for creating the source node. Nothing stops you from mixing
them across suites in the same `kitchen.yml`, since `driver`, `agentless`,
and `remote_nodes` can all be overridden for each platform or suite.

## Running the lifecycle

The `agentless` driver preserves Test Kitchen's normal `create`, `converge`,
`verify`, and `destroy` lifecycle---it only changes where the Chef Infra Client
run actually executes:

```console
$ bundle exec kitchen create
-----> Creating <default-ubuntu-2204>...
       [agentless-source] Not found --- creating it as a dependency for target 'default-ubuntu-2204'.
       [agentless-source] Creating shared source node...
       [target: default-ubuntu-2204] Creating ephemeral target instance...
       Finished creating <default-ubuntu-2204>.

$ bundle exec kitchen converge
-----> Converging <default-ubuntu-2204>...
       Preparing target_credentials for target mode...
       Running: chef-client --target ssh://root@<target-host> ...
       Infra Phase complete, 4 resources updated

$ bundle exec kitchen verify
-----> Verifying <default-ubuntu-2204>...
       Profile: my_cookbook (test/integration/default)
       4 successful, 0 failures

$ bundle exec kitchen destroy
-----> Destroying <default-ubuntu-2204>...
       [agentless-source] Destroying shared source node...
       [agentless-source] agentless-source destroyed
```

- `kitchen create` creates the shared `agentless-source` node the first time
  it's needed and reuses it for every later target in the same project until
  it's destroyed.
- `kitchen destroy` on the last remaining target also tears down the source
  node, unless you pass `--keep-agentless-source` or set
  `KITCHEN_KEEP_AGENTLESS_SOURCE=1`.

## Troubleshooting

### Stale `agentless-source` state

`kitchen create` reports that it's reusing an existing source node, but that
node no longer matches reality. Whether the source node exists is decided by a
local check for `.kitchen/agentless-source.yml`, which never verifies the
underlying resource. The file goes stale if you change the source `sub_driver`
without running `kitchen destroy` first. Run `kitchen destroy` before switching
the source `sub_driver`, or remove the stale file manually:

```shell
cat .kitchen/agentless-source.yml   # find and manually remove the underlying resource
rm .kitchen/agentless-source.yml    # then start clean
```

### AWS credential-chain timeout (IMDS)

An error like `Failed to open TCP connection to 169.254.169.254:80` means the
AWS SDK fell through to the EC2 Instance Metadata Service, which is only
reachable from inside a running EC2 instance. Add explicit AWS config
(`region`, `shared_credentials_profile`) to the `driver:` block. If you use SSO,
confirm your session with `aws sts get-caller-identity --profile <name>` and run
`aws sso login --profile <name>` if it has expired.

### `KITCHEN_YAML` doesn't isolate `.kitchen/` state

`KITCHEN_YAML` only changes which config file Test Kitchen reads; it doesn't
change where `.kitchen/` state is written. All `kitchen.yml` variants in one
project share the same `.kitchen/agentless-source.yml`. Run `kitchen destroy`
under the config that created the current state before switching, or use a
separate project directory for each `sub_driver`.

### Real-mode target validation fails

`kitchen create` fails immediately with a message like `'hostname' is required
for target '...'` or `no SSH credentials found for target '...'`. This is
intentional fail-fast validation. Add a `hostname` under
`remote_nodes.<name>.transport`, and set either direct credentials or a
resolvable `credential-map-file` entry.

### Chef Infra Client version too old for Target Mode

Target Mode requires Chef Infra Client 19.0 or newer on the source node. Set
`provisioner.version` (or `product_version`) to `latest` or an explicit version
of 19.0.0 or newer.

### InSpec or license install issues on the source node

Set `install_strategy: always` temporarily to force a clean reinstall, confirm
`CHEF_LICENSE_KEY` (or `verifier.chef_license_key`) is set and valid, and
confirm the source node can reach Chef's download endpoints.

### Duplicate provisioner or verifier registration

Test Kitchen errors that a plugin is loaded twice. This usually comes from a
`Gemfile` or `Gemfile.lock` with two overlapping sources for the same plugin
gem, for example a local `path:` gem and a published version. Ensure exactly
one source for each plugin gem with `bundle exec gem list | grep -i agentless`.

For more diagnostic output:

```shell
bundle exec kitchen create --log-level debug
bundle exec kitchen diagnose --all
```
