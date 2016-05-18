.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a rule contains a matching element that is identified by a regular expression:


For ``audit`` >= 2.3:

.. code-block:: ruby

   describe auditd_rules do
     its('lines') { should contain_match(%r{-w /etc/ssh/sshd_config/}) }
   end

For ``audit`` < 2.3:

.. code-block:: ruby

   describe audit_daemon_rules do
     its("LIST_RULES") {
       should contain_match(/^exit,always arch=.*\
       key=time-change\
       syscall=adjtimex,settimeofday/)
     }
   end
