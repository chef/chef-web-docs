Most Test Kitchen drivers work the same way: create a target instance, install
Chef Infra Client onto it, and run directly on that machine.
This is simple, but it means every target needs enough access to install
software, enough disk space to hold it, and enough lifetime to make the
install worthwhile. Some targets can't offer any of that---a locked-down
production image, a network appliance, or a container that only exists for a
few seconds.

The `agentless` driver for Test Kitchen (Kitchen Agent) tests infrastructure
without installing Chef Infra Client or InSpec on every target. Instead of
putting an agent on each machine under test, it creates or reuses a single
shared helper machine---the **source node**---installs Chef Infra Client and
InSpec there once, and then runs `chef-client --target` and
`inspec exec --target` **from** the source node **against** each target over
SSH or WinRM. Targets stay clean; only the source node ever has any tooling
installed on it. Chef Infra Client's `--target` flag (introduced for this
purpose) lets one running instance of Chef Infra Client manage a completely
different, remote node over an existing transport connection---the same
capability that makes this driver possible.

Use the `agentless` driver when:

- targets are locked down, production-like, or managed by a platform that
  doesn't allow installing software directly on them,
- the target is short-lived, minimal, or otherwise unsuited to hosting an
  agent,
- or you want one repeatable validation node that tests many targets instead
  of touching every endpoint.

`driver.name: agentless` owns the instance lifecycle, but it never talks to a
cloud provider or container runtime itself. It delegates that work to a real
driver named in `sub_driver` (such as `ec2` or `docker`), whose
gem must be installed and available to Test Kitchen.

Two concepts control how instances behave:

- **Volatility**, set with `driver.agentless.volatility`, is either
  `ephemeral` (Test Kitchen creates and destroys targets through
  `sub_driver`, the default) or `real` (targets already exist, and Test
  Kitchen only connects to them).
- **Source node**, configured under `driver.agentless.source_node`, is
  created once for each Test Kitchen run and shared by every instance in that
  run. It's either its own `instance` (created by `sub_driver`) or your own
  workstation in `local` mode. A shared instance source node appears in
  `kitchen list` as `agentless-source`, a reserved instance name.

`remote_nodes`, configured under `driver.agentless.remote_nodes` and keyed by
instance name, lets you override the driver and transport settings for each
target individually---this is where `real` targets get their `hostname`, and
where `ephemeral` targets can use a different image or instance size than the
source node.

## What actually happens during a test run

Understanding the run order makes the rest of the configuration easier to
reason about:

1. Test Kitchen resolves which target instances a command applies to, the
   same way it would for any driver.
2. If no source node exists yet for this run, one is created (or, in `local`
   mode, your workstation is used as-is). Every target in the run shares
   this single source node---it's created once, not once for each target.
3. Chef Infra Client and InSpec are installed on the source node, unless
   `install_strategy: skip` says they're already there.
4. For each target, short-lived credentials for reaching it are written to
   the source node.
5. The source node runs `chef-client --target` and `inspec exec --target`
   against the target's endpoint, over SSH or WinRM, exactly as it would run
   locally---only the connection is remote.
6. The per-target credentials are removed from the source node once the
   action finishes, whether it succeeded or failed.

Because the source node is shared, running `kitchen test` across several
platforms in one project only pays the installation cost once, not once for each
platform---as long as every platform can use the same source configuration.

## Requirements

- `chef-test-kitchen-enterprise` 3.0 or later
- Ruby 3.1 or later
- The `sub_driver` gem for your source node and targets (for example
  `kitchen-docker` or `kitchen-ec2`) available to Test Kitchen

Chef Infra Client and Chef InSpec don't need to be installed ahead of
time---the `chef_infra_agentless` provisioner and `inspec_agentless` verifier
install them on the source node at runtime.

## Plugin components

The `agentless` driver is made up of three cooperating pieces:

| Component | Role |
|---|---|
| Driver (`agentless`) | Orchestrates the source and target create and destroy actions, and delegates the actual compute lifecycle to the configured `sub_driver`. |
| Provisioner (`chef_infra_agentless`) | Builds `chef-client --target` commands, stages target credentials, and uploads cookbooks to the source node. |
| Verifier (`inspec_agentless`) | Runs Chef InSpec profiles against each target from the source node. |

`kitchen-agentless` is a plugin for `chef-test-kitchen-enterprise` and requires
the core gem. Test Kitchen core itself has no agentless-specific code; it only
provides the generic plugin extension points---driver registration and the
`kitchen list` and `kitchen destroy` hooks---that any Test Kitchen driver uses.

## State files

Two kinds of local state live under `.kitchen/`:

- `.kitchen/<instance-name>.yml` is the standard per-target Test Kitchen state,
  with one file for each target instance.
- `.kitchen/agentless-source.yml` is the shared source node's state, including
  its hostname, port, credentials, and the `sub_driver` that created it. The
  presence of this file is how `kitchen create` decides whether the source node
  already exists or needs to be created.

Because that check is a local file check that never verifies the resource still
exists in the cloud or hypervisor, keeping this file in sync with reality
matters. If you switch the `sub_driver` that creates the source node, run
`kitchen destroy` first so this file doesn't go stale.

## Source node in `kitchen list`

Unless `source_node.mode: local` is set, `kitchen list` shows an extra
`agentless-source` row above your target instances, with its driver name and
whether it's currently created:

```console
$ kitchen list
Instance             Driver     Provisioner          Verifier          Transport  Last Action    Last Error
agentless-source     docker     (source node)        -                 Ssh        <Not Created>  <None>
default-ubuntu-2204  agentless  ChefInfraAgentless   InspecAgentless   Ssh        <Not Created>  <None>
```

In `local` source mode no `agentless-source` row appears, because the machine
running `kitchen` is the source node and nothing is created for it.
