=====================================================
delivery-ctl (executable)
=====================================================

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server.rst

backup-data
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_backup_data.rst

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

   $ delivery-ctl create-user ENT_NAME john_smith


delete-application
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_application.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_application_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl delete-application github

returns something similar to:

.. code-block:: bash

   You have successfully deleted the OAuth Application: github

.. code-block:: bash

   $ delivery-ctl delete-application bamboo

returns something similar to:

.. code-block:: bash

   Error: OAuth Application bamboo not found.


delete-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl delete-enterprise pedant-testing-org

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

   $ delivery-ctl delete-user ENT_NAME john_smith

help
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_help.rst

list-applications
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_applications.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_applications_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl list-applications

returns something similar to:

.. code-block:: bash

   OAuth Applications:
    github
    github-enterprise


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

restore-data
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_restore_data.rst

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
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

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


