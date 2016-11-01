

=====================================================
About Knife
=====================================================

.. tag knife_24

knife is a command-line tool that provides an interface between a local chef-repo and the Chef server. knife helps users to manage:

* Nodes
* Cookbooks and recipes
* Roles
* Stores of JSON data (data bags), including encrypted data
* Environments
* Cloud resources, including provisioning
* The installation of the chef-client on management workstations
* Searching of indexed data on the Chef server

.. end_tag

.. note:: .. tag notes_knife_quick_reference

          The Knife Quick Reference provides an all-in-one quick reference of knife commands. View a web-based PNG file here: |url docs_knife_png|. Or download the source files from here: |url docs_repo_qr|. Print the front/back source files and laminate them for best effect.

          .. end_tag

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Topic
     - Description
   * - :doc:`knife_using`
     - knife runs from a management workstation and sits in-between a Chef server and an organization's infrastructure.
   * - :doc:`knife_common_options`
     - There are many options that are available for all knife subcommands.

knife includes the following subcommands:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Subcommand
     - Description
   * - :doc:`knife_bootstrap`
     - .. tag knife_bootstrap_25

       Use the ``knife bootstrap`` subcommand to run a bootstrap operation that installs the chef-client on the target system. The bootstrap operation must specify the IP address or FQDN of the target system.

       .. end_tag

   * - :doc:`knife_client`
     - .. tag knife_client_25

       The ``knife client`` subcommand is used to manage an API client list and their associated RSA public key-pairs. This allows authentication requests to be made to the Chef server by any entity that uses the Chef server API, such as the chef-client and knife.

       .. end_tag

   * - :doc:`knife_configure`
     - .. tag knife_configure_25

       Use the ``knife configure`` subcommand to create the knife.rb and client.rb files so that they can be distributed to workstations and nodes.

       .. end_tag

   * - :doc:`knife_cookbook`
     - .. tag knife_cookbook_25

       The ``knife cookbook`` subcommand is used to interact with cookbooks that are located on the Chef server or the local chef-repo.

       .. end_tag

   * - :doc:`knife_cookbook_site`
     - .. tag knife_site_cookbook

       The ``knife cookbook site`` subcommand is used to interact with cookbooks that are located at |url community|. A user account is required for any community actions that write data to this site. The following arguments do not require a user account: ``download``, ``search``, ``install``, and ``list``.

       .. end_tag

   * - :doc:`knife_data_bag`
     - .. tag knife_data_bag_25

       The ``knife data bag`` subcommand is used to manage arbitrary stores of globally available JSON data.

       .. end_tag

   * - :doc:`knife_delete`
     - .. tag knife_delete_25

       Use the ``knife delete`` subcommand to delete an object from a Chef server. This subcommand works similar to ``knife cookbook delete``, ``knife data bag delete``, ``knife environment delete``, ``knife node delete``, and ``knife role delete``, but with a single verb (and a single action).

       .. end_tag

   * - :doc:`knife_diff`
     - .. tag knife_diff_25

       Use the ``knife diff`` subcommand to compare the differences between files and directories on the Chef server and in the chef-repo. For example, to compare files on the Chef server prior to an uploading or downloading files using the ``knife download`` and ``knife upload`` subcommands, or to ensure that certain files in multiple production environments are the same. This subcommand is similar to the ``git diff`` command that can be used to diff what is in the chef-repo with what is synced to a git repository.

       .. end_tag

   * - :doc:`knife_download`
     - .. tag knife_download_25

       Use the ``knife download`` subcommand to download roles, cookbooks, environments, nodes, and data bags from the Chef server to the current working directory. It can be used to back up data on the Chef server, inspect the state of one or more files, or to extract out-of-process changes users may have made to files on the Chef server, such as if a user made a change that bypassed version source control. This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be downloaded, and then ``knife upload``, which does the opposite of ``knife download``.

       .. end_tag

   * - :doc:`knife_environment`
     - .. tag knife_environment_25

       The ``knife environment`` subcommand is used to manage environments within a single organization on the Chef server.

       .. end_tag

   * - :doc:`knife_exec`
     - .. tag knife_exec_25

       The ``knife exec`` subcommand uses the knife configuration file to execute Ruby scripts in the context of a fully configured chef-client. Use this subcommand to run scripts that will only access Chef server one time (or otherwise very infrequently) or any time that an operation does not warrant full usage of the knife subcommand library.

       .. end_tag

   * - :doc:`knife_index_rebuild`
     - .. tag knife_index_rebuild_9

       Use the ``knife index rebuild`` subcommand to rebuild the search indexes for the open source Chef server. This operation is destructive and may take some time.

       .. end_tag

   * - :doc:`knife_list`
     - .. tag knife_list_25

       Use the ``knife list`` subcommand to view a list of objects on the Chef server. This subcommand works similar to ``knife cookbook list``, ``knife data bag list``, ``knife environment list``, ``knife node list``, and ``knife role list``, but with a single verb (and a single action).

       .. end_tag

   * - :doc:`knife_node`
     - .. tag knife_node_25

       The ``knife node`` subcommand is used to manage the nodes that exist on a Chef server.

       .. end_tag

   * - :doc:`knife_raw`
     - .. tag knife_raw_25

       Use the ``knife raw`` subcommand to send a REST request to an endpoint in the Chef server API.

       .. end_tag

   * - :doc:`knife_recipe_list`
     - .. tag knife_recipe_list_25

       Use the ``knife recipe list`` subcommand to view all of the recipes that are on a Chef server. A regular expression can be used to limit the results to recipes that match a specific pattern. The regular expression must be within quotes and not be surrounded by forward slashes (/).

       .. end_tag

   * - :doc:`knife_role`
     - .. tag knife_role_25

       The ``knife role`` subcommand is used to manage the roles that are associated with one or more nodes on a Chef server.

       .. end_tag

   * - :doc:`knife_search`
     - .. tag knife_search_25

       Use the ``knife search`` subcommand to run a search query for information that is indexed on a Chef server.

       .. end_tag

   * - :doc:`knife_show`
     - .. tag knife_show_25

       Use the ``knife show`` subcommand to view the details of one (or more) objects on the Chef server. This subcommand works similar to ``knife cookbook show``, ``knife data bag show``, ``knife environment show``, ``knife node show``, and ``knife role show``, but with a single verb (and a single action).

       .. end_tag

   * - :doc:`knife_ssh`
     - .. tag knife_ssh_25

       Use the ``knife ssh`` subcommand to invoke SSH commands (in parallel) on a subset of nodes within an organization, based on the results of a search query made to the Chef server.

       .. end_tag

   * - :doc:`knife_status`
     - .. tag knife_status_25

       Use the ``knife status`` subcommand to display a brief summary of the nodes on a Chef server, including the time of the most recent successful chef-client run.

       .. end_tag

   * - :doc:`knife_tag`
     - .. tag knife_tag_25

       The ``knife tag`` subcommand is used to apply tags to nodes on a Chef server.

       .. end_tag

   * - :doc:`knife_upload`
     - .. tag knife_upload_25

       Use the ``knife upload`` subcommand to upload data to the  Chef server from the current working directory in the chef-repo. The following types of data may be uploaded with this subcommand:

       * Cookbooks
       * Data bags
       * Roles stored as JSON data
       * Environments stored as JSON data

       (Roles and environments stored as Ruby data will not be uploaded.) This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be uploaded, and then ``knife download``, which does the opposite of ``knife upload``.

       .. end_tag

