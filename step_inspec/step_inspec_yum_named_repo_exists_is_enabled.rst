.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the 'base/7/x86_64' repo exists and is enabled:

.. code-block:: ruby

   describe yum do
     its('repos') { should include 'base/7/x86_64' }
     its('epel') { should exist }
     its('epel') { should be_enabled }
   end
