.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``no_proxy`` setting is used to specify addresses for which the proxy should
not be used. This can be a single address or a comma-separated list of
addresses. Wildcard matching will work in this list.

Example:

.. code-block:: ruby

   no_proxy 'test1.example.com,*.example2.com,*.*.example3.*'