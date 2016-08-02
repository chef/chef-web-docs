.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``command_port``
   The port on which a |push jobs| server listens for requests that are to be executed on managed nodes. Default value: ``10002``.

``heartbeat_interval``
   The frequency of the |push jobs| server heartbeat message. Default value: ``1000`` (milliseconds).

``keep_alive_time``
   The number of seconds between keepalive messages being sent on the event stream. Default value: ``15`` (seconds).

``org_feed_expiration``
   The number of seconds before an organization event expires. Default value:: ``60`` (seconds).

``server_heartbeat_port``
   The port on which the |push jobs| server receives heartbeat messages from each |push jobs| client. (This port is the ``ROUTER`` half of the |zeromq| DEALER / ROUTER pattern.) Default value: ``10000``.

``server_name``
   The name of the |push jobs| server.

``wait_complete_time``
   The number of seconds that a job waits around after it completes, allowing it to provide a full event stream instead of a summary. Default value: ``5`` (seconds).

``zeromq_listen_address``
   The IP address used by |zeromq|. Default value: ``tcp://*``.
