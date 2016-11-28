

=====================================================
opscode-push-jobs-server.rb
=====================================================

.. tag config_rb_push_jobs_server_1

The opscode-push-jobs-server.rb file is used to specify the configuration settings used by the Chef push jobs server.

This file is the default configuration file and is located at: ``/etc/opscode-push-jobs-server``.

.. end_tag

Settings
==========================================================================

.. tag config_rb_push_jobs_server_settings

This configuration file has the following settings:

``command_port``
   The port on which a Chef push jobs server listens for requests that are to be executed on managed nodes. Default value: ``10002``.

``heartbeat_interval``
   The frequency of the Chef push jobs server heartbeat message. Default value: ``1000`` (milliseconds).

``server_heartbeat_port``
   The port on which the Chef push jobs server receives heartbeat messages from each Chef push jobs client. (This port is the ``ROUTER`` half of the ZeroMQ DEALER / ROUTER pattern.) Default value: ``10000``.

``server_name``
   The name of the Chef push jobs server.

``zeromq_listen_address``
   The IP address used by ZeroMQ. Default value: ``tcp://*``.

.. end_tag

