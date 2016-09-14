.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``sys_info`` |inspec resource| block declares the hostname to be tested:

.. code-block:: ruby

   describe sys_info do
     its('hostname') { should eq 'value' }
   end
