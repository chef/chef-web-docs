.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_rb_server.html BY DESIGN
.. THIS PAGE DOCUMENTS Chef server version 12.1

=====================================================
chef-server.rb Settings
=====================================================

.. include:: ../../includes_config/includes_config_rb_server.rst

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_does_not_exist_by_default.rst

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_was_private_chef_rb.rst

Use Conditions
=====================================================
.. include:: ../../step_config/step_config_add_condition.rst

Recommended Settings
=====================================================
.. include:: ../../includes_server_tuning/includes_server_tuning_general.rst

SSL Protocols
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

Optional Settings
=====================================================
The following settings are often used for performance tuning of the Chef server in larger installations.

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_must_reconfigure.rst

.. note:: Review the full list of :doc:`optional settings </config_rb_server_optional_settings>` that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.

bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_bookshelf.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_server_aws_cookbook_storage.rst

opscode-account
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_account.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_erchef.rst

Data Collector
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following settings are often modified from the default as part of the tuning effort for the **data_collector** **opscode-erchef** application:

``data_collector['http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the data collector. If failures indicate that **opscode-erchef** application has run out of HTTP connections for the **data_collector** then increase this value. Default value: `100`.

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_expander.rst

opscode-solr4
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_solr.rst

Available Memory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_available_memory.rst

Large Node Sizes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_large_node_sizes.rst

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_update_frequency.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_postgresql.rst

rabbitmq
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq.rst
