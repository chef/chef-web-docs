.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

TCP protocol ports 10000 and 10003 are the default heartbeat and command ports, respectively. They can be configured in the |push jobs| `configuration file <https://docs.chef.io/config_rb_push_jobs_server.html>`_. These ports allow the |push jobs| clients to communicate with the |push jobs| server. In a configuration with both front and back ends, these ports only need to be open on the back end servers. The |push jobs| server waits for connections from the |push jobs| client, and never initiates a connection to a |push jobs| client.

Port 10002 is the default web port and can not be changed as it is internal. 
