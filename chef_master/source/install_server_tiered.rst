.. This page is the Chef 12 server install page, for high availabilty in AWS.

=====================================================
Tiered
=====================================================

.. warning:: This topic is deprecated. See `High Availability: Backend Cluster <https://docs.chef.io/install_server_ha.html>`_ for information on how to set up a highly-available server cluster.

.. include:: ../../includes_install/includes_install_server_tiered.rst

.. image:: ../../images/chef_server_tiered.png

Prerequisites
=====================================================
.. include:: ../../includes_install/includes_install_server_tiered_pre.rst

Disk Configuration
=====================================================
.. include:: ../../includes_install/includes_install_server_tiered_config_disk.rst

Mount Storage Device
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_tiered_mount.rst

Backend
=====================================================
.. include:: ../../includes_install/includes_install_server_tiered_primary.rst

|chef server rb|
=====================================================
.. include:: ../../includes_install/includes_install_server_tiered_config_rb.rst

Frontend
=====================================================
.. include:: ../../includes_install/includes_install_server_tiered_frontend.rst

Enable Features
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

**Use Downloads**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download_ha.rst

**Use Local Packages**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

**Install Reporting**

.. include:: ../../includes_install/includes_install_reporting_ha.rst

Reference
=====================================================
The following sections show an example |chef server rb| file and a list of the ports that are required by the |chef server|.

|chef server rb|
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_tiered_reference_config.rst

Firewalls
-----------------------------------------------------
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports.rst

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_listening.rst

.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_loopback.rst

Backend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_tiered.rst

Frontend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_fe.rst
