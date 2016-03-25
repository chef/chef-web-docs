.. This page is the Chef 12 server install page, for high availabilty in AWS.

=====================================================
High Availability: Cluster
=====================================================

.. warning:: This topic is about a beta feature of Chef.

.. include:: ../../includes_install/includes_install_server_ha_aws.rst

.. image:: ../../images/chef_server_ha_cluster.svg
   :width: 600px
   :align: center

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst


chef-backend-ctl
=====================================================
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend.rst

bootstrap
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_bootstrap_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


cluster-status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_cluster_status_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Return cluster health data as JSON**

.. code-block:: bash

   $ chef-backend-ctl cluster-status --json



demote
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_demote.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_demote_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|no_options|

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


force-leader
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|no_options|

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

