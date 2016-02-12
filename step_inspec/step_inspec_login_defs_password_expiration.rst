.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test password expiration settings:

.. code-block:: ruby

   describe login_defs do
     its('PASS_MAX_DAYS') { should eq '180' }
     its('PASS_MIN_DAYS') { should eq '1' }
     its('PASS_MIN_LEN') { should eq '15' }
     its('PASS_WARN_AGE') { should eq '30' }
   end
