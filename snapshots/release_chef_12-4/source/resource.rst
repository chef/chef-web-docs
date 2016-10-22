.. THIS PAGE DOCUMENTS chef-client version 12.4

=====================================================
About Resources
=====================================================

.. note:: ../../includes_notes/includes_notes_all_resources.rst

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
.. include:: ../../includes_resources_common/includes_resources_common_platform_resources_intro.rst

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Resource
     - Description
   * - :doc:`apt_package </resource_apt_package>`
     - .. include:: ../../includes_resources/includes_resource_package_apt.rst
   * - :doc:`bash </resource_bash>`
     - .. include:: ../../includes_resources/includes_resource_script_bash.rst
   * - :doc:`batch </resource_batch>`
     - .. include:: ../../includes_resources/includes_resource_batch.rst
   * - :doc:`bff_package </resource_bff_package>`
     - .. include:: ../../includes_resources/includes_resource_package_bff.rst
   * - :doc:`breakpoint </resource_breakpoint>`
     - .. include:: ../../includes_resources/includes_resource_breakpoint.rst
   * - :doc:`chef_gem </resource_chef_gem>`
     - .. include:: ../../includes_resources/includes_resource_package_chef_gem.rst
   * - :doc:`cookbook_file </resource_cookbook_file>`
     - .. include:: ../../includes_resources/includes_resource_cookbook_file.rst
   * - :doc:`cron </resource_cron>`
     - .. include:: ../../includes_resources/includes_resource_cron.rst
   * - :doc:`csh </resource_csh>`
     - .. include:: ../../includes_resources/includes_resource_script_csh.rst
   * - :doc:`deploy </resource_deploy>`
     - .. include:: ../../includes_resources/includes_resource_deploy.rst
   * - :doc:`directory </resource_directory>`
     - .. include:: ../../includes_resources/includes_resource_directory.rst
   * - :doc:`dpkg_package </resource_dpkg_package>`
     - .. include:: ../../includes_resources/includes_resource_package_dpkg.rst
   * - :doc:`dsc_script </resource_dsc_script>`
     - .. include:: ../../includes_resources/includes_resource_dsc_script.rst
   * - :doc:`easy_install_package </resource_easy_install_package>`
     - .. include:: ../../includes_resources/includes_resource_package_easy_install.rst
   * - :doc:`env </resource_env>`
     - .. include:: ../../includes_resources/includes_resource_env.rst
   * - :doc:`erl_call </resource_erlang_call>`
     - .. include:: ../../includes_resources/includes_resource_erlang_call.rst
   * - :doc:`execute </resource_execute>`
     - .. include:: ../../includes_resources/includes_resource_execute.rst
   * - :doc:`file </resource_file>`
     - .. include:: ../../includes_resources/includes_resource_file.rst
   * - :doc:`freebsd_package </resource_freebsd_package>`
     - .. include:: ../../includes_resources/includes_resource_package_freebsd.rst
   * - :doc:`dpkg_package </resource_dpkg_package>`
     - .. include:: ../../includes_resources/includes_resource_package_gem.rst
   * - :doc:`git </resource_git>`
     - .. include:: ../../includes_resources/includes_resource_scm_git.rst
   * - :doc:`group </resource_group>`
     - .. include:: ../../includes_resources/includes_resource_group.rst
   * - :doc:`homebrew_package </resource_homebrew_package>`
     - .. include:: ../../includes_resources/includes_resource_package_homebrew.rst
   * - :doc:`http_request </resource_http_request>`
     - .. include:: ../../includes_resources/includes_resource_http_request.rst
   * - :doc:`ifconfig </resource_ifconfig>`
     - .. include:: ../../includes_resources/includes_resource_ifconfig.rst
   * - :doc:`ips_package </resource_ips_package>`
     - .. include:: ../../includes_resources/includes_resource_package_ips.rst
   * - :doc:`link </resource_link>`
     - .. include:: ../../includes_resources/includes_resource_link.rst
   * - :doc:`log </resource_log>`
     - .. include:: ../../includes_resources/includes_resource_log.rst
   * - :doc:`macports_package </resource_macports_package>`
     - .. include:: ../../includes_resources/includes_resource_package_macports.rst
   * - :doc:`mdadm </resource_mdadm>`
     - .. include:: ../../includes_resources/includes_resource_mdadm.rst
   * - :doc:`mount </resource_mount>`
     - .. include:: ../../includes_resources/includes_resource_mount.rst
   * - :doc:`ohai </resource_ohai>`
     - .. include:: ../../includes_resources/includes_resource_ohai.rst
   * - :doc:`package </resource_package>`
     - .. include:: ../../includes_resources/includes_resource_package.rst
   * - :doc:`pacman_package </resource_pacman_package>`
     - .. include:: ../../includes_resources/includes_resource_package_pacman.rst
   * - :doc:`perl </resource_perl>`
     - .. include:: ../../includes_resources/includes_resource_script_perl.rst
   * - :doc:`portage_package </resource_portage_package>`
     - .. include:: ../../includes_resources/includes_resource_package_portage.rst
   * - :doc:`powershell_script </resource_powershell_script>`
     - .. include:: ../../includes_resources/includes_resource_powershell_script.rst
   * - :doc:`python </resource_python>`
     - .. include:: ../../includes_resources/includes_resource_script_python.rst
   * - :doc:`reboot </resource_reboot>`
     - .. include:: ../../includes_resources/includes_resource_service_reboot.rst
   * - :doc:`registry_key </resource_registry_key>`
     - .. include:: ../../includes_resources/includes_resource_registry_key.rst
   * - :doc:`remote_directory </resource_remote_directory>`
     - .. include:: ../../includes_resources/includes_resource_remote_directory.rst
   * - :doc:`remote_file </resource_remote_file>`
     - .. include:: ../../includes_resources/includes_resource_remote_file.rst
   * - :doc:`route </resource_route>`
     - .. include:: ../../includes_resources/includes_resource_route.rst
   * - :doc:`rpm_package </resource_rpm_package>`
     - .. include:: ../../includes_resources/includes_resource_package_rpm.rst
   * - :doc:`ruby </resource_ruby>`
     - .. include:: ../../includes_resources/includes_resource_script_ruby.rst
   * - :doc:`ruby_block </resource_ruby_block>`
     - .. include:: ../../includes_resources/includes_resource_ruby_block.rst
   * - :doc:`script </resource_script>`
     - .. include:: ../../includes_resources/includes_resource_script.rst
   * - :doc:`service </resource_service>`
     - .. include:: ../../includes_resources/includes_resource_service.rst
   * - :doc:`smart_os_package </resource_smartos_package>`
     - .. include:: ../../includes_resources/includes_resource_package_smartos.rst
   * - :doc:`solaris_package </resource_solaris_package>`
     - .. include:: ../../includes_resources/includes_resource_package_solaris.rst
   * - :doc:`subversion </resource_subversion>`
     - .. include:: ../../includes_resources/includes_resource_scm_subversion.rst
   * - :doc:`template </resource_template>`
     - .. include:: ../../includes_resources/includes_resource_template.rst
   * - :doc:`user </resource_user>`
     - .. include:: ../../includes_resources/includes_resource_user.rst
   * - :doc:`windows_package </resource_windows_package>`
     - .. include:: ../../includes_resources/includes_resource_package_windows.rst
   * - :doc:`windows_service </resource_windows_service>`
     - .. include:: ../../includes_resources/includes_resource_service_windows.rst
   * - :doc:`yum_package </resource_yum>`
     - .. include:: ../../includes_resources/includes_resource_package_yum.rst

In addition, the :doc:`chef_handler </resource_chef_handler>` resource is configured and run using the **chef_handler** cookbook, which is the location in which custom handlers are defined and maintained. Despite being defined in a cookbook (as a custom resource), the **chef_handler** resource should otherwise be considered a "platform resource".
