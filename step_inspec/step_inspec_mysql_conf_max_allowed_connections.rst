.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the maximum number of allowed connections:

.. code-block:: ruby

   describe mysql_conf do
     its('max_connections') { should eq '505' }
     its('max_user_connections') { should eq '500' }
   end
