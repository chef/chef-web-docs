.. This page is the Chef 12 server install page, for high availabilty in AWS.

=====================================================
High Availability: AWS
=====================================================

.. include:: ../../includes_install/includes_install_server_ha_aws.rst

.. image:: ../../images/chef_server_ha_aws.svg
   :width: 600px
   :align: center

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Prerequisites
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_pre.rst

Primary Backend
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_primary.rst

|chef server rb|
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_config_rb.rst

Secondary Backend
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_secondary.rst

Verify Failover
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_verify.rst

Frontend Installation
=====================================================
.. include:: ../../includes_install/includes_install_server_ha_aws_frontend.rst

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
The following sections show the |chef ha| settings as they appear in a |chef server rb| file and required permissions of the user in |amazon iam|.

|chef server rb|
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_ha_aws_reference_config.rst

|amazon iam|
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_server_ha_aws_reference_iam.rst