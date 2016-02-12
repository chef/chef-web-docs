.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``params`` matcher tests arbitrary parameters for the bonded network interface:

.. code-block:: ruby

   its('params') { should eq 'value' }
