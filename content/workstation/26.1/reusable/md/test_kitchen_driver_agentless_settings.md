The `agentless` driver spreads its configuration across four places in
`kitchen.yml`: the `driver` block (which instance to create, and with what),
the nested `driver.agentless` block (agent-specific behavior like
`volatility`), the `provisioner` block (what to install and run on the
source node for Chef Infra Client), and the `verifier` block (the same, for
InSpec). Settings that apply to a specific target---rather than to the run
as a whole---live under `driver.agentless.remote_nodes`, keyed by instance
name.

The following attributes are used to configure the `agentless` driver.

`name`

: Must be `agentless`.

: Required

`sub_driver`

: The real driver that creates compute resources for the source node and any ephemeral targets, for example `ec2`, `docker`, or `vagrant`. Its gem must be installed. Required even when `volatility: real` and `source_node.mode: local` are both set, since Test Kitchen still checks for it before doing anything else.

: Required

`agentless`

: The Hash containing every agent-specific setting described below.

: Default value: `{}` (ephemeral targets, with an `instance`-mode source node).

### `driver.agentless`

`volatility`

: `ephemeral` lets Test Kitchen create and destroy targets through `sub_driver`. `real` targets already exist; Test Kitchen only connects, converges, and verifies them, and never creates or destroys them. Any other value raises an error.

: Default value: `ephemeral`.

`source_node`

: A Hash configuring the shared source node. See `driver.agentless.source_node` below.

: Default value: `{}`.

`remote_nodes`

: A Hash, keyed by instance name, of per-instance driver and transport overrides. Must be a Hash---an Array raises a migration error. Required when `volatility: real`, since that's how real targets get their `hostname`.

: Default value: `{}`.

`credential-map-file`

: Path to a YAML file that maps instance names to target credentials, so secrets stay out of `kitchen.yml`.

: Default value: `nil`.

`skip-connectivity-check`

: Skips the pre-flight TCP probe of `real` targets. Set to `true` when targets sit behind a jump host or proxy that the workstation running `kitchen` can't reach directly. Alias: `skip_connectivity_check`.

: Default value: `false`.

`connectivity-check-timeout`

: Number of seconds the connectivity probe waits before failing. Raise this on slow or high-latency networks. Alias: `connectivity_check_timeout`. Only applies to `real` targets, and runs before the source node is created.

: Default value: `10`.

### `driver.agentless.source_node`

`mode`

: `instance` has `sub_driver` create a machine to act as the source node. `local` uses your own workstation as the source---it needs `chef-client` and `inspec` on `PATH`, and no `agentless-source` row appears in `kitchen list`. Any other value raises an error.

: Default value: `instance`.

`driver`

: A Hash of sub-driver settings used only for the source node (image, instance size, and so on), merged over the top-level `driver:` block. Use this when the source needs a different image than the targets. Not used when `mode: local`.

: Default value: `{}`.

`transport`

: A Hash of connection settings for the source node, for example `username`, `ssh_key`, or `password`. Required in practice for `mode: instance`, since the provisioner and verifier both run their commands there. Not used when `mode: local`.

: Default value: `{}`.

### `driver.agentless.remote_nodes.<instance-name>`

Keys under `remote_nodes` must exactly match the instance names shown by
`kitchen list`. Test Kitchen builds names as `<suite>-<platform>`, removes
`.`, and turns `_`, `,`, and `/` into `-`, so `default` and `ubuntu-22.04`
becomes `default-ubuntu-2204`.

`driver`

: Per-target sub-driver overrides. Valid only for `ephemeral` targets---setting it under `volatility: real` raises an error, since nothing is created for a real target.

: Default value: `{}`.

`transport.hostname`

: Address of the existing target. Required for every `real` instance, either here or from `credential-map-file`; validated before the source node is created.

: Required for `real` targets.

`transport.port`

: Port used to connect to the target. Must be between 1 and 65535.

: Default value: `22`.

`transport.username`, `transport.ssh_key`, `transport.password`

: Direct credentials for this target, as an alternative to `credential-map-file`.

Driver and transport settings resolve with the following precedence, highest
first: `remote_nodes[name]`, then `platforms[]`/`suites[]`, then the
top-level `driver:`/`transport:` block. In practice, this means you can set
sensible defaults once at the top level, and reach for `remote_nodes` only
for the handful of targets---or the source node---that need to differ from
those defaults, such as a target that needs a larger instance size or a
different SSH user.

The provisioner and verifier settings below are unrelated to this precedence
chain---they configure the software installed and run *on the source node*,
not the targets themselves, so they apply uniformly to every target the
source node tests in a given run.

### Provisioner settings (`chef_infra_agentless`)

`name`

: Must be `chef_infra_agentless`.

: Required

`version`

: Chef Infra Client version installed on the source node. Must be 19.0 or newer---target mode doesn't exist before that.

: Default value: `nil` (latest).

`product_version`

: Standard Chef installer version key, used only when `version` isn't set.

: Default value: `latest`.

`product_name`

: Only `chef-ice` is accepted---other Chef packages have no target-mode support. Ignored when `source_node.mode: local`.

: Default value: `chef-ice`.

`channel`

: Download channel for the install: `stable`, `current`, or `unstable`.

: Default value: `stable`.

`install_strategy`

: `once` installs only if missing, `always` reinstalls on every converge, `skip` assumes Chef Infra Client is already present.

: Default value: `once`.

`chef_client_args`

: An Array of extra flags appended verbatim to every `chef-client --target` run.

: Default value: `[]`.

`target_sudo`

: Prefixes commands run on the target with `sudo`. Automatically skipped when the target user is `root`; set to `false` for images without `sudo` available.

: Default value: `true`.

`target_verify_host_key`

: Verifies the target's SSH host key. Enable this where host-key pinning is required.

: Default value: `false`.

`target_platform_version`

: Overrides the reported Windows platform version for WinRM targets. Only needed when the value auto-detected from the platform name (for example `windows-2022`) is wrong; ignored for non-WinRM targets.

: Default value: `nil`.

`chef_license_key`

: Entitled-download license key. Set this only when neither `CHEF_LICENSE_KEY` nor the key from `kitchen license` applies.

: Default value: `CHEF_LICENSE_KEY`, else the key from `kitchen license`.

### Verifier settings (`inspec_agentless`)

`name`

: Must be `inspec_agentless`.

: Required

`inspec_version`

: InSpec version installed on the source node.

: Default value: `nil` (latest).

`product_name`

: `inspec-enterprise` selects the licensed product; use `inspec` for InSpec 5.x--6.x.

: Default value: `inspec-enterprise`.

`channel`

: Download channel: `stable`, `current`, or `unstable`.

: Default value: `stable`.

`install_strategy`

: Same meaning as the provisioner's `install_strategy`.

: Default value: `once`.

`inspec_tests`

: An Array of profile locators, normally set per suite. Takes priority over `profiles_path`.

: Default value: `[]`.

`profiles_path`

: Fallback profile location, used only when `inspec_tests` is empty.

: Default value: `test/integration`.

`inspec_args`

: An Array of extra flags appended verbatim to `inspec exec`, such as reporters, for example `["--reporter", "cli", "junit:reports/out.xml"]`. `--reporter cli` is added automatically unless you supply your own.

: Default value: `[]`.

`chef_license_key`

: Same resolution as the provisioner's `chef_license_key`.

: Default value: `CHEF_LICENSE_KEY`, else the key from `kitchen license`.

### Command-line flags and environment variables

`--keep-agentless-source`

: Also settable as `keep_agentless_source: true`. `kitchen destroy` leaves the shared source node running, even when destroying the last target. Useful while iterating.

`KITCHEN_KEEP_AGENTLESS_SOURCE=1`

: Same effect as `--keep-agentless-source`, without editing `kitchen.yml`.

`KITCHEN_CREDENTIAL_PASSPHRASE`

: Passphrase for decrypting `credential-file` entries in the credential map.

`KITCHEN_CREDENTIAL_PASSPHRASE_<INSTANCE_NAME>`

: Per-instance override of the passphrase (instance name upper-cased, non-alphanumerics become `_`); takes priority over the global variable.

`CHEF_LICENSE_KEY`

: Default license key for both the provisioner and the verifier.

`KITCHEN_YAML`

: Standard Test Kitchen variable for selecting a `kitchen.yml` file. It does not change `.kitchen/` state paths, so different files in one project share `agentless-source.yml`.
