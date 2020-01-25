=====================================================
High Availability: Upgrade to Chef Backend 2
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server_ha_v2.rst>`__

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

This topic describes the process of upgrading a high availability Chef Infra Server cluster.

Overview
=====================================================
These instructions cover the process of upgrading a Chef Backend cluster. Please refer to the appropriate directions for the version of Chef Backend that you are using and the version that you intend to upgrade to:

* `Chef Backend 1.x to 2.x Upgrade`_ (downtime upgrade)
* `DRBD/Keepalived HA to Chef Backend 2.x`_ (migration)

Chef Backend 1.x to 2.x Upgrade
=====================================================

.. warning:: Upgrading from Chef Backend 1.x to Chef Backend 2.x requires full cluster downtime.

#. Identify the node with the **leader** role using the ``chef-backend-ctl cluster-status`` command:

   .. code-block:: none

    Name       IP              GUID                              Role      PG        ES
    backend-1  192.168.33.215  dc0c6ea77a751f94037cd950e8451fa3  leader    leader    not_master
    backend-2  192.168.33.216  008782c59d3628b6bb7f43556ac0c66c  follower  follower  not_master
    backend-3  192.168.33.217  1af654172b1830927a571d9a5ba7965b  follower  follower  master

   In this example, ``backend-1`` is the **leader** node, as indicated by its role in the **Role** column.

#. Install the new Chef Backend package on all nodes in the cluster:

   RHEL and CentOS:

     .. code-block:: bash

        yum install PATH_TO_FILE.rpm

   Debian and Ubuntu:

     .. code-block:: bash

        dpkg -i PATH_TO_FILE.deb

#. On the leader, run the following command to take the node down for the upgrade:

   .. code-block:: bash

      chef-backend-ctl down-for-upgrade

#. Then issue the same command on the follower nodes:

   .. code-block:: bash

      chef-backend-ctl down-for-upgrade

#. Initiate the upgrade on the follower nodes first:

   .. code-block:: bash

      chef-backend-ctl upgrade

#. Then initiate the upgrade on the leader node:

   .. code-block:: bash

      chef-backend-ctl upgrade

#. On any Chef Infra Server frontend nodes using the Chef Backend cluster upgraded in the previous steps, run:

   .. code-block:: bash

      chef-server-ctl reconfigure

#. To continue the upgrades on Chef Infra Server frontend nodes using this backend cluster, see `Upgrade Frontends Associated with a Chef Backend Cluster <https://docs.chef.io/install_server_ha.html#upgrading-chef-infra-server-on-the-frontend-machines>`_

Chef Backend Minor Version Upgrade
=====================================================

The Minor Version Upgrade is appropriate for all upgrades of a Chef Backend cluster other than upgrades from one major version to another major version. For example, 1.x to 1.x upgrades or 2.x to 2.x upgrades.

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

   RHEL and CentOS:

     .. code-block:: bash

        yum install PATH_TO_FILE.rpm

   Debian and Ubuntu:

     .. code-block:: bash

        dpkg -i PATH_TO_FILE.deb

    You may also want to look at the chef-ingredient cookbook to automate downloading and installing the latest package.

#. Run the upgrade command

   .. code-block:: bash

      chef-backend-ctl upgrade

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

     chef-backend-ctl status

DRBD/Keepalived HA to Chef Backend 2.x
=====================================================

DRBD configurations are no longer supported. See `End of Life Products <https://docs.chef.io/versions.html#end-of-life-eol-products>`__

For a guide to migrating to Chef Backend from DRBD see the `Best Best Practices for Migrating Your Chef Server <https://blog.chef.io/2018/04/06/best-practices-for-migrating-your-chef-server/>`__ webinar from the `Chef Blog <https://blog.chef.io/>`__
