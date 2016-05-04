.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), these packages can be installed as described below.

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Feature
     - Command
   * - |chef manage_title|
     - Use |chef manage| to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

       On the |chef server|, run:

       .. code-block:: ruby

          $ chef-server-ctl install chef-manage

       then:

       .. code-block:: ruby

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: ruby

          $ chef-manage-ctl reconfigure

       .. note:: .. include:: ../../includes_chef_license/includes_chef_license_reconfigure_manage.rst

   * - |push jobs_title|
     - Use |push jobs| to run jobs---an action or a command to be executed---against nodes independently of a |chef client| run.

       On the |chef server|, run:

       .. code-block:: ruby

          $ chef-server-ctl install opscode-push-jobs-server

       then:

       .. code-block:: ruby

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: ruby

          $ opscode-push-jobs-server-ctl reconfigure

   * - Reporting
     - Use |reporting| to keep track of what happens during every |chef client| runs across all of the infrastructure being managed by |chef|. Run |reporting| with |chef manage| to view reports from a web user interface.

       On the |chef server|, run:

       .. code-block:: ruby

          $ chef-server-ctl install opscode-reporting

       then:

       .. code-block:: ruby

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: ruby

          $ opscode-reporting-ctl reconfigure

