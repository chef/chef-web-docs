.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``status`` subcommand is used to show the status of all services available to |supermarket|. The results will vary based on the configuration of a given server. This subcommand has the following syntax:

.. code-block:: bash

   $ supermarket-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ supermarket-ctl status name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

When service status is requested, the output should be similar to:

.. code-block:: bash

   $ run: service_name: (pid 12345) 12345s; run: log: (pid 1234) 67890s

where

* ``run:`` is the state of the service (``run:`` or ``down:``)
* ``service_name:`` is the name of the service for which status is returned
* ``(pid 12345)`` is the process identifier
* ``12345s`` is the uptime of the service, in seconds

For example:

.. code-block:: bash

   $ down: actions: (pid 35546) 10s

By default, |runit| will restart services automatically when the services fail. Therefore, |runit| may report the status of a service as ``run:`` even when there is an issue with that service. When investigating why a particular service is not running as it should be, look for the services with the shortest uptimes. For example, the list below indicates that the |service actions| should be investigated further:

.. code-block:: bash

   run: actions: (pid 6361) 4132s; run: log: (pid 6173) 4146s
   run: actions_consumer: (pid 6374) 5s; run: log: (pid 6227) 4139s
   run: actions_messages: (pid 6392) 4131s; run: log: (pid 6324) 4133s
   run: memcached: (pid 6115) 4157s; run: log: (pid 6129) 4156s
