.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
|enterprise rb|
=====================================================

.. warning:: This topic documents the settings for |chef server oec|. The current version of the |chef server| is version 12. All of the documentation at https://docs.chef.io is about the current version of the |chef server|. The documentation for |chef server oec| has been moved: `Enterprise Chef 11.0 <https://docs.chef.io/release/oec_11-0/>`__, `Enterprise Chef 11.1 <https://docs.chef.io/release/oec_11-1/>`__, and `Enterprise Chef 11.2 <https://docs.chef.io/release/oec_11-1/>`__.

.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise.rst

.. note:: The |enterprise rb| file does not exist by default. To modify the settings for the |chef server|, create a file named ``private-chef.rb`` in the ``/etc/opscode/`` directory.

Use Conditions
=====================================================
.. include:: ../../step_config/step_config_add_condition.rst

Recommended Settings
=====================================================
.. include:: ../../includes_server_tuning/includes_server_tuning_general.rst

Optional Settings
=====================================================
The following settings are often used for performance tuning of |chef server oec| in larger installations.

.. note:: When changes are made to the |enterprise rb| file the |chef server oec| must be reconfigured by running the ``private-chef-ctl reconfigure`` command.

.. warning:: Review the full list of :doc:`optional settings </config_rb_chef_server_enterprise_optional_settings>` that can be added to the |enterprise rb| file. Many of these optional settings should not be added without first consulting with |company_name| support.

bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_bookshelf.rst

opscode-account
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_account.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_expander.rst

opscode-solr
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_solr.rst

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_update_frequency.rst

opscode-webui
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_webui.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_postgresql.rst

rabbitmq
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq.rst




