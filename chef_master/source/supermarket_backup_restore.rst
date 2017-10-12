=====================================================
Supermarket Backup and Restore
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/supermarket_backup_restore.rst>`__

Periodic backups of Supermarket data are an essential part of managing and maintaining a healthy configuration and to help ensure that important data can be restored, if required.

Cookbooks
default location is: /var/opt/supermarket/data

Database
/opt/supermarket/embedded/bin/pg_dump <supermarket_database_name> -c -f supermarket.sql
