.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if nginx version 1.9.5 is installed:

.. code-block:: ruby

   describe package('nginx') do
     it { should be_installed }
     its('version') { should eq 1.9.5 }
   end
