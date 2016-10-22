.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
About Resources and Providers
=====================================================

.. note:: .. include:: ../../includes_notes/includes_notes_all_resources.rst

.. include:: ../../includes_resources_common/includes_resources_common.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_platform.rst

Resources Syntax
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_syntax.rst

Common Functionality
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_intro.rst

.. list-table::
   :widths: 160 440
   :header-rows: 1

   * - Common Item
     - Description
   * - :ref:`resource_common_actions`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_actions.rst
   * - :ref:`resource_common_properties`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_attributes.rst
   * - :ref:`resource_common_guards`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_conditions.rst
   * - :ref:`resource_common_guard_interpreters`
     - Evaluate a string command using a **script**-based resource: **bash**, **csh**, **perl**, **powershell_script**, **python**, or **ruby**.
   * - :ref:`resource_common_notifications`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_notifications.rst
   * - :ref:`resource_common_relative_paths`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_relative_paths.rst
   * - :ref:`resource_common_windows_file_security`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_windows_file_security.rst
   * - :ref:`resource_common_run_in_compile_phase`
     - .. include:: ../../includes_resources_common/includes_resources_common_intro_run_during_compile.rst

Resources
-----------------------------------------------------
The following resources are platform resources (i.e. "are available from the chef-client directly and do not require a cookbook"):

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Resource
     - Description
   * - `apt_package <https://docs.chef.io/resource_apt_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_apt.rst
   * - `bash <https://docs.chef.io/resource_bash.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_bash.rst
   * - `batch <https://docs.chef.io/resource_batch.html>`_
     - .. include:: ../../includes_resources/includes_resource_batch.rst
   * - `bff_package <https://docs.chef.io/resource_bff_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_bff.rst
   * - `breakpoint <https://docs.chef.io/resource_breakpoint.html>`_
     - .. include:: ../../includes_resources/includes_resource_breakpoint.rst
   * - `chef_gem <https://docs.chef.io/resource_chef_gem.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_chef_gem.rst
   * - `cookbook_file <https://docs.chef.io/resource_cookbook_file.html>`_
     - .. include:: ../../includes_resources/includes_resource_cookbook_file.rst
   * - `cron <https://docs.chef.io/resource_cron.html>`_
     - .. include:: ../../includes_resources/includes_resource_cron.rst
   * - `csh <https://docs.chef.io/resource_csh.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_csh.rst
   * - `deploy <https://docs.chef.io/resource_deploy.html>`_
     - .. include:: ../../includes_resources/includes_resource_deploy.rst
   * - `directory <https://docs.chef.io/resource_directory.html>`_
     - .. include:: ../../includes_resources/includes_resource_directory.rst
   * - `dpkg_package <https://docs.chef.io/resource_dpkg_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_dpkg.rst
   * - `dsc_script <https://docs.chef.io/resource_dsc_script.html>`_
     - .. include:: ../../includes_resources/includes_resource_dsc_script.rst
   * - `easy_install_package <https://docs.chef.io/resource_easy_install_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_easy_install.rst
   * - `env <https://docs.chef.io/resource_env.html>`_
     - .. include:: ../../includes_resources/includes_resource_env.rst
   * - `erl_call <https://docs.chef.io/resource_erlang_call.html>`_
     - .. include:: ../../includes_resources/includes_resource_erlang_call.rst
   * - `execute <https://docs.chef.io/resource_execute.html>`_
     - .. include:: ../../includes_resources/includes_resource_execute.rst
   * - `file <https://docs.chef.io/resource_file.html>`_
     - .. include:: ../../includes_resources/includes_resource_file.rst
   * - `freebsd_package <https://docs.chef.io/resource_freebsd_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_freebsd.rst
   * - `gem_package <https://docs.chef.io/resource_gem_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_gem.rst
   * - `git <https://docs.chef.io/resource_git.html>`_
     - .. include:: ../../includes_resources/includes_resource_scm_git.rst
   * - `group <https://docs.chef.io/resource_group.html>`_
     - .. include:: ../../includes_resources/includes_resource_group.rst
   * - `homebrew_package <https://docs.chef.io/resource_homebrew_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_homebrew.rst
   * - `http_request <https://docs.chef.io/resource_http_request.html>`_
     - .. include:: ../../includes_resources/includes_resource_http_request.rst
   * - `ifconfig <https://docs.chef.io/resource_ifconfig.html>`_
     - .. include:: ../../includes_resources/includes_resource_ifconfig.rst
   * - `ips_package <https://docs.chef.io/resource_ips_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_ips.rst
   * - `ksh <https://docs.chef.io/resource_ksh.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_ksh.rst
   * - `link <https://docs.chef.io/resource_link.html>`_
     - .. include:: ../../includes_resources/includes_resource_link.rst
   * - `log <https://docs.chef.io/resource_log.html>`_
     - .. include:: ../../includes_resources/includes_resource_log.rst
   * - `macports_package <https://docs.chef.io/resource_macports_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_macports.rst
   * - `mdadm <https://docs.chef.io/resource_mdadm.html>`_
     - .. include:: ../../includes_resources/includes_resource_mdadm.rst
   * - `mount <https://docs.chef.io/resource_mount.html>`_
     - .. include:: ../../includes_resources/includes_resource_mount.rst
   * - `ohai <https://docs.chef.io/resource_ohai.html>`_
     - .. include:: ../../includes_resources/includes_resource_ohai.rst
   * - `package <https://docs.chef.io/resource_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package.rst
   * - `pacman_package <https://docs.chef.io/resource_pacman_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_pacman.rst
   * - `perl <https://docs.chef.io/resource_perl.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_perl.rst
   * - `portage_package <https://docs.chef.io/resource_portage_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_portage.rst
   * - `powershell_script <https://docs.chef.io/resource_powershell_script.html>`_
     - .. include:: ../../includes_resources/includes_resource_powershell_script.rst
   * - `python <https://docs.chef.io/resource_python.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_python.rst
   * - `reboot <https://docs.chef.io/resource_reboot.html>`_
     - .. include:: ../../includes_resources/includes_resource_service_reboot.rst
   * - `registry_key <https://docs.chef.io/resource_registry_key.html>`_
     - .. include:: ../../includes_resources/includes_resource_registry_key.rst
   * - `remote_directory <https://docs.chef.io/resource_remote_directory.html>`_
     - .. include:: ../../includes_resources/includes_resource_remote_directory.rst
   * - `remote_file <https://docs.chef.io/resource_remote_file.html>`_
     - .. include:: ../../includes_resources/includes_resource_remote_file.rst
   * - `route <https://docs.chef.io/resource_route.html>`_
     - .. include:: ../../includes_resources/includes_resource_route.rst
   * - `rpm_package <https://docs.chef.io/resource_rpm_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_rpm.rst
   * - `ruby <https://docs.chef.io/resource_ruby.html>`_
     - .. include:: ../../includes_resources/includes_resource_script_ruby.rst
   * - `ruby_block <https://docs.chef.io/resource_ruby_block.html>`_
     - .. include:: ../../includes_resources/includes_resource_ruby_block.rst
   * - `script <https://docs.chef.io/resource_script.html>`_
     - .. include:: ../../includes_resources/includes_resource_script.rst
   * - `service <https://docs.chef.io/resource_service.html>`_
     - .. include:: ../../includes_resources/includes_resource_service.rst
   * - `smart_os_package <https://docs.chef.io/resource_smartos_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_smartos.rst
   * - `solaris_package <https://docs.chef.io/resource_solaris_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_solaris.rst
   * - `subversion <https://docs.chef.io/resource_subversion.html>`_
     - .. include:: ../../includes_resources/includes_resource_scm_subversion.rst
   * - `template <https://docs.chef.io/resource_template.html>`_
     - .. include:: ../../includes_resources/includes_resource_template.rst
   * - `user <https://docs.chef.io/resource_user.html>`_
     - .. include:: ../../includes_resources/includes_resource_user.rst
   * - `windows_package <https://docs.chef.io/resource_windows_package.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_windows.rst
   * - `windows_service <https://docs.chef.io/resource_windows_service.html>`_
     - .. include:: ../../includes_resources/includes_resource_service_windows.rst
   * - `yum_package <https://docs.chef.io/resource_yum.html>`_
     - .. include:: ../../includes_resources/includes_resource_package_yum.rst

In addition, the `chef_handler <https://docs.chef.io/resource_chef_handler.html>`_ resource is configured and run using the **chef_handler** cookbook, which is the location in which custom handlers are defined and maintained. Despite being defined in a cookbook (and as a "lightweight resource"), the **chef_handler** resource should otherwise be considered a "platform resource".


