.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, if a cookbook conflicts with another cookbook named ``dogs``:

.. code-block:: ruby

   conflicts 'dogs'

Or if the cookbook conflicted with a cookbook named ``dogs`` and greater than version 1.0:

.. code-block:: ruby

   conflicts 'dogs', '> 1.0'
