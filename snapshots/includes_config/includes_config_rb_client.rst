.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A client.rb file is used to specify the configuration details for the chef-client. 

* This file is loaded every time this executable is run
* On UNIX- and Linux-based machines, the default location for this file is ``/etc/chef/client.rb``; on Microsoft Windows machines, the default location for this file is ``C:\chef\client.rb``; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a client.rb file is present in the default location, the settings contained within that client.rb file will override the default configuration settings
