.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a password expiration policy:

.. code-block:: ruby

   describe wmi({
     class: 'RSOP_SecuritySettingNumeric',
     namespace: 'root\\rsop\\computer',
     filter: 'KeyName = \'MinimumPasswordAge\' And precedence=1'
   }) do
      its('Setting') { should eq 1 }
   end
