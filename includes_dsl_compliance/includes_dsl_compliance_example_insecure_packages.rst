.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following test shows how to audit machines for insecure packages:

.. code-block:: ruby

   control 'cis-os-services-5.1.3' do
     impact 0.7
     title '5.1.3 Ensure rsh client is not installed'
     describe package('rsh') do
       it { should_not be_installed }
     end

     describe package('rsh-redone-client') do
       it { should_not be_installed }
     end
   end
