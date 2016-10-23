.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
knife download 
=====================================================

.. include:: ../../includes_knife/includes_knife_download.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_download_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--[no-]force``
   Use ``--force`` to download files even when the file on the hard drive is identical to the object on the server (role, cookbook, etc.). By default, files are compared to see if they have equivalent content, and local files are only overwritten if they are different. Default: ``--no-force``.

``-n``, ``--dry-run``
   Take no action and only print out results. Default: ``false``.

``--[no-]diff``
   Download only new and modified files. Set to ``false`` to download all files. Default: ``--diff``.

``--[no-]recurse``
   Use ``--no-recurse`` to disable downloading a directory recursively. Default: ``--recurse``.

``--[no-]purge``
   Use ``--purge`` to delete local files and directories that do not exist on the Chef server. By default, if a role, cookbook, etc. does not exist on the Chef server, the local file for said role is left alone and NOT deleted. Default: ``--no-purge``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
.. include:: ../../step_knife/step_knife_download_repository.rst

.. include:: ../../step_knife/step_knife_download_directory_cookbooks.rst

.. include:: ../../step_knife/step_knife_download_directory_environments.rst

.. include:: ../../step_knife/step_knife_download_directory_environment.rst

.. include:: ../../step_knife/step_knife_download_directory_roles.rst

.. include:: ../../step_knife/step_knife_download_directory_cookbooks_and_role.rst

