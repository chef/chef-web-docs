.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When backing up |chef server| data, be sure that the system is shut down (or otherwise quiet) at the time of the backup.
Perform all activities as root unless otherwise directed.

#. Make a postgres export using the following commands:

    .. code-block:: bash
    
      export THEDATE=`date '+%Y-%m-%d-%H-%M-%S'`
      sudo -E -u opscode-pgsql bash
      /opt/opscode/embedded/bin/pg_dumpall -c | gzip --fast > /tmp/postgresql-dump-$THEDATE.gz
      Ctrl-d

#. Synchronize to make sure that all of the data is present on-disk:

    .. code-block:: bash

      sync

#. Backup the /etc/opscode and /var/opt/opscode directories and include the postgres export file as root

    .. code-block:: bash

      tar cvfzp var-opt-opscode-$THEDATE.tar.gz /etc/opscode /var/opt/opscode /tmp/postgresql-dump-$THEDATE.gz
