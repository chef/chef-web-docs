.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When restoring |chef server| data, the previously backed-up files will be required, along with the |chef server| running only the |service postgresql| service. Perform all activities as root unless otherwise directed.

#. Stop the |chef server|:

   .. code-block:: bash
      
      $ chef-server-ctl stop

#. Restore the previously backed-up files to the following locations:

   * ``/etc/opscode`` 
   * ``/var/opt/opscode``

   by using the following command, which will exclude |postgresql| files:

   .. code-block:: bash

      tar xvfzp var-opt-opscode-$THEDATE.tar.gz --exclude='var/opt/opscode/drbd/data/postgresql_9.2' -C /

#. Start the |service postgresql| service:

   .. code-block:: bash
      
      $ chef-server-ctl start postgresql

#. Restore the |postgresql| database:

    .. code-block:: bash

      su - opscode-pgsql
      gunzip -c postgresql-dump-$THEDATE.gz | /opt/opscode/embedded/bin/psql -U "opscode-pgsql" -d postgres

    Ignore the following error messages:

    * ``ERROR: current user cannot be dropped``
    * ``ERROR: role "opscode-pgsql" already exists``

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl start

#. Reconfigure the |chef manage|:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure
