.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``setting`` matcher tests specific, named settings in the ``my.cnf`` file:

.. code-block:: ruby

   its('setting') { should eq 'value' }

Use a ``setting`` matcher for each setting to be tested.
