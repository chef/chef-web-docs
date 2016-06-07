=====================================================
High Availability: Backend Cluster
=====================================================

.. warning:: This topic is about an upcoming feature of the Chef server.

This topic describes the process of upgrading a highly available |chef server| cluster.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Overview
=====================================================

These instructions cover doing zero downtime upgrades of a
chef-backend cluster. They should work for any minor version
upgrade. Major version upgrades may require downtime.

Procedure
=====================================================

This assumes that the new chef-backend package has been copied to all of the nodes.

Step 1: Block Failover
-----------------------------------------------------
We don't want the cluster to fail over to a follower that is in the
process of being upgraded. So we start by disabling failover

#. Run ``chef-backend-ctl set-cluster-failover off``

Step 2: Upgrade the followers.
-----------------------------------------------------
Followers should be upgraded sequentially. Upgrading them simultaneously will
reduce redundancy and increase risk of data loss. Verify the successful
rejoin after each upgrade.

For each follower do:

#. Stop chef-backend

   .. code-block:: shell-session

      % chef-backend-ctl stop

#. Upgrade the the chef-backend

   * In RedHat/CentOS: ``yum install PATH_TO_RPM``
   * In Debian/Ubuntu: ``dpkg -i PATH_TO_DEB``

#. Start chef-backend

   .. code-block:: shell

      % chef-backend-ctl start

#. Verify the follower is synced

   .. code-block :: shell

      % chef-backend-ctl status
      Service        Local Status        Time in State  Distributed Node Status
      leaderl        running (pid 6881)  0d 0h 43m 35s  leader: 1; waiting: 0; follower: 2; total: 3
      etcd           running (pid 6833)  0d 0h 43m 41s  health: green; healthy nodes: 3/3
      postgresql     running (pid 6942)  0d 0h 43m 34s  leader: 1; offline: 0; syncing: 0; synced: 2
      elasticsearch  running (pid 6796)  0d 0h 43m 43s  state: green; nodes online: 3/3

Pay special attention to the postgresql 'synced' count; syncing is the
slowest part of rejoining the cluster.

Repeat the process for each follower.

Step 3: Failover from current leader to an upgraded follower
------------------------------------------------------------

#. Unblock failover, trigger failover, block it again.

   .. code-block :: shell

      % chef-backend-ctl set-cluster-failover on
      % chef-backend-ctl demote
      % chef-backend-ctl set-cluster-failover off

#. Verify that failover has succeeded

   .. code-block :: shell
   
      % chef-backend-ctl cluster-status
      Name       IP              GUID                              Role            PG        ES
      backend-1  192.168.33.215  79d84527cf937f3daa94c1435d0a4249  deposed_leader  follower  not_master
      backend-2  192.168.33.216  c106c88745ef13517874d7301463afb9  leader          leader    not_master
      backend-3  192.168.33.217  4d29bcb5eec25d3674d5b8af132f75b3  follower        follower  master

Check that a new leader has been elected. The old leader will initially have the state 'deposed_leader', and should transition to 'follower'.

Step 4: Upgrade the demoted leader
-----------------------------------------------------

Upgrade the demoted leader as in Step 2 above


Step 5: Re-enable failover
-----------------------------------------------------

Allow failover again:

   .. code-block :: shell

      % chef-backend-ctl set-cluster-failover on


Step 6: Verify the cluster is stable
-----------------------------------------------------

Check the status of the cluster:

  .. code-block :: shell
  
     % chef-backend-ctl status
