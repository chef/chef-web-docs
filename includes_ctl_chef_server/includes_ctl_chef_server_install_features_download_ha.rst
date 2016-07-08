.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), the |chef manage| package can be installed as described below:

|chef manage_title|
   Use |chef manage| to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

   On each front end server in the |chef server| configuration, run:

   .. code-block:: bash

      $ chef-server-ctl install chef-manage

   then:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   and then:

   .. code-block:: bash

      $ chef-manage-ctl reconfigure

   .. include:: ../../includes_install/includes_install_manage_copy_secrets.rst

   .. note:: .. include:: ../../includes_chef_license/includes_chef_license_reconfigure_manage.rst



