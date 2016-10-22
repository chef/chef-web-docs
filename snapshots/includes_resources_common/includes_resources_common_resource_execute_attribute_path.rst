.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``path`` property is not implemented by any provider in any version of the chef-client. Starting with chef-client 12, using the ``path`` property will return a warning. Starting with chef-client 13, the ``path`` property is deprecated and using it will return an exception. Cookbooks that currently use the ``path`` property should be updated to use the ``environment`` property instead.
