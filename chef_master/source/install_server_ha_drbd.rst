.. This page is the Chef 12 server install page, for high availabilty in AWS.

=====================================================
High Availability: DRBD
=====================================================

This topic describes how to set up the |chef server| for high availability using physical machines and |drbd|.

.. image:: ../../images/chef_server_ha_drbd.svg
   :width: 600px
   :align: center

Prerequisites
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_pre.rst

Disk Configuration
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_config_disk.rst

|chef server rb|
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_config_rb.rst

Primary Backend
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_primary.rst

Secondary Backend
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_secondary.rst

Establish Failover
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_establish_failover.rst

Frontend
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_drbd_frontend.rst

Enable Features
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

**Use Downloads**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download_ha.rst

**Use Local Packages**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

**Install Reporting**

.. include:: ../../includes_install/includes_install_reporting_ha.rst

**Install Push Jobs**

.. include:: ../../includes_install/includes_install_push_jobs_server_ha.rst

Reference
=====================================================
The following sections show an example |chef server rb| file and a list of the ports that are required by the |chef server|.

|chef server rb|
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_ha_drbd_reference_config.rst

Firewalls and Ports
-----------------------------------------------------
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports.rst

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_listening.rst

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_loopback.rst

Backend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_be.rst

Frontend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_fe.rst

GRE Tunnels
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_ha_drbd_gre_tunnels.rst