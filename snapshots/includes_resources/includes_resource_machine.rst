.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the **machine** resource to define one (or more) machines, and then converge entire clusters of machines. This allows clusters to be maintained in a version control system and to be defined using multi-machine orchestration scenarios. For example, spinning up small test clusters and using them for continuous integration and local testing, building clusters that auto-scale, moving a set of machines in one cluster to another, building images, and so on.

Each machine is declared as a separate application topology, defined using operating system- and provisioner-independent files. Recipes (defined in cookbooks) are used to manage them. The chef-client is used to converge the individual nodes (machines) within the cluster. 
