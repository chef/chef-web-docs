.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if an anonymous user can query the Local Security Authority (LSA):

.. code-block:: ruby

   describe wmi({
     namespace: 'root\rsop\computer',
     query: "SELECT Setting FROM RSOP_SecuritySettingBoolean WHERE KeyName='LSAAnonymousNameLookup' AND Precedence=1"
   }) do
     its('Setting') { should eq false }
   end
