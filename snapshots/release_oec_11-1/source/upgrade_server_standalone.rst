.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Upgrade to Enterprise Chef 11: Standalone 
=====================================================

.. note:: To upgrade from an earlier version of Enterprise Chef to a newer version of Enterprise Chef, the steps are identical to the ones described below.

This topic describes the upgrade process from Private Chef to Enterprise Chef. The upgrade process will require downtime equal to the amount of time it takes to stop the machine, run dpkg or RPM Package Manager, and then upgrade the machine. The final step will remove older components and will destroy the data after the upgrade process is complete.

.. Please `view the notes <https://docs.chef.io/upgrade_server_standalone_notes.html>`_ about the standalone Enterprise Chef upgrade for any changes that may exist for your upgrade process.

To upgrade to Enterprise Chef, do the following:

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash
      
      $ private-chef-ctl reconfigure

#. Stop the machine:

   .. code-block:: bash
      
      $ private-chef-ctl stop

#. Run dpkg or RPM Package Manager on the machines. For dpkg:

   .. code-block:: bash
      
      $ dpkg -D10 -i <new package>

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.
   
   For RPM Package Manager:

   .. code-block:: bash
      
      $ rpm -Uvh <new package>

#. Upgrade the machine with the following command:

   .. code-block:: bash
      
      $ private-chef-ctl upgrade

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the machine by removing all of the old data:

   .. code-block:: bash
   
      $ private-chef-ctl cleanup

   This process will remove old services, old data, messages about old services not running, and so on.

#. Start Enterprise Chef:

   .. code-block:: bash
   
      $ private-chef-ctl start
