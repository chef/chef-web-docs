.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``stop`` subcommand is used to stop services enabled on Enterprise Chef. This command can also be run for an individual service by specifying the name of the service in the command. 

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ private-chef-ctl stop

will return something similar to:

.. code-block:: bash

   ok: down: couchdb: 394s, normally up
   ok: down: nginx: 393s, normally up
   ok: down: opscode-account: 393s, normally up
   ok: down: opscode-authz: 392s, normally up
   ok: down: opscode-certificate: 392s, normally up
   ok: down: opscode-chef: 391s, normally up
   ok: down: opscode-erchef: 391s, normally up
   ok: down: opscode-expander: 390s, normally up
   ok: down: opscode-expander-reindexer: 389s, normally up
   ok: down: opscode-org-creator: 389s, normally up
   ok: down: opscode-solr: 389s, normally up
   ok: down: opscode-webui: 388s, normally up
   ok: down: postgresql: 388s, normally up
   ok: down: rabbitmq: 388s, normally up
   ok: down: redis: 387s, normally up




