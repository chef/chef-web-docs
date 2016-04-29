=====================================================
|supermarket|
=====================================================

.. include:: ../../includes_supermarket/includes_supermarket.rst

Public |supermarket|
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_public.rst

Private |supermarket|
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private.rst

.. note:: .. include:: ../../includes_supermarket/includes_supermarket_private_source_code.rst

Requirements
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_requirements.rst

|chef identity_title|
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_ocid.rst

.. note:: The |supermarket| server must be able to reach (via HTTPS) the specified ``chef_server_url`` during |oauth| 2.0 negotiation. This type of issue is typically with name resolution and firewall rules.

Configure
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_ocid_configure.rst

.. note:: The redirect URL specified for |chef identity| **MUST** match the hostname of the |supermarket| server. The URI must also be correct: ``/auth/chef_oauth2/callback``. Otherwise, an error message similar to ``The redict uri included is not valid.`` will be shown.

Install |supermarket|
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_install.rst

.. note:: In general, for production environments |chef| recommends to start running |supermarket| with small virtual machines, and then increase the size of the virtual machine as necessary. Put the ``/var/opt/supermarket`` directory on a separate disk, and then use LVM so that may be expanded.

Create a Wrapper Cookbook
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_install_wrapper_cookbook.rst

.. include:: ../../includes_supermarket/includes_supermarket_private_install_wrapper_cookbook_steps.rst

Define Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_install_attributes.rst

Upload the Wrapper Cookbook
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_install_upload.rst

Bootstrap |supermarket|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_install_bootstrap.rst

Connect to |supermarket|
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_connect.rst

Manage the Server
-----------------------------------------------------
The following sections describe approaches to managing the private |supermarket| server.

Enable Debug Logging
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_manage_server_enable_debug_logging.rst

Monitoring |supermarket|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket_private_manage_server__monitoring.rst

Recommended Tools
-----------------------------------------------------
The following tools are recommended for use with a private |supermarket|:

* |berkshelf|
* |stove|

|berkshelf|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_tools_berkshelf.rst

|stove|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_tools_stove.rst

Customize a Private |supermarket|
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_customize.rst

External Database
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_database.rst

External Cache
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_cache.rst

External Cookbook Storage
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_cookbook_storage.rst

Run |supermarket| in |kitchen|
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen.rst

Proxies
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen_behind_proxy.rst

|kitchen| Runs Slowly
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen_slow.rst

Set up Workstation
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_manage_cookbooks.rst

Install knife supermarket
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_manage_cookbooks_install_plugin.rst

Configure knife.rb
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_manage_cookbooks_configure_knife_rb.rst

Create Cookbook
=====================================================
The following examples show how to create a simple cookbook by using the |chef ctl| command that is built into the the |chef dk|.

**Generate a chef-repo**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_repo_supermarket.rst

**Generate a cookbook**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_cookbook_supermarket.rst

**Generate a template**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_template_supermarket.rst

**Create a recipe**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_recipe_supermarket.rst

Upload a Cookbook
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_upload_cookbook.rst

Share a Cookbook
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_share_cookbook.rst

Troubleshoot SSL Errors
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_troubleshoot_ssl.rst

supermarket-ctl (executable)
=====================================================
.. include:: ../../includes_ctl_supermarket/includes_ctl_supermarket.rst

For more information about the |supermarket ctl| command line tool, see :doc:`supermarket-ctl </ctl_supermarket>`.

knife supermarket
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_supermarket.rst

For more information about the ``knife supermarket`` subcommand, see :doc:`knife supermarket </plugin_knife_supermarket>`.

|supermarket rb|
=====================================================
.. include:: ../../includes_config/includes_config_rb_supermarket.rst

For more information about the |supermarket rb| file, see :doc:`supermarket.rb </config_rb_supermarket>`.

|api cookbooks site|
=====================================================
.. include:: ../../includes_api_cookbooks_site/includes_api_cookbooks_site.rst

For more information about the |api cookbooks site|, see :doc:`Cookbooks Site API </api_cookbooks_site>`.
