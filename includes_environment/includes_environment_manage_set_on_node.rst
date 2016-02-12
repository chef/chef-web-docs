.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A node is considered to be associated with an environment when the ``chef_environment`` attribute is set. The ``chef_environment`` attribute cannot be set with normal or override attributes (i.e. in a role) because it is actually a method. An environment may be set explicitly using the following methods:

* By using the |subcommand knife edit| and |subcommand knife exec| subcommands
* By editing the ``chef_environment`` directly using |knife| or the |chef manage|
* By editing the ``environment`` configuration details in the |client rb| file, and then using ``knife bootstrap -e environment_name`` to bootstrap the changes to the specified environment

  .. note:: After the environment has been set via bootstrap, the environment is set in the |client rb| file and may not be modified using the |chef manage| or the ``edit`` argument of the |subcommand knife node| subcommand.
* By setting the ``environment`` configuration entry in the |client rb| file ; when the |chef client| runs, it will pick up the value and then set the ``chef_environment`` attribute of the node
