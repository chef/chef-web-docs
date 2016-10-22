.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The chef-server.rb file contains all of the non-default configuration settings used by the Open Source Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the chef-server.rb file to apply non-default values.) These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run, such as immediately after setting up the Open Source Chef server or after making a change to the underlying configuration settings after the server has been deployed.
