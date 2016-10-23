.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In previous versions of the chef-client, ``node.default!`` was an alias of ``node.force_default!``. Starting with chef-client 12, ``node.force_default`` is changed from an accessor to a setter. Cookbooks that use ``node.default!`` must be updated for the correct attribute precedence type and must drop the exclamation point. For example:

.. code-block:: ruby

   node.default![:foo] = 'bar'

must be updated to:

.. code-block:: ruby

   node.force_default[:foo] = 'bar'
