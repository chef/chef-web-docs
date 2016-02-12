.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test system logging:

.. code-block:: ruby

   describe postgres_conf do
     its('logging_collector') { should eq 'on' }
     its('log_connections') { should eq 'on' }
     its('log_disconnections') { should eq 'on' }
     its('log_duration') { should eq 'on' }
     its('log_hostname') { should eq 'on' }
     its('log_line_prefix') { should eq '%t %u %d %h' }
   end
