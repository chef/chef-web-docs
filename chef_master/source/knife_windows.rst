=====================================================
Knife Windows
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_windows.rst>`__

Knife Windows Overview
=====================================================
.. tag knife_windows_summary

The ``knife windows`` subcommand is used to configure and interact with nodes that exist on server and/or desktop machines that are running Microsoft Windows. Nodes are configured using WinRM, which allows native objects---batch scripts, Windows PowerShell scripts, or scripting library variables---to be called by external applications. The ``knife windows`` subcommand supports NTLM and Kerberos methods of authentication.

.. end_tag

.. note:: Review the list of `common options </knife_options.html>`__ available to this (and all) knife subcommands and plugins.

Install Knife Windows
------------------------------------------------------
.. tag knife_windows_install_rubygem

To install the ``knife windows`` plugin using RubyGems, run the following command:

.. code-block:: bash

   $ /opt/chef/embedded/bin/gem install knife-windows

where ``/opt/chef/embedded/bin/`` is the path to the location where the chef-client expects knife plugins to be located. If the chef-client was installed using RubyGems, omit the path in the previous example.

.. end_tag

Requirements
------------------------------------------------------
.. tag knife_windows_winrm_requirements

This subcommand requires WinRM to be installed, and then configured correctly, including ensuring the correct ports are open. For more information, see: https://docs.microsoft.com/en-us/windows/desktop/WinRM/installation-and-configuration-for-windows-remote-management and/or https://support.microsoft.com/en-us/help/968930/windows-management-framework-core-package-windows-powershell-2-0-and-w. Use the quick configuration option in WinRM to allow outside connections and the entire network path from knife (and the workstation):

.. code-block:: bash

   $ winrm quickconfig -q

The following WinRM configuration settings should be updated:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``MaxMemoryPerShellMB``
     - The chef-client and Ohai typically require more memory than the default setting allows. Increase this value to ``300MB``. Only required on Windows Server 2008 R2 Standard and older. The default in Windows Server 2012 was increased to ``1024MB``.
   * - ``MaxTimeoutms``
     - A bootstrap command can take longer than allowed by the default setting. Increase this value to ``1800000`` (30 minutes).

To update these settings, run the following commands:

.. code-block:: bash

   $ winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'

and then:

.. code-block:: bash

   $ winrm set winrm/config '@{MaxTimeoutms="1800000"}'

Ensure that the Windows Firewall is configured to allow WinRM connections between the workstation and the Chef server. For example:

.. code-block:: bash

   $ netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" profile=public protocol=tcp localport=5985 remoteip=localsubnet new remoteip=any

.. end_tag

Negotiate, NTLM
-----------------------------------------------------
.. tag knife_windows_winrm_requirements_nltm

When knife is executed from a Microsoft Windows system, it is no longer necessary to make additional configuration of the WinRM listener on the target node to enable successful authentication from the workstation. It is sufficient to have a WinRM listener on the remote node configured to use the default configuration for ``winrm quickconfig``. This is because ``knife windows`` supports the Microsoft Windows negotiate protocol, including NTLM authentication, which matches the authentication requirements for the default configuration of the WinRM listener.

.. note:: To use Negotiate or NTLM to authenticate as the user specified by the ``--winrm-user`` option, include the user's Microsoft Windows domain, using the format ``domain\user``, where the backslash (``\``) separates the domain from the user.

For example:

.. code-block:: bash

   $ knife bootstrap windows winrm web1.cloudapp.net -r 'server::web' -x 'proddomain\webuser' -P 'password'

and:

.. code-block:: bash

   $ knife bootstrap windows winrm db1.cloudapp.net -r 'server::db' -x '.\localadmin' -P 'password'

.. end_tag

Domain Authentication
-----------------------------------------------------
.. tag knife_windows_winrm_domain_authentication

The ``knife windows`` plugin supports Microsoft Windows domain authentication. This requires:

* An SSL certificate on the target node
* The certificate details can be viewed and its `thumbprint hex values copied <https://docs.microsoft.com/en-us/dotnet/framework/wcf/feature-details/how-to-view-certificates-with-the-mmc-snap-in>`_

To create the listener over HTTPS, run the following command:

.. code-block:: bash

   $ winrm create winrm/config/Listener?Address=IP:<ip_address>+Transport=HTTPS @{Hostname="<fqdn>";CertificateThumbprint="<hexidecimal_thumbprint_value>"}

where the ``CertificateThumbprint`` is the thumbprint hex value copied from the certificate details. (The hex value may require that spaces be removed before passing them to the node using the ``knife windows`` plugin.) WinRM 2.0 uses port ``5985`` for HTTP and port ``5986`` for HTTPS traffic, by default.

To bootstrap the target node using the ``knife bootstrap`` subcommand, first use the ``winrm`` argument in the ``knife windows`` plugin to verify communication with the node:

.. code-block:: bash

   $ knife winrm 'node1.domain.com' 'dir' -m -x domain\\administrator -P 'super_secret_password' –p 5986

and then run a command similar to the following:

.. code-block:: bash

   $ knife bootstrap windows winrm 'node1.domain.com' -r 'role[webserver]' -x domain\\administrator -P 'password' -p 5986

.. end_tag

bootstrap windows ssh
=====================================================
.. tag knife_windows_bootstrap_windows_ssh

Use the ``bootstrap windows ssh`` argument to bootstrap chef-client installations in a Microsoft Windows environment, using a command shell that is native to Microsoft Windows.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_windows_bootstrap_windows_ssh_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife bootstrap windows ssh (options)

.. end_tag

.. warning:: .. tag knife_common_windows_ampersand

             When running knife in Microsoft Windows, an ampersand (``&``) is a special character and must be protected by quotes when it appears in a command. The number of quotes to use depends on the shell from which the command is being run.

             When running knife from the command prompt, an ampersand should be surrounded by quotes (``"&"``). For example:

             .. code-block:: bash

                $ knife bootstrap windows winrm -P "&s0meth1ng"

             When running knife from Windows PowerShell, an ampersand should be surrounded by triple quotes (``"""&"""``). For example:

             .. code-block:: bash

                $ knife bootstrap windows winrm -P """&s0meth1ng"""

             .. end_tag

Options
-----------------------------------------------------

This argument has the following options:

``-A``, ``--forward-agent``
    Enables SSH agent forwarding.

``--auth-timeout MINUTES``
    The maximum time in minutes to wait to for authentication over the transport to the node to succeed. Default: ``2``.

``--bootstrap-install-command COMMANDS``
    Custom command to install chef-client

``--bootstrap-no-proxy [NO_PROXY_URL|NO_PROXY_IP]``
    A URL or IP address that specifies a location that should not be proxied.

``--bootstrap-proxy PROXY_URL``
    The proxy server for the node that is the target of a bootstrap operation.

``--bootstrap-vault-file VAULT_FILE``
    A JSON file with a list of vault(s) and item(s) to be updated.

``--bootstrap-vault-item VAULT_ITEM``
    A single vault and item to update as ``vault:item``.

``--bootstrap-vault-json VAULT_JSON``
  A JSON string with the vault(s) and item(s) to be updated.

``--bootstrap-version VERSION``
    The version of the Chef Client to install.

``--chef-zero-host HOST``
    Host for starting chef-zero.

``--chef-zero-port PORT``
    Port or port range for starting chef-zero. Port ranges such as 100,1010 or 889-999, will try all given ports until one works.

``--[no-]color``
    Use color output. Default: enabled.

``-c``, ``--config CONFIG``
    Location of the configuration file.

``--config-option OPTION=VALUE``
    Override a single configuration option.

``--defaults``
    Accept default values for all questions.

``--disable-editing``
    Accept data without opening an editor.

``-e``, ``--editor EDITOR``
    Set the editor for use with interactive commands.

``-E``, ``--environment ENVIRONMENT``
    Set the Chef environment. This will be ignored in searches.

``-F``, ``--format FORMAT``
    Define the output format.

``-G GATEWAY``, ``--ssh-gateway GATEWAY``
    The SSH tunnel or gateway that is used to run a bootstrap action on a machine that is not accessible from the workstation.

``-h``, ``--help``
    Show all options.

``--hint HINT_NAME[=HINT_FILE]``
    Specify Ohai Hint to be set on the bootstrap targeting multiple nodes. See ``--hint options`` to specify multiple hints.

``--[no]host-key-verify``
    Use to disable host key verification. Default: ``true``.

``-i IDENTITY FILE``, ``--ssh-identity-file IDENTITY_FILE``
    The SSH identity file used for authentication. Key-based authentication is recommended.

``--install-as-service``
    Install the Chef Client as a Windows service. Default: ``false``.

``-j JSON_ATTRIBS``, ``--json-attributes``
    A JSON string that is added to the first Chef Client run.

``--json-attribute-file FILE``
    A JSON file that is used in the first Chef Client run.

``-k``, ``--key KEY``
    API client key.

``[no-]listen``
    Define if a local mode (-z) server binds to a port.

``--msi-url URL``
    Location of the Chef Client MSI. The default templates prefer to download from this location. The MSI will be downloaded from chef.io if not provided.

``-N NAME``, ``--node-name NAME``
    The name of the node.

``--node-ssl-verify-mode [peer|none]``
    Whether or not to verify the SSL cert for all requests.

``--[no-]node-verify-api-cert``
    Verify the SSL cert for HTTPS requests to the Chef sAPI. Default: ``true``.

``-p PORT``, ``--ssh-port PORT``
    The SSH port.

``-P PASSWORD``, ``ssh-password PASSWORD``
    The SSH password. Use to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.

``--policy-group POLICY_GROUP``
    Policy group name to use (``--policy-name`` must also be given).

``--policy-name POLICY_NAME``
    Policyfile name to use (``--policy-group`` must also be given).

``--prerelease``
    Install the pre-release chef gems.

``--print-after``
    Show data after a destructive action.

``--profile PROFILE``
    Selects a credential profile

``-r RUN_LIST``, ``--run-list RUN_LIST``
    Comma separated list of roles/recipes to apply. Default:[].

``-s SECRET``, ``--secret``
    The encryption key that is used for values contained within a data bag item.

``--secret-file SECRET_FILE``
    A file containing the secret key to use to encrypt data bag item values. Will be rendered on the node at ``c:/chef/encrypted_data_bag_secret`` and set in the rendered client config.

``--server-url URL``
    Chef Server URL.

``--tags``
    Comma separated list of tags to apply to the node. default: [].

``-t TEMPLATE``, ``--bootstrap-template TEMPLATE``
    Bootstrap Chef using a built-in or custom template. Set to the full path of an erb template or use one of the built-in templates.

``-u``, ``--user USER``
    API client username.

``-V``, ``--verbose``
    More verbose output. Use twice for maximum verbosity.

``-v``, ``--version``
    Show chef version.

``-x USERNAME``, ``--ssh-user USERNAME``
    The SSH username. Default: ``root``.

``-y``, ``--yes``
    Say "yes" to all confirmation prompts.

``-z``, ``--local-mode``
    Points knife commands at local repository instead of server.

bootstrap windows winrm
=====================================================
Use the ``bootstrap windows winrm`` argument to bootstrap chef-client installations in a Microsoft Windows environment, using WinRM and the WS-Management protocol for communication. This argument requires the FQDN of the host machine to be specified. The Microsoft Installer Package (MSI) run silently during the bootstrap operation (using the ``/qn`` option).

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife bootstrap windows winrm FQDN

.. warning:: .. tag knife_common_windows_ampersand

             When running knife in Microsoft Windows, an ampersand (``&``) is a special character and must be protected by quotes when it appears in a command. The number of quotes to use depends on the shell from which the command is being run.

             When running knife from the command prompt, an ampersand should be surrounded by quotes (``"&"``). For example:

             .. code-block:: bash

                $ knife bootstrap windows winrm -P "&s0meth1ng"

             When running knife from Windows PowerShell, an ampersand should be surrounded by triple quotes (``"""&"""``). For example:

             .. code-block:: bash

                $ knife bootstrap windows winrm -P """&s0meth1ng"""

             .. end_tag

Options
-----------------------------------------------------
This argument has the following options:

``-a``, ``--attribute ATTR``
    The attribute to use for opening the connection. Default: ``fqdn``

``--auth-timeout MINUTES``,
   The amount of time (in minutes) to wait for authentication to succeed. Default: ``2``.

``--bootstrap-install-command COMMANDS``
    Custom command to install chef-client.

``--bootstrap-no-proxy NO_PROXY_URL_or_IP``
   A URL or IP address that specifies a location that should not be proxied.

``--bootstrap-proxy PROXY_URL``
   The proxy server for the node that is the target of a bootstrap operation.


``--bootstrap-vault-file VAULT_FILE``
    A JSON file with a list of vault(s) and item(s) to be updated.

``--bootstrap-vault-item VAULT_ITEM``
    A single vault and item to update as ``vault:item``.

``--bootstrap-vault-json VAULT_JSON``
  A JSON string with the vault(s) and item(s) to be updated.

``--bootstrap-version VERSION``
   The version of the chef-client to install.

``--chef-zero-host HOST``
    Host for starting chef-zero.

``--chef-zero-port PORT``
    Port or port range for starting chef-zero. Port ranges such as 100,1010 or 889-999, will try all given ports until one works.

``--[no-]color``
    Use color output. Default: enabled.

``-c``, ``--config CONFIG``
    Location of the configuration file.

``-C``, ``--concurrency NUM``
    The number of allowed concurrent connections

``--config-option OPTION=VALUE``
    Override a single configuration option.

``--defaults``
    Accept default values for all questions.

``--disable-editing``
    Accept data without opening an editor.

``-e``, ``--editor EDITOR``
    Set the editor for use with interactive commands.

``-E``, ``--environment ENVIRONMENT``
    Set the Chef environment. This will be ignored in searches.

``-f CA_TRUST_FILE``, ``--ca-trust-file``
    The Certificate Authority (CA) trust file used for SSL transport

``-F``, ``--format FORMAT``
    Define the output format.

``-h``, ``--help``
    Show all options.

``--hint HINT_NAME[=HINT_FILE]``
    Specify Ohai Hint to be set on the bootstrap targeting multiple nodes. See ``--hint options`` to specify multiple hints.

``--[no]host-key-verify``
    Use to disable host key verification. Default: ``true``.

``--install-as-service``
   Indicates the client should be installed as a Windows Service.

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   A JSON string that is added to the first run of a chef-client.

``-k``, ``--key KEY``
    API client key.

``[no-]listen``
    Define if a local mode (-z) server binds to a port.

``--msi-url URL``
    Location of the Chef Client MSI. The default templates prefer to download from this location. The MSI will be downloaded from chef.io if not provided.

``-m``, ``--manual-list`` 
    Query returns a space separated list of servers

``-N NAME``, ``--node-name NAME``
   The name of the node.

``--node-ssl-verify-mode [peer|none]``
    Whether or not to verify the SSL cert for all requests.

``--[no-]node-verify-api-cert``
    Verify the SSL cert for HTTPS requests to the Chef sAPI. Default: ``true``.

``-p PORT``, ``--winrm-port PORT``
    The WinRM port.  Defaults: ``5985`` for ``plaintext`` and ``5986`` for ``ssl`` WinRM transport

``-P PASSWORD``, ``winrm-password PASSWORD``
    The WinRM password.

``--policy-group POLICY_GROUP``
    Policy group name to use (``--policy-name`` must also be given).

``--policy-name POLICY_NAME``
    Policyfile name to use (``--policy-group`` must also be given).

``--prerelease``
   Install pre-release gems.

``--print-after``
    Show data after a destructive action.

``--profile PROFILE``
    Selects a credential profile

``-r RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``-R KERBEROS_REALM``, ``--kerberos-realm``
    The Kerberos realm used for authentication

``-s SECRET``, ``--secret``
   The encryption key that is used for values contained within a data bag item.

``-S KERBEROS_SERVICE``, ``--kerberos-service``
    The Kerberos service used for authentication

``--secret-file SECRET_FILE``
   The path to the file that contains the encryption key.

``--server-url URL``
    Chef Server URL.

``--session-timeout MINUTES``
    The timeout for the client for the maximum length of the WinRM session

``--ssl-peer-fingerprint FINGERPRINT``
    SSL certificate fingerprint to bypass normal certificate chain checks.

``-t TEMPLATE``, ``--bootstrap-template TEMPLATE``
    Bootstrap Chef using a built-in or custom template. Set to the full path of an erb template or use one of the built-in templates.

``-T``, ``--keytab-file KEYTAB_FILE``
    The Kerberos keytab file used for authentication.

``--tags``
    Comma separated list of tags to apply to the node. default: [].

``-u``, ``--user USER``
    API client username.

``-V``, ``--verbose``
    More verbose output. Use twice for maximum verbosity.

``-v``, ``--version``
    Show chef version.

``-w``, ``--winrm-transport TRANSPORT`` 
    The WinRM transport type. Values: ``ssl``, ``plaintext``

``--winrm-authentication-protocol AUTHENTICATION_PROTOCOL``
    The authentication protocol used during WinRM communication. The supported protocols are basic,negotiate,kerberos. Default is 'negotiate'.

``--winrm-codepage CODEPAGE``
    The codepage to use for the winrm cmd shell

``--winrm-shell SHELL``
      The WinRM shell type. Values: ``cmd``, ``powershell``, ``elevated``. ``elevated`` runs powershell in a scheduled task

``--winrm-ssl-verify-mode SSL_VERIFY_MODE``
    The WinRM peer verification mode. Values: ``verify_peer``, ``verify_none``

``-x USERNAME``, ``--ssh-user USERNAME``
    The SSH username. Default: ``root``.

``-y``, ``--yes``
    Say "yes" to all confirmation prompts.

``-z``, ``--local-mode``
    Points knife commands at local repository instead of server.

cert generate
=====================================================
Use the ``cert generate`` argument to generate certificates for use with WinRM SSL listeners. This argument also generates a related public key file (in .pem format) to validate communication between listeners that are configured to use the generated certificate.

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife windows cert generate FILE_PATH (options)

Options
-----------------------------------------------------
This argument has the following options:

``-cp PASSWORD``, ``--cert-passphrase PASSWORD``
   The password for the SSL certificate.

``-cv MONTHS``, ``--cert-validity MONTHS``
   The number of months for which a certificate is valid. Default value: ``24``.

``-h HOST_NAME``, ``--hostname HOST_NAME``
   The hostname for the listener. For example, ``--hostname something.mydomain.com`` or ``*.mydomain.com``. Default value: ``*``.

``-k LENGTH``, ``--key-length LENGTH``
   The length of the key. Default value: ``2048``.

``-o PATH``, ``--output-file PATH``
   The location in which the ``winrmcert.b64``, ``winrmcert.pem``, and ``winrmcert.pfx`` files are generated. For example: ``--output-file /home/.winrm/server_cert`` will create ``server_cert.b64``, ``server_cert.pem``, and ``server_cert.pfx`` in the ``server_cert`` directory. Default location: ``current_directory/winrmcert``.

cert install
=====================================================
Use the ``cert install`` argument to install a certificate (such as one generated by the ``cert generate`` argument) into the Microsoft Windows certificate store so that it may be used as the SSL certificate by a WinRM listener.

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife windows cert install CERT [CERT] (options)

Options
-----------------------------------------------------
This argument has the following options:

``-cp PASSWORD``, ``--cert-passphrase PASSWORD``
   The password for the SSL certificate.

listener create
=====================================================
Use the ``listener create`` argument to create a WinRM listener on the Microsoft Windows platform.

.. note:: This command may only be used on the Microsoft Windows platform.

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife windows listener create (options)

Options
-----------------------------------------------------
This argument has the following options:

``-c CERT_PATH``, ``--cert-install CERT_PATH``
   Add the specified certificate to the store before creating the listener.

``-cp PASSWORD``, ``--cert-passphrase PASSWORD``
   The password for the SSL certificate.

``-h HOST_NAME``, ``--hostname HOST_NAME``
   The hostname for the listener. For example, ``--hostname something.mydomain.com`` or ``*.mydomain.com``. Default value: ``*``.

``-p PORT``, ``--port PORT``
   The WinRM port. Default value: ``5986``.

``-t THUMBPRINT``, ``--cert-thumbprint THUMBPRINT``
   The thumbprint of the SSL certificate. Required when the ``--cert-install`` option is not part of a command.

winrm
=====================================================
.. tag knife_windows_winrm

Use the ``winrm`` argument to create a connection to one or more remote machines. As each connection is created, a password must be provided. This argument uses the same syntax as the ``search`` subcommand.

.. end_tag

.. tag knife_windows_winrm_ports

WinRM requires that a target node be accessible via the ports configured to support access via HTTP or HTTPS.

.. end_tag

Syntax
-----------------------------------------------------
.. tag knife_windows_winrm_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife winrm SEARCH_QUERY SSH_COMMAND (options)

.. end_tag

Options
-----------------------------------------------------
.. tag knife_windows_winrm_options

This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute used when opening an SSH connection. The default attribute is the FQDN of the host. Other possible values include a public IP address, a private IP address, or a hostname.

``-f CA_TRUST_FILE``, ``--ca-trust-file CA_TRUST_FILE``
   Optional. The certificate authority (CA) trust file used for SSL transport.

``-C NUM``, ``--concurrency NUM``
   Changed in knife-windows 1.9.0.
   The number of allowed concurrent connections. Defaults to 1.

``-i IDENTITY_FILE``, ``--identity-file IDENTITY_FILE``
   The keytab file that contains the encryption key required by Kerberos-based authentication.

``--keytab-file KEYTAB_FILE``
   The keytab file that contains the encryption key required by Kerberos-based authentication.

``-m``, ``--manual-list``
   Define a search query as a space-separated list of servers.

``-p PORT``, ``--winrm-port PORT``
   The WinRM port. The TCP port on the remote system to which ``knife windows`` commands that are made using WinRM are sent. Default: ``5986`` when ``--winrm-transport`` is set to ``ssl``, otherwise ``5985``.

``-P PASSWORD``, ``--winrm-password PASSWORD``
   The WinRM password.

``-R KERBEROS_REALM``, ``--kerberos-realm KERBEROS_REALM``
   Optional. The administrative domain to which a user belongs.

``--returns CODES``
   A comma-delimited list of return codes that indicate the success or failure of the command that was run remotely.

``-S KERBEROS_SERVICE``, ``--kerberos-service KERBEROS_SERVICE``
   Optional. The service principal used during Kerberos-based authentication.

``SEARCH_QUERY``
   The search query used to return a list of servers to be accessed using SSH and the specified ``SSH_COMMAND``. This option uses the same syntax as the search subcommand.

``SSH_COMMAND``
   The command to be run against the results of a search query.

``--session-timeout MINUTES``
   The amount of time (in minutes) for the maximum length of a WinRM session.

``-t TRANSPORT``, ``--winrm-transport TRANSPORT``
   The WinRM transport type. Possible values: ``ssl`` or ``plaintext``.

``--winrm-authentication-protocol PROTOCOL``
   The authentication protocol to be used during WinRM communication. Possible values: ``basic``, ``kerberos`` or ``negotiate``. Default value: ``negotiate``.

``--winrm-shell SHELL``
   The WinRM shell type. Valid choices are ``cmd``, ``powershell`` or ``elevated``. Default value: ``cmd``. The ``elevated`` shell is similar to the ``powershell`` option, but runs the powershell command from a scheduled task.

``--winrm-ssl-verify-mode MODE``
   The peer verification mode that is used during WinRM communication. Possible values: ``verify_none`` or ``verify_peer``. Default value: ``verify_peer``.

``-x USERNAME``, ``--winrm-user USERNAME``
   The WinRM user name.

.. end_tag

Examples
=====================================================

**Find Uptime for Web Servers**

.. tag knife_windows_winrm_find_uptime

To find the uptime of all web servers, enter:

.. code-block:: bash

   $ knife winrm "role:web" "net stats srv" -x Administrator -P password

.. end_tag

**Force a chef-client run**

.. tag knife_windows_winrm_force_chef_run

To force a chef-client run:

.. code-block:: bash

   knife winrm 'ec2-50-xx-xx-124.amazonaws.com' 'chef-client -c c:/chef/client.rb' -m -x admin -P 'password'
   ec2-50-xx-xx-124.amazonaws.com [date] INFO: Starting Chef Run (Version 0.9.12)
   ec2-50-xx-xx-124.amazonaws.com [date] WARN: Node ip-0A502FFB has an empty run list.
   ec2-50-xx-xx-124.amazonaws.com [date] INFO: Chef Run complete in 4.383966 seconds
   ec2-50-xx-xx-124.amazonaws.com [date] INFO: cleaning the checksum cache
   ec2-50-xx-xx-124.amazonaws.com [date] INFO: Running report handlers
   ec2-50-xx-xx-124.amazonaws.com [date] INFO: Report handlers complete

Where in the examples above, ``[date]`` represents the date and time the long entry was created. For example: ``[Fri, 04 Mar 2011 22:00:53 +0000]``.

.. end_tag

**Bootstrap a Windows machine using SSH**

.. tag knife_windows_bootstrap_ssh

To bootstrap a Microsoft Windows machine using SSH:

.. code-block:: bash

   $ knife bootstrap windows ssh ec2-50-xx-xx-124.compute-1.amazonaws.com -r 'role[webserver],role[production]' -x Administrator -i ~/.ssh/id_rsa

.. end_tag

**Bootstrap a Windows machine using Windows Remote Management**

.. tag knife_windows_bootstrap_winrm

To bootstrap a Microsoft Windows machine using WinRM:

.. code-block:: bash

   $ knife bootstrap windows winrm ec2-50-xx-xx-124.compute-1.amazonaws.com -r 'role[webserver],role[production]' -x Administrator -P 'super_secret_password'

.. end_tag

**Generate an SSL certificate, and then create a listener**

Use the ``listener create``, ``cert generate``, and ``cert install`` arguments to create a new listener and assign it a newly-generated SSL certificate. First, make sure that WinRM is enabled on the machine:

.. code-block:: bash

   $ winrm quickconfig

Create the SSL certificate

.. code-block:: bash

   $ knife windows cert generate --domain myorg.org --output-file $env:userprofile/winrmcerts/winrm-ssl

This command may be run on any machine and will output three file types: ``.b64``, ``.pem``, and ``.pfx``.

Next, create the SSL listener:

.. code-block:: bash

   $ knife windows listener create --hostname *.myorg.org --cert-install $env:userprofile/winrmcerts/winrm-ssl.pfx

This will use the same ``.pfx`` file that was output by the ``cert generate`` argument. If the command is run on a different machine from that which generated the certificates, the required certificate files must first be transferred securely to the system on which the listener will be created. (Use the ``cert install`` argument to install a certificate on a machine.)

The SSL listener is created and should be listening on TCP port ``5986``, which is the default WinRM SSL port.
