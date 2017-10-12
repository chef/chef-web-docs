=====================================================
About Knife
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife.rst>`__

.. tag knife_summary

knife is a command-line tool that provides an interface between a local chef-repo and the Chef server. knife helps users to manage:

* Nodes
* Cookbooks and recipes
* Roles, Environments, and Data Bags
* Resources within various cloud environments
* The installation of the chef-client onto nodes
* Searching of indexed data on the Chef server

.. end_tag

The Knife Quick Reference provides an all-in-one quick reference of knife commands. You can view the `overview <https://github.com/chef/quick-reference/blob/master/qr_knife_web.png>`_ or download the `source files <https://github.com/chef/quick-reference>`_.

.. tag knife_index

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Topic
     - Description
   * - `Setting up Knife </knife_setup.html>`_
     - Configure knife to interact with your organization's Chef server and infrastructure.
   * - `Knife Common Options </knife_options.html>`_
     - Common options that are available for all knife subcommands.
   * - `knife.rb </config_rb_knife.html>`_
     - Common options for the ``knife.rb`` file
   * - `knife.rb Optional Settings </config_rb_knife_optional_settings.html>`_
     - Additional options for your ``knife.rb``

.. end_tag

Knife Subcommands
=====================================================

knife includes a collection of built in subcommands that work together to provide all of the functionality required to take specific actions against any object in an organization, including cookbooks, nodes, roles, data bags, environments, and users. A knife plugin extends the functionality beyond built-in subcommands.

Plugin Command Syntax
-----------------------------------------------------
All knife subcommands have the following syntax:

   knife subcommand [ARGUMENT] (options)

Each subcommand has its own set of arguments and options.

.. note:: All syntax examples in this document show variables in ALL_CAPS. For example ``-u PORT_LIST`` (where PORT_LIST is a comma-separated list of local and public UDP ports) or ``-F FORMAT`` (where FORMAT determines the output format, either ``summary``, ``text``, ``json``, ``yaml``, or ``pp``). These variables often require specific values that are unique to each organization.

Built-in Subcommands
-----------------------------------------------------
.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Subcommand
     - Description
   * - `knife_bootstrap </knife_bootstrap.html>`_
     - .. tag knife_bootstrap_summary

       Use the ``knife bootstrap`` subcommand to run a bootstrap operation that installs the chef-client on the target system. The bootstrap operation must specify the IP address or FQDN of the target system.

       .. end_tag

   * - `knife_client </knife_client.html>`_
     - .. tag knife_client_summary

       The ``knife client`` subcommand is used to manage an API client list and their associated RSA public key-pairs. This allows authentication requests to be made to the Chef server by any entity that uses the Chef server API, such as the chef-client and knife.

       .. end_tag

   * - `knife configure </knife_configure.html>`_
     - .. tag knife_configure_summary

       Use the ``knife configure`` subcommand to create the knife.rb and client.rb files so that they can be distributed to workstations and nodes.

       .. end_tag

   * - `knife cookbook </knife_cookbook.html>`_
     - .. tag knife_cookbook_summary

       The ``knife cookbook`` subcommand is used to interact with cookbooks that are located on the Chef server or the local chef-repo.

       .. end_tag

   * - `knife cookbook site </knife_cookbook_site.html>`_
     - .. tag knife_site_cookbook

       The ``knife cookbook site`` subcommand is used to interact with cookbooks that are available in the `Chef Supermarket <https://supermarket.chef.io/>`___. A user account is required for any community actions that write data to this site. The following arguments do not require a user account: ``download``, ``search``, ``install``, and ``list``.

       .. end_tag

   * - :`knife data bag </knife_data_bag.html>`_
     - .. tag knife_data_bag_summary

       The ``knife data bag`` subcommand is used to manage arbitrary stores of globally available JSON data.

       .. end_tag

   * - `knife delete </knife_delete.html>`_
     - .. tag knife_delete_summary

       Use the ``knife delete`` subcommand to delete an object from a Chef server. This subcommand works similar to ``knife cookbook delete``, ``knife data bag delete``, ``knife environment delete``, ``knife node delete``, and ``knife role delete``, but with a single verb (and a single action).

       .. end_tag

   * - `knife deps </knife_deps.html>`_
     - .. tag knife_deps_summary

       Use the ``knife deps`` subcommand to identify dependencies for a node, role, or cookbook.

       .. end_tag

   * - `knife diff </knife_diff.html>`_
     - .. tag knife_diff_summary

       Use the ``knife diff`` subcommand to compare the differences between files and directories on the Chef server and in the chef-repo. For example, to compare files on the Chef server prior to an uploading or downloading files using the ``knife download`` and ``knife upload`` subcommands, or to ensure that certain files in multiple production environments are the same. This subcommand is similar to the ``git diff`` command that can be used to diff what is in the chef-repo with what is synced to a git repository.

       .. end_tag

   * - `knife download </knife_download.html>`_
     - .. tag knife_download_summary

       Use the ``knife download`` subcommand to download roles, cookbooks, environments, nodes, and data bags from the Chef server to the current working directory. It can be used to back up data on the Chef server, inspect the state of one or more files, or to extract out-of-process changes users may have made to files on the Chef server, such as if a user made a change that bypassed version source control. This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be downloaded, and then ``knife upload``, which does the opposite of ``knife download``.

       .. end_tag

   * - `knife edit </knife_edit.html>`_
     - .. tag knife_edit_summary

       Use the ``knife edit`` subcommand to edit objects on the Chef server. This subcommand works similar to ``knife cookbook edit``, ``knife data bag edit``, ``knife environment edit``, ``knife node edit``, and ``knife role edit``, but with a single verb (and a single action).

       .. end_tag

   * - `knife environment </knife_environment.html>`_
     - .. tag knife_environment_summary

       The ``knife environment`` subcommand is used to manage environments within a single organization on the Chef server.

       .. end_tag

   * - `knife exec </knife_exec.html>`_
     - .. tag knife_exec_summary

       The ``knife exec`` subcommand uses the knife configuration file to execute Ruby scripts in the context of a fully configured chef-client. Use this subcommand to run scripts that will only access Chef server one time (or otherwise very infrequently) or any time that an operation does not warrant full usage of the knife subcommand library.

       .. end_tag

   * - `knife list </knife_list.html>`_
     - .. tag knife_list_summary

       Use the ``knife list`` subcommand to view a list of objects on the Chef server. This subcommand works similar to ``knife cookbook list``, ``knife data bag list``, ``knife environment list``, ``knife node list``, and ``knife role list``, but with a single verb (and a single action).

       .. end_tag

   * - `knife node </knife_node.html>`_
     - .. tag knife_node_summary

       The ``knife node`` subcommand is used to manage the nodes that exist on a Chef server.

       .. end_tag

   * - `knife raw </knife_raw.html>`_
     - .. tag knife_raw_summary

       Use the ``knife raw`` subcommand to send a REST request to an endpoint in the Chef server API.

       .. end_tag

   * - `knife recipe list </knife_recipe_list.html>`_
     - .. tag knife_recipe_list_summary

       Use the ``knife recipe list`` subcommand to view all of the recipes that are on a Chef server. A regular expression can be used to limit the results to recipes that match a specific pattern. The regular expression must be within quotes and not be surrounded by forward slashes (/).

       .. end_tag

   * - `knife role </knife_role.html>`_
     - .. tag knife_role_summary

       The ``knife role`` subcommand is used to manage the roles that are associated with one or more nodes on a Chef server.

       .. end_tag

   * - `knife search </knife_search.html>`_
     - .. tag knife_search_summary

       Use the ``knife search`` subcommand to run a search query for information that is indexed on a Chef server.

       .. end_tag

   * - `knife serve </knife_serve.html>`_
     - .. tag knife_serve_summary

       Use the ``knife serve`` subcommand to run a persistent chef-zero against the local chef-repo. (chef-zero is a lightweight Chef server that runs in-memory on the local machine.) This is the same as running the chef-client executable with the ``--local-mode`` option. The ``chef_repo_path`` is located automatically and the Chef server will bind to the first available port between ``8889`` and ``9999``. ``knife serve`` will print the URL for the local Chef server, so that it may be added to the knife.rb file.

       .. end_tag

   * - `knife show </knife_show.html>`_
     - .. tag knife_show_summary

       Use the ``knife show`` subcommand to view the details of one (or more) objects on the Chef server. This subcommand works similar to ``knife cookbook show``, ``knife data bag show``, ``knife environment show``, ``knife node show``, and ``knife role show``, but with a single verb (and a single action).

       .. end_tag

   * - `knife ssh </knife_ssh.html>`_
     - .. tag knife_ssh_summary

       Use the ``knife ssh`` subcommand to invoke SSH commands (in parallel) on a subset of nodes within an organization, based on the results of a `search query </chef_search.html>`__ made to the Chef server.

       .. end_tag

   * - `knife ssl check </knife_ssl_check.html>`_
     - .. tag knife_ssl_check_summary

       Use the ``knife ssl check`` subcommand to verify the SSL configuration for the Chef server or a location specified by a URL or URI. Invalid certificates will not be used by OpenSSL.

       When this command is run, the certificate files (``*.crt`` and/or ``*.pem``) that are located in the ``/.chef/trusted_certs`` directory are checked to see if they have valid X.509 certificate properties. A warning is returned when certificates do not have valid X.509 certificate properties or if the ``/.chef/trusted_certs`` directory does not contain any certificates.

       .. warning:: When verification of a remote server's SSL certificate is disabled, the chef-client will issue a warning similar to "SSL validation of HTTPS requests is disabled. HTTPS connections are still encrypted, but the chef-client is not able to detect forged replies or man-in-the-middle attacks." To configure SSL for the chef-client, set ``ssl_verify_mode`` to ``:verify_peer`` (recommended) **or** ``verify_api_cert`` to ``true`` in the client.rb file.

       .. end_tag

   * - `knife ssl fetch </knife_ssl_fetch.html>`_
     - .. tag knife_ssl_fetch_summary

       Use the ``knife ssl fetch`` subcommand to copy SSL certificates from an HTTPS server to the ``trusted_certs_dir`` directory that is used by knife and the chef-client to store trusted SSL certificates. When these certificates match the hostname of the remote server, running ``knife ssl fetch`` is the only step required to verify a remote server that is accessed by either knife or the chef-client.

       .. warning:: It is the user's responsibility to verify the authenticity of every SSL certificate before downloading it to the ``/.chef/trusted_certs`` directory. knife will use any certificate in that directory as if it is a 100% trusted and authentic SSL certificate. knife will not be able to determine if any certificate in this directory has been tampered with, is forged, malicious, or otherwise harmful. Therefore it is essential that users take the proper steps before downloading certificates into this directory.

       .. end_tag

   * - `knife status </knife_status.html>`_
     - .. tag knife_status_summary

       Use the ``knife status`` subcommand to display a brief summary of the nodes on a Chef server, including the time of the most recent successful chef-client run.

       .. end_tag

   * - `knife tag </knife_tag.html>`_
     - .. tag knife_tag_summary

       The ``knife tag`` subcommand is used to apply tags to nodes on a Chef server.

       .. end_tag

   * - `knife upload </knife_upload.html>`_
     - .. tag knife_upload_summary

       Use the ``knife upload`` subcommand to upload data to the  Chef server from the current working directory in the chef-repo. The following types of data may be uploaded with this subcommand:

       * Cookbooks
       * Data bags
       * Roles stored as JSON data
       * Environments stored as JSON data

       (Roles and environments stored as Ruby data will not be uploaded.) This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be uploaded, and then ``knife download``, which does the opposite of ``knife upload``.

       .. end_tag

   * - `knife user </knife_user.html>`_
     - .. tag knife_user_summary

       The ``knife user`` subcommand is used to manage the list of users and their associated RSA public key-pairs.

       .. end_tag

   * - `knife xargs </knife_xargs.html>`_
     - .. tag knife_xargs_summary

       Use the ``knife xargs`` subcommand to take patterns from standard input, download as JSON, run a command against the downloaded JSON, and then upload any changes.

       .. end_tag

Verb Subcommands
-----------------------------------------------------

knife includes a set of subcommands that are built around common verbs: ``delete``, ``deps``, ``diff``, ``download``, ``edit``, ``list``, ``show``, ``upload``, ``xargs``. These subcommands allow knife to issue commands that interact with any object stored in the chef-repo or stored on the Chef server. Some important principles behind this group of subcommands includes:

* A command that works with each object in the chef-repo. The subcommands specify the desired action (the "verb"), and then directory in which that object resides (``clients``, ``cookbooks/``, ``data_bags/``, ``environments/``, ``nodes``, ``roles/``, and ``users``). For example: ``download cookbooks/``
* A command that works with certain objects in the Chef server, including ``acls``, ``groups``, and ``containers``
* Uses the Chef server as if it were a file system, allowing the chef-repo on the Chef server to behave like a mirror of the chef-repo on the workstation. The Chef server will have the same objects as the local chef-repo. To make changes to the files on the Chef server, just download files from the Chef server or upload files from the chef-repo
* The context from which a command is run matters. For example, when working in the ``roles/`` directory, knife will know what is being worked with. Enter ``knife show base.json`` and knife will return the base role from the Chef server. From the chef-repo root, enter ``knife show roles/base.json`` to get the same result
* Parallel requests can be made to the Chef server and are configurable on a per-command basis

Wildcard Search
-----------------------------------------------------
A wildcard matching pattern can be used for substring matches that replace zero (or more) characters. There are two types of wildcard patterns:

* A question mark ("?") can be used to replace exactly one character (as long as that character is not the first character)
* An asterisk ("*") can be used to replace any number of characters (including zero)

Wildcard patterns must be escaped (using a backslash) so that the wildcard itself can reach the Chef server. If they are not escaped, the wildcard is expanded into the actual filenames and knife will not know the wildcard was intended to be used. For example, if the Chef server has data bags named ``aardvarks``, ``anagrams``, and ``arp_tables``, but the local file system only has ``aardvarks`` and ``anagrams``, escaping vs. not escaping the wildcard pattern will yield different results:

.. code-block:: bash

  $ knife list data_bags/a\*

asks the Chef server for everything starting with the letter "a" and will return:

.. code-block:: bash

  $ aardvarks/ anagrams/ arp_tables/

But, the following:

.. code-block:: bash

  $ knife list data_bags/a*

will return:

.. code-block:: bash

  $ aardvarks/ anagrams/

Which is the same as entering:

.. code-block:: bash

  $ knife list data_bags/aardvarks data_bags/anagrams

to return:

.. code-block:: bash

  $ aardvarks/ anagrams/

Knife Plug-ins
=====================================================

Knife functionality can be extended with plugins, which work the same as built-in subcommands (including common options). Knife plugins have been written to interact with common cloud providers, to simplify common Chef tasks, and to aid in Chef workflows.

Plugin Installation
-----------------------------------------------------

Knife plugins ship as Rubygems and are installed into the ChefDK installation using the ``chef`` command:

.. code-block:: bash

  chef gem install PLUGIN_NAME

Post installation you will also need to rehash the list of knife commands by running:

.. code-block:: bash

  knife rehash

Chef Maintained Knife Plugins
-----------------------------------------------------

Chef maintains the following plugins:

* ``knife-acl``
* ``knife-azure``
* ``knife-ec2``
* ``knife-eucalyptus``
* ``knife-google``
* ``knife-linode``
* ``knife-lpar``
* ``knife-openstack``
* ``knife-push``
* ``knife-rackspace``
* ``knife-vcenter``
* ``knife-windows``.

Community Knife Plugins
-----------------------------------------------------

Knife plugins written by Chef community members can be found on Supermarket under `Knife Plugins <https://supermarket.chef.io/tools?type=knife_plugin>`_.
