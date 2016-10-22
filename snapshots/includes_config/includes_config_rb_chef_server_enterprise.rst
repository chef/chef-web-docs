.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The private-chef.rb file contains all of the non-default configuration settings used by the Enterprise Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the private-chef.rb file to apply non-default values.) These configuration settings are processed when the ``private-chef-ctl reconfigure`` command is run, such as immediately after setting up the Enterprise Chef server or after making a change to the underlying configuration settings after the server has been deployed. The private-chef.rb file is a Ruby file, which means that conditional statements can be used in the configuration file.
