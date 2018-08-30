=====================================================
knife bootstrap
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_bootstrap.rst>`__

.. tag chef_client_bootstrap_node

A node is any physical, virtual, or cloud machine that is configured to be maintained by a chef-client. In order to bootstrap a node, you will first need a working installation of the `Chef software package </packages.html>`__. A bootstrap is a process that installs the chef-client on a target system so that it can run as a chef-client and communicate with a Chef server. There are two ways to do this:

* Use the ``knife bootstrap`` subcommand to `bootstrap a node using the Chef installer </install_bootstrap.html>`__
* Use an unattended install to bootstrap a node from itself, without using SSH or WinRM

.. end_tag

.. tag knife_bootstrap_summary

Use the ``knife bootstrap`` subcommand to run a bootstrap operation that installs the chef-client on the target system. The bootstrap operation must specify the IP address or FQDN of the target system.

.. end_tag

**Considerations:**

* As of Chef 12.8 you can create a ``.chef/client.d`` directory on your workstation and the contents of that ``client.d`` directory will be copied to the system being bootstrapped by the ``knife bootstrap`` command. You can also set the ``client_d_dir`` option in ``knife.rb`` to point to an arbitrary directory instead of ``.chef/client.d``, and the contents of that directory will be copied to the system being bootstrapped. All config files inside ``client.d`` directory get copied into ``/etc/chef/client.d`` on the system being bootstrapped.

* Starting with Chef 12.0, use the `knife ssl fetch </knife_ssl_fetch.html>`__ command to pull down the SSL certificates from the on-premises Chef server and add them to the ``/trusted_certs_dir`` on the workstation. These certificates are used during a ``knife bootstrap`` operation.

* To bootstrap the Chef Client on Microsoft Windows machines, the `knife-windows </plugin_knife_windows.html>`__ plugin is required.

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

          Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

          .. end_tag

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

          See `knife.rb </config_rb_knife_optional_settings.html>`__ for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Validatorless Bootstrap
-----------------------------------------------------
.. tag knife_bootstrap_no_validator

The ORGANIZATION-validator.pem is typically added to the .chef directory on the workstation. When a node is bootstrapped from that workstation, the ORGANIZATION-validator.pem is used to authenticate the newly-created node to the Chef server during the initial chef-client run. Starting with Chef client 12.1, it is possible to bootstrap a node using the USER.pem file instead of the ORGANIZATION-validator.pem file. This is known as a "validatorless bootstrap".

To create a node via the USER.pem file, simply delete the ORGANIZATION-validator.pem file on the workstation. For example:

.. code-block:: bash

   $ rm -f /home/lamont/.chef/myorg-validator.pem

and then make the following changes in the knife.rb file:

* Remove the ``validation_client_name`` setting
* Edit the ``validation_key`` setting to be something that isn't a path to an existent ORGANIZATION-validator.pem file. For example: ``/nonexist``.

As long as a USER.pem is also present on the workstation from which the validatorless bootstrap operation will be initiated, the bootstrap operation will run and will use the USER.pem file instead of the ORGANIZATION-validator.pem file.

When running a validatorless ``knife bootstrap`` operation, the output is similar to:

.. code-block:: bash

   desktop% knife bootstrap 10.1.1.1 -N foo01.acme.org \
     -E dev -r 'role[base]' -j '{ "foo": "bar" }' \
     --ssh-user vagrant --sudo
   Node foo01.acme.org exists, overwrite it? (Y/N)
   Client foo01.acme.org exists, overwrite it? (Y/N)
   Creating new client for foo01.acme.org
   Creating new node for foo01.acme.org
   Connecting to 10.1.1.1
   10.1.1.1 Starting first Chef Client run...
   [....etc...]

.. end_tag

``knife bootstrap`` Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_vault_knife_bootstrap_options

Use the following options with a validatorless bootstrap to specify items that are stored in``chef-vault``:

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

.. end_tag

.. note:: The ``--node-name`` option is required for a validatorless bootstrap (Changed in Chef Client 12.4).

FIPS Mode
-----------------------------------------------------
.. tag fips_intro_client

Federal Information Processing Standards (FIPS) is a United States government computer security standard that specifies security requirements for cryptography. The current version of the standard is FIPS 140-2. The chef-client can be configured to allow OpenSSL to enforce FIPS-validated security during a chef-client run. This will disable cryptography that is explicitly disallowed in FIPS-validated software, including certain ciphers and hashing algorithms. Any attempt to use any disallowed cryptography will cause the chef-client to throw an exception during a chef-client run.

.. note:: Chef uses MD5 hashes to uniquely identify files that are stored on the Chef server. MD5 is used only to generate a unique hash identifier and is not used for any cryptographic purpose.

Notes about FIPS:

* May be enabled for nodes running on Microsoft Windows and Enterprise Linux platforms
* Should only be enabled for environments that require FIPS 140-2 compliance
* May not be enabled for any version of the chef-client earlier than 12.8

.. end_tag

**Bootstrap a node using FIPS**

.. tag knife_bootstrap_node_fips

.. To bootstrap a node:

.. code-block:: bash

   $ knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]' --fips

which shows something similar to:

.. code-block:: none

   OpenSSL FIPS 140 mode enabled
   ...
   192.0.2.0 Chef Client finished, 12/12 resources updated in 78.942455583 seconds

.. end_tag

Custom Templates
=====================================================
.. tag knife_bootstrap_template

The default ``chef-full`` template uses the Chef installer. For most bootstrap operations, regardless of the platform on which the target node is running, using the ``chef-full`` distribution is the best approach for installing the chef-client on a target node. In some situations, a custom template may be required.

For example, the default bootstrap operation relies on an Internet connection to get the distribution to the target node. If a target node cannot access the Internet, then a custom template can be used to define a specific location for the distribution so that the target node may access it during the bootstrap operation. The example below will show you how to create a bootstrap template that uses a custom artifact store for Chef packages and installation scripts, as well as a RubyGem mirror:

#. A custom bootstrap template file must be located in a ``bootstrap/`` directory, which is typically located within the ``~/.chef/`` directory on the local workstation. Navigate to the ``.chef`` directory, and create a ``bootstrap`` directory within it:

   .. code-block:: bash

      mkdir bootstrap

#. Move to the ``bootstrap`` directory and create a blank template file; this example will use ``template.erb`` for the template name:

   .. code-block:: bash

      touch template.erb

#. Still in the ``bootstrap`` directory, issue the following command to copy the ``chef-full`` configuration to your new template:

   .. code-block:: bash

      find /opt/chefdk/embedded/lib/ruby -type f -name chef-full.erb -exec cat {} \; > template.erb

   This command searches for the ``chef-full`` template file under ``/opt/chefdk/embedded/lib/ruby``, and then outputs the contents of the file to ``template.erb``. If you used a different template file name, be sure to replace ``template.erb`` with the template file you created during the last step.

#. Update ``template.erb`` to replace ``omnitruck.chef.io`` with the URL of an ``install.sh`` script on your artifact store:

   .. code-block:: ruby

      install_sh="<%= knife_config[:bootstrap_url] ? knife_config[:bootstrap_url] : "http://packages.example.com/install.sh" %>"

#. Still in your text editor, locate the following line near the bottom of your ``template.erb`` file:

   .. code-block:: ruby

      cat > /etc/chef/client.rb <<'EOP'
      <%= config_content %>
      EOP

   Beneath it, add the following, replacing ``gems.example.com`` with the URL of your gem mirror:

   .. code-block:: ruby

      cat >> /etc/chef/client.rb <<'EOP'
      rubygems_url "http://gems.example.com"
      EOP

   This appends the appropriate ``rubygems_url`` setting to the ``/etc/chef/client.rb`` file that is created during bootstrap, which ensures that your nodes use your internal gem mirror.

.. end_tag

Bootstrap a Custom Template
-----------------------------------------------------
You can use the ``--bootstrap-template`` option with the ``knife bootstrap`` subcommand to specify the name of your bootstrap template file:

.. code-block:: bash

   $ knife bootstrap 123.456.7.8 -x username -P password --sudo --bootstrap-template "template"

Alternatively, you can use the ``knife[:bootstrap_template]`` option within ``knife.rb`` to specify the template that ``knife bootstrap`` will use by default when bootstrapping a node. It should point to your custom template within the ``bootstrap`` directory:

.. code-block:: ruby

   knife[:bootstrap_template] = "#{current_dir}/bootstrap/template.erb"

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Bootstrap a node**

.. To bootstrap a node:

.. code-block:: bash

   $ knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]'

which shows something similar to:

.. code-block:: none

   ...
   192.0.2.0 Chef Client finished, 12/12 resources updated in 78.942455583 seconds

Use ``knife node show`` to verify:

.. code-block:: bash

   $ knife node show debian-wheezy.int.domain.org

which returns something similar to:

.. code-block:: none

   Node Name:   debian-wheezy.int.domain.org
   Environment: _default
   FQDN:        debian-wheezy.int.domain.org
   IP:          192.0.2.0
   Run List:    recipe[apt], recipe[xfs], recipe[vim]
   Roles:
   Recipes:     apt, xfs, vim, apt::default, xfs::default, vim::default
   Platform:    debian 7.4
   Tags:

**Use an SSH password**

.. To pass an SSH password as part of the command:

.. code-block:: bash

   $ knife bootstrap 192.0.2.0 -x username -P PASSWORD --sudo

**Use a file that contains a private key**

.. To use a file that contains a private key:

.. code-block:: bash

   $ knife bootstrap 192.0.2.0 -x username -i ~/.ssh/id_rsa --sudo

**Specify options when using cURL**

.. To specify options when using cURL:

.. code-block:: bash

   $ knife bootstrap --bootstrap-curl-options "--proxy http://myproxy.com:8080"

**Specify options when using GNU Wget**

.. To specify options when using GNU Wget:

.. code-block:: bash

   $ knife bootstrap --bootstrap-wget-options "-e use_proxy=yes -e http://myproxy.com:8080"

**Specify a custom installation command sequence**

.. To specify a custom installation command sequence:

.. code-block:: bash

   $ knife bootstrap --bootstrap-install-command "curl -l http://mycustomserver.com/custom_install_chef_script.sh | sudo bash -s --"
