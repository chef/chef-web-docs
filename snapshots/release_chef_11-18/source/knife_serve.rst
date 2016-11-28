

.. tag knife_serve_17

=====================================================
knife serve
=====================================================

.. tag knife_serve_18

Use the ``knife serve`` subcommand to run a persistent chef-zero against the local chef-repo. (chef-zero is a lightweight Chef server that runs in-memory on the local machine.) This is the same as running the chef-client executable with the ``--local-mode`` option. The ``chef_repo_path`` is located automatically and the Chef server will bind to the first available port between ``8889`` and ``9999``. ``knife serve`` will print the URL for the local Chef server, so that it may be added to the knife.rb file.

.. end_tag

Syntax
=====================================================
.. tag knife_serve_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife serve (options)

.. end_tag

Options
=====================================================
.. note:: .. tag knife_common_see_common_options_link

          Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

          .. end_tag

.. tag knife_serve_options

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. Default value: same as ``chef_repo_path`` in the client.rb file.

``--chef-zero-host IP``
   Override the host on which chef-zero listens. Default value: ``127.0.0.1``.

``--chef-zero-port PORT``
   The port on which chef-zero listens. The default behavior will bind to the first available port between ``8889`` and ``9999``.

``--repo-mode MODE``
   Use to specify the local chef-repo layout. Possible values: ``static`` (for environments, roles, data bags, and cookbooks), ``everything`` (same as static, plus nodes, clients, and users), ``hosted_everything`` (for ACLs, groups). Default value: ``everything/hosted_everything``.

.. end_tag

Examples
=====================================================
None.

.. end_tag

