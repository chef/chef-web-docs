+++
title = "Upgrade Chef InSpec"

[menu.inspec_7_2]
title = "Upgrade Chef InSpec"
identifier = "manage/upgrade"
parent = "manage"
weight = 10
+++

## Upgrade Chef InSpec that was installed from a Habitat package

To upgrade Chef InSpec to a newer version in the same channel, re-run the install command with `--force`:

```sh
sudo hab pkg install chef/inspec --channel base-2025 --binlink --force
```

## Upgrade Chef InSpec that was installed from a platform-native package

To upgrade Chef InSpec to a newer version:

1. [Uninstall the current version](uninstall) using the steps for your platform.
1. [Download and install](/inspec/7.2/install/) the new version.
