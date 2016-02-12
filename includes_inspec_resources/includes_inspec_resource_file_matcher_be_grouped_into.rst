.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_grouped_into`` matcher tests if the file exists as part of the named group:

.. code-block:: ruby

   it { should be_grouped_into 'group' }
