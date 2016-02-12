.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the Unix socket settings:

.. code-block:: ruby

   describe postgres_conf do
     its('unix_socket_directories') { should eq '.s.PGSQL.5432' }
     its('unix_socket_group') { should eq nil }
     its('unix_socket_permissions') { should eq '0770' }
   end

where ``unix_socket_group`` is set to the |postgresql| default setting (the group to which the server user belongs).
