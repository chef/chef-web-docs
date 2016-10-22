.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Upgrade to Enterprise Chef 11: High Availability 
=====================================================

.. note:: To upgrade from an earlier version of Enterprise Chef to a newer version of Enterprise Chef, the steps are identical to the ones described below.

This topic describes the upgrade process from Private Chef to Enterprise Chef. The upgrade process will require downtime equal to the amount of time it takes to stop all of the machines, run dpkg or RPM Package Manager, and then upgrade each of the machines. The final step will remove older components (like the CouchDB) and will destroy the data after the upgrade process is complete.

Please `view the notes <https://docs.chef.io/upgrade_server_ha_notes.html>`_ about the high availability Enterprise Chef upgrade for any changes that may exist for your upgrade process.

To upgrade to Enterprise Chef, do the following:

#. Run the following command on all machines to make sure all services are in a sane state.

   .. code-block:: bash
      
      $ private-chef-ctl reconfigure

#. Stop all of the front end machines:

   .. code-block:: bash
      
      $ private-chef-ctl stop

#. Identify the name of the original non-bootstrap backend machine. This is the back end machine that does **not** have ``:bootstrap => true`` in ``/etc/opscode/private-chef.rb``.

#. Stop Keepalived on the original non-bootstrap backend machine. This will ensure that the bootstrap back end machine is the active machine. This action may trigger a failover.

   .. code-block:: bash
      
      $ private-chef-ctl stop keepalived

#. Run dpkg or RPM Package Manager on all machines. For dpkg:

   .. code-block:: bash
      
      $ dpkg -D10 -i <new package>

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for dpkg for more information about this option.
   
   For RPM Package Manager:

   .. code-block:: bash
      
      $ rpm -Uvh <new package>

#. Upgrade the back end primary machine with the following command:

   .. code-block:: bash
      
      $ private-chef-ctl upgrade

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Copy the entire ``/etc/opscode`` directory from the back end primary machine to all front and back end nodes. For example, from each server run:

   .. code-block:: bash
      
      $ scp -r <Bootstrap server IP>:/etc/opscode /etc

   or from the back end primary machine:

   .. code-block:: bash
      
      $ scp -r /etc/opscode <each servers IP>:/etc

#. Upgrade the back end secondary machine with the following command:

   .. code-block:: bash
      
      $ private-chef-ctl upgrade

   In some instances, after the upgrade processes is complete, it may be required to stop Keepalived on the back end secondary machine, then restart Keepalived on the back end primary machine, and then restart Keepalived on the back end secondary machine.

#. Upgrade all front end machines with the following commands:

   .. code-block:: bash
      
      $ private-chef-ctl upgrade

#. Run the following command on all front end and back end machines:

   .. code-block:: bash
      
      $ private-chef-ctl start

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and that everything looks satisfactory, remove old data by running the following command on each machine:

   .. code-block:: bash
   
      $ private-chef-ctl cleanup

   This process will remove old services, old data, messages about old services not running, and so on.

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.
