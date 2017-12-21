=====================================================
Supermarket Backup and Restore
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/supermarket_backup_restore.rst>`__

Periodic backups of Supermarket data are an essential part of managing and maintaining a healthy configuration and to help ensure that important data can be restored, if required.

**Cookbooks**

The default location of cookbooks is here: `/var/opt/supermarket/data`

**Database**

A database export can be make with the following syntax:

```
/opt/supermarket/embedded/bin/pg_dump <supermarket_database_name> -c -f <targetfilename>`
```

A concrete example of a default supermarket installation could look as follows:
```
/opt/supermarket/embedded/bin/pg_dump supermarket -h localhost -p 15432 -c -f supermarket.sql -U supermarket
```
