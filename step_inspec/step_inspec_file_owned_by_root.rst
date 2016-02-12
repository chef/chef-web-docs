.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a file is owned by the root user:

.. code-block:: bash

   describe file('/dev') do
     it { should be_owned_by 'root' }
   end
