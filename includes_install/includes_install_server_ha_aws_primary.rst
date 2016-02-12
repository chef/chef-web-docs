.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following steps to set up the primary backend |chef server|:

#. Create an |amazon ebs| volume and attach it to the primary backend.
#. Download the packages from http://downloads.chef.io/chef-server/ and http://downloads.chef.io/chef-ha/.
#. Install the ``chef-server-core`` package. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the |chef server| will be installed.
#. Install ``chef-ha`` package. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-ha-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-ha-<version>.deb

#. Create a file named |chef server rb| that is located in the ``/etc/opscode/`` directory. See the |chef server rb| section below for an example of the settings and values that are required. The ``ha['ebs_device']`` setting must specify the actual ``/dev`` device name that is reported by the machine's kernel, which may not be the same value that is reported by |amazon aws|. For example, |amazon aws| may refer to a volume as ``/dev/sdf`` through the management console, but to the |linux| kernel on the instance, it may appear as ``/dev/xvdf``.

#. Install |lvm| tools. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ sudo yum install lvm2

   For |ubuntu|:

   .. code-block:: bash
      
      $ sudo apt-get install lvm2

#. Create a physical volume, volume group, and logical volume with the following series of commands. The volume group and logical volume names must be ``chef`` and ``data``, respectively.

   .. code-block:: bash
      
      $ sudo pvcreate /dev/xvdf

   then:

   .. code-block:: bash
      
      $ sudo vgcreate chef /dev/xvdf

   then:

   .. code-block:: bash
      
      $ sudo lvcreate -l 85%VG -n data chef

#. Format and mount the new volume with the following series of commands:

   .. code-block:: bash
      
      $ sudo mkdir -p /var/opt/opscode/drbd/data

   then:

   .. code-block:: bash
      
      $ sudo mkfs.ext4 /dev/mapper/chef-data

   and then:

   .. code-block:: bash
      
      $ sudo mount /dev/mapper/chef-data /var/opt/opscode/drbd/data

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

   This will reconfigure the |chef server|, start |keepalived|, assign the VIP IP address as a secondary address on the |amazon eni|, and then configure the machine as the primary backend server.

#. Verify the machine is the primary backend server:

   .. code-block:: bash
      
      $ sudo chef-server-ctl ha-status

   This should display a screen of output indicating that the server is ``PRIMARY`` and that all services are running.

   Additionally, you may run the following command to verify that the VIP IP address is configured on the Ethernet interface:

   .. code-block:: bash

      $ ip addr list dev eth0

   .. warning:: Do *not* use the ``ifconfig`` command as it will not show all aliases.

