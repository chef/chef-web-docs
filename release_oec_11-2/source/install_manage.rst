.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Install |chef manage_title|
=====================================================

.. include:: ../../includes_manage/includes_manage.rst

Requirements
=====================================================
.. include:: ../../includes_system_requirements/includes_system_requirements_manager.rst

Install the Server
=====================================================
The |chef manage| is installed as a premium feature of the |chef server| and can be enabled in both standalone or high availability configurations.

Standalone
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_11_manager_server.rst

High Availability
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_11_manager_server_ha.rst

Upgrade the Server
=====================================================
|chef manage| can be upgraded as part of a standalone or high availability configuration:

#. Contact |company_name| and get the package that is appropriate for your |chef server oec| server's platform and operating system.

#. Install the package on the same machines that are currently running |chef server oec|. For example on |ubuntu|:

   .. code-block:: bash

      $ dpkg -i opscode-manage_1.0.0-1.ubuntu.10.04_amd64.deb

#. Reconfigure the |chef server oec| server:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

   This step is required for each of the front end servers in the |chef server oec| deployment. For example, in a configuration with two back end servers and three front end servers, this command would need to be run on all three front end machines.



