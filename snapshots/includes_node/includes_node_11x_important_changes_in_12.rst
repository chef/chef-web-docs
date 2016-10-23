.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Please `see RFC-23 for important changes to attributes <https://github.com/chef/chef-rfc/blob/master/rfc023-chef-12-attributes-changes.md>`_ in chef-client 12, including how to delete an attribute key for a specific precedence level, how to delete an attribute key for all precedence levels, and how to overwrite the nested value at a specific precedence level. In addition, ``node.default!`` is now ``node.force_default`` and ``node.override!`` is now ``node.force_override``.
