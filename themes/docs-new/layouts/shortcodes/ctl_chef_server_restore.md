The `restore` subcommand is used to restore Chef Infra Server data from
a backup that was created by the `backup` subcommand. This subcommand
may also be used to add Chef Infra Server data to a newly-installed
server. This subcommand:

- Requires rsync to be installed on the Chef Infra Server prior to
    running the command
- Requires a `chef-server-ctl reconfigure` prior to running the
    command
- Should not be run in a Chef Infra Server configuration with an
    external PostgreSQL database; [use knife ec
    backup](https://github.com/chef/knife-ec-backup) instead

Ideally, the server you restore to will have the same FQDN as the one you
backed up. If this is not possible, perform the following additional steps
before running `chef-server-ctl reconfigure` and `chef-server-ctl restore`:

- Edit /etc/opscode/chef-server.rb and /etc/opscode/chef-server-running.json
    to replace the old FQDN with the new one
- Delete the old SSL certificate, key and -ssl.conf file from
    /var/opt/opscode/nginx/ca . If you use a CA-issued certificate instead of a
    self-signed certificate, copy that certificate and key into the same directory.
- On each client, update the /etc/chef/client.rb file to point to the new server.
