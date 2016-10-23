=====================================================
Release Notes: chef-client 11.14
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

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
.. include:: ../../includes_knife/includes_knife_serve.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_serve_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_serve_options.rst

knife node environment set
-----------------------------------------------------
The ``knife node`` subcommand has a new argument: ``environment_set``.

.. include:: ../../includes_knife/includes_knife_node_environment_set.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_node_environment_set_syntax.rst

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
.. include:: ../../includes_node/includes_node_attribute_whitelist.rst
   
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
.. include:: ../../includes_proxy/includes_proxy_env.rst

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
