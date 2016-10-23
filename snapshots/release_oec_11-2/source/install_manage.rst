.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Install Chef Manage
=====================================================

.. include:: ../../includes_manage/includes_manage.rst

Requirements
=====================================================
The Chef management console add-on has the following requirements:

* Enterprise Chef version 11.0.1 (or later)
* The existing legacy Chef management console web user interface must be disabled
* TCP protocol ports 443

Install the Server
=====================================================
The Chef management console is installed as a premium feature of the Chef server and can be enabled in both standalone or high availability configurations.

Standalone
-----------------------------------------------------
To set up Chef management console for a standalone configuration:

#. Contact Chef and get the package that is appropriate for the Chef server platform and operating system
#. Install the package on the same server that is running Chef server 11.0.1 or higher. For example on Ubuntu:

   .. code-block:: bash

      $ dpkg -i opscode-manage_1.0.0-1.ubuntu.10.04_amd64.deb

#. Disable the legacy web interface. Modify the private-chef.rb file (located at ``/etc/opscode/private-chef.rb``) to disable the existing **opscode-webui** service.

   .. code-block:: bash

      opscode_webui['enable']=false

   If the private-chef.rb file does not exist, then create the file and add this setting to it.

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Reconfigure the Chef management console:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

.. #. Verify the installation:
.. 
..    .. code-block:: bash
.. 
..       $ opscode-manage-ctl test
.. 
..    The Chef management console should now be running and accessible by a web browser on port 443 (HTTPS). 


High Availability
-----------------------------------------------------
To set up the Chef management console server for a high availability configuration:

#. Contact Chef and get the package that is appropriate for the Chef server platform and operating system.
#. Install the package on the same frontend servers that are running Chef server, version 11.0.1 or higher. For example on Ubuntu:

   .. code-block:: bash

      $ dpkg -i opscode-manage_1.0.0-1.ubuntu.10.04_amd64.deb

#. Disable the legacy web interface. Modify the private-chef.rb file (located at ``/etc/opscode/private-chef.rb``) to disable the existing **opscode-webui** service:

   .. code-block:: bash
   
      if PrivateChef['servers'][node['fqdn']]['role'] == 'frontend'
        opscode_webui['enable'] = false
      end

   If the private-chef.rb file does not exist, then create the file and add this setting to it. This step is required for each of the frontend servers in the Enterprise Chef deployment.

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ private-chef-ctl reconfigure

   This step is required for each of the frontend servers in the Chef server deployment. For example, in a configuration with two backend servers and three frontend servers, this command would need to be run on all three frontend servers.

#. Reconfigure the Chef management console server:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

   This step is required for each of the frontend servers in the Chef server deployment.

.. #. Verify the installation:
.. 
..    .. code-block:: bash
.. 
..       $ opscode-manage-ctl test
.. 
..    The Chef management console should now be running and accessible by a web browser on port 443 (HTTPS). 


Upgrade the Server
=====================================================
Chef management console can be upgraded as part of a standalone or high availability configuration:

#. Contact Chef and get the package that is appropriate for your Enterprise Chef server's platform and operating system.

#. Install the package on the same machines that are currently running Enterprise Chef. For example on Ubuntu:

   .. code-block:: bash

      $ dpkg -i opscode-manage_1.0.0-1.ubuntu.10.04_amd64.deb

#. Reconfigure the Enterprise Chef server:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

   This step is required for each of the front end servers in the Enterprise Chef deployment. For example, in a configuration with two back end servers and three front end servers, this command would need to be run on all three front end machines.



