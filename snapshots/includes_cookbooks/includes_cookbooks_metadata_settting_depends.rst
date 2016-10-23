.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, to set a dependency a cookbook named ``cats``:

.. code-block:: ruby

   depends 'cats'

or, to set a dependency on the same cookbook, but only when the version is less than 1.0:

.. code-block:: ruby

   depends 'cats', '< 1.0'
