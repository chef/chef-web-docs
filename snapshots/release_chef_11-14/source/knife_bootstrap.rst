

=====================================================
knife bootstrap
=====================================================

.. tag chef_client_bootstrap_node

A node is any physical, virtual, or cloud machine that is configured to be maintained by a chef-client. A bootstrap is a process that installs the chef-client on a target system so that it can run as a chef-client and communicate with a Chef server. There are two ways to do this:

* Use the ``knife bootstrap`` subcommand to :doc:`bootstrap a node using the omnibus installer </install_bootstrap>`
* Use an unattended install to bootstrap a node from itself, without using SSH or WinRM

.. end_tag

.. tag knife_bootstrap_25

Use the ``knife bootstrap`` subcommand to run a bootstrap operation that installs the chef-client on the target system. The bootstrap operation must specify the IP address or FQDN of the target system.

.. end_tag

.. note:: .. tag notes_knife_bootstrap_on_windows

          To bootstrap the chef-client on Microsoft Windows machines, the :doc:`knife-windows <plugin_knife_windows>` plugins is required, which includes the necessary bootstrap scripts that are used to do the actual installation.

          .. end_tag

Syntax
=====================================================
.. tag knife_bootstrap_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife bootstrap FQDN_or_IP_ADDRESS (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 16_2

This subcommand has the following options:

``-A``, ``--forward-agent``
   Enable SSH agent forwarding.

``--bootstrap-curl-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using cURL. This option may not be used in the same command with ``--bootstrap-install-command``.

``--bootstrap-install-command COMMAND``
   Execute a custom installation command sequence for the chef-client. This option may not be used in the same command with ``--bootstrap-curl-options``, ``--bootstrap-install-sh``, or ``--bootstrap-wget-options``.

``--bootstrap-install-sh URL``
   Fetch and execute an installation script at the specified URL. This option may not be used in the same command with ``--bootstrap-install-command``.

``--bootstrap-no-proxy NO_PROXY_URL_or_IP``
   A URL or IP address that specifies a location that should not be proxied.

   .. note:: This option is used internally by Chef to help verify bootstrap operations during testing and should never be used during an actual bootstrap operation.

``--bootstrap-proxy PROXY_URL``
   The proxy server for the node that is the target of a bootstrap operation.

``--bootstrap-version VERSION``
   The version of the chef-client to install.

``--bootstrap-wget-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using GNU Wget. This option may not be used in the same command with ``--bootstrap-install-command``.

``-d DISTRO``, ``--distro DISTRO``
   .. tag knife_bootstrap_distro

   The template file to be used during a bootstrap operation. The following distributions are supported:

   * ``chef-full`` (the default bootstrap)
   * ``centos5-gems``
   * ``fedora13-gems``
   * ``ubuntu10.04-gems``
   * ``ubuntu10.04-apt``
   * ``ubuntu12.04-gems``
   * The name of a custom bootstrap template file.

   When this option is used, knife searches for the template file in the following order:

   #. The ``bootstrap/`` folder in the current working directory
   #. The ``bootstrap/`` folder in the chef-repo
   #. The ``bootstrap/`` folder in the ``~/.chef/`` directory
   #. A default bootstrap file.

   Do not use the ``--template-file`` option when ``--distro`` is specified.

   .. end_tag

   .. warning:: The default bootstrap operation uses the omnibus installer, which means the default template file (``chef-full``) should work on all supported platforms. It is recommended to use custom bootstrap templates only when the omnibus installer cannot be used. The ``.erb`` file extension is added automatically and should not be passed as part of the bootstrap command.

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

   The default directory in which hint files are located is ``/etc/chef/ohai/hints/``. Use the ``Ohai::Config[:hints_path]`` setting in the client.rb file to customize this location.

   .. end_tag

   ``HINT_FILE`` is the name of the JSON file. ``HINT_NAME`` is the name of a hint in a JSON file. Use multiple ``--hint`` options to specify multiple hints.

``-i IDENTITY_FILE``, ``--identity-file IDENTITY_FILE``
   The SSH identity file used for authentication. Key-based authentication is recommended.

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   A JSON string that is added to the first run of a chef-client.

``-N NAME``, ``--node-name NAME``
   The name of the node.

``--[no-]host-key-verify``
   Use ``--no-host-key-verify`` to disable host key verification. Default setting: ``--host-key-verify``.

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

``--template-file TEMPLATE``
   The path to a template file to be used during a bootstrap operation. Do not use the ``--distro`` option when ``--template-file`` is specified.

``--use-sudo-password``
   Perform a bootstrap operation with sudo; specify the password with the ``-P`` (or ``--ssh-password``) option.

``-V -V``
   Run the initial chef-client run at the ``debug`` log-level (e.g. ``chef-client -l debug``).

``-x USERNAME``, ``--ssh-user USERNAME``
   The SSH user name.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Custom Templates
=====================================================
.. tag 16_3

The ``chef-full`` distribution uses the omnibus installer. For most bootstrap operations, regardless of the platform on which the target node is running, using the ``chef-full`` distribution is the best approach for installing the chef-client on a target node. In some situations, using another supported distribution is necessary. And in some situations, a custom template may be required. For example, the default bootstrap operation relies on an Internet connection to get the distribution to the target node. If a target node cannot access the Internet, then a custom template can be used to define a specific location for the distribution so that the target node may access it during the bootstrap operation.

For example, a bootstrap template file named "british_sea_power":

.. code-block:: bash

   $ knife bootstrap 123.456.7.8 -x username -P password --sudo --distro "british_sea_power"

The following examples show how a bootstrap template file can be customized for various platforms.

.. end_tag

Template Locations
-----------------------------------------------------
.. tag 16_4

A custom bootstrap template file (``template_filename``) must be located in a ``bootstrap/`` directory, typically located within the ``~/.chef/`` directory.

Use the ``--distro`` option with the ``knife bootstrap`` subcommand to specify the bootstrap template file. This location is configurable when the following settings are added to the knife.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``knife[:distro]``
     - .. tag knife_bootstrap_distro

       The template file to be used during a bootstrap operation. The following distributions are supported:

       * ``chef-full`` (the default bootstrap)
       * ``centos5-gems``
       * ``fedora13-gems``
       * ``ubuntu10.04-gems``
       * ``ubuntu10.04-apt``
       * ``ubuntu12.04-gems``
       * The name of a custom bootstrap template file.

       When this option is used, knife searches for the template file in the following order:

       #. The ``bootstrap/`` folder in the current working directory
       #. The ``bootstrap/`` folder in the chef-repo
       #. The ``bootstrap/`` folder in the ``~/.chef/`` directory
       #. A default bootstrap file.

       Do not use the ``--template-file`` option when ``--distro`` is specified.

       .. end_tag

   * - ``knife[:template_file]``
     - The path to a template file to be used during a bootstrap operation. Do not use the ``--distro`` option when ``--template-file`` is specified.

.. end_tag

Ubuntu 12.04
-----------------------------------------------------
.. tag 16_summary

The following example shows how to modify the default script for Ubuntu 12.04. First, copy the bootstrap template from the default location. If the chef-client is installed from a RubyGems, the full path can be found in the gem contents:

.. code-block:: bash

   $ gem contents chef | grep ubuntu12.04-gems
   /Users/jtimberman/.rvm/gems/ruby-1.9.3-p180/gems/chef-0.10.2/lib/chef/knife/bootstrap/ubuntu12.04-gems.erb

Copy the template to the chef-repo in the ``.chef/bootstrap`` directory:

.. code-block:: bash

   $ cp /Users/jtimberman/.rvm/gems/ruby-1.9.3-p180/gems/chef-0.10.2/
      lib/chef/knife/bootstrap/ubuntu12.04-gems.erb ~/chef-repo/.chef/
      bootstrap/ubuntu12.04-gems-mine.erb

Modify the template with any editor, then specify it using the ``--distro`` option as part of the the ``knife bootstrap`` operation, or with any of the knife plug-ins that support cloud computing.

.. code-block:: bash

   $ knife bootstrap 192.168.1.100 -r 'role[webserver]' -distro ubuntu12.04-gems-mine

Alternatively, an example bootstrap template can be found in the git source for the chef-repo: https://github.com/chef/chef/tree/master/lib/chef/knife/bootstrap. Copy the template to ``~/.chef-repo/.chef/bootstrap/ubuntu12.04-apt.erb`` and modify the template appropriately.

.. end_tag

Debian and Apt
-----------------------------------------------------
.. tag 16

The following example shows how to use the ``knife bootstrap`` subcommand to create a client configuration file (/etc/chef/client.rb) that uses Hosted Chef as the Chef server. The configuration file will look something like:

.. code-block:: ruby

   log_level        :info
   log_location     STDOUT
   chef_server_url  'https://api.opscode.com/organizations/ORGNAME'
   validation_client_name 'ORGNAME-validator'

The ``knife bootstrap`` subcommand will look in three locations for the template that is used during the bootstrap operation. The locations are:

#. A bootstrap directory in the installed knife library; the actual location may vary, depending how the chef-client is installed
#. A bootstrap directory in the ``$PWD/.chef``, e.g. in ``~/chef-repo/.chef``
#. A bootstrap directory in the users ``$HOME/.chef``

If, in the example above, the second location was used, then create the ``.chef/bootstrap/`` directory in the chef-repo, and then create the Embedded Ruby (ERB) template file by running commands similar to the following:

.. code-block:: bash

   $ mkdir ~/.chef/bootstrap

and then:

.. code-block:: bash

   $ vi ~/.chef/bootstrap/debian5.0-apt.erb

When finished creating the directory and the Embedded Ruby (ERB) template file, edit the template to run the SSH commands. Then set up the validation certificate and the client configuration file.

Finally, run the chef-client on the node using a ``knife bootstrap`` command that specifies a run-list (the ``-r`` option). The bootstrap template can be called using a command similar to the following:

.. code-block:: bash

   $ knife bootstrap mynode.example.com -r 'role[webserver]','role[production]' --distro debian5.0-apt

.. end_tag

Microsoft Windows
-----------------------------------------------------
.. tag 16_1

The following example shows how to modify the default script for Microsoft Windows and Windows PowerShell:

..   # Moved this license/header info out of the code sample; keeping it in the topic just because
..   @rem
..   @rem Author:: Seth Chisamore (<schisamo@opscode.com>)
..   @rem Author:: Michael Goetz (<mpgoetz@opscode.com>)
..   @rem Author:: Julian Dunn (<jdunn@opscode.com>)
..   @rem Copyright:: Copyright (c) 2011-2013 Opscode, Inc.
..   @rem License:: Apache License, Version 2.0
..   @rem
..   @rem Licensed under the Apache License, Version 2.0 (the "License");
..   @rem you may not use this file except in compliance with the License.
..   @rem You may obtain a copy of the License at
..   @rem
..   @rem     http://www.apache.org/licenses/LICENSE-2.0
..   @rem
..   @rem Unless required by applicable law or agreed to in writing, software
..   @rem distributed under the License is distributed on an "AS IS" BASIS,
..   @rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
..   @rem See the License for the specific language governing permissions and
..   @rem limitations under the License.
..   @rem

.. code-block:: bash

   @setlocal

   <%= "SETX HTTP_PROXY \"#{knife_config[:bootstrap_proxy]}\"" if knife_config[:bootstrap_proxy] %>
   @mkdir <%= bootstrap_directory %>

   > <%= bootstrap_directory %>\wget.ps1 (
    <%= win_wget_ps %>
   )

   :install
   @rem Install Chef using chef-client MSI installer

   <% url="http://reposerver.example.com/chef-client-11.6.0.rc.1-1.windows.msi" -%>
   @set "REMOTE_SOURCE_MSI_URL=<%= url %>"
   @set "LOCAL_DESTINATION_MSI_PATH=<%= local_download_path %>"

   @powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive "& '<%= bootstrap_directory %>\wget.ps1' '%REMOTE_SOURCE_MSI_URL%' '%LOCAL_DESTINATION_MSI_PATH%'"

   @REM Replace install_chef from knife-windows Gem with one that has extra flags to turn on Chef service feature -- only available in Chef >= 11.6.x
   @REM <%= install_chef %>
   @echo Installing Chef Client 11.6.0.rc1 with msiexec
   @msiexec /q /i "%LOCAL_DESTINATION_MSI_PATH%" ADDLOCAL="ChefClientFeature,ChefServiceFeature"
   @endlocal

   @echo Writing validation key...

   > <%= bootstrap_directory %>\validation.pem (
    <%= validation_key %>
   )

   @echo Validation key written.

   <% if @config[:encrypted_data_bag_secret] -%>
   > <%= bootstrap_directory %>\encrypted_data_bag_secret (
    <%= encrypted_data_bag_secret %>
   )
   <% end -%>

   > <%= bootstrap_directory %>\client.rb (
    <%= config_content %>
   )

   > <%= bootstrap_directory %>\first-boot.json (
    <%= run_list %>
   )

   <%= start_chef %>

.. end_tag

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Bootstrap a node**

.. tag knife_bootstrap_node

.. To bootstrap a node:

.. code-block:: bash

   $ knife bootstrap 12.34.56.789 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]'

which shows something similar to:

.. code-block:: none

   ...
   12.34.56.789 Chef Client finished, 12/12 resources updated in 78.942455583 seconds

Use ``knife node show`` to verify:

.. code-block:: bash

   $ knife node show debian-wheezy.int.domain.org

which returns something similar to:

.. code-block:: none

   Node Name:   debian-wheezy.int.domain.org
   Environment: _default
   FQDN:        debian-wheezy.int.domain.org
   IP:          12.34.56.789
   Run List:    recipe[apt], recipe[xfs], recipe[vim]
   Roles:
   Recipes:     apt, xfs, vim, apt::default, xfs::default, vim::default
   Platform:    debian 7.4
   Tags:

.. end_tag

**Use an SSH password**

.. tag knife_bootstrap_use_ssh_password

.. To pass an SSH password as part of the command:

.. code-block:: bash

   $ knife bootstrap 192.168.1.1 -x username -P PASSWORD --sudo

.. end_tag

**Use a file that contains a private key**

.. tag knife_bootstrap_use_file_with_private_key

.. To use a file that contains a private key:

.. code-block:: bash

   $ knife bootstrap 192.168.1.1 -x username -i ~/.ssh/id_rsa --sudo

.. end_tag

**Fetch and execute an installation script from a URL**

.. tag knife_bootstrap_fetch_install_script_from_url

.. To fetch and execute an installation script from a URL:

.. code-block:: bash

   $ knife bootstrap --bootstrap-install-sh http://mycustomserver.com/custom_install_chef_script.sh

.. end_tag

**Specify options when using cURL**

.. tag knife_bootstrap_options_with_curl

.. To specify options when using cURL:

.. code-block:: bash

   $ knife bootstrap --bootstrap-curl-options "--proxy http://myproxy.com:8080"

.. end_tag

**Specify options when using GNU Wget**

.. tag knife_bootstrap_options_with_gnu_wget

.. To specify options when using GNU Wget:

.. code-block:: bash

   $ knife bootstrap --bootstrap-wget-options "-e use_proxy=yes -e http://myproxy.com:8080"

.. end_tag

**Specify a custom installation command sequence**

.. tag knife_bootstrap_custom_install_command_sequence

.. To specify a custom installation command sequence:

.. code-block:: bash

   $ knife bootstrap --bootstrap-install-command "curl -l http://mycustomserver.com/custom_install_chef_script.sh | sudo bash -s --"

.. end_tag

