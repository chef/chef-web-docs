The `install` subcommand downloads packages from
<https://packages.chef.io/> by default. For systems that are behind a
firewall (and may not have connectivity to packages.chef.io), these
packages can be downloaded from
<https://downloads.chef.io/chef-manage/>, and then installed manually.
First download the package that is appropriate for the platform, save it
to a local path, and then run the `install` command using the `--path`
option to specify the directory in which the package is located:

``` bash
$ sudo chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory
```

For example:

``` bash
$ sudo chef-server-ctl install chef-manage --path /root/packages
```

The `chef-server-ctl` command will install the first `chef-manage`
package found in the `/root/packages` directory.