.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To query the audit daemon status:

.. code-block:: ruby

   describe auditd_rules.status('backlog') do
     it { should cmp 0 }
   end
