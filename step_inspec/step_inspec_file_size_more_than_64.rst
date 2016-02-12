.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a file's size is between 64 and 10240:

.. code-block:: bash

   describe file('/') do
     its('size') { should be > 64 }
     its('size') { should be < 10240 }
   end
