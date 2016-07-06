=====================================================
Upgrade Chef Automate
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The following sections describe the upgrade process for Chef Automate.

Prerequisites
=====================================================

This section describes the prereqs for the upgrade.

#. Previously installed version of Chef Automate.
#. ``sudo`` or ``root`` access to the machine.

Upgrade
=====================================================

To upgrade to the latest version of Chef Automate, do the following:

#. Download the latest version of Chef Automate from `<https://downloads.chef.io/delivery/>`_ or `<https://bintray.com/chef/stable/delivery/view>`_ and copy it to your Chef Automate server.
#. Update the package as appropriate for the server's OS:

   For Debian:
  
   .. code-block:: bash

      dpkg -i $PATH_TO_AUTOMATE_SERVER_PACKAGE


   For Red Hat or Centos:
  
   .. code-block:: bash

      rpm -Uvh $PATH_TO_AUTOMATE_SERVER_PACKAGE

#. Run ``sudo delivery-ctl reconfigure`` to complete the upgrade process.

   .. note:: This will restart your Chef Automate services and may result in a brief period of unavailability.

 
