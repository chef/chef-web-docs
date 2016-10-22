=====================================================
knife delete 
=====================================================

.. include:: ../../includes_knife/includes_knife_delete.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_delete_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``--both``
   Delete both local and remote copies of an object. Default: ``false``.

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--local``
   Delete only the local copy of an object. A remote copy will not be deleted. Default: ``false``.

``-r``, ``--[no-]recurse``
   Use ``--recurse`` to delete directories recursively. Default: ``--no-recurse``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
None.
