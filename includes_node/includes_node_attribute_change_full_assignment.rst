.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``!`` to clear out the key for the named attribute precedence level, and then complete the write by using one of the following syntax patterns:

* ``node.default!['foo']['bar'] = {...}``
* ``node.force_default!['foo']['bar'] = {...}``
* ``node.normal!['foo']['bar'] = {...}``
* ``node.override!['foo']['bar'] = {...}``
* ``node.force_override!['foo']['bar'] = {...}``
