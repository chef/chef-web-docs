.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Over time, and with enough data, disks will fill up or exceed the per-disk quotas that may have been set for them and they will not be able to write data. A disk that is not able to write data will not be able to support certain components of the Chef server, such as PostgreSQL, RabbitMQ, service log files, and deleted file handles. Monitoring disk usage is the best way to ensure that disks don't fill up or exceed their quota.

Use the following commands to monitor global disk usage on a Chef server with a typical installation:

.. code-block:: bash

   $ du -sh /var/opt/opscode 

and:

.. code-block:: bash

   $ du -sh /var/log/opscode 

To keep the Chef server healthy, both ``/var/opt/opscode`` and ``/var/log/opscode`` should never exceed 80% use. In situations where disk space grows at a rapid pace, it may be preferable to shut down the Chef server and contact Chef support.

The following components should be monitored for signs that disks may be rapidly filling up:

* **PostgreSQL** PostgreSQL is the data store for the Chef server.
* **RabbitMQ** The RabbitMQ data folder can fill up if the **opscode-expander** service is not able to keep up with the data being moved into the search database by RabbitMQ. When the **opscode-expander** service falls behind, RabbitMQ will start storing the individual messages on-disk while it waits for the **opscode-expander** service to catch up. If the RabbitMQ disk fills up completely, RabbitMQ will need to be restarted to free up the disk space and any data that was stored on-disk will be lost.
* **Log files** If ``/var/log/opscode`` is taking up a lot of disk space, ensure that the Chef server log rotation cron job is running without errors. These errors can be found in ``/var/log/messages``, ``/var/log/syslog`` and/or the root user's local mail.
* **Deleted file handles** Running processes with file handles associated with one (or more) deleted files will prevent the disk space being used by the deleted files from being reclaimed. Use the ``sudo lsof | grep '(deleted)'`` command to find all deleted file handles. 



