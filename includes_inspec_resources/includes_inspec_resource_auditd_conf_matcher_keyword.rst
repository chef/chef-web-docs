.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| matches any keyword that is listed in the ``auditd.conf`` configuration file:

.. code-block:: ruby

   its('log_format') { should eq 'raw' }
