=====================================================
delivery-ctl (executable)
=====================================================

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server.rst

cleanse
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_cleanse.rst

create-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_enterprise_syntax.rst

create-user
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl create-user john_smith

create-user
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl create-users delivery_eng.tsv

delete-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise_syntax.rst

**Example**

.. code-block:: bash

   $ delviery-ctl delete-enterprise pedant-testing-org

delete-project
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_project.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_project_syntax.rst

delete-user
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_user.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_user_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl delete-user john_smith


help
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_help.rst

list-enterprises
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_enterprise_syntax.rst

list-users
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_users.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_users_syntax.rst

migrate-change-description
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_syntax.rst

migrate-change-description-dry-run
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_dry_run.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_dry_run_syntax.rst

migrate-patchset-diffs
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_syntax.rst

migrate-patchset-diffs-dry-run
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_dry_run.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_dry_run_syntax.rst

reconfigure
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_reconfigure.rst

rename-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_rename_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_rename_enterprise_syntax.rst

revoke-token
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_revoke_token.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_revoke_token_syntax.rst

show-config
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_show_config.rst

uninstall
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_uninstall.rst

update-project-hooks
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_update_project_hooks.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_update_project_hooks_syntax.rst


Service Subcommands
=====================================================
The Chef Automate server has a built in process supervisor, which ensures that all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service.


graceful-kill
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_kill_graceful.rst

hup
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_hup.rst

int
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_int.rst

kill
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_kill.rst

once
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_once.rst

restart
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_restart.rst

service-list
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_service_list.rst

start
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_start.rst

status
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_status.rst

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_status_logs.rst

stop
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_stop.rst

tail
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_tail.rst

term
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_term.rst

usr1
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_usr1.rst

usr2
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_usr2.rst


