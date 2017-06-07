=====================================================
Upgrade Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The following sections describe the upgrade process between versions of Chef Automate.

Prerequisites
=====================================================

This section describes the prereqs for the upgrade.

#. Previously installed version of Chef Automate.
#. ``sudo`` or ``root`` access to the machine.

Update license
====================================================

If you need to update a license on a Chef Automate server, perform the following steps:

#. Securely copy your new license to your Chef Automate server. You must overwrite the current ``delivery.license`` file located at ``/var/opt/delivery/license/delivery.license``. The `scp` utility is used below to log into an Ubuntu machine; however, you can use other utilities such as `rsync` to securely copy the new license onto your Chef Automate server.

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

#. If you are upgrading from a previous version of Chef Automate, then run ``sudo automate-ctl reconfigure`` to complete the upgrade process. If you are upgrading from a ``delivery-cluster`` setup, then skip to the section below.

   .. note:: This will restart your Chef Automate services and may result in a brief period of unavailability.

   .. tag delivery_ctl_note

   .. note:: Prior to Chef Automate 0.6.0, this tool was named `delivery-ctl`. To support backwards compatibility, you can continue to call `delivery-ctl` in Chef Automate 0.6.0.

   .. end_tag

Upgrading and the ``automate-ctl setup`` command
-------------------------------------------------------------------

The ``automate-ctl setup`` command used during the Chef Automate installation process is intended to simplify the initial configuration of your Chef Automate cluster. If your cluster is up and running, you don't need to run this command; however to set up additional runners with the ``automate-ctl install-runner`` command, running ``automate-ctl setup`` is recomended to ensure all required files are in the correct place.

Upgrading to Push Jobs Server 2.1 and Later
-------------------------------------------------------------------

If you are using Push Jobs Server to orchestrate your build nodes, 2.1.0 and later are now fully supported for use with Chef Automate. Instructions for this upgrade can be found `here </release_notes_push_jobs.html#upgrading-chef-automate-installation-to-use-push-jobs-server-2-1>`_.
