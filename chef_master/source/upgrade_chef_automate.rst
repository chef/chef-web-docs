=====================================================
Upgrade Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The following sections describe the upgrade process between versions of Chef Automate and when upgrading from a ``delivery-cluster`` setup to Chef Automate.

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

Upgrading from a ``delivery-cluster`` setup
--------------------------------------------------------

Chef Delivery clusters configured using the ``delivery-cluster`` setup process specify a search method to identify build nodes that is not compatible with the previous build node or new runner installation mechanisms used by Chef Automate. In order to ensure that both your existing build nodes and those added with ``automate-ctl install-build-node`` or ``automate-ctl install-runner`` can be seen by an Chef Automate server, you will need to edit ``/etc/delivery/delivery.rb`` and modify the value present for ``delivery['default_search']``.

In the ``delivery.rb`` configured by ``delivery-cluster``, you will find a line that looks like this:

.. code-block:: ruby

   delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default) AND chef_environment:_default)"

If you have further customized this setting, modify your custom query to include ``OR tags:delivery-build-node``. If you have not modified it from what ``delivery-cluster`` set up, you can replace it with the following line:

.. code-block:: ruby

   delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default OR tags:delivery-build-node) AND chef_environment:_default)"

Save your changes and then run ``sudo automate-ctl reconfigure`` to complete the upgrade process.

.. tag chef_automate_build_nodes

.. note:: Legacy build nodes created by ``delivery-cluster`` can be used with a Chef Automate server.  Some visibility features are designed to only work with new build nodes and runners installed through the command line process, but the workflow feature in Chef Automate can use legacy, new, or mixed node pools; however, you cannot upgrade a legacy build node to the new build node or runner models.  If you would like to use new build nodes/runners, please use fresh hosts or completely wipe your legacy build nodes before attempting to run ``automate-ctl install-build-node`` or ``automate-ctl install-runner``.

.. end_tag

Upgrading and the ``automate-ctl setup`` command
-------------------------------------------------------------------

The ``automate-ctl setup`` command used during the Chef Automate installation process is intended to simplify the initial configuration of your Chef Automate cluster. If your cluster is up and running, you don't need to run this command; however to set up additional runners with the ``automate-ctl install-runner`` command, running ``automate-ctl setup`` is recomended to ensure all required files are in the correct place.
