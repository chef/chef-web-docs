+++
title = "Upgrade your Chef Habitat Builder on-prem deployment"

[menu]
  [menu.habitat]
    title = "Upgrade Builder"
    identifier = "habitat/on-prem-builder/manage/upgrade"
    parent = "habitat/on-prem-builder/manage"
    weight = 50
+++

Chef Habitat Builder on-prem services don't upgrade automatically.
To upgrade the services, use the uninstall script to stop, unload, and remove them.

{{< note >}}

The uninstall script doesn't remove user data, so you can uninstall and reinstall the Habitat Builder services without losing data.

{{< /note >}}

To upgrade Chef Habitat Builder on-prem, follow these steps:

1. Clone the [`habitat-sh/on-prem-builder`](https://github.com/habitat-sh/on-prem-builder) repository on the computer running Habitat Builder on-prem.

1. Uninstall all Habitat Builder services by running the [uninstall script](https://github.com/habitat-sh/on-prem-builder/blob/main/uninstall.sh):

    ```shell
    sudo ./uninstall.sh
    ```

1. After the services are uninstalled, reinstall them by running the [`install.sh` script](https://github.com/habitat-sh/on-prem-builder/blob/main/install.sh):

    ```shell
    ./install.sh
    ```
