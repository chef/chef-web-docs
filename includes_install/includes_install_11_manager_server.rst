.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To set up |chef manage| for a standalone configuration:

#. Contact |company_name| and get the package that is appropriate for the |chef server| platform and operating system
#. Install the package on the same server that is running |chef server| 11.0.1 or higher. For example on |ubuntu|:

   .. code-block:: bash

      $ dpkg -i opscode-manage_1.0.0-1.ubuntu.10.04_amd64.deb

#. Disable the legacy web interface. Modify the |enterprise rb| file (located at ``/etc/opscode/private-chef.rb``) to disable the existing |service webui| service.

   .. code-block:: bash

      opscode_webui['enable']=false

   If the |enterprise rb| file does not exist, then create the file and add this setting to it.

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Reconfigure the |chef manage|:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

.. #. Verify the installation:
.. 
..    .. code-block:: bash
.. 
..       $ opscode-manage-ctl test
.. 
..    The |chef manage| should now be running and accessible by a web browser on port 443 (HTTPS). 

