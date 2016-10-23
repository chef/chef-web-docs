.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``reconfigure`` subcommand is used to reconfigure the Chef Automate server after changes are made to the delivery configuration file, located at ``/etc/delivery/delivery.rb``. When changes are made to the delivery configuration file, they are not applied to the Chef Automate configuration until after this command is run. This subcommand also restarts any services for which the ``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl reconfigure
