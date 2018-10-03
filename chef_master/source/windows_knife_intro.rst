=====================================================
Using Knife
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/windows_knife_intro.rst>`__

Knife
=====================================================
.. tag knife_summary

knife is a command-line tool that provides an interface between a local chef-repo and the Chef server. knife helps users to manage:

* Nodes
* Cookbooks and recipes
* Roles, Environments, and Data Bags
* Resources within various cloud environments
* The installation of the chef-client onto nodes
* Searching of indexed data on the Chef server

.. end_tag

Set the Text Editor
-----------------------------------------------------
.. tag knife_common_set_editor

Some knife commands, such as ``knife data bag edit``, require that information be edited as JSON data using a text editor. For example, the following command:

.. code-block:: bash

   $ knife data bag edit admins admin_name

will open up the text editor with data similar to:

.. code-block:: javascript

   {
     "id": "admin_name"
   }

Changes to that file can then be made:

.. code-block:: javascript

   {
     "id": "Justin C."
     "description": "I am passing the time by letting time pass over me ..."
   }

The type of text editor that is used by knife can be configured by adding an entry to your config.rb file, or by setting an ``EDITOR`` environment variable. For example, to configure knife to open the ``vim`` text editor, add the following to your config.rb file:

.. code-block:: ruby

   knife[:editor] = "/usr/bin/vim"

When a Microsoft Windows file path is enclosed in a double-quoted string (" "), the same backslash character (``\``) that is used to define the file path separator is also used in Ruby to define an escape character. The config.rb file is a Ruby file; therefore, file path separators must be escaped. In addition, spaces in the file path must be replaced with ``~1`` so that the length of each section within the file path is not more than 8 characters. For example, if EditPad Pro is the text editor of choice and is located at the following path::

   C:\\Program Files (x86)\EditPad Pro\EditPad.exe

the setting in the config.rb file would be similar to:

.. code-block:: ruby

   knife[:editor] = "C:\\Progra~1\\EditPa~1\\EditPad.exe"

One approach to working around the double- vs. single-quote issue is to put the single-quotes outside of the double-quotes. For example, for Notepad++:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\Notepad++\notepad++.exe" -nosession -multiInst'

for Sublime Text:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files\Sublime Text 2\sublime_text.exe" --wait'

for TextPad:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\TextPad 7\TextPad.exe"'

and for vim:

.. code-block:: ruby

   knife[:editor] = '"C:\Program Files (x86)\vim\vim74\gvim.exe"'

.. end_tag

Quotes, Windows
-----------------------------------------------------
.. tag knife_common_windows_quotes

When running knife in Microsoft Windows, a string may be interpreted as a wildcard pattern when quotes are not present in the command. The number of quotes to use depends on the shell from which the command is being run.

When running knife from the command prompt, a string should be surrounded by single quotes (``' '``). For example:

.. code-block:: bash

   $ knife node run_list set test-node 'recipe[iptables]'

When running knife from Windows PowerShell, a string should be surrounded by triple single quotes (``''' '''``). For example:

.. code-block:: bash

   $ knife node run_list set test-node '''recipe[iptables]'''

.. end_tag

Import-Module chef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_common_windows_quotes_module

The chef-client version 12.4 release adds an optional feature to the Microsoft Installer Package (MSI) for Chef. This feature enables the ability to pass quoted strings from the Windows PowerShell command line without the need for triple single quotes (``''' '''``). This feature installs a Windows PowerShell module (typically in ``C:\opscode\chef\modules``) that is also appended to the ``PSModulePath`` environment variable. This feature is not enabled by default. To activate this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Import-Module chef

or add ``Import-Module chef`` to the profile for Windows PowerShell located at:

.. code-block:: bash

   ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

This module exports cmdlets that have the same name as the command-line tools---chef-client, knife, chef-apply---that are built into Chef.

For example:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' """&s0meth1ng"""

is now:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' '&s0meth1ng'

and:

.. code-block:: bash

   $ knife node run_list set test-node '''role[ssssssomething]'''

is now:

.. code-block:: bash

   $ knife node run_list set test-node 'role[ssssssomething]'

To remove this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Remove-Module chef

.. end_tag

Ampersands, Windows
-----------------------------------------------------
.. tag knife_common_windows_ampersand

When running knife in Microsoft Windows, an ampersand (``&``) is a special character and must be protected by quotes when it appears in a command. The number of quotes to use depends on the shell from which the command is being run.

When running knife from the command prompt, an ampersand should be surrounded by quotes (``"&"``). For example:

.. code-block:: bash

   $ knife bootstrap windows winrm -P "&s0meth1ng"

When running knife from Windows PowerShell, an ampersand should be surrounded by triple quotes (``"""&"""``). For example:

.. code-block:: bash

   $ knife bootstrap windows winrm -P """&s0meth1ng"""

.. end_tag

knife bootstrap
-----------------------------------------------------
.. tag chef_client_bootstrap_node

A node is any physical, virtual, or cloud machine that is configured to be maintained by a chef-client. In order to bootstrap a node, you will first need a working installation of the `Chef software package </packages.html>`__. A bootstrap is a process that installs the chef-client on a target system so that it can run as a chef-client and communicate with a Chef server. There are two ways to do this:

* Use the ``knife bootstrap`` subcommand to `bootstrap a node using the Chef installer </install_bootstrap.html>`__
* Use an unattended install to bootstrap a node from itself, without using SSH or WinRM

.. end_tag

.. tag knife_bootstrap_summary

Use the ``knife bootstrap`` subcommand to run a bootstrap operation that installs the chef-client on the target system. The bootstrap operation must specify the IP address or FQDN of the target system.

.. end_tag

.. note:: To bootstrap the chef-client on Microsoft Windows machines, the `knife-windows </knife_windows.html>`__ plugins is required, which includes the necessary bootstrap scripts that are used to do the actual installation.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_bootstrap_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife bootstrap FQDN_or_IP_ADDRESS (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. note:: Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

.. tag knife_bootstrap_options

This subcommand has the following options:

``-A``, ``--forward-agent``
   Enable SSH agent forwarding.

``--bootstrap-curl-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using cURL. This option may not be used in the same command with ``--bootstrap-install-command``.

``--bootstrap-install-command COMMAND``
   Execute a custom installation command sequence for the chef-client. This option may not be used in the same command with ``--bootstrap-curl-options`` or ``--bootstrap-wget-options``.

``--bootstrap-no-proxy NO_PROXY_URL_or_IP``
   A URL or IP address that specifies a location that should not be proxied.

   .. note:: This option is used internally by Chef to help verify bootstrap operations during testing and should never be used during an actual bootstrap operation.

``--bootstrap-preinstall-command COMMANDS``
   Custom commands to run before installing chef-client

``--bootstrap-proxy-pass PROXY_PASS``
   The proxy authentication password for the node being bootstrapped

``--bootstrap-proxy-user PROXY_USER``
   The proxy authentication username for the node being bootstrapped

``--bootstrap-proxy PROXY_URL``
   The proxy server for the node that is the target of a bootstrap operation.

``--bootstrap-vault-file VAULT_FILE``
   The path to a JSON file that contains a list of vaults and items to be updated.

``--bootstrap-vault-item VAULT_ITEM``
   A single vault and item to update as ``vault:item``.

``--bootstrap-vault-json VAULT_JSON``
   A JSON string that contains a list of vaults and items to be updated.

   .. tag knife_bootstrap_vault_json

   For example:

   .. code-block:: none

      --bootstrap-vault-json '{ "vault1": ["item1", "item2"], "vault2": "item2" }'

   .. end_tag

``--bootstrap-version VERSION``
   The version of the chef-client to install.

``--bootstrap-wget-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using GNU Wget. This option may not be used in the same command with ``--bootstrap-install-command``.

``-E ENVIRONMENT``, ``--environment ENVIRONMENT``
   The name of the environment. When this option is added to a command, the command will run only against the named environment.

``-G GATEWAY``, ``--ssh-gateway GATEWAY``
   The SSH tunnel or gateway that is used to run a bootstrap action on a machine that is not accessible from the workstation.

``--hint HINT_NAME[=HINT_FILE]``
   An Ohai hint to be set on the target node.

   .. tag ohai_hints

   Ohai hints are used to tell Ohai something about the system that it is running on that it would not be able to discover itself. An Ohai hint exists if a JSON file exists in the hint directory with the same name as the hint. For example, calling ``hint?('antarctica')`` in an Ohai plugin would return an empty hash if the file ``antarctica.json`` existed in the hints directory, and return nil if the file does not exist.

   .. end_tag

   .. tag ohai_hints_json

   If the hint file contains JSON content, it will be returned as a hash from the call to ``hint?``.

   .. code-block:: javascript

      {
        "snow": true,
        "penguins": "many"
      }

   .. code-block:: ruby

      antarctica_hint = hint?('antarctica')
      if antarctica_hint['snow']
        "There are #{antarctica_hint['penguins']} penguins here."
      else
        'There is no snow here, and penguins like snow.'
      end

   Hint files are located in the ``/etc/chef/ohai/hints/`` directory by default. Use the ``Ohai.config[:hints_path]`` setting in the ``client.rb`` file to customize this location.

   .. end_tag

   ``HINT_FILE`` is the name of the JSON file. ``HINT_NAME`` is the name of a hint in a JSON file. Use multiple ``--hint`` options to specify multiple hints.

``-i IDENTITY_FILE``, ``--ssh-identity-file IDENTITY_FILE``
   The SSH identity file used for authentication. Key-based authentication is recommended.

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   A JSON string that is added to the first run of a chef-client.

``--json-attribute-file FILE``
   A JSON file to be added to the first run of chef-client.

``-N NAME``, ``--node-name NAME``
   The name of the node.

   .. note:: This option is required for a validatorless bootstrap.
``--[no-]fips``
  Allows OpenSSL to enforce FIPS-validated security during the chef-client run.

``--[no-]host-key-verify``
   Use ``--no-host-key-verify`` to disable host key verification. Default setting: ``--host-key-verify``.

``--[no-]node-verify-api-cert``
   Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. If this option is not specified, the setting for ``verify_api_cert`` in the configuration file is applied.

``--node-ssl-verify-mode MODE``
   Set the verify mode for HTTPS requests. Options: ``none`` or ``peer``.

   Use ``none`` to do no validation of SSL certificates.

   Use ``peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.

``-p PORT``, ``--ssh-port PORT``
   The SSH port.

``-P PASSWORD``, ``--ssh-password PASSWORD``
   The SSH password. This can be used to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.

``--prerelease``
   Install pre-release gems.

``-r RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item.

``--secret-file FILE``
   The path to the file that contains the encryption key.

``--sudo``
   Execute a bootstrap operation with sudo.

``--sudo-preserve-home``
   Use to preserve the non-root user's ``HOME`` environment.

``-t TEMPLATE``, ``--bootstrap-template TEMPLATE``
   The bootstrap template to use. This may be the name of a bootstrap template---``chef-full``, for example---or it may be the full path to an Embedded Ruby (ERB) template that defines a custom bootstrap. Default value: ``chef-full``, which installs the chef-client using the Chef installer on all supported platforms.

``--use-sudo-password``
   Perform a bootstrap operation with sudo; specify the password with the ``-P`` (or ``--ssh-password``) option.

``-V -V``
   Run the initial chef-client run at the ``debug`` log-level (e.g. ``chef-client -l debug``).

``-V -V -V``
   Run the initial chef-client run at the ``trace`` log-level (e.g. ``chef-client -l trace``). This was added in Chef Client 14.

``-x USERNAME``, ``--ssh-user USERNAME``
   The SSH user name.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See `config.rb </config_rb_optional_settings.html>`__ for more information about how to add certain knife options as settings in the config.rb file.

          .. end_tag
