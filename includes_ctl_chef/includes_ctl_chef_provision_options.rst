.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the |knife| configuration file.

``--cookbook COOKBOOK_PATH``
   Use to specify the location of the cookbook that is used to provision the node. Default value: ``./provision``.

``-d``, ``--destroy``
   Use to set the default action for the |resource machine| resource to ``:destroy``. Default value: ``false``.

``-D``, ``--debug``
   Use to enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   |help subcommand|

``-n NODE_NAME``, ``--node-name NODE_NAME``
   Use to specify the name of the node. (This value may be overridden by the cookbook that is used to provision the node.)

``-o OPT=VALUE``, ``--opt OPT=VALUE``
   Use to set an arbitrary command-line option (``OPT``) and value (``=VALUE``). Use this option once per command-line option. Default value: ``{}``.

   .. note:: Use the ``extra_chef_config`` property in a recipe in the ``provision`` cookbook to set arbitrary configuration settings. Define the ``extra_chef_config`` values in the ``provision`` cookbook using the following syntax:

      .. code-block:: ruby

         ChefDK::ProvisioningData.context.extra_chef_config = 'setting :value'

      For example:

      .. code-block:: ruby

         ChefDK::ProvisioningData.context.extra_chef_config = 'log_level :debug'

``-p POLICY_NAME``, ``--policy-name POLICY_NAME``
   Use to set the policy name for one (or more) machines that are managed by this |policyfile rb| file.

``--[no-]policy``
   Use ``--policy`` to enable one (or more) machines to be managed by a |policyfile rb| file. Default value: ``--policy``.

``-r RECIPE``, ``--recipe RECIPE``
   Use to specify the name of the recipe to be run. This recipe must be located in the ``policyfile`` cookbook at the path specified by the ``--cookbook`` option.

``-s PATH``, ``--sync PATH``
   Use to push a |policyfile rb| file to the |chef server| before running the |chef client| on a node. The ``PATH`` is the location of the |policyfile rb| file to be synchronized.

``-t REMOTE_HOST``, ``--target REMOTE_HOST``
   Use to set the hostname or IP address of the host on which the |chef client| run will occur. (This value may be overridden by the cookbook that is used to provision the node.)

``-v``, ``--version``
   |version chef|
