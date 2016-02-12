.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the encryption method:

.. code-block:: ruby

   describe login_defs do
     its('ENCRYPT_METHOD') { should eq 'SHA512' }
   end
