.. THIS PAGE DOCUMENTS Chef server version 12.5

=====================================================
chef-server.rb Optional Settings
=====================================================

.. include:: ../../includes_config/includes_config_rb_server.rst

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_does_not_exist_by_default.rst

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_was_private_chef_rb.rst

Settings
=====================================================
The following sections describe the various settings that are available in the chef-server.rb file.

.. note:: .. include:: ../../includes_notes/includes_notes_config_rb_server_must_reconfigure.rst

General
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_general.rst

bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_bookshelf.rst

.. note:: .. include:: ../../includes_notes/includes_notes_server_aws_cookbook_storage.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_bookshelf.rst

bootstrap
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_bootstrap.rst

dark_launch
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_dark_launch.rst

.. 
.. this has been moved to the chef-ha add-on? verify
.. 
.. drbd
.. -----------------------------------------------------
.. .. include:: ../../includes_config/includes_config_rb_server_settings_drbd.rst

estatsd
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_estatsd.rst

.. 
.. this has been moved to the chef-ha add-on? verify
.. 
.. ha
.. -----------------------------------------------------
.. .. include:: ../../includes_config/includes_config_rb_server_settings_ha.rst

jetty
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_jetty.rst

keepalived
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_keepalived.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_keepalived.rst

lb / lb_internal
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_lb.rst

ldap
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_ldap.rst

nginx
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_nginx.rst

oc_bifrost
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_bifrost.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_bifrost.rst

oc_chef_authz
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_authz.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_chef_authz.rst

oc-chef-pedant
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_oc_chef_pedant.rst

oc-id
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_oc_id.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_id.rst

opscode-chef-mover
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_opscode_chef_mover.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_erchef.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_opscode_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_expander.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_opscode_expander.rst

opscode-solr4
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_solr4.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_opscode_solr4.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_postgresql.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_postgresql.rst

rabbitmq
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_rabbitmq.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_rabbitmq.rst

redis_lb
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_redis.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_redis_lb.rst

upgrades
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_upgrades.rst

user
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server_settings_user.rst
