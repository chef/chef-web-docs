=====================================================
Deprecation: Deprecation of run_command (CHEF-14)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_run_command.rst>`__

The old run_command API has been replaced by shell_out (a wrapper around Mixlib::ShellOut).



This deprecation warning was added in Chef Client 12.18.31, and run_command will be removed permanently in Chef Client 13.

Example
=====================================================

Previously to run a command from Chef Infra Client code you might have written:

.. code-block:: ruby

  run_command(:command => "/sbin/ifconfig eth0")

Remediation
=====================================================

You now need to use shell_out! instead:

.. code-block:: ruby

  shell_out!("/sbin/ifconfig eth0")
