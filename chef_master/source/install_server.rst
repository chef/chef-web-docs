.. This page is the Chef 12 server install page.

=====================================================
Install the |chef server_title|
=====================================================
There are three configuration scenarios for the |chef server|:

* `Standalone <https://docs.chef.io/server/install_server.html#standalone>`__ (everything on a single machine)
* `High availability <https://docs.chef.io/server/install_server.html#high-availability>`__ (machines configured for front-end and back-end, allowing for failover on the back-end and load-balancing on the front-end, as required)
* `Tiered <https://docs.chef.io/server/install_server.html#tiered-single-backend>`__ (machines configured for front-end and back-end, with a single back-end and load-balancing on the front-end, as required)

Prerequisites
=====================================================
The |chef server| has the :doc:`following prerequisites </install_server_pre>`:

* An x86_64 compatible system architecture; |redhat enterprise linux| and |centos| may require updates prior to installation
* A resolvable hostname that is specified using a |fqdn| or an IP address
* A connection to |ntp| to prevent clock drift
* A local mail transfer agent that allows the |chef server| to send email notifications
* Using |cron| and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the |apache qpid| daemon on |centos| and |redhat| systems
* Optional. A local user account under which services will run, a local user account for |postgresql|, and a group account under which services will run. See https://docs.chef.io/install_server_pre.html#uids-and-gids for more information.

Standalone
=====================================================
.. include:: ../../includes_install/includes_install_server_standalone.rst

High Availability
=====================================================
The following links describe how to configure the |chef server| for high availability:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/install_server_ha_aws.html">High Availability using Amazon Web Services</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/install_server_ha_drbd.html">High Availability using DRBD</a> </br>

Tiered (Single Backend)
=====================================================
The following link describes how to configure the |chef server| with a single backend machine and multiple frontend machines:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/install_server_tiered.html">Tiered</a> </br>
