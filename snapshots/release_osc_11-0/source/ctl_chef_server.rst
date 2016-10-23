.. THIS PAGE DOCUMENTS Open Source Chef server version 11.0

=====================================================
chef-server-ctl (executable)
=====================================================

The open source Chef server includes a command-line utility named chef-server-ctl, which is used to start and stop individual services, reconfigure the Chef server, and tail Chef server log files.

Options
=====================================================
This command has the following syntax::

   chef-server-ctl OPTION

This command has the following options:

``help``
   Show help for the command.

``reconfigure``
   Reconfigure the Chef server. This option reads from the ``/etc/chef-server/chef-server.rb`` file and applies that configuration to the Chef server. Any time changes are made to the chef-server.rb file, run the chef-server-ctl command with this option.

``restart [SERVICE_NAME]``
   Restart all enabled services or restart a single service.

``start [SERVICE_NAME]``
   Start all enabled services or start a single service.

``status [SERVICE_NAME]``
   View the status of all services or view the status of a single service.

``stop [SERVICE_NAME]``
   Stop all enabled services or stop a single service.

``tail [SERVICE_NAME]``
   Follow the Chef server logs for all services or for a single service.

``test --all``
   Execute chef-pedant, an integration test suite for the Chef server installation. By default, only a subset of the available test are run. Add the ``--all`` flag to run the full test suite.


Examples
=====================================================
The following examples show how to use chef-server-ctl to manage services.

**View the status of a service**

.. code-block:: bash

   $ ctl-chef-server status name_of_service

For example, to view the status for a service named ``erchef``, enter:

.. code-block:: bash

   $ ctl-chef-server status erchef

**Restart a service**

.. code-block:: bash

   $ ctl-chef-server restart name_of_service

For example, to restart a service named ``erchef``, enter:

.. code-block:: bash

   $ ctl-chef-server restart erchef

**Restart all services**

.. code-block:: bash

   $ ctl-chef-server restart
