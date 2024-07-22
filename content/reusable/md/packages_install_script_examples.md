The following examples show how to use the Chef Software Install script.

To install Chef Inspec 6.6.0:

```bash
curl -L https://chefdownload-commercial.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash -s -- -v 6.6.0
```

To install the latest version of Chef Workstation on Windows
from the `current` channel:

```powershell
. { iwr -useb https://chefdownload-commercial.chef.io/install.ps1?license_id=<YOUR LICENSE ID1> } | iex; install -channel stable -project inspec -version 6.6.0
```

enter your licenseId in the place of YOUR LICENSE ID