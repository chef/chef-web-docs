.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a CSV file:

.. code-block:: ruby

   describe csv('some_file.csv') do
     its('setting') { should eq 1 }
   end
