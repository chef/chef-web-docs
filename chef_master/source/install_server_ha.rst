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


backup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_backup_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


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

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


force-leader
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_force_leader_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


gen-sample-backend-config
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config_syntax.rst

Example Output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_sample_backend_config_example.rst


gen-server-config
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_syntax.rst

Configure the Front End
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_steps.rst

Example Output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_gen_server_config_example.rst


join-cluster
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_join_cluster_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


promote
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_promote.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_promote_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


remove-node
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_remove_node_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


restore
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_restore_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


set-cluster-failover
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_cluster_failover.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_cluster_failover_syntax.rst


set-node-failover
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_node_failover.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_set_node_failover_syntax.rst


status

-----------------------------------------------------
.. include:: ../../includes_ctl_chef_backend/includes_ctl_chef_backend_status.rst

