.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``security_policy`` |inspec resource| block declares the name of a security policy and the value to be tested:

.. code-block:: ruby

   describe security_policy do
     its('policy_name') { should eq 'value' }
   end

where

* ``'policy_name'`` must specify a security policy
* ``{ should eq 'value' }`` tests the value of ``policy_name`` against the value declared in the test
