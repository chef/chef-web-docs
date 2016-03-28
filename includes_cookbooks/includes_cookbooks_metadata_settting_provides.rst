.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, for recipes:

.. code-block:: ruby

   provides 'cats::sleep'
   provides 'cats::eat'

For definitions:

.. code-block:: ruby

   provides 'here(:kitty, :time_to_eat)'

And for resources:

.. code-block:: ruby

   provides 'service[snuggle]'
