.. THIS PAGE DOCUMENTS chef-client version 11.12

=====================================================
|chef client| (executable)
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. note:: |daemonize chef_client|

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client.rst

.. note:: .. include:: ../../includes_config/includes_config_rb_client.rst

Options
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_11-12_options.rst

Run in Local Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_local_mode.rst

About |chef zero|
-----------------------------------------------------
.. include:: ../../includes_chef/includes_chef_zero.rst

Run with Elevated Privileges
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges.rst

Linux
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_linux.rst

Windows
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_windows.rst

Run as Non-root User
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root.rst

Set the Cache Path
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root_set_cache_path.rst

Elevate Commands
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root_use_attributes.rst

Examples
=====================================================

**Run the chef-client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the chef-client is running as a daemon**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_daemon.rst

**Setting the initial run-list using a JSON file**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_bootstrap_initial_run_list.rst