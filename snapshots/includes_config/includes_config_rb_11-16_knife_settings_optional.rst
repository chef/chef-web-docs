.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Before adding any settings to the knife.rb file:

* Verify the settings by reviewing the documentation for the knife subcommands and/or knife plugins
* Verify the use case(s) your organization has for adding them

Also note that:

* Custom plugins can be configured to use the same settings as the core knife subcommands
* Many of these settings are used by more than one subcommand and/or plugin
* Some of the settings are included only because knife checks for a value in the knife.rb file

To add settings to the knife.rb file, use the following syntax:

.. code-block:: ruby

   knife[:setting_name] = value

where ``value`` may require quotation marks (' ') if that value is a string. For example:

.. code-block:: ruby

   knife[:ssh_port] = 22
   knife[:distro] = 'ubuntu10.04-gems'
   knife[:template_file] = ''
   knife[:bootstrap_version] = ''
   knife[:bootstrap_proxy] = ''

Some of the optional knife.rb settings are used often, such as the template file used in a bootstrap operation. The frequency of use of any option varies from organization to organization, so even though the following settings are often added to a knife.rb file, they may not be the right settings to add for every organization:

``knife[:bootstrap_proxy]``
   The proxy server for the node that is the target of a bootstrap operation.

``knife[:bootstrap_version]``
   The version of the chef-client to install.

``knife[:distro]``
   .. include:: ../../includes_knife/includes_knife_bootstrap_distro.rst

``knife[:editor]``
   The $EDITOR that is used for all interactive commands.

``knife[:ssh_gateway]``
   The SSH tunnel or gateway that is used to run a bootstrap action on a machine that is not accessible from the workstation. Adding this setting can be helpful when a user cannot SSH directly into a host.

``knife[:ssh_port]``
   The SSH port.

``knife[:template_file]``
   The path to a template file to be used during a bootstrap operation.

Other SSH-related settings that are sometimes helpful when added to the knife.rb file:

``knife[:forward_agent]``
   Enable SSH agent forwarding.

``knife[:ssh_attribute]``
   The attribute used when opening an SSH connection.

``knife[:ssh_password]``
   The SSH password. This can be used to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.

``knife[:ssh_user]``
   The SSH user name.

Some organizations choose to have all data bags use the same secret and secret file, rather than have a unique secret and secret file for each data bag. To use the same secret and secret file for all data bags, add the following to knife.rb:

``knife[:secret]``
   The encryption key that is used for values contained within a data bag item.

``knife[:secret_file]``
   The path to the file that contains the encryption key.

Some settings are better left to Ohai, which will get the value at the start of the chef-client run:

``knife[:server_name]``
   Same as node_name. Recommended configuration is to allow Ohai to collect this value during each chef-client run.

``node_name``
   See the description above for this setting.

When working with chef-container, add the following setting:

``knife[:dockerfiles_path]``
   The path to the directory in which Docker contexts are stored. Default value: ``/var/chef/dockerfiles``.
	 
.. warning:: Review the full list of `optional settings <https://docs.chef.io/config_rb_knife_optional_settings.html>`_ that can be added to the knife.rb file. Many of these optional settings should not be added to the knife.rb file. The reasons for not adding them can vary. For example, using ``--yes`` as a default in the knife.rb file will cause knife to always assume that "Y" is the response to any prompt, which may lead to undesirable outcomes. Other settings, such as ``--hide-healthy`` (used only with the ``knife status`` subcommand) or ``--bare-directories`` (used only with the ``knife list`` subcommand) probably aren't used often enough (and in the same exact way) to justify adding them to the knife.rb file. In general, if the optional settings are not listed on `the main knife.rb topic <https://docs.chef.io/config_rb_knife.html>`_, then add settings only after careful consideration. Do not use optional settings in a production environment until after the setting's performance has been validated in a safe testing environment.

