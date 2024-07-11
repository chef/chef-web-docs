The following examples show how to use the Chef Software Install script.

To install Chef Infra Client 15.8.23:

```bash
curl -L https://chefdownload-trial.chef.io/stable/downloadScript?os_type=linux | sudo bash -s -- -v 6.6.0
```

To install the latest version of Chef Workstation on Windows
from the `current` channel:

```powershell
. { iwr -useb https://chefdownload-trial.chef.io/stable/downloadScript?os_type=windows } | iex; install -channel stable -project inspec -version 6.6.0
```
