=====================================================
Chef Deprecation Warnings
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_deprecations_client.rst>`__

When we wish to remove a feature or an API in Chef, we try to first mark it with a deprecation warning that contains a link to a description of the change and how to fix it. For example:

.. code-block:: ruby

   Deprecated features used!
     JSON auto inflation is not supported (CHEF-1) at (irb):7:in `irb_binding`.
     Please see /chef-client/deprecations/json_auto_inflate.html for further details and information on how to correct this problem.

Testing for Deprecations
=====================================================

To test your code for deprecations, you can put Test Kitchen in a mode where any deprecations cause the chef run to fail. Ensure your ``.kitchen.yml`` includes:

.. code-block:: yaml

   provisioner:
     deprecations_as_errors: true

and then run Test Kitchen as usual. Test Kitchen will fail if any deprecation errors are issued. This feature was added in Test Kitchen 1.13, which shipped in ChefDK 1.0.

All Deprecations
=====================================================

.. list-table::
  :widths: 50 230 40 80
  :header-rows: 1

  * - ID
    - Description
    - Deprecated
    - Expected Removal
  * - `CHEF-0 </deprecations_internal_api.html>`__
    - Many internal APIs have been improved.
    - various
    - varies
  * - `CHEF-1 </deprecations_json_auto_inflate.html>`__
    - Consumers of JSON are now required to be explicit in how it is turned in to a Chef object.
    - 12.7
    - 13.0
  * - `CHEF-2 </deprecations_exit_code.html>`__
    - Chef's exit codes are now defined so that it's easy to understand why Chef exited.
    - 12.11
    - 13.0
  * - `CHEF-3 </deprecations_chef_gem_compile_time.html>`__
    - When using the ``chef_gem`` resource, the phase to install the gem in must be specified.
    - 12.1
    - 13.0
  * - `CHEF-4 </deprecations_attributes.html>`__
    - Various improvements have been made to attribute syntax.
    - various
    - varies
  * - `CHEF-5 </deprecations_custom_resource_cleanups.html>`__
    - Various improvements have been made to custom resource syntax.
    - various
    - varies
  * - `CHEF-6 </deprecations_easy_install.html>`__
    - The ``easy_install`` resource will be removed.
    - 12.10
    - 13.0
  * - `CHEF-7 </deprecations_verify_file.html>`__
    - The ``verify`` metaproperty's ``file`` substitution will be removed.
    - 12.5
    - 13.0
  * - `CHEF-8 </deprecations_supports_property.html>`__
    - The ``supports`` metaproperty will be removed.
    - 12.14
    - 13.0
  * - `CHEF-9 </deprecations_chef_rest.html>`__
    - The ``Chef::REST`` API will be removed.
    - 12.7
    - 13.0
  * - `CHEF-10 </deprecations_dnf_package_allow_downgrade.html>`__
    - DNF package provider and resource do not require ``--allow-downgrade`` anymore.
    - 12.18
    - 13.0
  * - `CHEF-11 </deprecations_property_name_collision.html>`__
    - An exception will be raised if a resource property conflicts with an already-existing property or method.
    - 12.19
    - 13.0
  * - `CHEF-12 </deprecations_launchd_hash_property.html>`__
    - An exception will be raised whenever the ``hash`` property in the launchd resource is used.
    - 12.19
    - 13.0
  * - `CHEF-13 </deprecations_chef_platform_methods.html>`__
    - Deprecated ``Chef::Platform`` methods
    - 12.18
    - 13.0
  * - `CHEF-14 </deprecations_run_command.html>`__
    - Deprecation of run_command
    - 12.18
    - 13.0
  * - `CHEF-18 </deprecations_local_listen.html>`__
    - Deprecation of local mode listening.
    - 13.1
    - 15.0
  * - `CHEF-19 </deprecations_namespace_collisions.html>`__
    - Deprecation of ``property_name`` within actions.
    - 13.2
    - 14.0
  * - `CHEF-20 </deprecations_deploy_resource.html>`__
    - Deprecation of the ``deploy`` resource.
    - 13.6
    - 14.0
  * - `CHEF-21 </deprecations_chocolatey_uninstall.html>`__
    - Deprecation of the ``:uninstall`` action in the ``chocolatey_package`` resource.
    - 13.7
    - 14.0
  * - `CHEF-3694 </deprecations_resource_cloning.html>`__
    - Resource Cloning will no longer work.
    - 10.18
    - 13.0
  * - `OHAI-1 </deprecations_ohai_legacy_config.html>`__
    - Ohai::Config removal.
    - 12.6
    - 13.0
  * - `OHAI-2 </deprecations_ohai_sigar_plugins.html>`__
    - Sigar gem based plugins removal.
    - 12.19
    - 13.0
  * - `OHAI-3 </deprecations_ohai_run_command_helpers.html>`__
    - run_command and popen4 helper method removal.
    - 12.8
    - 13.0
  * - `OHAI-4 </deprecations_ohai_libvirt_plugin.html>`__
    - Libvirt plugin attributes changes.
    - 12.19
    - 14.0
  * - `OHAI-5 </deprecations_ohai_windows_cpu.html>`__
    - Windows CPU plugin attribute changes.
    - 12.19
    - 13.0
  * - `OHAI-6 </deprecations_ohai_digitalocean.html>`__
    - DigitalOcean plugin attribute changes.
    - 12.19
    - 13.0
  * - `OHAI-7 </deprecations_ohai_amazon_linux.html>`__
    - Amazon linux moved to the Amazon platform_family.
    - 13.0
    - 13.0
  * - `OHAI-8 </deprecations_ohai_cloud.html>`__
    - Cloud plugin replaced by the Cloud_V2 plugin.
    - 13.0
    - 13.0
  * - `OHAI-9 </deprecations_ohai_filesystem.html>`__
    - Filesystem plugin replaced by the Filesystem V2 plugin.
    - 13.0
    - 13.0
  * - `OHAI-10 </deprecations_ohai_v6_plugins.html>`__
    - Removal of support for Ohai version 6 plugins.
    - 11.12
    - 14.0
  * - `OHAI-11 </deprecations_ohai_cloud_v2.html>`__
    - Cloud_v2 attribute removal.
    - 13.1
    - 14.0
  * - `OHAI-12 </deprecations_ohai_filesystem_v2.html>`__
    - Filesystem2 attribute removal.
    - 13.1
    - 14.0
  * - `OHAI-13 </deprecations_ohai_ipscopes.html>`__
    - Removal of IpScopes plugin
    - 13.2
    - 14.0
