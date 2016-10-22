.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``ohai`` recipe can be added to a run-list. First, ensure that any custom Ohai plugins are loaded and available to recipes. When the chef-client runs, the plugins will be copied into place and then loaded and merged with the node. This does cause Ohai to be run twice, which can increase the total run time for the chef-client.



