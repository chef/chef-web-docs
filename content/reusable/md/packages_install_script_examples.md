The following examples show how to use the Chef Software Install script.

To install Infra Client 15.8.23:

{{< note >}}Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```bash
curl -L https://chefdownload-commericial.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash -s -- -v 15.8.23
```

To install the latest version of Chef Workstation on Windows
from the `current` channel:

{{< note >}}Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```powershell
. { iwr -useb https://chefdownload-commericial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install -channel current -project chef-workstation
```
