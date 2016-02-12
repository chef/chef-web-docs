.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test connection and thread variables:

.. code-block:: ruby

   describe mysql_conf do
     its('port') { should eq '3306' }
     its('socket') { should eq '/var/run/mysqld/mysql.sock' }
     its('max_allowed_packet') { should eq '12M' }
     its('default_storage_engine') { should eq 'InnoDB' }
     its('character_set_server') { should eq 'utf8' }
     its('collation_server') { should eq 'utf8_general_ci' }
     its('max_connections') { should eq '505' }
     its('max_user_connections') { should eq '500' }
     its('thread_cache_size') { should eq '505' }
   end
