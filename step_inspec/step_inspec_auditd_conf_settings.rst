.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the auditd.conf file:

.. code-block:: ruby

   describe auditd_conf do
     its('log_file') { should eq '/full/path/to/file' }
     its('log_format') { should eq 'raw' }
     its('flush') { should eq 'none' }
     its('freq') { should eq '1' }
     its('num_logs') { should eq '0' }
     its('max_log_file') { should eq '6' }
     its('max_log_file_action') { should eq 'email' }
     its('space_left') { should eq '2' }
     its('action_mail_acct') { should eq 'root' }
     its('space_left_action') { should eq 'email' }
     its('admin_space_left') { should eq '1' }
     its('admin_space_left_action') { should eq 'halt' }
     its('disk_full_action') { should eq 'halt' }
     its('disk_error_action') { should eq 'halt' }
   end
