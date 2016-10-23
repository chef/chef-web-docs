=====================================================
knife diff
=====================================================

.. include:: ../../includes_knife/includes_knife_diff.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_diff_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

.. This file describes a command or a subcommand for Knife.
.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--cookbook-version VERSION``
   The version of a cookbook to download.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--diff-filter=[(A|D|M|T)...[*]]``
   Select only files that have been added (``A``), deleted (``D``), modified (``M``), and/or have had their type changed (``T``). Any combination of filter characters may be used, including no filter characters. Use ``*`` to select all paths if a file matches other criteria in the comparison. Default value: ``nil``.

``--name-only``
   Show only the names of modified files.

``--name-status``
   Show only the names of files with a status of ``Added``, ``Deleted``, ``Modified``, or ``Type Changed``.

``--no-recurse``
   Use ``--no-recurse`` to disable listing a directory recursively. Default: ``--recurse``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Compare files that contain JSON data**

.. include:: ../../step_knife/step_knife_diff_compare_json_files.rst

**Compare the chef-repo and the server**

.. include:: ../../step_knife/step_knife_diff_compare_repo_and_server.rst

**Compare, then return results**

.. include:: ../../step_knife/step_knife_diff_compare_then_return_results.rst
