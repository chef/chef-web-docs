.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the port on which PostgreSQL listens:

.. code-block:: ruby

   describe postgres_conf do
     its('port') { should eq '5432' }
   end
