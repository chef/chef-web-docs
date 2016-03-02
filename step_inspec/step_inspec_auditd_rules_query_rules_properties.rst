.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To query properties of rules targeting specific syscalls or files:

.. code-block:: ruby

   describe auditd_rules.syscall('open').action do
     it { should eq(['always']) }
   end

   describe auditd_rules.key('sshd_config') do
     its(:permissions) { should contain_match(/x/) }
   end

Filters may be chained. For example:

.. code-block:: ruby

   describe auditd_rules.syscall('open').action('always').list do
     it { should eq(['exit']) }
   end
