.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A library allows arbitrary |ruby| code to be included in a cookbook, either as a way of extending the classes that are built-in to the |chef client|---``Chef::Recipe``, for example---or for implementing entirely new functionality, similar to a mixin in |ruby|. A library file is a |ruby| file that is located within a cookbook's ``/libraries`` directory. Because a library is built using |ruby|, anything that can be done with |ruby| can be done in a library file.
