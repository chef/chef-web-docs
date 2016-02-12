.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following steps to set up the primary backend |chef server|:

#. Download the packages from http://downloads.chef.io/chef-server/. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the |chef server| will be installed.

#. Create a file named |chef server rb| that is located in the ``/etc/opscode/`` directory. See the |chef server rb| section below for an example of the settings and values that are required.

#. Install |drbd|. These steps vary, depending on the platform. 

   **For Ubuntu**:

   .. code-block:: bash
      
      $ apt-get install drbd8-utils

   **For RedHat and CentOS (all versions)**, first check for the ``xen`` kernel:

   .. code-block:: bash
      
      $ rpm -qa kernel\* | grep -ci xen

   If anything other than ``0`` is returned, the machine is running the ``xen`` kernel. 

   **For RedHat and CentOS 6.6**, install |elrepo|:

   .. code-block:: bash
      
      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash
      
      $ rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

   .. note:: The |elrepo| provides updated drivers for the |linux| family of enterprise distributions (based on |redhat enterprise linux|.) With the introduction of |redhat enterprise linux| 6, |redhat| no longer distributes |drbd| within the kernel. These modules provide properly built, community tested releases of the required kernel and |drbd| userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84

   If the server returned something other than ``0``, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84-xen

   **For RedHat and CentOS 6.5**, install |elrepo|:

   .. code-block:: bash
      
      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash
      
      $ rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

   .. note:: The |elrepo| provides updated drivers for the |linux| family of enterprise distributions (based on |redhat enterprise linux|.) With the introduction of |redhat enterprise linux| 6, |redhat| no longer distributes |drbd| within the kernel. These modules provide properly built, community tested releases of the required kernel and |drbd| userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84-8.4.5-1.el6.elrepo

   If the server returned something other than ``0``, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84-xen-8.4.5-1.el6.elrepo

   **For RedHat and CentOS 5.11**, install |elrepo|:

   .. code-block:: bash
      
      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash
      
      $ rpm -Uvh http://www.elrepo.org/elrepo-release-5-5.el5.elrepo.noarch.rpm

   .. note:: The |elrepo| provides updated drivers for the |linux| family of enterprise distributions (based on |redhat enterprise linux|.) With the introduction of |redhat enterprise linux| 6, |redhat| no longer distributes |drbd| within the kernel. These modules provide properly built, community tested releases of the required kernel and |drbd| userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84

   If the server returned something other than ``0``, run:

   .. code-block:: bash
      
      $ yum install -y drbd84-utils kmod-drbd84-xen


#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

   This will configure |drbd|. The installer will pause and ask for confirmation that |drbd| has been set up. Confirm (``CTRL-C``), and then run the following commands:

   .. code-block:: bash
      
      $ drbdadm create-md pc0

   then:

   .. code-block:: bash
      
      $ drbdadm up pc0
