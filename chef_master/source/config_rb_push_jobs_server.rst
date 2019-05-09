=====================================================
opscode-push-jobs-server.rb
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_push_jobs_server.rst>`__

.. tag config_rb_push_jobs_server_summary

The opscode-push-jobs-server.rb file is used to specify the configuration settings used by the Chef Push Jobs server.

This file is the default configuration file and is located at: ``/etc/opscode-push-jobs-server``.

.. end_tag

Settings
==========================================================================

This configuration file has the following settings:

``command_port``
   The port on which a Chef Push Jobs server listens for requests that are to be executed on managed nodes. Default value: ``10002``.

``heartbeat_interval``
   The frequency of the Chef Push Jobs server heartbeat message. Default value: ``1000`` (milliseconds).

``keep_alive_time``
   The number of seconds between keepalive messages being sent on the event stream. Default value: ``15`` (seconds).

``org_feed_expiration``
   The number of seconds before an organization event expires. Default value:: ``60`` (seconds).

``server_heartbeat_port``
   The port on which the Chef Push Jobs server receives heartbeat messages from each Chef Push Jobs client. (This port is the ``ROUTER`` half of the ZeroMQ DEALER / ROUTER pattern.) Default value: ``10000``.

``server_name``
   The name of the Chef Push Jobs server.

``wait_complete_time``
   The number of seconds that a job waits around after it completes, allowing it to provide a full event stream instead of a summary. Default value: ``5`` (seconds).

``zeromq_listen_address``
   The IP address used by ZeroMQ. Default value: ``tcp://*``.

