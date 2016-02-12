.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test which variables may be sent to the server:

.. code-block:: ruby

   describe sshd_config do
     its('AcceptEnv') { should include('GORDON_SERVER') }
   end
