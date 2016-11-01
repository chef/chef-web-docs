=====================================================
Release Notes: chef-client 11.14
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
The following items are new for chef-client 11.14 and/or are changes from previous versions. The short version:

* **New knife serve subcommand** Use ``knife serve`` to run chef-zero on the local machine.
* **New argument for knife node** The ``knife node`` subcommand has a new argument: ``environment set``. Use it to set the environment for a node, but without the need to edit the node object.
* **New options for knife bootstrap** The ``knife bootstrap`` command has four new options: ``--bootstrap-curl-options``, ``--bootstrap-install-command``, ``--bootstrap-install-sh``, and ``--bootstrap-wget-options``.
* **New attributes for whitelisting node attributes** Use ``automatic_attribute_whitelist``, ``default_attribute_whitelist``, ``normal_attribute_whitelist``, and ``override_attribute_whitelist`` to prevent attributes from being saved by a node.
* **New client.rb settings** The following settings have been added to the client.rb file: ``automatic_attribute_whitelist``, ``cookbook_sync_threads``, ``default_attribute_whitelist``, ``ftp_proxy``, ``ftp_proxy_pass``, ``ftp_proxy_user``, ``normal_attribute_whitelist``, ``override_attribute_whitelist``, and ``yum_lock_timeout``.
* **New --run-lock-timeout Setting** New command line setting for chef-client and chef-solo.
* **Automatic proxy configuration** Use ``http_proxy``, ``https_proxy``, ``ftp_proxy``, or ``no_proxy`` in the client.rb file to have the chef-client automatically configure the ``ENV`` environment variable with proxy settings.
* **Sensitive property added to common resource properties** Use the ``sensitive`` property with **any** resource to ensure that sensitive data is not logged by the chef-client.
* **chef-zero port ranges** The ``chef_zero.port`` setting (in the client.rb file) and the ``--chef-zero-port`` option from the command line for the chef-client now supports using a range of ports. For example ``chef_zero.port ="10,20,30"`` or ``--chef-zero-port 10000-20000``.

knife serve
-----------------------------------------------------
.. tag knife_serve_18

Use the ``knife serve`` subcommand to run a persistent chef-zero against the local chef-repo. (chef-zero is a lightweight Chef server that runs in-memory on the local machine.) This is the same as running the chef-client executable with the ``--local-mode`` option. The ``chef_repo_path`` is located automatically and the Chef server will bind to the first available port between ``8889`` and ``9999``. ``knife serve`` will print the URL for the local Chef server, so that it may be added to the knife.rb file.

.. end_tag

**Syntax**

.. tag knife_serve_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife serve (options)

.. end_tag

**Options**

.. tag knife_serve_options

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. Default value: same as ``chef_repo_path`` in the client.rb file.

``--chef-zero-host IP``
   Override the host on which chef-zero listens. Default value: ``127.0.0.1``.

``--chef-zero-port PORT``
   The port on which chef-zero listens. The default behavior will bind to the first available port between ``8889`` and ``9999``.

``--repo-mode MODE``
   Use to specify the local chef-repo layout. Possible values: ``static`` (for environments, roles, data bags, and cookbooks), ``everything`` (same as static, plus nodes, clients, and users), ``hosted_everything`` (for ACLs, groups). Default value: ``everything/hosted_everything``.

.. end_tag

knife node environment set
-----------------------------------------------------
The ``knife node`` subcommand has a new argument: ``environment_set``.

.. tag knife_node_environment_set

Use the ``environment set`` argument to set the environment for a node without editing the node object.

.. end_tag

**Syntax**

.. tag knife_node_environment_set_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node environment_set NODE_NAME ENVIRONMENT_NAME (options)

.. end_tag

New knife bootstrap Options
-----------------------------------------------------
The following options have been added to ``knife bootstrap``:

``--bootstrap-curl-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using cURL. This option may not be used in the same command with ``--bootstrap-install-command``.

``--bootstrap-install-command COMMAND``
   Execute a custom installation command sequence for the chef-client. This option may not be used in the same command with ``--bootstrap-curl-options``, ``--bootstrap-install-sh``, or ``--bootstrap-wget-options``.

``--bootstrap-install-sh URL``
   Fetch and execute an installation script at the specified URL. This option may not be used in the same command with ``--bootstrap-install-command``.

``--bootstrap-wget-options OPTIONS``
   Arbitrary options to be added to the bootstrap command when using GNU Wget. This option may not be used in the same command with ``--bootstrap-install-command``.

Attribute Whitelists
-----------------------------------------------------
.. tag node_attribute_whitelist

.. warning:: When these settings are used, any attribute not defined in a whitelist will not be saved. Each attribute type is whitelisted independently of the other attribute types. For example, if ``automatic_attribute_whitelist`` defines attributes to be saved, but ``normal_attribute_whitelist``, ``default_attribute_whitelist``, and ``override_attribute_whitelist`` are not defined, then all normal, default and override attributes are saved, along with only the specified automatic attributes.

Attributes that should be saved by a node may be whitelisted in the client.rb file. The whitelist is a Hash of keys that specify each attribute to be saved.

Attributes are whitelisted by attribute type, with each attribute type being whitelisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define whitelists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - A Hash that whitelists ``automatic`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: all attributes are saved. If the Hash is empty, no attributes are saved.
   * - ``default_attribute_whitelist``
     - A Hash that whitelists ``default`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: all attributes are saved. If the Hash is empty, no attributes are saved.
   * - ``normal_attribute_whitelist``
     - A Hash that whitelists ``normal`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: all attributes are saved. If the Hash is empty, no attributes are saved.
   * - ``override_attribute_whitelist``
     - A Hash that whitelists ``override`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: all attributes are saved. If the Hash is empty, no attributes are saved.

.. warning:: It is recommended that only ``automatic_attribute_whitelist`` be used to whitelist attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are whitelisted incorrectly.

For example, normal attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To whitelist the ``network`` attributes and prevent the other attributes from being saved, update the client.rb file:

.. code-block:: ruby

   normal_attribute_whitelist ['network/interfaces/']

When a whitelist is defined, any attribute of that type that is not specified in that attribute whitelist **will not** be saved. So based on the previous whitelist for normal attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

.. code-block:: ruby

   normal_attribute_whitelist []

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_whitelist [['filesystem','/dev/diskos2']]

.. end_tag

New client.rb Settings
-----------------------------------------------------
The following settings have been added to client.rb:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - A Hash that whitelists ``automatic`` attributes, preventing non-whitelisted attributes from being saved.
   * - ``cookbook_sync_threads``
     - The number of helper threads available for parallel cookbook synchronization. Increasing this value **may** increase the frequency of gateway errors from the Chef server (503 and 504 errors). Decreasing this number reduces the frequency of gateway errors, if present. Default value: ``10``.
   * - ``default_attribute_whitelist``
     - A Hash that whitelists ``default`` attributes, preventing non-whitelisted attributes from being saved.
   * - ``ftp_proxy``
     - The proxy server for FTP connections.
   * - ``ftp_proxy_pass``
     - The password for the proxy server when the proxy server is using an FTP connection. Default value: ``nil``.
   * - ``ftp_proxy_user``
     - The user name for the proxy server when the proxy server is using an FTP connection. Default value: ``nil``.
   * - ``normal_attribute_whitelist``
     - A Hash that whitelists ``normal`` attributes, preventing non-whitelisted attributes from being saved.
   * - ``override_attribute_whitelist``
     - A Hash that whitelists ``override`` attributes, preventing non-whitelisted attributes from being saved.
   * - ``yum_lock_timeout``
     - The amount of time (in seconds) after which a Yum lock request is to time out. Default value: ``30``.

--run-lock-timeout
-----------------------------------------------------
The following option has been added to chef-client and chef-solo:

``--run-lock-timeout SECONDS``
   The amount of time (in seconds) to wait for a chef-client run to finish. Default value: not set (indefinite).

Automatic Proxy Config
-----------------------------------------------------
.. tag proxy_env

If ``http_proxy``, ``https_proxy``, ``ftp_proxy``, or ``no_proxy`` is set in the client.rb file, the chef-client will configure the ``ENV`` variable based on these (and related) settings. For example:

.. code-block:: ruby

   http_proxy 'http://proxy.example.org:8080'
   http_proxy_user 'myself'
   http_proxy_pass 'Password1'

will be set to:

.. code-block:: ruby

   ENV['http_proxy'] = 'http://myself:Password1@proxy.example.org:8080'

.. end_tag

sensitive Property
-----------------------------------------------------
The following property may now be used with the **execute** resource (prior releases only supported using this property with the **template** and **file** resources):

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Parameter
     - Description
   * - ``sensitive``
     - Ensure that sensitive resource data is not logged by the chef-client. Default value: ``false``.

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef/blob/11-stable/CHANGELOG.md
