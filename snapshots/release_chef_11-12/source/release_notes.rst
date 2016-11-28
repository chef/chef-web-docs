=====================================================
Release Notes: chef-client 11.12
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 11.12 and/or are changes from previous versions. The short version:

* **Ohai 7.0** Ohai 7 is part of the chef-client 11-12 install
* **New windows_package resource** Use the **windows_package** resource to manage packages on the Microsoft Windows platform.
* **New guard_interpreter attribute** Use the ``guard_interpreter`` attribute to specify a **script**-based resource---**bash**, **csh**, **perl**, **powershell_script**, **python**, and **ruby**---that will be used to evaluate a string command.
* **New reboot_pending? Recipe DSL method** Use the ``reboot_pending?`` method to test if a Microsoft Windows node requires a reboot.
* **New convert_boolean_true attribute** Use the ``convert_boolean_true`` attribute to return ``0`` (true) or ``1`` (false) based on certain conditions in a **powershell_script** resource block.
* **knife ssl check** Use the ``knife ssl check`` subcommand to verify SSL configuration for the Chef server.
* **knife ssl fetch** Use the ``knife ssl fetch`` subcommand to copy SSL certificates from an HTTPS server to the ``trusted_certs_dir`` directory.
* **New options for knife client subcommands** New options allow the creation and deletion of the chef-validator.
* **New options for chef-client** A new option allows a run-list to be specified, and then set permanently.
* **Weekdays as symbols** The **cron** resource allows weekdays to be entered as a symbol, e.g. ``:monday`` or ``:friday``.
* **Generate the public/private key pair on a node** The ``local_key_generation`` setting has been added to the client.rb file. When ``true``, key pairs will be generated on the node and the public key will be sent to the Chef server.
* **knife cookbook test and .chefignore files** The ``knife cookbook test`` subcommand will respect the settings in a chefignore file.
* **knife bootstrap -V -V** The ``knife bootstrap`` command can set the initial chef-client run to be logged at the debug level.
* **Sensitive property added to common resource properties** Use the ``sensitive`` property with the **template** and **file** resources to ensure that sensitive data is not logged by the chef-client.
* **cron resource accepts symbols for weekday property** Symbols---``:sunday``, ``:monday``, ``:tuesday``, ``:wednesday``, ``:thursday``, ``:friday``, ``:saturday``---may be used with the ``weekday`` property and the **cron** resource.

Ohai 7
-----------------------------------------------------
.. tag ohai

Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run. Ohai is required by the chef-client and must be present on a node. (Ohai is installed on a node as part of the chef-client install process.)

The types of attributes Ohai collects include (but are not limited to):

* Platform details
* Network usage
* Memory usage
* CPU data
* Kernel data
* Host names
* Fully qualified domain names
* Other configuration details

Attributes that are collected by Ohai are automatic attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

.. tag ohai_platforms

Ohai collects data for many platforms, including AIX, Darwin, HP-UX, Linux, FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating system based off the ``Windows_NT`` kernel and has access to ``win32`` or ``win64`` sub-systems.

.. end_tag

collect_data Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_ohai

The Ohai DSL is a Ruby DSL that is used to define an Ohai plugin and to ensure that Ohai collects the right data at the start of every chef-client run. The Ohai DSL is a small DSL with a single method that is specific to Ohai plugins. Because the Ohai DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining an Ohai plugin.

.. end_tag

.. tag dsl_ohai_method_collect_data

The ``collect_data`` method is a block of Ruby code that is called by Ohai when it runs. One (or more) ``collect_data`` blocks can be defined in a plugin, but only a single ``collect_data`` block is ever run. The ``collect_data`` block that is run is determined by the platform on which the node is running, which is then matched up against the available ``collect_data`` blocks in the plugin.

* A ``collect_data(:default)`` block is used when Ohai is not able to match the platform of the node with a ``collect_data(:platform)`` block in the plugin
* A ``collect_data(:platform)`` block is required for each platform that requires non-default behavior

When Ohai runs, if there isn't a matching ``collect_data`` block for a platform, the ``collect_data(:default)`` block is used. The syntax for the ``collect_data`` method is:

.. code-block:: ruby

   collect_data(:default) do
     # some Ruby code
   end

or:

.. code-block:: ruby

   collect_data(:platform) do
     # some Ruby code
   end

where:

* ``:default`` is the name of the default ``collect_data`` block
* ``:platform`` is the name of a platform, such as ``:aix`` for AIX or ``:windows`` for Microsoft Windows

.. end_tag

.. tag dsl_ohai_method_collect_data_mash

Use a mash to store data. This is done by creating a new mash, and then setting an attribute to it. For example:

.. code-block:: ruby

   provides 'name_of_mash'
   name_of_mash Mash.new
   name_of_mash[:attribute] = 'value'

.. end_tag

.. tag dsl_ohai_method_collect_data_example

The following examples show how to use the ``collect_data`` block:

.. code-block:: ruby

   Ohai.plugin(:Azure) do
     provides 'azure'

     collect_data do
       azure_metadata_from_hints = hint?('azure')
       if azure_metadata_from_hints
         Ohai::Log.debug('azure_metadata_from_hints is present.')
         azure Mash.new
         azure_metadata_from_hints.each {|k, v| azure[k] = v }
       else
         Ohai::Log.debug('No hints present for azure.')
         false
       end
     end
   end

or:

.. code-block:: ruby

   require 'ohai/mixin/ec2_metadata'
   extend Ohai::Mixin::Ec2Metadata

   Ohai.plugin do
     provides 'openstack'

     collect_data do
       if hint?('openstack') || hint?('hp')
         Ohai::Log.debug('ohai openstack')
         openstack Mash.new
         if can_metadata_connect?(EC2_METADATA_ADDR,80)
           Ohai::Log.debug('connecting to the OpenStack metadata service')
           self.fetch_metadata.each {|k, v| openstack[k] = v }
           case
           when hint?('hp')
             openstack['provider'] = 'hp'
           else
             openstack['provider'] = 'openstack'
           end
         else
           Ohai::Log.debug('unable to connect to the OpenStack metadata service')
         end
       else
         Ohai::Log.debug('NOT ohai openstack')
       end
     end
   end

.. end_tag

**windows_package**
-----------------------------------------------------
.. tag resource_package_windows

Use the **windows_package** resource to manage Microsoft Installer Package (MSI) packages for the Microsoft Windows platform.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_windows_syntax

A **windows_package** resource block manages a package on a node, typically by installing it. The simplest use of the **windows_package** resource is:

.. code-block:: ruby

   windows_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **windows_package** resource is:

.. code-block:: ruby

   windows_package 'name' do
     checksum                   String
     installer_type             Symbol
     notifies                   # see description
     options                    String
     provider                   Chef::Provider::Package::Windows
     remote_file_attributes     Hash
     returns                    String, Integer, Array
     source                     String # defaults to 'name' if not specified
     subscribes                 # see description
     timeout                    String, Integer
     action                     Symbol # defaults to :install if not specified
   end

where

* ``windows_package`` tells the chef-client to manage a package
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``checksum``, ``installer_type``, ``options``, ``package_name``, ``provider``, ``remote_file_attributes``, ``returns``, ``source``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_windows_actions

This resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:remove``
   Remove a package.

.. end_tag

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 5_44

This resource has the following properties:

``checksum``
   **Ruby Type:** String

   The SHA-256 checksum of the file. Use to prevent a file from being re-downloaded. When the local file matches the checksum, the chef-client does not download it. Use when a URL is specified by the ``source`` property.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``installer_type``
   **Ruby Type:** Symbol

   A symbol that specifies the type of package. Possible values: ``:msi``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``remote_file_attributes``
   **Ruby Type:** Hash

   A package at a remote location define as a Hash of properties that modifes the properties of the **remote_file** resource.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``returns``
   **Ruby Types:** String, Integer, Array

   A comma-delimited list of return codes that indicate the success or failure of the command that was run remotely. This code signals a successful ``:install`` action. Default value: ``0``.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system. The location of the package may be at a URL. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out. Default value: ``600`` (seconds).

.. end_tag

guard_interpreter
-----------------------------------------------------
.. tag resources_common_guard_interpreter

Any resource that passes a string command may also specify the interpreter that will be used to evaluate that string command. This is done by using the ``guard_interpreter`` property to specify a **script**-based resource.

.. end_tag

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 16_guard_interpreter_attributes

The ``guard_interpreter`` property may be set to any of the following values:

``:bash``
   Evaluates a string command using the **bash** resource.

``:batch``
   Evaluates a string command using the **batch** resource.

``:csh``
   Evaluates a string command using the **csh** resource.

``:default``
   Default. Executes the default interpreter as identified by the chef-client.

``:perl``
   Evaluates a string command using the **perl** resource.

``:powershell_script``
   Evaluates a string command using the **powershell_script** resource.

``:python``
   Evaluates a string command using the **python** resource.

``:ruby``
   Evaluates a string command using the **ruby** resource.

.. end_tag

Inheritance
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 16_guard_interpreter_attributes_inherit

The ``guard_interpreter`` property is set to ``:default`` by default. When the ``guard_interpreter`` property is set to ``:default``, the ``not_if`` or ``only_if`` properties will guard statements that **do not inherit** properties that are defined by the **script**-based resource in which the ``not_if`` or ``only_if`` guard statement is defined.

For example, the ``not_if`` guard statement in the following example **does not inherit** the ``environment`` property:

.. code-block:: ruby

   bash 'javatooling' do
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started'
   end

and requires adding the ``environment`` property to the ``not_if`` guard statement so that it may use the ``JAVA_HOME`` path as part of its evaluation:

.. code-block:: ruby

   bash 'javatooling' do
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started', :environment => 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
   end

To inherit properties, add the ``guard_interpreter`` property to the resource block and set it to the appropriate value:

* ``:bash`` for **bash**
* ``:batch`` for **batch**
* ``:csh`` for **csh**
* ``:perl`` for **perl**
* ``:powershell_script`` for **powershell_script**
* ``:python`` for **python**
* ``:ruby`` for **ruby**

For example, using the same example as from above, but this time adding the ``guard_interpreter`` property and setting it to ``:bash``:

.. code-block:: ruby

   bash 'javatooling' do
     guard_interpreter :bash
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started'
   end

The ``not_if`` statement now inherits the ``environment`` property and will use the ``JAVA_HOME`` path as part of its evaluation.

.. end_tag

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resources_common_guard_interpreter_example_default

For example, the following code block will ensure the command is evaluated using the default intepreter as identified by the chef-client:

.. code-block:: ruby

   resource 'name' do
     guard_interpreter :default
     # code
   end

.. end_tag

**powershell_script** Property
-----------------------------------------------------
The following property has been added to the **powershell_script** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``convert_boolean_return``
     - Return ``0`` if the last line of a command is evaluated to be true or to return ``1`` if the last line is evaluated to be false.

.. tag resource_powershell_convert_boolean_return

.. To return ``0`` for true, ``1`` for false:

Use the ``convert_boolean_return`` attribute to raise an exception when certain conditions are met. For example, the following fragments will run successfully without error:

.. code-block:: ruby

   powershell_script 'false' do
     code '$false'
   end

and:

.. code-block:: ruby

   powershell_script 'true' do
     code '$true'
   end

whereas the following will raise an exception:

.. code-block:: ruby

   powershell_script 'false' do
     convert_boolean_return true
     code '$false'
   end

.. end_tag

reboot_pending? Method
-----------------------------------------------------
.. tag dsl_recipe_method_reboot_pending

Use the ``reboot_pending?`` method to test if a node needs a reboot, or is expected to reboot. ``reboot_pending?`` returns ``true`` when the node needs a reboot.

The syntax for the ``reboot_pending?`` method is as follows:

.. code-block:: ruby

   reboot_pending?

.. end_tag

knife ssl check
-----------------------------------------------------
.. tag knife_ssl_check_18

Use the ``knife ssl check`` subcommand to verify the SSL configuration for the Chef server or a location specified by a URL or URI. Invalid certificates will not be used by OpenSSL.

When this command is run, the certificate files (``*.crt`` and/or ``*.pem``) that are located in the ``/.chef/trusted_certs`` directory are checked to see if they have valid X.509 certificate properties. A warning is returned when certificates do not have valid X.509 certificate properties or if the ``/.chef/trusted_certs`` directory does not contain any certificates.

.. warning:: When verification of a remote server's SSL certificate is disabled, the chef-client will issue a warning similar to "SSL validation of HTTPS requests is disabled. HTTPS connections are still encrypted, but the chef-client is not able to detect forged replies or man-in-the-middle attacks." To configure SSL for the chef-client, set ``ssl_verify_mode`` to ``:verify_peer`` (recommended) **or** ``verify_api_cert`` to ``true`` in the client.rb file.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_ssl_check_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife ssl check (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_ssl_check_options

This subcommand has the following options:

``URL_or_URI``
   The URL or URI for the location at which the SSL certificate is located. Default value: the URL for the Chef server, as defined in the knife.rb file.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**SSL certificate has valid X.509 properties**

.. tag knife_ssl_check_verify_server_config

If the SSL certificate can be verified, the response to

.. code-block:: bash

   $ knife ssl check

is similar to:

.. code-block:: bash

   Connecting to host chef-server.example.com:443
   Successfully verified certificates from 'chef-server.example.com'

.. end_tag

**SSL certificate has invalid X.509 properties**

.. tag knife_ssl_check_bad_ssl_certificate

If the SSL certificate cannot be verified, the response to

.. code-block:: bash

   $ knife ssl check

is similar to:

.. code-block:: bash

   Connecting to host chef-server.example.com:443
   ERROR: The SSL certificate of chef-server.example.com could not be verified
   Certificate issuer data:
     /C=US/ST=WA/L=S/O=Corp/OU=Ops/CN=chef-server.example.com/emailAddress=you@example.com

   Configuration Info:

   OpenSSL Configuration:
   * Version: OpenSSL 1.0.1j 15 Oct 2014
   * Certificate file: /opt/chefdk/embedded/ssl/cert.pem
   * Certificate directory: /opt/chefdk/embedded/ssl/certs
   Chef SSL Configuration:
   * ssl_ca_path: nil
   * ssl_ca_file: nil
   * trusted_certs_dir: "/Users/grantmc/Downloads/chef-repo/.chef/trusted_certs"

   TO FIX THIS ERROR:

   If the server you are connecting to uses a self-signed certificate,
   you must configure chef to trust that certificate.

   By default, the certificate is stored in the following location on the
   host where your chef-server runs:

     /var/opt/opscode/nginx/ca/SERVER_HOSTNAME.crt

   Copy that file to your trusted_certs_dir (currently:

     /Users/grantmc/Downloads/chef-repo/.chef/trusted_certs)

   using SSH/SCP or some other secure method, then re-run this command to
   confirm that the certificate is now trusted.

.. end_tag

**Verify the SSL configuration for the chef-client**

.. tag knife_ssl_check_verify_client_config

The SSL certificates that are used by the chef-client may be verified by specifying the path to the client.rb file. Use the ``--config`` option (that is available to any knife command) to specify this path:

.. code-block:: bash

   $ knife ssl check --config /etc/chef/client.rb

.. end_tag

**Verify an external server's SSL certificate**

.. tag knife_ssl_check_verify_external_server

.. code-block:: bash

   $ knife ssl check URL_or_URI

for example:

.. code-block:: bash

   $ knife ssl check https://www.chef.io

.. end_tag

knife ssl fetch
-----------------------------------------------------
.. tag knife_ssl_fetch_18

Use the ``knife ssl fetch`` subcommand to copy SSL certificates from an HTTPS server to the ``trusted_certs_dir`` directory that is used by knife and the chef-client to store trusted SSL certificates. When these certificates match the hostname of the remote server, running ``knife ssl fetch`` is the only step required to verify a remote server that is accessed by either knife or the chef-client.

.. warning:: It is the user's responsibility to verify the authenticity of every SSL certificate before downloading it to the ``/.chef/trusted_certs`` directory. knife will use any certificate in that directory as if it is a 100% trusted and authentic SSL certificate. knife will not be able to determine if any certificate in this directory has been tampered with, is forged, malicious, or otherwise harmful. Therefore it is essential that users take the proper steps before downloading certificates into this directory.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_ssl_fetch_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife ssl fetch (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_ssl_fetch_options

This subcommand has the following options:

``URL_or_URI``
   The URL or URI for the location at which the SSL certificate is located. Default value: the URL for the Chef server, as defined in the knife.rb file.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Fetch the SSL certificates used by Knife from the Chef server**

.. tag knife_ssl_fetch_knife_certificates

.. code-block:: bash

   $ knife ssl fetch

The response is similar to:

.. code-block:: bash

   WARNING: Certificates from <chef_server_url> will be fetched and placed in your trusted_cert
   directory (/Users/grantmc/chef-repo/.chef/trusted_certs).

   Knife has no means to verify these are the correct certificates. You should
   verify the authenticity of these certificates after downloading.

   Adding certificate for <chef_server_url> in /Users/grantmc/chef-repo/.chef/trusted_certs/grantmc.crt
   Adding certificate for DigiCert Secure Server CA in /Users/grantmc/chef-repo/.chef/trusted_certs/DigiCert_Secure_Server_CA.crt

.. end_tag

**Fetch SSL certificates from a URL or URI**

.. tag knife_ssl_fetch_from_url_or_uri

.. code-block:: bash

   $ knife ssl fetch https://www.example.com

.. end_tag

**Verify Checksums**

.. tag knife_ssl_fetch_verify_certificate

The SSL certificate that is downloaded to the ``/.chef/trusted_certs`` directory should be verified to ensure that it is, in fact, the same certificate as the one located on the Chef server. This can be done by comparing the SHA-256 checksums.

#. View the checksum on the Chef server:

   .. code-block:: bash

      $ ssh ubuntu@chef-server.example.com sudo sha256sum /var/opt/opscode/nginx/ca/chef-server.example.com.crt

   The response is similar to:

   .. code-block:: bash

      <ABC123checksum>  /var/opt/opscode/nginx/ca/chef-server.example.com.crt

#. View the checksum on the workstation:

   .. code-block:: bash

      $ gsha256sum .chef/trusted_certs/chef-server.example.com.crt

   The response is similar to:

   .. code-block:: bash

      <ABC123checksum>  .chef/trusted_certs/chef-server.example.com.crt

#. Verify that the checksum values are identical.

.. end_tag

client.rb Settings
-----------------------------------------------------
New settings have been added to the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``local_key_generation``
     - Whether the Chef server or chef-client generates the private/public key pair. When ``true``, the chef-client generates the key pair, and then sends the public key to the Chef server. For example:

       .. code-block:: ruby

          local_key_generation false
   * - ``ssl_verify_mode``
     - Set the verify mode for HTTPS requests.

       * Use ``:verify_none`` to do no validation of SSL certificates.
       * Use ``:verify_peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.

knife Options
-----------------------------------------------------
New options have been added to the following knife subcommands:

knife bootstrap
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-V -V``
   Run the initial chef-client run at the ``debug`` log-level (e.g. ``chef-client -l debug``).

knife client bulk delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-D``, ``--delete-validators``
   Force the deletion of the client when it is also a chef-validator.

knife client create
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--validator``
   Use to create the client as the chef-validator.

knife client delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-D``, ``--delete-validators``
   Force the deletion of the client when it is also a chef-validator.

knife node run list add
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-b ITEM``, ``--before ITEM``
   Add a run-list item before the specified run-list item.

chef-client Options
-----------------------------------------------------
New options have been added to the chef-client:

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   Permanently replace the current run-list with the specified run-list items.

sensitive Property
-----------------------------------------------------
A new common resource property has been added:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``sensitive``
     - Ensure that sensitive resource data is not logged by the chef-client. Default value: ``false``. This setting only applies to the **file** and **template** resources.

Disable Ohai plugins
-----------------------------------------------------
.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

Use the following setting to disable plugins:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``Ohai::Config[:disabled_plugins]``
     - An array of Ohai plugins to be disabled on a node. For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both Ohai 6 and Ohai 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]

Changelog
=====================================================
https://github.com/chef/chef/blob/11-stable/CHANGELOG.md
