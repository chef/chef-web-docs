

=====================================================
knife download
=====================================================

.. tag knife_download_25

Use the ``knife download`` subcommand to download roles, cookbooks, environments, nodes, and data bags from the Chef server to the current working directory. It can be used to back up data on the Chef server, inspect the state of one or more files, or to extract out-of-process changes users may have made to files on the Chef server, such as if a user made a change that bypassed version source control. This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be downloaded, and then ``knife upload``, which does the opposite of ``knife download``.

.. end_tag

Syntax
=====================================================
.. tag knife_download_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife download [PATTERN...] (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 4_3

This subcommand has the following options:

``--force``
   Use ``--force`` to download files even when the file on the hard drive is identical to the object on the server (role, cookbook, etc.). By default, files are compared to see if they have equivalent content, and local files are only overwritten if they are different.

``-n``, ``--dry-run``
   Take no action and only print out results.

``--[no-]recurse``
   Use ``--no-recurse`` to disable downloading a directory recursively. Default: ``--recurse``.

``--purge``
   Use ``--purge`` to delete local files and directories that do not exist on the Chef server. By default, if a role, cookbook, etc. does not exist on the Chef server, the local file for said role is left alone and NOT deleted.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
=====================================================
.. tag knife_download_repository

To download the entire chef-repo from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download /

.. end_tag

.. tag knife_download_directory_cookbooks

To download the ``cookbooks/`` directory from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download cookbooks

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife download /cookbooks

.. end_tag

.. tag knife_download_directory_environments

To download the ``environments/`` directory from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download environments

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife download /environments

.. end_tag

.. tag knife_download_directory_environment

To download an environment named "production" from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download environments/production.json

or from the ``environments/`` directory, enter:

.. code-block:: bash

   $ knife download production.json

.. end_tag

.. tag knife_download_directory_roles

To download the ``roles/`` directory from the Chef server, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife download roles

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife download /roles

.. end_tag

.. tag knife_download_directory_cookbooks_and_role

To download all cookbooks that start with "apache" and belong to the "webserver" role, browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $  knife download cookbooks/apache\* roles/webserver.json

.. end_tag

