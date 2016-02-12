.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Before adding any settings to the |knife rb| file:

* Verify the settings by reviewing the documentation for the |knife| subcommands and/or |knife| plugins
* Verify the use case(s) your organization has for adding them

Also note that:

* Custom plugins can be configured to use the same settings as the core |knife| subcommands
* Many of these settings are used by more than one subcommand and/or plugin
* Some of the settings are included only because |knife| checks for a value in the |knife rb| file

To add settings to the |knife rb| file, use the following syntax:

.. code-block:: ruby

   knife[:setting_name] = value

where ``value`` may require quotation marks (' ') if that value is a string. For example:

.. code-block:: ruby

   knife[:ssh_port] = 22
   knife[:bootstrap_template] = 'ubuntu14.04-gems'
   knife[:bootstrap_version] = ''
   knife[:bootstrap_proxy] = ''

Some of the optional |knife rb| settings are used often, such as the template file used in a bootstrap operation. The frequency of use of any option varies from organization to organization, so even though the following settings are often added to a |knife rb| file, they may not be the right settings to add for every organization:

``knife[:bootstrap_proxy]``
   |bootstrap proxy|

``knife[:bootstrap_template]``
   |path bootstrap_template|

``knife[:bootstrap_version]``
   |bootstrap version|

``knife[:editor]``
   |editor|

``knife[:ssh_gateway]``
   |ssh_gateway| Adding this setting can be helpful when a user cannot |ssh| directly into a host.

``knife[:ssh_port]``
   |ssh_port|

Other |ssh|-related settings that are sometimes helpful when added to the |knife rb| file:

``knife[:forward_agent]``
   |forward_agent|

``knife[:ssh_attribute]``
   |attribute ssh|

``knife[:ssh_password]``
   |ssh_password|

``knife[:ssh_user]``
   |ssh_user|

Some organizations choose to have all data bags use the same secret and secret file, rather than have a unique secret and secret file for each data bag. To use the same secret and secret file for all data bags, add the following to |knife rb|:

``knife[:secret]``
   |secret|

``knife[:secret_file]``
   |secret_file|

Some settings are better left to |ohai|, which will get the value at the start of the |chef client| run:

``knife[:server_name]``
   Same as node_name. Recommended configuration is to allow |ohai| to collect this value during each |chef client| run.

``node_name``
   See the description above for this setting.

When working with |chef container|, add the following setting:

``knife[:dockerfiles_path]``
   The path to the directory in which |docker| contexts are stored. Default value: ``/var/chef/dockerfiles``.
	 
.. warning:: Review the full list of `optional settings <https://docs.chef.io/config_rb_knife_optional_settings.html>`_ that can be added to the |knife rb| file. Many of these optional settings should not be added to the |knife rb| file. The reasons for not adding them can vary. For example, using ``--yes`` as a default in the |knife rb| file will cause |knife| to always assume that "Y" is the response to any prompt, which may lead to undesirable outcomes. Other settings, such as ``--hide-healthy`` (used only with the ``knife status`` subcommand) or ``--bare-directories`` (used only with the ``knife list`` subcommand) probably aren't used often enough (and in the same exact way) to justify adding them to the |knife rb| file. In general, if the optional settings are not listed on `the main knife.rb topic <https://docs.chef.io/config_rb_knife.html>`_, then add settings only after careful consideration. Do not use optional settings in a production environment until after the setting's performance has been validated in a safe testing environment.

