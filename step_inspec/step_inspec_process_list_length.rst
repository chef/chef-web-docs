.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the list length for the mysqld process is 1:

.. code-block:: ruby

   describe processes('mysqld') do
     its('list.length') { should eq 1 }
   end
