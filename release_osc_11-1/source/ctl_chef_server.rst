.. THIS PAGE DOCUMENTS Open Source Chef server version 11.1

=====================================================
|chef server ctl| (executable)
=====================================================

The open source |chef server| includes a command-line utility named |chef server ctl|, which is used to start and stop individual services, reconfigure the |chef server|, and tail |chef server| log files.

Options
=====================================================
This command has the following syntax::

   chef-server-ctl OPTION

This command has the following options:

``help``
   |help subcommand|

``reconfigure``
   |server command_reconfigure|

``restart [SERVICE_NAME]``
   |server command_restart|

``start [SERVICE_NAME]``
   |server command_start|

``status [SERVICE_NAME]``
   |server command_status|

``stop [SERVICE_NAME]``
   |server command_stop|

``tail [SERVICE_NAME]``
   |server command_tail|

``test --all``
   |server command_test|
   
``upgrade --all``
   |server command_upgrade|
   
   .. warning:: The ``upgrade`` option applies only to upgrading standalone configurations of the |chef server osc| server.


Examples
=====================================================
The following examples show how to use |chef server ctl| to manage services.

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
