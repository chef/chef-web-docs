=====================================================
Release Notes: |chef client| 11.14
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 11.14 and/or are changes from previous versions. The short version:

* **New knife serve subcommand** Use |subcommand knife serve| to run |chef zero| on the local machine.
* **New argument for knife node** The |subcommand knife node| subcommand has a new argument: ``environment set``. Use it to set the environment for a node, but without the need to edit the node object.
* **New options for knife bootstrap** The |subcommand knife bootstrap| command has four new options: ``--bootstrap-curl-options``, ``--bootstrap-install-command``, ``--bootstrap-install-sh``, and ``--bootstrap-wget-options``.
* **New attributes for whitelisting node attributes** Use ``automatic_attribute_whitelist``, ``default_attribute_whitelist``, ``normal_attribute_whitelist``, and ``override_attribute_whitelist`` to prevent attributes from being saved by a node.
* **New client.rb settings** The following settings have been added to the |client rb| file: ``automatic_attribute_whitelist``, ``cookbook_sync_threads``, ``default_attribute_whitelist``, ``ftp_proxy``, ``ftp_proxy_pass``, ``ftp_proxy_user``, ``normal_attribute_whitelist``, ``override_attribute_whitelist``, and ``yum_lock_timeout``.
* **New --run-lock-timeout Setting** New command line setting for |chef client| and |chef solo|.
* **Automatic proxy configuration** Use ``http_proxy``, ``https_proxy``, ``ftp_proxy``, or ``no_proxy`` in the |client rb| file to have the |chef client| automatically configure the ``ENV`` environment variable with proxy settings.
* **Sensitive property added to common resource properties** Use the ``sensitive`` property with **any** resource to ensure that sensitive data is not logged by the |chef client|.
* **chef-zero port ranges** The ``chef_zero.port`` setting (in the |client rb| file) and the ``--chef-zero-port`` option from the command line for the |chef client| now supports using a range of ports. For example ``chef_zero.port ="10,20,30"`` or ``--chef-zero-port 10000-20000``.

|subcommand knife serve|
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_serve.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_serve_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_serve_options.rst

knife node environment set
-----------------------------------------------------
The |subcommand knife node| subcommand has a new argument: ``environment_set``.

.. include:: ../../includes_knife/includes_knife_node_environment_set.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_node_environment_set_syntax.rst

New |subcommand knife bootstrap| Options
-----------------------------------------------------
The following options have been added to |subcommand knife bootstrap|:

``--bootstrap-curl-options OPTIONS``
   |bootstrap curl_options| |bootstrap no_install_command|

``--bootstrap-install-command COMMAND``
   |bootstrap install_command| |bootstrap no_curl_sh_wget|
 
``--bootstrap-install-sh URL``
   |bootstrap install_sh| |bootstrap no_install_command|

``--bootstrap-wget-options OPTIONS``
   |bootstrap wget_options| |bootstrap no_install_command|

Attribute Whitelists
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_attribute_whitelist.rst
   
New |client rb| Settings
-----------------------------------------------------
The following settings have been added to |client rb|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - |whitelist attribute_automatic|
   * - ``cookbook_sync_threads``
     - |cookbook_sync_threads| Default value: ``10``.
   * - ``default_attribute_whitelist``
     - |whitelist attribute_default|
   * - ``ftp_proxy``
     - |ftp_proxy|
   * - ``ftp_proxy_pass``
     - |ftp_proxy_pass| Default value: ``nil``.
   * - ``ftp_proxy_user``
     - |ftp_proxy_user| Default value: ``nil``.
   * - ``normal_attribute_whitelist``
     - |whitelist attribute_normal|
   * - ``override_attribute_whitelist``
     - |whitelist attribute_override|
   * - ``yum_lock_timeout``
     - |yum_lock_timeout| Default value: ``30``.

--run-lock-timeout
-----------------------------------------------------
The following option has been added to |chef client| and |chef solo|:

``--run-lock-timeout SECONDS``
   The amount of time (in seconds) to wait for a |chef client| run to finish. Default value: not set (indefinite).
   
Automatic Proxy Config
-----------------------------------------------------
.. include:: ../../includes_proxy/includes_proxy_env.rst

sensitive Property
-----------------------------------------------------
The following property may now be used with the |resource execute| resource (prior releases only supported using this property with the |resource template| and |resource file| resources):

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Parameter
     - Description
   * - ``sensitive``
     - |sensitive| Default value: ``false``.
	 
What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/chef/blob/11-stable/CHANGELOG.md