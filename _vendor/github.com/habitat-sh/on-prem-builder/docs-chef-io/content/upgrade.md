+++
title = "Upgrade Chef Habitat Builder on-prem"

[menu]
  [menu.habitat]
    title = "Upgrade"
    identifier = "habitat/builder/on-prem/upgrade"
    parent = "habitat/builder/on-prem"
    weight = 20
+++

Chef Habitat Builder on-prem services don't auto-upgrade. When you wish to upgrade the services, there is a simple uninstall script you can use to stop and unload the services, and remove the services.

To upgrade Chef Habitat Builder on-prem, follow these steps:

1. Uninstall all Habitat Builder services:

    ```shell
    cd ${SRC_ROOT}
    sudo ./uninstall.sh
    ```

1. Once the services are uninstalled, re-install them by running the `./install.sh` script:

    ```shell
    ./install.sh
    ```

{{< note >}}

Running the uninstall script doesn't remove any user data, so you can freely uninstall and re-install the services.

{{< /note >}}