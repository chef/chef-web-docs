.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, to support every version of Ubuntu:

.. code-block:: ruby

   supports 'ubuntu'

or, to support versions of Ubuntu greater than or equal to 12.04:

.. code-block:: ruby

   supports 'ubuntu', '>= 12.04'

or, to support only Ubuntu 14.10:

.. code-block:: ruby

   supports 'ubuntu', '= 14.10'
