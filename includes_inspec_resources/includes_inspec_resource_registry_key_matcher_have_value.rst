.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``have_value`` matcher tests if a value exists for a registry key:

.. code-block:: ruby

   it { should have_value 'value' }
