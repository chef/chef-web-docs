.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, to replace a cookbook named ``dogs`` with this cookbook:

.. code-block:: ruby

   replaces 'dogs'

or to replace a cookbook named ``dogs``, but only for versions prior to 4.0:

.. code-block:: ruby

   replaces 'dogs', '< 4.0'
