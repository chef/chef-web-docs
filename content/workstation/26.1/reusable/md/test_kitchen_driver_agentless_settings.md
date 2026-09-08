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

## `driver.agentless`

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

## `driver.agentless.source_node`

`mode`

: `instance` has `sub_driver` create a machine to act as the source node. `local` uses your own workstation as the source---it needs `chef-client` and `inspec` on `PATH`, and no `agentless-source` row appears in `kitchen list`. Any other value raises an error.

: Default value: `instance`.

`driver`

: A Hash of sub-driver settings used only for the source node (such as image and instance size), merged over the top-level `driver:` block. Use this when the source needs a different image than the targets. Not used when `mode: local`.

: Default value: `{}`.

`transport`

: A Hash of connection settings for the source node, for example `username`, `ssh_key`, or `password`. Required in practice for `mode: instance`, since the provisioner and verifier both run their commands there. Not used when `mode: local`.

: Default value: `{}`.

## `driver.agentless.remote_nodes.<instance-name>`

Keys under `remote_nodes` must exactly match the instance names shown by
`kitchen list`. Test Kitchen builds names as `<suite>-<platform>`, removes
`.`, and turns `_`, `,`, and `/` into `-`, so `default` and `ubuntu-22.04`
becomes `default-ubuntu-2204`.

Because the instance name comes from `<suite>-<platform>`, each `real` target
needs its own `platforms` entry so it produces a unique instance name that
matches its `remote_nodes` key. For example, a `staging` suite with the
`web-01` and `web-02` platforms yields the `staging-web-01` and
`staging-web-02` keys used under `remote_nodes`.

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

`transport.protocol` (alias `transport.name`)

: Transport family used to reach the target, either `ssh` or `winrm`.

: Default value: `ssh`.

`transport.ssl`

: Use SSL for WinRM connections.

: Default value: `false`.

Driver and transport settings resolve with the following precedence, highest
first: `remote_nodes[name]`, then `platforms[]`/`suites[]`, then the
top-level `driver:`/`transport:` block. In practice, this means you can set
sensible defaults once at the top level, and reach for `remote_nodes` only
for the handful of targets---or the source node---that need to differ from
those defaults, such as a target that needs a larger instance size or a
different SSH user.

The provisioner and verifier settings below are unrelated to this precedence
chain---they configure the software installed and run _on the source node_,
not the targets themselves, so they apply uniformly to every target the
source node tests in a given run.

## Connectivity checks

Before creating a `real` target---and before validating or using its
credentials---the driver runs a best-effort TCP reachability check against the
target's `hostname:port`. This turns an unreachable host, closed port, or DNS
failure into a clear `Kitchen::UserError` raised immediately by `kitchen
create`, instead of a confusing Chef Infra Client or InSpec connection error
later during `converge` or `verify`.

- The check applies only to `real` targets. Ephemeral targets are created by
  `sub_driver`, which already waits for the resource to become reachable.
- It runs before the shared source node is created or reused, so an unreachable
  target never triggers an unnecessary source-node creation.
- It checks raw TCP connectivity to `transport.port` only. A successful check
  doesn't guarantee that SSH or WinRM authentication will succeed---credentials
  are validated separately.

Set `skip-connectivity-check: true` for targets behind a jump host or proxy that
the workstation can't reach directly but the source node can, and raise
`connectivity-check-timeout` on slow or high-latency networks. Both keys accept
dash-case or snake_case (`skip_connectivity_check`, `connectivity_check_timeout`).

## Provisioner settings (`chef_infra_agentless`)

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

: Overrides the reported Windows platform version for WinRM targets. Only needed when the value automatically detected from the platform name (for example `windows-2022`) is wrong; ignored for non-WinRM targets.

: Default value: `nil`.

`chef_license_key`

: Entitled-download license key. Set this only when neither `CHEF_LICENSE_KEY` nor the key from `kitchen license` applies.

: Default value: `CHEF_LICENSE_KEY`, else the key from `kitchen license`.

`source_platform`

: Windows platform used when generating the source node's install script. Only used when a Windows source install script is needed; ignored otherwise.

: Default value: `windows`.

`source_platform_version`

: Windows OS version used in the source node's install script.

: Default value: `2019`.

`source_architecture`

: CPU architecture used in the source node's install script.

: Default value: `x86_64`.

## Verifier settings (`inspec_agentless`)

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

: An Array of profile locators, normally set for each suite. Takes priority over `profiles_path`.

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

`source_platform`, `source_platform_version`, `source_architecture`

: Same meaning as the matching provisioner keys, used when generating a Windows install script for InSpec on the source node.

: Default values: `windows`, `2019`, and `x86_64`.

## Command-line flags and environment variables

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

: Standard Test Kitchen variable for selecting a `kitchen.yml` file. It doesn't change `.kitchen/` state paths, so different files in one project share `agentless-source.yml`.

## Credentials

Agentless mode needs credentials in three distinct places. They're easy to
conflate, but each serves a different purpose:

1. **Workstation to source node**---`driver.agentless.source_node.transport`
   describes how the machine running `kitchen` reaches the source node.
2. **Source node to target node**---how `chef-client --target` (converge) and
   InSpec (verify), both running on the source node, authenticate to each
   target. This is what the rest of this section covers.
3. **`kitchen.yml` to cloud provider**---normal `sub_driver` credentials (such
   as an AWS profile or the Docker socket) for creating compute resources.
   These aren't agentless-specific; see your `sub_driver`'s own documentation.

For reaching a target from the source node, you have two options:

- `remote_nodes.<instance-name>.transport`---direct, inline in `kitchen.yml`.
  Works for both `ephemeral` and `real` targets. For ephemeral targets this is
  usually all you need, since the `sub_driver` typically generates or knows the
  key itself.
- `credential-map-file`---a centralized YAML file that supports encryption, used
  only for `real` targets. An entry for an ephemeral target's instance name is
  never consulted.

When both a `credential-map-file` entry and `remote_nodes.<name>.transport`
credentials are set for the same `real` target, the `credential-map-file` entry
wins for any field it supplies; `remote_nodes.<name>.transport` only fills in
fields the credential-map-file entry leaves out. `hostname` and `port` always
come from `remote_nodes.<name>.transport`.

### `credential-map-file` format

```yaml
credentials:
  <instance-name>:
    type: inline            # or: credential-file

    # type: inline
    protocol: ssh           # or winrm
    username: admin
    password: <%= ENV["TARGET_PASSWORD"] %>   # optional if ssh_key is set
    ssh_key: ~/.ssh/id_rsa                     # path, resolved relative to the project root

    # type: credential-file (alternative to inline)
    path: creds/my-target.enc
    passphrase: <%= ENV["KITCHEN_CREDENTIAL_PASSPHRASE"] %>   # only for encrypted files
```

- The whole file supports ERB (`<%= ENV["..."] %>`), evaluated before the YAML
  is parsed, which is the standard way to keep secrets out of the file.
- A `type: credential-file` entry can point at a plaintext or an
  `openssl enc -aes-256-cbc -pbkdf2`-encrypted file of `key=value` lines (for
  example `username=...`, `ssh_key=...`). Encryption is automatically detected from the
  `Salted__` header.

To encrypt a credential file:

```shell
openssl enc -aes-256-cbc -pbkdf2 -salt \
  -in creds/my-target.plain \
  -out creds/my-target.enc
```

### Passphrase resolution

For an encrypted `credential-file` entry, the passphrase is resolved in this
order:

1. `passphrase` set directly in the credential-map-file entry.
2. `KITCHEN_CREDENTIAL_PASSPHRASE_<INSTANCE_NAME>` environment variable.
3. `KITCHEN_CREDENTIAL_PASSPHRASE` environment variable.
4. An interactive prompt, only when attached to a real TTY and `CI` is unset.
5. Otherwise, it fails with a clear error. It never hangs waiting for input in CI.

### Secret masking and validation

Any password or passphrase resolved from your credentials is masked as `****` in
all logged output, including verify and InSpec command logs, so secrets never
appear in `kitchen` output or CI logs. Under `volatility: real`, `kitchen
create` also validates---before any resources are created---that every target
has a hostname and some resolvable credential source, and names exactly which
target is missing what.
