=====================================================
High Availability: Backend Cluster
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server_ha_v2.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

This topic describes the process of upgrading a highly available Chef server cluster.

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Overview
=====================================================

These instructions cover doing zero downtime upgrades of a
chef-backend cluster. They should work for any minor version
upgrade. Major version upgrades may require downtime.

Procedure
=====================================================

.. note:: The procedure assumes that the new chef-backend package has been copied to all of the nodes.

Step 1: Block Failover
-----------------------------------------------------
We don't want the cluster to fail over to a follower that is in the
process of being upgraded. So we start by disabling failover

#. Run ``chef-backend-ctl set-cluster-failover off``

Step 2: Upgrade the followers.
-----------------------------------------------------
Followers should be upgraded sequentially. Upgrading them simultaneously is not supported and may result in data loss. Verify the successful rejoin after each upgrade.

#. Install the new chef-backend package

   * In RedHat/CentOS: ``yum install PATH_TO_RPM``
   * In Debian/Ubuntu: ``dpkg -i PATH_TO_DEB``

You may also want to look at the chef-ingredient cookbook to automate
downloading and installing the latest package.

#. Run the upgrade command

   .. code-block:: bash

      % chef-backend-ctl upgrade

The upgrade command will make any changes necessary to start the new service and verify that the upgraded node has rejoined the cluster.

Repeat the previous steps in this section for each remaining follower.

Step 3: Upgrade the leader
------------------------------------------------------------

#. Unblock failover, trigger failover, block it again.

   .. code-block:: bash

      % chef-backend-ctl set-cluster-failover on
      % chef-backend-ctl upgrade --failover
      % chef-backend-ctl set-cluster-failover off

Step 4: Re-enable failover
-----------------------------------------------------

Allow failover again:

   .. code-block:: bash

      % chef-backend-ctl set-cluster-failover on

Step 5: Verify the cluster is stable
-----------------------------------------------------

Check the status of the cluster:

  .. code-block:: bash

     % chef-backend-ctl status
