.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To override the service manager:

Under some circumstances, it may be required to override the logic in place to select the right service manager. For example, to check a service managed by |upstart|:

.. code-block:: ruby

   describe upstart_service('service') do
     it { should_not be_enabled }
     it { should be_installed }
     it { should be_running }
   end

This is also possible with ``systemd_service``, ``runit_service``, ``sysv_service``, ``bsd_service``, and ``launchd_service``. Provide the control command when it is not to be found at the default location.
For example, if the ``sv`` command for services managed by |runit| is not in the ``PATH``:

.. code-block:: ruby

   describe runit_service('service', '/opt/chef/embedded/sbin/sv') do
     it { should be_enabled }
     it { should be_installed }
     it { should be_running }
   end
