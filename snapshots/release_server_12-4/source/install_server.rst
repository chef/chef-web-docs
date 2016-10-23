.. THIS PAGE DOCUMENTS Chef server version 12.4

=====================================================
Install the Chef Server
=====================================================

There are three configuration scenarios for the Chef server:

* `Standalone <https://docs.chef.io/release/server_12-4/install_server.html#standalone>`__ (everything on a single machine)
* `High availability <https://docs.chef.io/release/server_12-4/install_server.html#high-availability>`__ (machines configured for front-end and back-end, allowing for failover on the back-end and load-balancing on the front-end, as required)
* `Tiered <https://docs.chef.io/release/server_12-4/install_server.html#tiered-single-backend>`__ (machines configured for front-end and back-end, with a single back-end and load-balancing on the front-end, as required)

Prerequisites
=====================================================
The Chef server has the :doc:`following prerequisites </install_server_pre>`:

* An x86_64 compatible system architecture; Red Hat Enterprise Linux and CentOS may require updates prior to installation
* A resolvable hostname that is specified using a FQDN or an IP address
* A connection to Network Time Protocol (NTP) to prevent clock drift
* A local mail transfer agent that allows the Chef server to send email notifications
* Using cron and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the Apache Qpid daemon on CentOS and Red Hat systems
* Optional. A local user account under which services will run, a local user account for PostgreSQL, and a group account under which services will run. See https://docs.chef.io/release/server_12-4/install_server_pre.html#uids-and-gids for more information.

Standalone
=====================================================
.. include:: ../../includes_install/includes_install_server_standalone.rst

Update config for purchased nodes
=====================================================
.. include:: ../../includes_install/includes_install_server_licensing.rst

High Availability
=====================================================
The following links describe how to configure the Chef server for high availability:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-4/install_server_ha_aws.html">High Availability using Amazon Web Services</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-4/install_server_ha_drbd.html">High Availability using DRBD</a> </br>

Tiered (Single Backend)
=====================================================
The following link describes how to configure the Chef server with a single backend machine and multiple frontend machines:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-4/install_server_tiered.html">Tiered</a> </br>
