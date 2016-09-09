=====================================================
knife windows
=====================================================

.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows.rst
  		  
.. note:: Review the list of `common options <http://docs.chef.io/knife_common_options.html>`_ available to this (and all) |knife| subcommands and plugins.
		
Install this plugin		
=====================================================		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_install_rubygem.rst		
		
Requirements		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_requirements.rst		
		
|microsoft negotiate|, |ntlm|		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_requirements_nltm.rst		
		
Domain Authentication		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_domain_authentication.rst		
		
bootstrap windows ssh		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh_syntax.rst		
		
.. warning:: .. include:: ../../includes_knife/includes_knife_common_windows_ampersand.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_ssh_options.rst		
		
bootstrap windows winrm		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_winrm.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_winrm_syntax.rst		
		
.. warning:: .. include:: ../../includes_knife/includes_knife_common_windows_ampersand.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_bootstrap_windows_winrm_options.rst		
		
cert generate		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_generate.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_generate_syntax.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_generate_options.rst		
		
cert install		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_install.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_install_syntax.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_cert_install_options.rst		
		
listener create		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_listener_create.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_listener_create_syntax.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_listener_create_options.rst		
		
winrm		
=====================================================		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm.rst		
		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_ports.rst		
		
Syntax		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_syntax.rst		
		
Options		
-----------------------------------------------------		
.. include:: ../../includes_plugin_knife/includes_plugin_knife_windows_winrm_options.rst		
		
Examples		
=====================================================		
		
**Find Uptime for Web Servers**		
		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_winrm_find_uptime.rst		
		
**Force a chef-client run**		
		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_winrm_force_chef_run.rst		
		
**Bootstrap a Windows machine using SSH**		
		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_bootstrap_ssh.rst		
		
**Bootstrap a Windows machine using Windows Remote Management**		
		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_bootstrap_winrm.rst		
		
**Generate an SSL certificate, and then create a listener**		
		
.. include:: ../../step_plugin_knife/step_plugin_knife_windows_winrm_generate_cert_create_listener.rst
