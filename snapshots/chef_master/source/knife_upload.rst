=====================================================
knife upload
=====================================================

.. include:: ../../includes_knife/includes_knife_upload.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_upload_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--[no-]diff``
   Upload only new and modified files. Set to ``false`` to upload all files. Default: ``true``.

``--[no-]force``
   Use ``--force`` to upload roles, cookbooks, etc. even if the file in the directory is identical (by default, no ``POST`` or ``PUT`` is performed unless an actual change would be made). Default: ``--no-force``.

``--[no-]freeze``
   Require changes to a cookbook be included as a new version. Only the ``--force`` option can override this setting. Default: ``false``.

``-n``, ``--dry-run``
   Take no action and only print out results. Default: ``false``.

``--[no-]purge``
   Use ``--purge`` to delete roles, cookbooks, etc. from the Chef server if their corresponding files do not exist in the chef-repo. By default, such objects are left alone and NOT purged. Default: ``--no-purge``.

``--[no-]recurse``
   Use ``--no-recurse`` to disable uploading a directory recursively. Default: ``--recurse``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Upload the entire chef-repo**

.. include:: ../../step_knife/step_knife_upload_repository.rst

**Upload the /cookbooks directory**

.. include:: ../../step_knife/step_knife_upload_directory_cookbooks.rst

**Upload the /environments directory**

.. include:: ../../step_knife/step_knife_upload_directory_environments.rst

**Upload a single environment**

.. include:: ../../step_knife/step_knife_upload_directory_environment.rst

**Upload the /roles directory**

.. include:: ../../step_knife/step_knife_upload_directory_roles.rst

**Upload cookbooks and roles**

.. include:: ../../step_knife/step_knife_upload_directory_cookbooks_and_role.rst

**Use output of knife deps to pass command to knife upload**

.. Use the output of ``knife deps`` to pass a command to ``knife upload``. For example:

.. code-block:: bash

   $ knife upload `knife deps nodes/*.json`
