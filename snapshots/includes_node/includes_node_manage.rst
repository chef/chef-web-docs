.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

There are several ways to manage nodes directly, including by using knife, the Chef management console add-on for the Chef server, or by using command-line tools that are specific to chef-client.

* knife can be used to create, edit, view, list, tag, and delete nodes.
* knife plug-ins can be used to create, edit, and manage nodes that are located on cloud providers.
* The Chef management console add-on can be used to create, edit, view, list, tag, and delete nodes. In addition, node attributes can be modified and nodes can be moved between environments.
* The chef-client can be used to manage node data using the command line and JSON files. Each JSON file contains a hash, the elements of which are added as node attributes. In addition, the ``run_list`` setting allows roles and/or recipes to be added to the node.
* chef-solo can be used to manage node data using the command line and JSON files. Each JSON file contains a hash, the elements of which are added as node attributes. In addition, the ``run_list`` setting allows roles and/or recipes to be added to the node.
* The command line can also be used to edit JSON files and files that are related to third-party services, such as Amazon EC2, where the JSON files can contain per-instance metadata that is stored in a file on-disk and then read by chef-solo or chef-client as required.
