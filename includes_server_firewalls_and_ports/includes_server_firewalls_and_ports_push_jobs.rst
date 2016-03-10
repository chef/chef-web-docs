.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

TCP protocol ports 10000 is the default heartbeat port. It may be configured in the |push jobs| `configuration file <https://docs.chef.io/config_rb_push_jobs_server.html>`_. This port allows |push jobs| clients to communicate with the |push jobs| server. In a configuration with both front and back ends, this port only needs to be open on the back end servers. The |push jobs| server waits for connections from the |push jobs| client, and never initiates a connection to a |push jobs| client. 
