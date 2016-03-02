.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| matches any keyword that is listed in the ``auditd.conf`` configuration file. Option names and values are case-insensitive:

.. code-block:: ruby

   its('log_format') { should cmp 'raw' }

or:

.. code-block:: ruby

   its('max_log_file') { should cmp 6 }
