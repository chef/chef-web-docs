.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A daemon named **ec-syncd** runs on each of the replica instances of the Chef server and periodically polls the primary Chef server via the ``updated_since`` endpoint in the Chef server API. The **ec-syncd** daemon requests a list of objects that have been updated since the last successful synchronization time. If there are updates, the **ec-syncd** daemon then pulls down the updated data from the primary Chef server to the replica. 

.. image:: ../../images/chef_server_replication_sequence.png
