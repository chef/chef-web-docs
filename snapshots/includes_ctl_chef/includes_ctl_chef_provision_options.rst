.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``--cookbook COOKBOOK_PATH``
   Specify the location of the cookbook that is used to provision the node. Default value: ``./provision``.

``-d``, ``--destroy``
   Set the default action for the **machine** resource to ``:destroy``. Default value: ``false``.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-n NODE_NAME``, ``--node-name NODE_NAME``
   Specify the name of the node. (This value may be overridden by the cookbook that is used to provision the node.)

``-o OPT=VALUE``, ``--opt OPT=VALUE``
   Set an arbitrary command-line option (``OPT``) and value (``=VALUE``). Use this option once per command-line option. Default value: ``{}``.

   .. note:: Use the ``extra_chef_config`` property in a recipe in the ``provision`` cookbook to set arbitrary configuration settings. Define the ``extra_chef_config`` values in the ``provision`` cookbook using the following syntax:
             
             .. code-block:: ruby
             
                ChefDK::ProvisioningData.context.extra_chef_config = 'setting :value'
             
             For example:
             
             .. code-block:: ruby
             
                ChefDK::ProvisioningData.context.extra_chef_config = 'log_level :debug'

``-p POLICY_NAME``, ``--policy-name POLICY_NAME``
   Set the policy name for one (or more) machines that are managed by this Policyfile.rb file.

``--[no-]policy``
   Use ``--policy`` to enable one (or more) machines to be managed by a Policyfile.rb file. Default value: ``--policy``.

``-r RECIPE``, ``--recipe RECIPE``
   Specify the name of the recipe to be run. This recipe must be located in the ``policyfile`` cookbook at the path specified by the ``--cookbook`` option.

``-s PATH``, ``--sync PATH``
   Push a Policyfile.rb file to the Chef server before running the chef-client on a node. The ``PATH`` is the location of the Policyfile.rb file to be synchronized.

``-t REMOTE_HOST``, ``--target REMOTE_HOST``
   Set the hostname or IP address of the host on which the chef-client run will occur. (This value may be overridden by the cookbook that is used to provision the node.)

``-v``, ``--version``
   The version of the chef-client.
