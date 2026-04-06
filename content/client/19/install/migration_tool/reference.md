+++
title = "Migration tool CLI reference"

[menu.install]
title = "CLI reference"
identifier = "install/migration_tool/reference"
parent = "install/migration_tool"
weight = 999
+++

## Syntax

The `migrate-ice apply` command upgrades or installs Chef Infra Client to version 19.

This command has the following basic syntax:

```sh
migrate-ice apply {airgap|online} [flags]
```

It supports two subcommands:

- `airgap`: Uses pre-downloaded air-gapped bundles to install or upgrade Chef Infra Client .
- `online`: Uses network-connected resources to download and install Chef Infra Client .

## Flags

<!-- markdownlint-disable MD006 MD007 -->

`--debug`
: Enable debug logs. Logs are available in `/var/log/chef19migrate.log`. Valid values are: `true` or `false`.

`--chef-version <VERSION>`
: Specify the Chef Infra Client version to download and install. Only applicable for online mode. The `--license-key` option is required with `--chef-version`.

  The tool performs the following actions:

  - **Download**: Automatically downloads the specified Chef Infra Client package from the official repository
  - **Validation**: Checks version format and ensures it's a supported Chef 19.x.x version
  - **Package Path**: The downloaded package is stored at a predefined location for later use
  - **Skip Option**: If `--chef-version` isn't provided, the flag is skipped (useful when using `--download-url` instead)

  Valid format: `19.x.x` (for example, `19.1.0`, `19.0.5`)

  This flag is mutually exclusive with `--download-url`. Use one or the other, not both.

`--download-url <URL>`
: Specify the Chef Infra Client download location.

`--fresh-install`
: Whether to perform a fresh installation. Valid values are: `true` or `false`.

  Default value: `false`.

`--fstab <option>`
: Remount Chef Infra Client from `/opt/chef` to `/hab`.
  This maintains system integrity while transitioning from an Omnibus-based Infra Client installation to a Habitat-based setup.

  Flag not available on Windows.

  Valid values:

  - `apply`: Performs the mount migration from `/opt/chef` to `/hab`. Default behavior.
  - `fail`: Checks whether `/opt/chef` is already mounted and logs the result without performing the migration.
  - `ignore`: Skips the mount migration check entirely.

  Default value: `apply`.

`--habitat`
: Install Chef Habitat along with Chef Infra Client.

`--habitat-upgrade`
: Whether to upgrade Chef Habitat to the latest version.

  Default value: `false`.

`--help`
: CLI command help.

`--license-key <key>`
: A Progress Chef License key for downloading Chef Infra Client.

`--license-server <URL>`
: URL of the private or public Chef licensing service (optional).

`--preserve-omnibus`
: Whether to preserve an existing Omnibus Chef Infra Client installation. Valid values are: `true` or `false`.

  Default value: `false`.

`--process-config <option>`
: Analyzes the `client.rb` config file to determine if it references the Omnibus-based Chef Infra Client installation (`/opt/chef`). This identifies potential conflicts when migrating to a Habitat-based setup.

  Valid values:

  - `ignore`: Skips the configuration check entirely.
  - `warn`: Logs a warning if `/opt/chef` is found in `client.rb` but continues execution.
  - `error`: Aborts execution if `/opt/chef` is found, preventing potential conflicts.

  Default value: `error`.

`--selinux-ignore-warnings`
: Ignore warnings related to SELinux handling.

`--selinux-profile <option>`
: Install a default or custom SELinux profile.

  Valid options: `default` or `<PROFILE_FILE_PATH>`.

`--symlink`
: Replaces symbolic links to essential binaries---for example, `ruby`, `chef-client`, and `openssl`---from Omnibus-based to Habitat-based Chef Infra Client.

  This processes binaries in `/opt/chef/bin` and `/opt/chef/embedded/bin`. Each file within these directories is evaluated and if it's an executable associated with Chef, the tool creates a symlink to the corresponding binary within Chef Habitat. If no equivalent is found in Habitat, the file is left unchanged.

  Flag not available on Windows.

  Default value: `false`.

<!-- markdownlint-enable MD006 MD007 -->

## Examples

### Install Chef Infra Client

These examples show how to perform a fresh install of Chef Infra Client .

Install Chef Infra Client by specifying a download URL:

```sh
migrate-ice apply online --fresh-install --download-url "<DOWNLOAD_URL>" --license-key "<LICENSE_KEY>"
```

Replace:

- `<DOWNLOAD_URL>` with the Chef Infra Client package download URL
- `<LICENSE_KEY>` with a valid Progress Chef License key

Install Chef Infra Client in an online environment by specifying a version number:

```sh
migrate-ice apply online --fresh-install --chef-version <VERSION> --license-key "<LICENSE_KEY>"
```

Replace:

- `<LICENSE_KEY>` with a valid Progress Chef License key
- `<VERSION>` the full three-part Chef Infra Client version number (for example, `19.1.0`)

<!---
Standard air-gapped installation:

```sh
migrate-ice apply airgap </PATH/TO/BUNDLE> --fresh-install --license-key "<LICENSE_KEY>"
```
--->

### Upgrade Chef Infra Client

These examples show how to upgrade Chef Infra Client to version 19 RC3 from an earlier version.

Standard online upgrade:

```sh
migrate-ice apply online --download-url "<DOWNLOAD_URL>" --license-key "<LICENSE_KEY>"
```

Standard air-gapped upgrade:

```sh
migrate-ice apply airgap </PATH/TO/BUNDLE> --license-key "<LICENSE_KEY>"
```

### Manage Omnibus-based Chef Infra Client

Preserve an Omnibus-based Chef Infra Client installation:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --preserve-omnibus
```

Log a warning if the `client.rb` config file references the Omnibus-based Chef Infra Client installation (`/opt/chef`):

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --process-config warn
```

Replace the existing Omnibus-based Chef binaries (for example, `ruby`, `chef-client`, and `openssl`) with symbolic links pointing to their Habitat-based equivalents.

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --preserve-omnibus --symlink
```

Remount Chef Infra Client from `/opt/chef` to `/hab`:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --fstab apply
```

Abort the migration process if `/opt/chef` is already mounted:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --fstab fail
```

### Manage Chef Habitat

Upgrade Chef Habitat while installing Chef Infra Client:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --habitat-upgrade
```

### SELinux profiles

Install the default SELinux profile:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --selinux-profile default --selinux-ignore-warnings
```

Install a custom SELinux profile:

```sh
migrate-ice apply {airgap|online} --license-key "<LICENSE_KEY>" --selinux-profile <PATH/TO/CUSTOM/PROFILE>
```

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
