.. THIS PAGE DOCUMENTS Chef server version 12.0

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

.. warning:: Review the full list of :doc:`optional settings </config_rb_server_optional_settings>` that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.

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

opscode-solr4
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_solr.rst

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_update_frequency.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_postgresql.rst

rabbitmq
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq.rst
