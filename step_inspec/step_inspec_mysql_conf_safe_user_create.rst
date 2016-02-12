.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the safe-user-create parameter:

.. code-block:: ruby

   describe mysql_conf.params('mysqld') do
     its('safe-user-create') { should eq('1') }
   end
