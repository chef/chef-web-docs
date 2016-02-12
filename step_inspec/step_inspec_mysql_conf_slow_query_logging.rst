.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test slow query logging:

.. code-block:: ruby

   describe mysql_conf do
     its('slow_query_log_file') { should eq 'hostname_slow.log' }
     its('slow_query_log') { should eq '0' }
     its('log_queries_not_using_indexes') { should eq '1' }
     its('long_query_time') { should eq '0.5' }
     its('min_examined_row_limit') { should eq '100' }
   end
