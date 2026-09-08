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
  *targets*, not the source node---the source node can be `ephemeral` or
  `local` regardless of what the targets are. Choose `ephemeral` when Test
  Kitchen should own the target's full lifecycle (the common case for
  testing a cookbook against disposable instances). Choose `real` when the
  targets already exist and must not be created or destroyed by Test
  Kitchen---staging servers, appliances, or anything you'd never want an
  automated `kitchen destroy` to touch.

Every example below sets up both `source_node` and `remote_nodes`, since the
two are configured independently: `source_node` always describes how to
reach the one shared helper machine, while `remote_nodes` always describes
the target(s) under test.

**Docker, ephemeral targets**

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

**Docker, real targets**

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
  - name: staging

suites:
  - name: default
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

**EC2, ephemeral targets**

Both the shared source node and every target are real EC2 instances. Good
for CI pipelines or for testing images that need real cloud networking and
IAM.

```yaml
driver:
  name: agentless
  sub_driver: ec2
  region: us-east-1
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0
  associate_public_ip: true
  instance_type: t3.medium

  agentless:
    volatility: ephemeral
    source_node:
      mode: instance
      driver:
        image_id: ami-0123456789abcdef0     # a source-friendly AMI (Ubuntu/Amazon Linux)
        instance_type: t3.medium
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

**EC2, real targets**

The source node is still an ephemeral EC2 instance, but the targets are
pre-existing hosts---staging servers, appliances, or other long-lived
infrastructure---that Test Kitchen only connects to, converges, and
verifies.

```yaml
driver:
  name: agentless
  sub_driver: ec2                # still used to create the shared source node
  region: us-east-1
  aws_ssh_key_id: my-keypair
  security_group_ids:
    - sg-0123456789abcdef0
  associate_public_ip: true

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
  - name: staging

suites:
  - name: default
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

When both `credential-map-file` and `remote_nodes[name].transport` supply a
value for the same target, `credential-map-file` wins for any field it sets;
`remote_nodes[name].transport` only fills in what `credential-map-file`
leaves out, for example `staging-web-02`'s `username: admin` above, since
`credentials.yml` doesn't set one for it.

All values above are placeholders. Keep real keys, passwords, hostnames, and
account identifiers out of `kitchen.yml`---use a `credential-map-file`,
environment variables, or an SSH agent instead.

**Choosing between these examples**

In practice, most projects settle on one combination and stay there: local
development and quick iteration favor Docker with `ephemeral` targets,
CI pipelines that need realistic networking favor EC2 with `ephemeral`
targets, and validating already-provisioned infrastructure---in any
cloud or on-prem---favors `real` targets with whichever `sub_driver` is
convenient for creating the source node. Nothing stops you from mixing
them across suites in the same `kitchen.yml`, since `driver`, `agentless`,
and `remote_nodes` can all be overridden per platform or per suite.
