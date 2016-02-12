.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Monitor
=====================================================

.. include:: ../../includes_server_monitor/includes_server_monitor.rst

Application Checks
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_application.rst

|couch db|
-----------------------------------------------------
|couch db| can be polled directly using HTTP. If |couch db| is running it should respond on port 5984. For example:

.. code-block:: bash

   $ curl http://localhost:5984/

which will return something similar to:

.. code-block:: bash

   {
     "couchdb":"Welcome",
     "version":"1.0.3"
   }

or:

.. code-block:: bash

   $ curl http://localhost:5984/opscode_account

which will return something similar to:

.. code-block:: bash

   {
     "db_name":"opscode_account",
     "doc_count":187,
     "doc_del_count":0,
     ...
   }

|couch db| can also be accessed using a web interface. For example, using an |ssh| tunnel:

.. code-block:: bash

   $ ssh -L5984:localhost:5984 ubuntu@172.31.6.222

and then use a local web browser and navigate to the following address::

   http://localhost/5984/_utils/

|drbd|
-----------------------------------------------------
|drbdadm| is the management tool for |drbd|. It can be used to obtain status information and to alter the state of the |drbd| cluster. For more information about |drbdadm|, see http://www.drbd.org/users-guide/re-drbdadm.html.

``/proc/drbd`` is a virtual file that displays real-time status information about all currently-configured |drbd| resources. Use the following command to view the contents of this virtual file:

.. code-block:: bash

   $ cat /proc/drbd

Use ``private-chef-ctl ha-status`` along with ``/proc/drbd`` to help evaluate the current state of the cluster. Follow the split-brain recovery procedures for |drbd| if the cluster becomes two unconnected pieces.

|erlang|
-----------------------------------------------------
Many components of the |chef server| are written using |erlang| and run on the |beam| virtual machine. One feature of |erlang| and |beam| is the ability to interact with the running service using a command shell. For example:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/erl/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/erl -setcookie service_name -name me@127.0.0.1 -remsh service_name@127.0.0.1

where ``service_name`` is ``authz``, ``erchef``, or ``org_app``. This command will then open a shell that is connected to the |erchef| processes:

.. code-block:: bash

   $ Erlang R15B02 (erts-5.9.2) [source] [64-bit] ...

.. warning:: Connecting to the |erlang| processes should only be done when directed by |company_name| support services.

To connect to the |service authz| service, use the following command:

.. code-block:: bash

   $ erl -setcookie authz -name me@127.0.0.1 -remsh authz@127.0.0.1

To connect to the |service erchef| service, use the following command:

.. code-block:: bash

   $ erl -setcookie erchef -name me@127.0.0.1 -remsh erchef@127.0.0.1

To connect to the |service orgcreator| service, use the following command:

.. code-block:: bash

   $ erl -setcookie org_app -name me@127.0.0.1 -remsh org_app@127.0.0.1

|nginx|
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_nginx.rst

|postgresql|
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_postgresql.rst

|rabbitmq|
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_rabbitmq.rst

|redis|
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_redis.rst

System Checks
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_system.rst

ha-status
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_ha_status.rst

opscode-authz
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_authz.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander.rst

Search Indexes
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search.rst

.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander_search.rst

opscode-expanderctl
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_options.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_example.rst

Nodes, Workstations
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_system_client.rst

Disks
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_system_disk.rst