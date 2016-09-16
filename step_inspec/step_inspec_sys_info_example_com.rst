.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To get system information for example.com:

.. code-block:: ruby

   describe sys_info do
     its('hostname') { should eq 'example.com' }
   end
