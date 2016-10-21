=====================================================
|chef replication_title| (DEPRECATED)
=====================================================

.. warning:: This topic is deprecated as of the 12.9 release of the Chef servver.

.. include:: ../../includes_server_replication/includes_server_replication_legacy_notice_long.rst

.. include:: ../../includes_server_replication/includes_server_replication.rst

.. note:: |chef replication| requires |chef server| version 12.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Scenarios
=====================================================
.. include:: ../../includes_server_replication/includes_server_replication_scenarios.rst

How Replication Works
=====================================================
.. include:: ../../includes_server_replication/includes_server_replication_how_it_works.rst

Configure |chef replication_title|
=====================================================
.. include:: ../../includes_install/includes_install_server_replication.rst

|chef sync ctl| (executable)
=====================================================
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync.rst

manager-log
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_manager_log.rst

prepare-org
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_prepare_org.rst

sync-log
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_log.rst

sync-start
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_start.rst

sync-status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_status.rst
 
sync-stop
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_stop.rst

unsynced-objects
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_sync/includes_ctl_chef_sync_unsynced_objects.rst



|chef_sync rb|
=====================================================
.. include:: ../../includes_config/includes_config_rb_sync.rst

Settings
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_sync_settings.rst



|api chef server| Endpoint
=====================================================
The following |api chef server| endpoint supports |chef replication|. 

/updated_since
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_org_name_updated_since.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_org_name_updated_since_get.rst
