.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the maximum number of allowed client connections:

.. code-block:: ruby

   describe postgres_conf do
     its('max_connections') { should eq '5' }
   end
