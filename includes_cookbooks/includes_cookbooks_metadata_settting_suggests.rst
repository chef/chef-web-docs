.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example:

.. code-block:: ruby

   suggests 'cats'

or, to suggest a cookbook named ``cats``, but only for versions 1.0 and higher:

.. code-block:: ruby

   suggests 'cats', '> 1.0'
