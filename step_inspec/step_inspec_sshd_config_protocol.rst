.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the Protocol setting:

.. code-block:: ruby

   describe sshd_config do
     its('Protocol') { should eq '2' }
   end
