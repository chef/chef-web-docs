.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

chef-shell determines which configuration file to load based on the following:

#. If a configuration file is specified using the ``-c`` option, chef-shell will use the specified configuration file
#. When chef-shell is started using a named configuration as an argument, chef-shell will search for a chef-shell.rb file in that directory under ``~/.chef``. For example, if chef-shell is started using ``production`` as the named configuration, the chef-shell will load a configuration file from ``~/.chef/production/chef_shell.rb``
#. If a named configuration is not provided, chef-shell will attempt to load the chef-shell.rb file from the ``.chef`` directory. For example: ``~/.chef/chef_shell.rb``
#. If a chef-shell.rb file is not found, chef-shell will attempt to load the client.rb file
#. If a chef-shell.rb file is not found, chef-shell will attempt to load the solo.rb file
