.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the init process is owned by the root user: 

.. code-block:: ruby

   describe processes('init') do
     its('user') { should eq 'root' }
   end
