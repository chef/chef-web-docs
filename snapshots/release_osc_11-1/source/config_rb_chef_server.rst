.. THIS PAGE DOCUMENTS Open Source Chef server version 11.1

=====================================================
chef-server.rb
=====================================================

.. warning:: This topic documents the settings for Open Source Chef. The current version of the Chef server is version 12. All of the documentation at https://docs.chef.io is about the current version of the Chef server. The documentation for Open Source Chef has been moved: `Open Source Chef 11.0 <https://docs.chef.io/release/osc_11-0/>`__ and `Open Source Chef 11.1 <https://docs.chef.io/release/osc_11-1/>`__.

.. include:: ../../includes_config/includes_config_rb_chef_server.rst

.. note:: The chef-server.rb file does not exist by default. To modify the settings for the Chef server, create a file named ``chef-server.rb`` in the ``/etc/chef-server/`` directory.

Example
=====================================================
The following shows a common starting point for settings in a chef-server.rb:

.. code-block:: ruby

   # /etc/chef-server/chef-server.rb
   # This file is used to configure the chef server. 
   # After making any changes you need to run 'chef-server-ctl reconfigure' for the changes to be implemented
   # For a full list of parameters, see: https://docs.chef.io/config_rb_chef_server.html
   # All examples shown are default values
   
   # lb['api_fqdn'] = node['fqdn']
   # nginx['enable_non_ssl'] = false
   # chef_server_webui['enable'] = true

Recommended Settings
=====================================================
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_general.rst

Optional Settings
=====================================================
The following settings are often used for performance tuning of Open Source Chef in larger installations.

.. note:: When changes are made to the chef-server.rb file the Open Source Chef must be reconfigured by running the ``chef-server-ctl reconfigure`` command.

.. warning:: Review the full list of :doc:`optional settings </config_rb_chef_server_optional_settings>` that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.



bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_bookshelf.rst

chef-expander
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_expander.rst

chef-solr
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_solr.rst

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_solr_update_frequency.rst

erchef
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_erchef.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_postgresql.rst

webui
-----------------------------------------------------
.. include:: ../../includes_server_tuning_osc/includes_server_tuning_osc_webui.rst
