

=====================================================
knife upload
=====================================================

.. tag knife_upload_25

Use the ``knife upload`` subcommand to upload data to the  Chef server from the current working directory in the chef-repo. The following types of data may be uploaded with this subcommand:

* Cookbooks
* Data bags
* Roles stored as JSON data
* Environments stored as JSON data

(Roles and environments stored as Ruby data will not be uploaded.) This subcommand is often used in conjunction with ``knife diff``, which can be used to see exactly what changes will be uploaded, and then ``knife download``, which does the opposite of ``knife upload``.

.. end_tag

Syntax
=====================================================
.. tag knife_upload_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife upload [PATTERN...] (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 4_5

This subcommand has the following options:

``--force``
   Use ``--force`` to upload roles, cookbooks, etc. even if the file in the directory is identical (by default, no ``POST`` or ``PUT`` is performed unless an actual change would be made).

``-n``, ``--dry-run``
   Take no action and only print out results.

``--purge``
   Use ``--purge`` to delete roles, cookbooks, etc. from the Chef server if their corresponding files do not exist in the chef-repo. By default, such objects are left alone and NOT purged.

``--recurse``
   Use ``--no-recurse`` to disable uploading a directory recursively. Default: ``--recurse``.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
=====================================================
.. tag knife_upload_repository

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload .

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload /

to upload all cookbooks and data bags, plus all roles and enviroments that are stored as JSON data. (Roles and environments stored as Ruby data will not be uploaded.)

.. end_tag

.. tag knife_upload_directory_cookbooks

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload cookbooks

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload /cookbooks

.. end_tag

.. tag knife_upload_directory_environments

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload environments

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload /environments

to upload all enviroments that are stored as JSON data. (Environments stored as Ruby data will not be uploaded.)

.. end_tag

.. tag knife_upload_directory_environment

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload environments/production.json

or from the ``environments/`` directory, enter:

.. code-block:: bash

   $ knife upload production.json

.. end_tag

.. tag knife_upload_directory_roles

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload roles

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload /roles

to upload all roles that are stored as JSON data. (Roles stored as Ruby data will not be uploaded.)

.. end_tag

.. tag knife_upload_directory_cookbooks_and_role

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload cookbooks/apache\* roles/webserver.json

.. end_tag

