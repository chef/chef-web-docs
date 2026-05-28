The `install` subcommand downloads packages from the Chef download API by default (<https://chefdownload-commercial.chef.io> for commercial users or <https://chefdownload-community.chef.io> for community users).
For systems that are not behind a firewall (and have connectivity to the Chef download API), these packages can be installed as described below.

1. Install add-ons

   Install Chef Manage with:

   ```bash
   sudo chef-server-ctl install chef-manage
   ```

1. Reconfigure the server

   ```bash
   sudo chef-server-ctl reconfigure
   ```

1. Reconfigure add-ons

   Reconfigure Chef Manage with:

   ```bash
   sudo chef-manage-ctl reconfigure
   ```

Finally, accept the [Chef License](https://docs.chef.io/chef_license/):

```bash
sudo chef-manage-ctl reconfigure --accept-license
```
