.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``output`` matcher tests the results of the query:

.. code-block:: ruby

   its('output') { should eq(/^0/) }
