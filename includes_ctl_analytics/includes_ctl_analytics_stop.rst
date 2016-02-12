.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``stop`` subcommand is used to stop all services enabled on |chef analytics|. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-analytics-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ opscode-analytics-ctl stop

will return something similar to:

.. code-block:: bash

   ok: down: actions: 1s, normally up
   ok: down: actions_consumer: 0s, normally up
   ok: down: actions_messages: 0s, normally up
   ok: down: memcached: 1s, normally up
