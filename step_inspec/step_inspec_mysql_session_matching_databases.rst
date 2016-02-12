.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for matching databases:

.. code-block:: ruby

   sql = mysql_session('my_user','password')
   
   describe sql.query('show databases like \'test\';') do
     its(:stdout) { should_not match(/test/) }
   end
