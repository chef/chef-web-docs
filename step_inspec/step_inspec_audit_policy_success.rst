.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a parameter is set to "Success":

.. code-block:: ruby

   describe audit_policy do
     its('User Account Management') { should eq 'Success' }
   end
