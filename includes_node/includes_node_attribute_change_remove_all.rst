.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

All attribute precedence levels may be removed by using the following syntax pattern:

* ``node.rm('foo', 'bar')``

.. note:: Using ``node['foo'].delete('bar')`` will throw an exception that points to the new API.
