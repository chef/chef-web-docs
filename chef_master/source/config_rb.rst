=====================================================
config.rb
=====================================================

.. warning:: The |config rb| file is a replacement for the |knife rb| file, starting with the |chef client| 12.0 release. The |config rb| file has identical settings and behavior to the |knife rb| file. The |chef client| will first look for the presence of the |config rb| file and if it is not found, will look for the |knife rb| file. If you are using the |chef client| 11.x versions in your infrastructure, continue using the |knife rb| file.

A ``config.rb`` file is used to specify |chef repo|-specific configuration details.

* This file is loaded every time this executable is run
* The default location in which the |chef client| expects to find this file is ``~/.chef/config.rb``; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a |config rb| file is present in this directory, the settings contained within that file will override the default configuration settings

Settings
=====================================================
.. include:: ../../includes_config/includes_config_rb_config_settings.rst

Proxy Settings
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_knife_settings_proxy.rst

Optional Settings
=====================================================
In addition to the default settings in a |config rb| file, there are other subcommand-specific settings that can be added:

#. A value passed via the command-line
#. A value contained in the |config rb| file
#. The default value

A value passed via the command line will override a value in the |config rb| file; a value in a |config rb| file will override a default value.

.. include:: ../../includes_config/includes_config_rb_knife_settings_optional.rst


