.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following test shows how to audit machines running |windows| 2012 R2 that pwassword complexity is enabled:

.. code-block:: ruby

   control 'windows-account-102' do
     impact 1.0
     title 'Windows Password Complexity is Enabled'
     desc 'Password must meet complexity requirement'
     describe security_policy do
       its('PasswordComplexity') { should eq 1 }
     end
   end
