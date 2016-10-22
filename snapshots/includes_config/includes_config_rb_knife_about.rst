.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A knife.rb file:

* Is loaded every time this executable is run
* Is not created by default
* Is located by default at ``~/chef-repo/.chef/knife.rb`` (UNIX and Linux platforms) or ``c:\Users\username\.chef`` (Microsoft Windows platform, starting with Chef development kit version 0.7.0); use the ``--config`` option from the command line to change this location
* Will override the default configuration when a knife.rb file exists at the default path or the path specified by the ``--config`` option
