.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``install`` subcommand downloads packages from https://packagecloud.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packagecloud.io/), these packages can be installed as described below.

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Feature
     - Command
   * - |chef manage_title|
     - Use |chef manage| to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

       On each front end server in the |chef server| configuration, run:

       .. code-block:: ruby

          $ chef-server-ctl install opscode-manage

       then:

       .. code-block:: ruby

          $ chef-server-ctl reconfigure 

       and then:

       .. code-block:: ruby

          $ opscode-manage-ctl reconfigure

       .. include:: ../../includes_install/includes_install_manage_copy_secrets.rst

   * - |chef replication_title|
     - Use |chef replication| to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary |chef server| to one (or more) replicas of that |chef server|.

       On all servers in the |chef server| configuration, run:

       .. code-block:: ruby

          $ chef-server-ctl install chef-sync

       .. include:: ../../includes_install/includes_install_server_replication_create_directory.rst

       then:

       .. code-block:: ruby

          $ chef-server-ctl reconfigure 

       and then:

       .. code-block:: ruby

          $ chef-sync-ctl reconfigure


..
..   * - |chef ha_title|
..     - Run:
..
..       .. code-block:: ruby
..
..          $ chef-server-ctl install chef-ha
..
..       and then:
..
..       .. code-block:: ruby
..
..          $ chef-server-ctl reconfigure
..
