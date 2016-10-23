.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A solo.rb file is used to specify the configuration details for chef-solo. 

* This file is loaded every time this executable is run
* The default location in which chef-solo expects to find this file is ``/etc/chef/solo.rb``; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a ``solo.rb`` file is present in this directory, the settings contained within that file will override the default configuration settings
