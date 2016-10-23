.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The name of a node is required as part of the authentication process to the Chef server. The name of each node must be unique within an organization, but otherwise can be any string that matches the following regular expression::

   /^[\-[:alnum:]_:.]+$/

The name of a node can be obtained from the ``node_name`` attribute in the client.rb file or by allowing Ohai to collect this data during the chef-client run. When Ohai collects this data during the chef-client run, it uses the FQDN name of the node (which is always unique within an organization) as the name of the node. 

Using the FQDN as the node name, and then allowing Ohai to collect this information during each chef-client run, is the recommended approach and the easiest way to ensure that the names of all nodes across the organization are unique.
