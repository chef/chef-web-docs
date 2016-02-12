=====================================================
|openstack chef|
=====================================================

.. include:: ../../includes_openstack/includes_openstack.rst

This page describes how to use the |openstack chef| cookbooks as the basis for managing an |openstack| deployment with |chef|, as well as how to participate in the development and maintenance process of these cookbooks. For more information about |openstack| itself, see http://docs.openstack.org.

Architecture
=====================================================
This section describes the supported deployment scenarios for |openstack chef| and is based on the `OpenStack Grizzly <http://www.solinea.com/2013/06/15/openstack-grizzly-architecture-revisited/>`_ release. This is going to be updated for both |openstack juno| and |openstack kilo| at a later date.

.. image:: ../../images/openstack-arch-grizzly-conceptual-v2.jpg

There are a number of configuration options available, including block storage, hypervisors, databases, message queuing, networking, object storage, source builds, and so on. The current supported deployment scenarios include:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Scenario
     - Description
   * - All-in-One Compute
     - A full |openstack compute| deployment on a single host. No object storage.
   * - Single Controller + N Compute
     - A single controller with 1 or more |openstack compute| nodes. No object storage.
   * - |vagrant|
     - A virtual instance on a single host using |vagrant|.

One Controller + N Compute
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_architecture_1+n.rst

All-in-One Compute
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_architecture_allinone.rst

Roles
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_allinone_roles.rst

Environments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_allinone_environments.rst

|vagrant|
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_architecture_vagrant.rst

Vagrantfile
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_vagrant_vagrantfile.rst

Install
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_vagrant_configure.rst

Environments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_vagrant_environment.rst

Usage
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_architecture_vagrant_usage.rst



Deployment Prerequisites
=====================================================
.. include:: ../../includes_openstack/includes_openstack_deploy.rst

|chef|
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_deploy_prereq_chef.rst

Hardware
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_deploy_prereq_hardware.rst

Network
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_deploy_prereq_network.rst

Operating Systems
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_deploy_prereq_os.rst

Images
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_deploy_prereq_images.rst



Install
=====================================================
.. include:: ../../includes_openstack/includes_openstack_install.rst



Development Process
=====================================================
.. include:: ../../includes_openstack/includes_openstack_develop.rst

|irc|
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_develop_irc.rst

Issue Tracking
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_develop_issues.rst

Feature Tracking
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_develop_features.rst

Testing
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_develop_gerrit.rst



Repository
=====================================================

.. include:: ../../includes_openstack/includes_openstack_repo.rst

|berkshelf|
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_repo_berkshelf.rst

Roles
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_repo_roles.rst



Cookbooks
=====================================================

.. include:: ../../includes_openstack/includes_openstack_cookbooks.rst

The canonical upstream |chef| cookbooks and example repository are located in the `OpenStack Github organization <https://github.com/openstack/>`_. Each integrated OpenStack project has a separate cookbook and repository.

|openstack| Cookbooks
-----------------------------------------------------
The following table lists all of the cookbooks that are available for |openstack chef|:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Cookbook
     - Description
   * - block-storage
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_block_storage.rst
   * - common
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_common.rst
   * - compute
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_compute.rst
   * - dashboard
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_dashboard.rst
   * - identity
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_identity.rst
   * - image
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_image.rst
   * - metering
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_metering.rst
   * - network
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_network.rst
   * - object-storage
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_object_storage.rst
   * - ops-database
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_ops_database.rst
   * - ops-messaging
     - .. include:: ../../includes_openstack/includes_openstack_cookbooks_ops_messaging.rst

.. note:: All |openstack| cookbooks are prefaced with ``cookbook-openstack-`` in addition to the name listed in the previous table. For example: ``cookbook-openstack-block-storage`` or ``cookbook-openstack-ops-messaging``.

Contribute
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_cookbooks_contribute.rst

Commit Messages
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_cookbooks_contribute_commit_messages.rst

Code Review
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_cookbooks_contribute_code_review.rst

Access Controller
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_cookbooks_contribute_code_review_access_controller.rst

Test Controller
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_cookbooks_contribute_code_review_test_controller.rst

Test Cookbooks
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_cookbooks_test.rst



knife-openstack
=====================================================
Please see the documentation for this |knife| plugin on |github|: https://github.com/chef/knife-openstack



Example Deployment
=====================================================
.. include:: ../../includes_openstack/includes_openstack_example.rst

.. image:: ../../images/openstack-lab.png

lab-repo
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo.rst

Environment
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_environment.rst

Roles
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_roles.rst

lab-admin
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_roles_lab_admin.rst

lab-base
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_roles_lab_base.rst

Data Bags
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_data_bags.rst

pxe_dust
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_data_bags_pxe_dust.rst

users
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_data_bags_users.rst

Cookbooks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_lab_repo_cookbooks.rst

Network
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_example_network.rst

Admin
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_network_admin.rst

Public
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_network_public.rst

Storage
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_network_storage.rst

Hardware
-----------------------------------------------------
.. include:: ../../includes_openstack/includes_openstack_example_hardware.rst

mom.lab.atx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_hardware_mom.rst

crushinator.lab.atx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_hardware_crushinator.rst

ignar.lab.atx/larry.lab.atx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_hardware_ignar.rst

lrrr.lab.atx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_openstack/includes_openstack_example_hardware_lrrr.rst




For More Information ...
=====================================================
.. include:: ../../includes_openstack/includes_openstack_more_info.rst

