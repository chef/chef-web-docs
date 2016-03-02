.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test Unix System V services:

On targets that are using |unix systemv| services, the existing run levels can also be checked:

.. code-block:: ruby

   describe service('sshd').runlevels do
     its('keys') { should include(2) }
   end

   describe service('sshd').runlevels(2,4) do
     it { should be_enabled }
   end
