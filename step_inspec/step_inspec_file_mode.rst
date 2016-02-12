.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the mode for a file:

.. code-block:: bash

   describe file('/dev') do
    its('mode') { should eq 00755 }
   end
