.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |analytics rb| file contains all of the non-default configuration settings used by the |chef analytics| add-on for the |chef server|.  (The default settings are built-in to the |chef analytics| configuration and should only be added to the |analytics rb| file to apply non-default values.)

These settings are applied every time ``opscode-analytics-ctl reconfigure`` is run, such as immediately after setting up the |chef analytics| server or after making a change to the underlying configuration settings after the server has been deployed.

The configuration file is located at: ``/etc/opscode-analytics/opscode-analytics.rb``.
