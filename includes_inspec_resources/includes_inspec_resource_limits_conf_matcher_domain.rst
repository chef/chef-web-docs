.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``domain`` matcher tests the domain in the ``limits.conf`` file, along with associated type, item, and value:

.. code-block:: ruby

   its('domain') { should include ['type', 'item', 'value'] }

For example:

.. code-block:: ruby

   its('grantmc') { should include ['hard', 'nofile', '63536'] }
