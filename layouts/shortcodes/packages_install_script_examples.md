The following examples show how to use the install script.

To install Chef Client 15.3.14:

``` bash
$ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.3.14
```

To install the latest version of Chef Workstation on Microsoft Windows
from the `current` channel:

``` none
. { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -channel current -project chef-workstation
```