.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the auditd.conf file:

.. code-block:: ruby

   describe auditd_conf do
     its('log_file') { should cmp '/full/path/to/file' }
     its('log_format') { should cmp 'raw' }
     its('flush') { should cmp 'none' }
     its('freq') { should cmp 1 }
     its('num_logs') { should cmp 0 }
     its('max_log_file') { should cmp 6 }
     its('max_log_file_action') { should cmp 'email' }
     its('space_left') { should cmp 2 }
     its('action_mail_acct') { should cmp 'root' }
     its('space_left_action') { should cmp 'email' }
     its('admin_space_left') { should cmp 1 }
     its('admin_space_left_action') { should cmp 'halt' }
     its('disk_full_action') { should cmp 'halt' }
     its('disk_error_action') { should cmp 'halt' }
   end
