

=====================================================
knife diff
=====================================================

.. tag knife_diff_25

Use the ``knife diff`` subcommand to compare the differences between files and directories on the Chef server and in the chef-repo. For example, to compare files on the Chef server prior to an uploading or downloading files using the ``knife download`` and ``knife upload`` subcommands, or to ensure that certain files in multiple production environments are the same. This subcommand is similar to the ``git diff`` command that can be used to diff what is in the chef-repo with what is synced to a git repository.

.. end_tag

Syntax
=====================================================
.. tag knife_diff_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife diff [PATTERN...] (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag 4_2

This subcommand has the following options:

``--name-only``
   Show only the names of modified files.

``--name-status``
   Show only the names of files with a status of ``Added``, ``Deleted``, ``Modified``, or ``Type Changed``.

``--no-recurse``
   Use ``--no-recurse`` to disable listing a directory recursively. Default: ``--recurse``.

.. end_tag

.. note:: .. tag knife_common_see_all_config_options

          See :doc:`knife.rb </config_rb_knife_optional_settings>` for more information about how to add certain knife options as settings in the knife.rb file.

          .. end_tag

Examples
=====================================================
.. tag knife_diff_compare_json_files

To compare the ``base.json`` role to a ``webserver.json`` role, enter:

.. code-block:: bash

   $ knife diff roles/base.json roles/webserver.json

.. end_tag

.. tag knife_diff_compare_repo_and_server

To compare the differences between the local chef-repo and the files that are on the Chef server, enter:

.. code-block:: bash

   $ knife diff

.. end_tag

.. tag knife_diff_compare_then_return_results

To diff a node named ``node-lb`` and then only return files that have been added, deleted, modified, or changed, enter:

.. code-block:: bash

   $ knife diff --name-status node-lb

to return something like:

.. code-block:: bash

   node-lb/recipes/eip.rb
   node-lb/recipes/heartbeat-int.rb
   node-lb/templates/default/corpsite.conf.erb
   node-lb/files/default/wildcard.node.com.crt
   node-lb/files/default/wildcard.node.com.crt-2009
   node-lb/files/default/wildcard.node.com.key
   node-lb/.gitignore
   node-lb/Rakefile

.. end_tag

