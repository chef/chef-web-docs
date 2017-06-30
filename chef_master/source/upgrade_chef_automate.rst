=====================================================
Upgrade Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

This page describes how to upgrade from Chef Automate versions earlier than 0.8.5.

Prerequisites
=====================================================

To upgrade Chef Automate, you will first need:

#. A previously installed version of Chef Automate.
#. ``sudo`` or ``root`` access to the machine.

Update license
====================================================

To update a license on a Chef Automate server, perform the following steps:

#. Securely copy your new license to your Chef Automate server. You must overwrite the current ``delivery.license`` file located at ``/var/opt/delivery/license/delivery.license``. The ``scp`` utility is used below to log into an Ubuntu machine; however, you can use other utilities such as ``rsync`` to copy the new license onto your Chef Automate server securely.

   .. code-block:: bash

      scp -i SSH_KEY /path/to/automate.license ubuntu@IP_ADDRESS:/home/ubuntu/automate.license

#. Log into the Chef Automate server via SSH.

   .. code-block:: bash

      ssh -i SSH_KEY ubuntu@IP_ADDRESS

#. After a successful login, copy the license file to the ``/var/opt/delivery/license`` directory.

   .. code-block:: bash

      sudo mv ~/automate.license /var/opt/delivery/license/delivery.license

#. Reconfigure and restart your Chef Automate server.

   .. code-block:: bash

      sudo automate-ctl reconfigure && sudo automate-ctl restart

Upgrade
=====================================================

To upgrade to the latest version of Chef Automate, do the following:

#. Download the latest version of Chef Automate from `<https://downloads.chef.io/automate/>`_ and copy it to your Chef Automate server.
#. Update the package as appropriate for the server's OS:

   For Debian:

   .. code-block:: bash

      dpkg -i $PATH_TO_AUTOMATE_SERVER_PACKAGE

   For Red Hat or Centos:

   .. code-block:: bash

      rpm -Uvh $PATH_TO_AUTOMATE_SERVER_PACKAGE

#. If you are upgrading from a previous version of Chef Automate, then run ``sudo automate-ctl reconfigure`` to complete the  process. If you are upgrading from a ``delivery-cluster`` setup, then skip to the section below.

   .. note:: This will restart your Chef Automate services and may result in a brief period of unavailability.

   .. tag delivery_ctl_note

   .. note:: Prior to Chef Automate 0.6.0, this tool was named ``delivery-ctl``. To support backwards compatibility, you can continue to call ``delivery-ctl`` in Chef Automate 0.6.0.

   .. end_tag

Upgrading and the ``automate-ctl setup`` command
-------------------------------------------------------------------

The ``automate-ctl setup`` command used during the Chef Automate installation process is intended to simplify the initial configuration of your Chef Automate cluster. If your cluster is up and running, you don't need to run this command; however to set up additional runners with the ``automate-ctl install-runner`` command, running ``automate-ctl setup`` is recommended to ensure all required files are in the correct place.

Upgrading to Push Jobs Server 2.1 and Later
-------------------------------------------------------------------

If you are using Push Jobs Server to orchestrate your build nodes, 2.1.0 and later are now fully supported for use with Chef Automate. Instructions for this upgrade can be found `here </release_notes_push_jobs.html#upgrading-chef-automate-installation-to-use-push-jobs-server-2-1>`_.


Migrations
=====================================================

Compliance Data Migration
-------------------------------------------------------------------

Beginning with Chef Automate version 0.8.5, and now with Chef Automate version 1.5.41, we've made significant changes to the data model in order to accommodate larger data sets and more complex queries.

To view reports from Automate versions earlier than 0.8.5 you will need to use a data migration command.

**Prerequisites:**

#. Chef Automate version 1.5.41 or newer
#. ``sudo`` or ``root`` access to the machine.
#. `Backup <https://docs.chef.io/delivery_server_backup.html>`__ the Chef Automate data:

**Migration:**

Log in to the Chef Automate server and run the following command:

.. code-block:: bash

   automate-ctl migrate-compliance

For a more detailed output, pass in the ``--debug`` option:

.. code-block:: bash

   automate-ctl migrate-compliance --debug

* First ensure that your previously uploaded profiles are cached in ElasticSearch. Storing each profile in memory takes a few seconds per profile.

* Second, migrate the old profiles to the new system using ``automate-ctl migrate-compliance --debug``.  The process moves 15 profiles per second, with the total number of reports displayed at the start of the migration. Your output will look something like this:

.. code-block:: bash

   [root@ca ~]# automate-ctl migrate-compliance --debug
   * Ensuring all local profiles are cached in the `compliance-profiles` index...
   INFO[0000] Rebuild Cache
   DEBU[0000] Verify all profiles for admin
   INFO[0000] Check profile apache-baseline with version 2.0.1
   DEBU[0000] Create Cache for /var/opt/delivery/compliance/profiles/admin/apache-baseline.tar.gz
   DEBU[0000] Run: inspec [json /var/opt/delivery/compliance/profiles/admin/apache-baseline.tar.gz]
   DEBU[0002] Stored profile 41a02784bfea15592ba2748d55927d8d1f9da205816ef18d3bb2ebe4c5ce18a9
   DEBU[0002] Stored profile mapping fea93aed071984b80b53473b6ab1c5dfa306a4b93d12fffc17b1d8630d1e232a
   DEBU[0002] Store profile information for admin/apache-baseline
   ...

   Compliance reports to migrate from the insights-* indices: 757
   Processing report cb0716a4-f7f0-452c-bc24-e1785d8c671e for node fuscia-rockefeller(5ba3fe3b-145e-4128-9cb0-5d2a4215ff0f)
     Processing profile mylinux-success(1.8.9)
   ...
     Report 757/757 MIGRATED
   [root@ca ~]#


Once the migration is complete, subsequent ``automate-ctl migrate-compliance`` runs will exit with 0 reports to migrate.

The Chef Automate server will store future compliance reports in both the old format (accessible via Nodes > Compliance Status) and the new format (Compliance > Reporting). To reduce the storage and processing needs of the server, you may choose to keep reports in only the new format. Storing reports only in the new format means that you will exclusively use the new view. To stop storing reports in the legacy format, configure Chef Automate like this:

Add the following line to ``/etc/delivery/delivery.rb``:

.. code-block:: bash

   compliance_profiles['legacy_insights_data'] = false

Run the reconfigure subcommand to apply the change:

.. code-block:: bash

   automate-ctl reconfigure


Audit Cookbook
-------------------------------------------------------------------

If you are upgrading to Chef Automate 0.8.5 or newer, please ensure ``audit`` cookbook version ``4.0.0`` or newer is used for compliance reporting. See the README of the cookbook for more details: https://github.com/chef-cookbooks/audit/blob/master/README.md .
