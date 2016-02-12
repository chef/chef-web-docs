.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test which variables from the local environment are sent to the server:

.. code-block:: ruby

   only_if do
     command('sshd').exist? or command('ssh').exists?
   end

   describe ssh_config do
     its('SendEnv') { should include('GORDON_CLIENT') }
   end
