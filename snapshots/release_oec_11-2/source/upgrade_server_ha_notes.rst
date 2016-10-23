.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

======================================================
Notes for High Availability Enterprise Chef Upgrades 
======================================================

The following sections contain notes about specific scenarios that some customers may run into when upgrading from Private Chef to Enterprise Chef. Please consult with Chef support about any of these situations.

All Upgrade Scenarios
=====================================================

All upgrades should be performed first with a copy of production data, but in an environment that is non-essential. This is often done using a Vagrant virtual machine, but any non-essential environment suitable for testing the upgrade of production data is OK.

Backups are good to have for many reasons, at all times. This is especially true during upgrades. Therefore, ensure that tested backups are available during the entire upgrade process.


Upgrading from Private Chef 1.2.x
=====================================================

Upgrading from Private Chef 1.2.x to any version of Enterprise Chef 11 **REQUIRES** that Private Chef 1.2.x first be upgraded (on all systems) to Private Chef 1.4.6+.


Upgrading from Private Chef 1.4.6+ to Enterprise Chef 11.1.3+
===========================================================================

The following sections are specific to Private Chef 1.4.6+ upgrades to Enterprise Chef 11.1.3+.

.. note:: Unless otherwise noted, all patching should be done after Private Chef 1.4.6+ is installed, and before the Enterprise Chef 11.1.3+ package install and upgrade begins.

Known Issues
=====================================================

The following bugs may affect the upgrade:

As of Enterprise Chef 11.1.8:

* OC-11575 --- Services start automatically at boot on backup/passive machine in HA mode
* OC-11601 --- During an upgrade redis_lb isn't restarted before the attempt to reconfigure it.

Before Enterprise Chef 11.1.8:

* OC-11297 --- Enterprise Chef 11.0.X not saving its migration-level state on HA back end machines. Breaks ``private-chef-ctl upgrade`` on subsequent upgrades
* OC-11382 --- HA Upgrades to 11.1.3+ fail because keepalived restart interferes with partybus migrations
* OC-11426 --- Upgrade Runit Ownership Issue OPC 1.4.6 -> EC11.1.3+
* OC-11490 --- Root ownership of ``/var/log/opscode/keepalived`` prevents keepalived from running properly
* OC-11540 --- Setting non_ssl_port to false causes invalid opscode-account configuration
* OC-11656 --- Test Umask Inheritance and Cleanup Ownership in EC11 Embedded Cookbooks
* OC-11657 --- Default svwait timeout of 7 seconds is too short, causes many unnecessary failures during reconfigure/upgrade scenarios
* OC-11658 --- oc_authz_migrator failures are not trapped, leaving Authz -> Bifrost data un-migrated
* OC-11662 --- redis_lb timeout is too short for the real world
* OC-11669 --- During 1.4.x -> EC 11.x upgrade on Ubuntu and EL6 systems, keepalived transitions to backup because of the opscode-runsvdir -> private-chef-runsvdir change
* OC-11670 --- Partybus migration step 1.9 silently fails to run if keepalived is still in transition

.. warning:: Check runsvdir status during the upgrade, especially between each upgrade of the system. Here is an example of the highest level upgrade process that should be followed: check runsvdir status -> Private Chef 1.2.x -> check runsvdir status -> Private Chef 1.4.6+ -> check runsvdir status -> Enterprise Chef 11.1.3+ -> check runsvdir status. See "Runit Process Structure and Checks" below for more information.


Pre-Flight Check
=====================================================
It is recommended to do the following:

#. Backup the data on the bootstrap back end machine. (e.g. LVM snapshot, VMware snapshot, etc)

#. Run the following command on all machines to make sure things are in a sane state. (e.g. runit):

   .. code-block:: bash

      $ private-chef-ctl reconfigure

#. Stop all frontend machines:

   .. code-block:: bash

      private-chef-ctl stop

#. Identify the name of the original non-bootstrap back end machine. This is the back end machine that does not have ``:bootstrap => true`` in ``/etc/opscode/private-chef.rb``.

#. Stop keepalived on the original non-bootstrap back end machine. This will ensure that the bootstrap back end machine is the active machine. This action may trigger a failover.

   .. code-block:: bash

      private-chef-ctl stop keepalived

#. For known issue OC-11297 - On the back end machines, examine the ``/var/opt/opscode/upgrades/migration-level`` file. It should match the version on the front end machines. In high availability systems, the migration-level file is usually correct on the front end nodes but not the back end nodes due to the fact that the back end machine installation process gets interrupted for DRBD setup. If it is incorrect on the back end machines, please copy it from the front end nodes before proceeding.

   .. list-table::
      :widths: 200 300
      :header-rows: 1
   
      * - Chef Server Version
        - Migration Level
      * - Private Chef 1.4.6+
        - major: 1, minor: 7
      * - Enterprise Chef 11.0.x
        - major: 1, minor: 12
      * - Enterprise Chef 11.1.3+
        - major: 1, minor: 13

#. While running Private Chef 1.4.6+ and before the upgrade, be sure that the status for runit looks good. See "Runit Process Structure and Checks" below for more information.

#. Before proceeding, make sure that the bootstrap back end machine and all of its services are healthy, and that all services are stopped on the standby. Please check runsvdir status to make a determination about "healthy". See "Runit Process Structure and Checks" below for more information.


Upgrade Steps
=====================================================

#. Install the Enterprise Chef server package on all machines using dpkg or rpm.

#. On both backend nodes, apply the patches from the Patches section at the bottom of this page

#. On the bootstrap (primary) backend machine, perform a reconfigure and then WAIT about 2 minutes until all services have returned to a normal, working state according to ha-status and ``/var/log/opscode/keepalived/cluster.log``:

   .. code-block:: bash

      private-chef-ctl reconfigure

In a separate terminal window run this to monitor cluster state:

   .. code-block:: bash

      private-chef-ctl tail keepalived &
      while true; do echo "`date` : `cat /var/opt/opscode/keepalived/current_cluster_status`" ; sleep 1; done

During a 1.4.x to 11.x upgrade, the following services will remain down/unavailable and can be safely ignored. They will all be removed by ``private-chef-ctl cleanup`` except for ``opscode-chef-mover``

* fcgiwrap
* nagios
* nrpe
* opscode-chef
* opscode-chef-mover
* php-fpm
* redis

#. Once all services are verified, upgrade the bootstrap back end machine. (If anything strange happens here, please consider how the issue you see you could be related to runit. Please check runsvdir status for cleanup. You will also need to ensure that all ``omnibus-ctl``, ``private-chef-ctl``, and ``sv`` processes are gone. Then, be sure that the ``opscode-chef-mover`` service is started and retry the upgrade.)

   .. code-block:: bash

      private-chef-ctl upgrade

   
    See "Runit Process Structure and Checks" below for more information.
#. Copy the entire ``/etc/opscode`` directory from the bootstrap back end machine to all front end and back end machines. For example, from each machine run:

   .. code-block:: bash

      scp -r BOOTSTRAP_SERVER_IP:/etc/opscode /etc

#. Upgrade the secondary back end machine.

   .. code-block:: bash

      private-chef-ctl upgrade

#. Upgrade all frontend machines.

   .. code-block:: bash

      private-chef-ctl upgrade

#. Run the following on all machines to make sure all services are started.

   .. code-block:: bash

      private-chef-ctl start

#. After the upgrade process is complete, and the state of the system after the upgrade has been tested and verified, remove old data on all machines.

   .. code-block:: bash

      private-chef-ctl cleanup


Runit Process Structure and Checks
=====================================================

Please use the following diagram to understand the runit process supervision tree. All runit components can be inspected with ``ps aux | grep [s]v``::

   RHEL6/Ubuntu10.04+ Upstart
    |
    ----> opscode-runsvdir or private-chef-runsvdir 
        |
        ----> runsv -> (EC11 service like postgresql or opscode-erchef)
            |
            ---->svlogd -> (Logging for each service's STDOUT. Goes into a "current" file)

.. note:: In the diagram above, the Upstart config file is located at ``/etc/init/opscode-runsvdir`` on pre-Enterprise Chef 11, and at ``/etc/init/private-chef-runsvdir`` in Enterprise Chef 11.1.3+.

Between upgrades from major version to major version of Private Chef or Enterprise Chef, you will want to check that the ``ps aux | grep [r]unsvdir`` output looks similar to:

.. code-block:: bash

   root      1543  0.0  0.0   4032   196 ?        Ss   20:18   0:00 runsvdir -P /opt/opscode/service log:
   ......................................................................................................
   ......................................................................................................
   ......................................................................................................

and not similar to:

.. code-block:: bash

   root 864 0.0 0.0 4088 476 ? Ss 2013 14:26 runsvdir -P /opt/opscode/service log: not exist?svlogd: 
   pausing: unable to rename current: /var/log/opscode/opscode-erchef: file does not exist?svlogd: 
   pausing: unable to rename current: /var/log/opscode/opscode-erchef: file does not exist?svlogd: 
   pausing: unable to rename current: /var/log/opscode/opscode-erchef: file does not exist?svlogd: 
   pausing: unable to rename current: /var/log/opscode/opscode-erchef: file does not exist?

Any number of issues can occur with the runsvdir process in runit. The most common in an Private Chef or Enterprise Chef setting are these:

* In Private Chef 1.4.6+, ``/var/log/opscode`` should have ``755`` permissions, but it doesn't
* Any of the ``/var/log/opscode/SERVICE/current`` files are missing
* In Enterprise Chef, the ownership of ``/var/log/opscode`` is not ``opscode``, so the processes cannot read/write their log files
* The filesystem where the logs are stored is full

When this type of problem is encountered, the process is to check the error output in the process list as above, and figure out what has gone wrong for either the runsvdir, or its svlogd processes, or both. Correct the issue, shutdown Private Chef or Enterprise Chef, then use Upstart to restart runsvdir:

.. code-block:: bash

   private-chef-ctl stop

Restart the runsvdir:

* For Private Chef 1.4.6+ on RHEL6 and ubuntu10.04+ ``initctl stop opscode-runsvdir``
* For Enterprise Chef 11.x on RHEL6 and ubuntu10.04+ ``initctl stop private-chef-runsvdir``

.. note:: During the upgrade of Private Chef 1.4.6+ -> Enterprise Chef 11.1.3+, you may have both of the above.

* If continuing an Enterprise Chef 11.1.3+ upgrade ``initctl start private-chef-runsvdir``
* If fixing up an Private Chef 1.4.6+ system before an upgrade to Enterprise Chef 11.1.3+ ``initctl start private-chef-runsvdir``

Example
-----------------------------------------------------
The following is one specific problem-fix scenario encountered while proceeding through an Private Chef 1.4.6+ -> Enterprise Chef 11.1.3+ upgrade. The issue was likely triggered by an unhealthy runit status while running at version Private Chef 1.4.6+::

      1. Checked runvsvdir status when it became apparent that the Partybus
      initiated final private-chef-ctl start during the EC11.1.2 upgrade
      was looping on starting services. It was failing, because it was
      getting stuck on the old OPC 1.4.6 processes. This is likely because
      the OPC 1.4.6 runsvdir was no longer able to control the processes through
      incorrect permissions leading to a bad runsvdir state.
      
      2. Just for good measure, I removed the following links that pointed to
      the old process run control directories
      lrwxrwxrwx. 1 root root 24 Feb 3 08:08 fcgiwrap ->/opt/opscode/sv/fcgiwrap
      lrwxrwxrwx. 1 root root 22 Feb 3 08:08 nagios -> /opt/opscode/sv/nagios
      lrwxrwxrwx. 1 root root 20 Feb 3 08:08 nrpe -> /opt/opscode/sv/nrpe
      lrwxrwxrwx. 1 root root 28 Feb 3 08:07 opscode-chef -> /opt/opscode/sv/opscode-chef
      lrwxrwxrwx. 1 root root 23 Feb 3 08:08 php-fpm -> /opt/opscode/sv/php-fpm
      lrwxrwxrwx. 1 root root 21 Feb 3 08:07 redis -> /opt/opscode/sv/redis
      
      3. We had to cancel the first upgrade attempt, stop opscode-runsvdir and
      private-chef-runsvdir and make sure all their child processes were removed from the process list.
      
      4. chown -R opscode.opscode /var/log/opscode # Fix permissions, so
      that the new runsvdir can do stuff with its runsv and svlogd processes.
      
      5. start private-chef-runsvdir
      
      6. Wait for good bootstrap master state.
      
      7. Check ps aux | grep runsvdir. Status looks good.
      
      8. Restart the upgrade.
      
      9. Proceeded to the end of the upgrade.
      
      10. p-c-c cleanup


Enterprise Chef Patches as of 11.1.8
======================================

OC-11575 patch for Enterprise Chef 11.1.x
-------------------------------------------
Copy this file to ``/opt/opscode/embedded/cookbooks/enterprise/definitions/component_runit_service.rb`` on your backend nodes:

.. code-block:: ruby

    define :component_runit_service, :log_directory => nil,
                                     :svlogd_size => nil,
                                     :svlogd_num => nil,
                                     :ha => nil,
                                     :control => nil,
                                     :action => :enable do
      component = params[:name]
      log_directory = params[:log_directory] || node['private_chef'][component]['log_directory']
      
      template "#{log_directory}/config" do
        source "config.svlogd"
        cookbook "enterprise"
        mode "0644"
        owner "root"
        group "root"
        variables(
          :svlogd_size => ( params[:svlogd_size] || node['private_chef'][component]['log_rotation']['file_maxbytes']),
          :svlogd_num  => ( params[:svlogd_num] || node['private_chef'][component]['log_rotation']['num_to_keep'])
        )
      end
      
      runit_service component do
        action :enable
        retries 20
        control params[:control] if params[:control]
        options(
          :log_directory => log_directory
        )
      end
      
      if params[:action] == :down
        log "stop runit_service[#{component}]" do
          notifies :down, "runit_service[#{component}]", :immediately
        end
      end
      
      # Keepalive management
      #
      # Our keepalived setup knows which services it must manage by
      # looking for a 'keepalive_me' sentinel file in the service's
      # directory.
      if EnterpriseChef::Helpers.ha?(node)
        is_keepalive_service = params[:ha] || node['private_chef'][component]['ha']
        file "#{node['runit']['sv_dir']}/#{component}/keepalive_me" do
          action is_keepalive_service ? :create : :delete
        end
        
        file "#{node['runit']['sv_dir']}/#{component}/down" do
          action is_keepalive_service ? :create : :delete
        end
      end
      
    end
    


OC-11601 patch for Enterprise Chef 11.1.x
-------------------------------------------
Copy this file to ``/opt/opscode/embedded/cookbooks/private-chef/recipes/redis_lb.rb`` on your backend nodes:

.. code-block:: ruby

    # Copyright:: Copyright (c) 2012 Opscode, Inc.
    # License:: Apache License, Version 2.0
    # Author:: Marc A. Paradise <marc@opscode.com>
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #     http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
    #
    
    redis = node['private_chef']['redis_lb']
    redis_dir = redis['dir']
    redis_etc_dir = File.join(redis_dir, "etc")
    redis_data_dir = redis['data_dir']
    redis_data_dir_symlink = File.join(redis_dir, "data")
    redis_log_dir = redis['log_directory']
    
    [
      redis_dir,
      redis_etc_dir,
      redis_data_dir,
      redis_log_dir,
    ].each do |dir_name|
      directory dir_name do
        owner node['private_chef']['user']['username']
        mode '0700'
        recursive true
      end
    end
    
    redis_config = File.join(redis_etc_dir, "redis.conf")
        
    link redis_data_dir_symlink do
      to redis_data_dir
      not_if { redis_data_dir_symlink == redis_data_dir }
    end
    
    component_runit_service "redis_lb"
    
    redis_data = redis
    template redis_config do
      source "redis_lb.conf.erb"
      owner "root"
      group "root"
      mode "0644"
      variables(redis_data.to_hash)
      notifies :restart, 'service[redis_lb]', :immediately if is_data_master?
    end
    
    runit_service "redis_lb" do
      action :start
      only_if { is_data_master? }
    end
    
    # log rotation
    template "/etc/opscode/logrotate.d/redis_lb" do
      source "logrotate.erb"
      owner "root"
      group "root"
      mode "0644"
      variables(redis.to_hash)
    end
    
    #
    # This should be guarded by a test that redis is running.
    #
    # For the time being we retry a few times. This avoids a race
    # condition where the server is still starting and the port isn't
    # bound. The redis gem does not retry on ECONNREFUSED, and we fail.
    #
    ruby_block "set_lb_redis_values" do
      retries 5
      retry_delay 1
      only_if { is_data_master? }
      block do
        require "redis"
        redis = Redis.new(:host => redis_data.vip, :port => redis_data.port)
        xdl = node['private_chef']['lb']['xdl_defaults']
        banned_ips = PrivateChef['banned_ips']
        maint_mode_ips = PrivateChef['maint_mode_whitelist_ips']
        # Ensure there is no stale data, but first institute
        # a brief maint mode to avoid potential misrouting when
        # we delete old keys.
        redis.hset "dl_default", "503_mode", true
        next while not redis.spop("banned_ips").nil?
        next while not redis.spop("maint_data").nil?
        keys = redis.hkeys "dl_default"
        
        # Clear all dl_default keys except for the 503 mode we just set.
        redis.pipelined do
          keys.each do |key|
            redis.hdel "dl_default", key unless key == "503_mode"
          end
        end
        
        redis.pipelined do
          # Now we're clear to repopulate from configuration.
          if (!banned_ips.nil?)
            banned_ips.each do |ip|
              redis.sadd   "banned_ips", ip
            end
          end
          if (!maint_mode_ips.nil?)
            maint_mode_ips.each do |ip|
              redis.sadd   "maint_data", ip
            end
          end
          # Note that we'll preserve 503 mode until everything is
          # populated.
          if (!xdl.nil?)
            xdl.each do |key, value|
              redis.hset("dl_default", key, value) unless key == "503_mode"
            end
          end
        end
        
        if xdl && xdl.has_key?("503_mode")
          redis.hset "dl_default", "503_mode", xdl["503_mode"]
        else
          redis.hdel "dl_default", "503_mode"
        end
      end
      action :create
    end


