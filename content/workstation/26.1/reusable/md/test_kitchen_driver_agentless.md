Most Test Kitchen drivers work the same way: create a target instance, copy
Chef Infra Client and InSpec onto it, and run both directly on that machine.
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
driver named in `sub_driver` (`ec2`, `docker`, `vagrant`, and so on), whose
gem must be installed and available to Test Kitchen.

Two concepts control how instances behave:

- **Volatility**, set with `driver.agentless.volatility`, is either
  `ephemeral` (Test Kitchen creates and destroys targets through
  `sub_driver`, the default) or `real` (targets already exist, and Test
  Kitchen only connects to them).
- **Source node**, configured under `driver.agentless.source_node`, is
  created once per Test Kitchen run and shared by every instance in that
  run. It's either its own `instance` (created by `sub_driver`) or your own
  workstation in `local` mode. A shared instance source node appears in
  `kitchen list` as `agentless-source`, a reserved instance name.

`remote_nodes`, configured under `driver.agentless.remote_nodes` and keyed by
instance name, lets you override the driver and transport settings for each
target individually---this is where `real` targets get their `hostname`, and
where `ephemeral` targets can use a different image or instance size than the
source node.

**What actually happens during a test run**

Understanding the run order makes the rest of the configuration easier to
reason about:

1. Test Kitchen resolves which target instances a command applies to, the
   same way it would for any driver.
2. If no source node exists yet for this run, one is created (or, in `local`
   mode, your workstation is used as-is). Every target in the run shares
   this single source node---it's created once, not once per target.
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
platforms in one project only pays the installation cost once, not once per
platform---as long as every platform can use the same source configuration.
