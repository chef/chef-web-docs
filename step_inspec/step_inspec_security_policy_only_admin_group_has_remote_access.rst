.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that only the Administrators group has remote access:

.. code-block:: ruby

   describe security_policy do
     its('SeRemoteInteractiveLogonRight') { should eq '*S-1-5-32-544' }
   end
