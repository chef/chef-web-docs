.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test limits:

.. code-block:: ruby

   describe limits_conf('path') do
     its('*') { should include ['soft', 'core', '0'], ['hard', 'rss', '10000'] }
     its('ftp') { should eq ['hard', 'nproc', '0'] }
   end
