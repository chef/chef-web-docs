=====================================================
Runbook
=====================================================

.. include:: ../../includes_chef_server/includes_chef_server.rst

.. include:: ../../includes_chef_server/includes_chef_server_component_erchef_background.rst

The following diagram shows the various components that are part of a |chef server| deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Bookshelf
     - .. include:: ../../includes_chef_server/includes_chef_server_component_bookshelf.rst

       All cookbooks are stored in a dedicated repository.
   * - WebUI
     - .. include:: ../../includes_chef_server/includes_chef_server_component_webui.rst
   * - Erchef
     - .. include:: ../../includes_chef_server/includes_chef_server_component_erchef.rst
   * - Message Queues
     - Messages are sent to the Search Index using the following components:
       
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_rabbitmq.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_expander.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_solr.rst

       All messages are added to a dedicated search index repository.
   * - Nginx
     - .. include:: ../../includes_chef_server/includes_chef_server_component_nginx.rst
   * - PostgreSQL
     - .. include:: ../../includes_chef_server/includes_chef_server_component_postgresql.rst

The following sections detail how to monitor the server, manage log files, manage services, manage firewalls and ports, configure SSL, tune server configuration settings, and backup and restore data.


Monitoring
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor.rst

Application Checks
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application.rst

|drbd|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_drbd.rst

|erlang|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_erlang.rst

eper tools
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_server_monitor/includes_server_monitor_application_erlang_eper.rst

|nginx|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_nginx.rst

|postgresql|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_postgresql.rst

|rabbitmq|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_rabbitmq.rst

|redis|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_redis.rst

|apache solr|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_application_solr.rst

System Checks
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system.rst

ha-status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status_ha.rst

opscode-authz
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_system_authz.rst

opscode-erchef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_system_erchef.rst

opscode-expander
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander.rst

**Search Indexes**

.. include:: ../../includes_search/includes_search.rst

.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander_search.rst

**opscode-expanderctl**

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_options.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_example.rst

Nodes, Workstations
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_client.rst

Disks
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_disk.rst






Log Files
=====================================================

.. include:: ../../includes_server_logs/includes_server_logs.rst

View Log Files
-----------------------------------------------------
.. include:: ../../includes_server_logs/includes_server_logs_view.rst

tail Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_tail.rst

.. include:: ../../step_server_services/step_server_services_general_tail.rst

Supervisor
-----------------------------------------------------
.. include:: ../../includes_server_logs/includes_server_logs_type_supervisor.rst

nginx, access
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_logs/includes_server_logs_nginx_log_access.rst

opscode-erchef, current
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_logs/includes_server_logs_erchef_log_current.rst

opscode-erchef, erchef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_logs/includes_server_logs_erchef_log_erchef.rst

Application
-----------------------------------------------------
.. include:: ../../includes_server_logs/includes_server_logs_type_application.rst

nginx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_logs/includes_server_logs_nginx.rst

.. include:: ../../step_server_services/step_server_services_nginx_tail.rst

**Read Log Files**

.. include:: ../../includes_server_logs/includes_server_logs_nginx_read_logs.rst







Firewalls and Ports
=====================================================

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports.rst

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_listening.rst

Standalone
-----------------------------------------------------
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_standalone.rst

Front End
-----------------------------------------------------
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_fe.rst

Back End
-----------------------------------------------------
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_be.rst






Services
=====================================================
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

hup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_hup.rst

int
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_int.rst

kill
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_kill.rst

once
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_once.rst

restart
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restart.rst

service-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_service_list.rst

start
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_start.rst

status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status.rst

High Availability
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status_ha.rst

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status_logs.rst

stop
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_stop.rst

tail
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_tail.rst

term
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_term.rst

SSL Configuration
=====================================================

.. include:: ../../includes_server_security/includes_server_security_ssl.rst

.. warning:: The |fqdn| for the |chef server| should not exceed 64 characters when using |open ssl|. |open ssl| requires the ``CN`` in a certificate to be no longer than 64 characters.

.. warning:: By default, the |chef server| uses the |fqdn| to determine the common name (``CN``). If the |fqdn| of the |chef server| is longer than 64 characters, the ``reconfigure`` command will not fail, but an empty certificate file will be created. |nginx| will not start if a certificate file is empty.

SSL Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom.rst

Regenerate Certificates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_regenerate.rst

SSL Protocols
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

|chef client| Settings
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_ssl_config_settings.rst

Server Tuning
=====================================================

.. include:: ../../includes_server_tuning/includes_server_tuning.rst

.. note:: .. include:: ../../includes_notes/includes_notes_enterprise_chef_tuning.rst


Customize the Config File
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_server.rst

Use Conditions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_config/step_config_add_condition.rst


Recommended Settings
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_general.rst

SSL Protocols
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

Optional Settings
-----------------------------------------------------
The following settings are often used to for performance tuning of the |chef server| in larger installations.

.. note:: When changes are made to the |chef server rb| file, the |chef server| must be reconfigured by running the ``chef-server-ctl reconfigure`` command.

bookshelf
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_bookshelf.rst

opscode-erchef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_erchef.rst

opscode-expander
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_expander.rst

opscode-solr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_solr.rst

**Update Frequency**

.. include:: ../../includes_server_tuning/includes_server_tuning_solr_update_frequency.rst

postgresql
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_postgresql.rst

rabbitmq
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq.rst




Resize |drbd|
=====================================================
.. include:: ../../includes_server_storage/includes_server_storage_drbd.rst

Devices
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_resize_device.rst

Volume Groups
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_resize_vg.rst

Logical Volumes
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_resize_lv.rst

Primary Backend
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_resize_primary_backend.rst

Primary File System
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_resize_primary_filesystem.rst

Verify Resize
-----------------------------------------------------
.. include:: ../../includes_server_storage/includes_server_storage_drbd_verify.rst


Backup and Restore
=====================================================
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore.rst

High Availability
-----------------------------------------------------
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_ha.rst

Required Directories
-----------------------------------------------------
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations.rst

Backup
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations_backup.rst

Restore
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations_restore.rst





Manage Organizations
=====================================================
The following commands are built-in to the |chef server ctl| command line tool:

org-create
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_options.rst

org-delete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete_syntax.rst

org-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_options.rst

org-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show_syntax.rst


org-user-add
-----------------------------------------------------
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-associate``. This is the same command, with the exception of the ``--admin`` flag, which is added to the command (along with the rename) for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_options.rst

org-user-remove
-----------------------------------------------------
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-disociate``. This is the same command, but renamed for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_syntax.rst


Manage Users
=====================================================
The following commands are built-in to the |chef server ctl| command line tool:

user-create
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_options.rst

user-delete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete_syntax.rst

user-edit
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit_syntax.rst

user-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_options.rst

user-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_options.rst

