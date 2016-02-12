.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following steps to set up the backend |chef server|:

#. Download the packages from http://downloads.chef.io/chef-server/. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the |chef server| will be installed.

#. Create a file named |chef server rb| that is located in the ``/etc/opscode/`` directory. See the |chef server rb| section below for an example of the settings and values that are required.
