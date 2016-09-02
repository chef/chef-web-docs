.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


String vs. regular expression:

.. code-block:: ruby

   describe auditd_conf do
     its('log_format') { should cmp /raw/i }
   end

