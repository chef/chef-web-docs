.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the owner of a file:

.. code-block:: bash

   describe file('/root') do
     its('owner') { should eq 'root' }
   end
