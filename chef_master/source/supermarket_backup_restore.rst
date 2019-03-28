=====================================================
Supermarket Backup and Restore
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/supermarket_backup_restore.rst>`__

Periodic backups of Supermarket data are an essential part of managing and maintaining a healthy configuration, and to help ensure that important data can be restored if required. In a typical installation of Supermarket, both the cookbook store and the database need to be backed up on a regular basis.


Backup
=====================================================

Cookbook Backup
-----------------------------------------------------

If you are not using AWS S3 storage for cookbooks, you will also need to make a backup of the local cookbook storage location. 

The default location is: ``/var/opt/supermarket/data/cookbook_versions``.

For example, a cookbook backup command:

.. code-block:: bash

     cd /var/opt/supermarket/data/ 
     tar cvzf supermarket_cookbook_versions.tar.gz cookbook_versions

Database Backup
-----------------------------------------------------

A database export can be made in several formats. 

For example, a database export in a .dump format can be made with the following syntax:

.. code-block:: bash

     $ /opt/supermarket/embedded/bin/pg_dump -h localhost -U supermarket -d supermarket_production -p 15432 -F c -b -v -f smkt-date-blah-backup.dump

where, in a typical installation:
  * ``/opt/supermarket/embedded/bin/pg_dump`` is
  * ``localhost`` may alternatively be 127.0.0.1 
  * ``15432`` is PostgreSQL port number, which may need to be modified.
  * ``-F c`` makes a custom .dump format

For documentation about the pg_dump utility, see: https://www.postgresql.org/docs/9.3/app-pgdump.html

Be sure to update the various local values in the syntax as necessary to match your infrastructure. To find local variables, look at ``/var/opt/supermarket/etc/database.yml``. For example, an output of ``database.yml`` may look like:

.. code-block:: yaml

     production:
         adapter: postgresql
         database: supermarket
         username: supermarket
         password:
         host: 127.0.0.1
         port: 15432
         pool: 25


Restore
=====================================================

Cookbook Restore
-----------------------------------------------------

When restoring cookbooks, **make sure the cookbook directory is writable by the supermarket user.**

For example, to restore your cookbook files, run:

.. code-block:: bash

     cd /var/opt/supermarket/data/
      tar xvfz /path/to/supermarket_cookbook_versions.tar.gz


Database Restore
-----------------------------------------------------

.. note::

    The restore does not support transferring backups across different versions of Supermarket. Backups taken must be restored to the same version of Supermarket that was in use when they were created.

For example, to restore a backup in a .dump format, run: 

.. code-block:: bash

     $ pg_restore -h localhost -p 15432 --clean --no-acl --no-owner -d supermarket_production -v smkt-date-blah-backup.dump

  
