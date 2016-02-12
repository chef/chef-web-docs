.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a parameter is not set to "No Auditing":

.. code-block:: ruby

   describe audit_policy do
     its('Other Account Logon Events') { should_not eq 'No Auditing' }
   end
