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

Upgrading from a `delivery-cluster` setup
--------------------------------------------------------

Chef Delivery clusters configured using the ``delivery-cluster`` setup process specify a search method to identify build nodes 
that is not compatible with the new build node installation mechanism used by |automate|. In order to ensure that both your 
existing build nodes and those added with ``delivery-ctl install-build-node`` can be seen by an |automate| server, you will 
need to edit ``/etc/delivery/delivery.rb`` and modify the value present for ``delivery['default_search']``.

In the ``delivery.rb`` configured by delivery-cluster, you will find a line that looks like this:

.. code-block:: ruby

   delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default) AND chef_environment:_default)"

If you have further customized this setting, modify your custom query to include ``OR tags:delivery-build-node``. If you have not modified it 
from what delivery-cluster set up, you can replace it with the following line:

.. code-block:: ruby

   delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default OR tags:delivery-build-node) AND chef_environment:_default)"

Save your changes and then run ``sudo delivery-ctl reconfigure`` to complete the upgrade process.
 
