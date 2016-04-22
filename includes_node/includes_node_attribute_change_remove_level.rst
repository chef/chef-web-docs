.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A specific attribute precedence level for default, normal, and override attributes may be removed by using one of the following syntax patterns.

For default attributes:

* ``node.rm_default('foo', 'bar')``

For normal attributes:

* ``node.rm_normal('foo', 'bar')``

For override attributes:

* ``node.rm_override('foo', 'bar')``

These patterns return the computed value of the key being deleted for the specified precedence level.
