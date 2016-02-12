.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the expiration time for new account passwords:

.. code-block:: ruby

   output = command('useradd -D').stdout

   describe parse_config(output) do
     its('INACTIVE') { should eq '35' }
   end
