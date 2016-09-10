=====================================================
About |berkshelf|
=====================================================

.. include:: ../../includes_berkshelf/includes_berkshelf.rst

Berkshelf CLI
=====================================================
The |berkshelf| CLI is the interface to |berkshelf|.

Common Options
-----------------------------------------------------

``-c PATH``, ``--config PATH``
   The path to the |berkshelf| configuration file.

``-d``, ``--debug``
   Use to print debug information. Default value: ``false``.

``-F JSON``, ``--format JSON``
   Use to specify the output format to be used. Default value: ``human`` Possible values: ``base``, ``human``, ``json``, and ``null``.

``-q``, ``--quiet``
   Use to silence all informational output. Default value: ``false``.


berks apply
-----------------------------------------------------
Use ``berks apply`` to apply |berksfile| version locks to the named environment on the |chef server|.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks apply ENVIRONMENT (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b LOCK_FILE_PATH``, ``--lockfile LOCK_FILE_PATH``
   The path to the |berksfile| lock file from which |berksfile| version locks are applied.

``-f JSON_FILE_PATH``, ``--envfile PATH``
   The path to an environment file (in |json| format) to which |berksfile| version locks are applied.

``--ssl-verify``
   Use to enable (``true``) or disable (``false``) SSL verification when applying |berksfile| version locks to an environment.


berks contingent
-----------------------------------------------------
Use ``berks contingent`` to list all cookbooks in a |berksfile| that depend on the named cookbook.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks contingent COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the cookbook is located.


berks cookbook
-----------------------------------------------------
Use ``berks cookbook`` to create a skeleton for a new cookbook.

.. warning:: This command is deprecated in favor of ``chef generate cookbook``.


berks info
-----------------------------------------------------
Use ``berks info`` to display the name, author, copyright, and dependcy information for the named cookbook.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks info COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the cookbook is located.


berks init
-----------------------------------------------------
Use ``berks init`` to initialize |berkshelf| to the specified directory.

.. warning:: This command is deprecated in favor of ``chef generate cookbook``.


berks install
-----------------------------------------------------
Use ``berks install`` to install cookbooks to the named |berksfile|.

.. warning:: This command is deprecated. Run ``berks vendor`` instead.


berks list
-----------------------------------------------------
Use ``berks list`` to list cookbooks and their dependencies.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks list (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the cookbook is located.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be listed.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be listed. When this option is used, cookbooks that exist in groups not listed will not be listed.


berks outdated
-----------------------------------------------------
Use ``berks outdated`` to list dependencies for the named cookbook, and then check if there are new versions available for version constraints that may exist.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks outdated COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the cookbook is located.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be checked for version constraints.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be checked for version constraints. When this option is used, cookbooks that exist in groups not listed will not be checked for version constraints.


berks package
-----------------------------------------------------
Use ``berks package`` to vendor, and then archive the dependencies of a |berksfile|.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks package PATH (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| to be vendored, and then archived.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be vendored, and then archived.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be vendored, and then archived. When this option is used, cookbooks that exist in groups not listed will not be vendored or archived.


berks search
-----------------------------------------------------
Use ``berks search`` to search the remote source for cookbooks that match the search query. The query itself will match partial cookbook names.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks search QUERY (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``--source URL``
   The URL at which remote cookbooks are located. Default value: ``https://supermarket.chef.io``.


berks test
-----------------------------------------------------
Use ``berks test`` to run |kitchen| from within |berkshelf|.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks test KITCHEN_COMMAND (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command may run any |kitchen| CLI command, such as:

* `kitchen create <https://docs.chef.io/ctl_kitchen.html#kitchen-create>`__
* `kitchen converge <https://docs.chef.io/ctl_kitchen.html#kitchen-converge>`__
* `kitchen destroy <https://docs.chef.io/ctl_kitchen.html#kitchen-destroy>`__
* `kitchen exec <https://docs.chef.io/ctl_kitchen.html#kitchen-exec>`__
* `kitchen list <https://docs.chef.io/ctl_kitchen.html#kitchen-list>`__
* `kitchen test <https://docs.chef.io/ctl_kitchen.html#kitchen-test>`__
* `kitchen verify <https://docs.chef.io/ctl_kitchen.html#kitchen-verify>`__

See :doc:`kitchen (executable) </ctl_kitchen>` for descriptions of every |kitchen| subcommand.

berks show
-----------------------------------------------------
Use ``berks show`` to show the path to the named cookbook.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks show COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the named cookbook is defined.


berks update
-----------------------------------------------------
Use ``berks update`` to update the named cookbook or cookbooks (and any dependencies).

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks update COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the named cookbook is defined.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be updated.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be updated. When this option is used, cookbooks that exist in groups not listed will not be updated.


berks upload
-----------------------------------------------------
Use ``berks upload`` to upload the named cookbook to the |chef server|.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks upload COOKBOOK (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| in which the named cookbook is defined.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be uploaded.

``--force``
   Use to upload any named cookbook even if that cookbook exists on the |chef server| and is frozen.

``--halt-on-frozen``
   Use to exit the command with a non-zero exit code if this version of a cookbook already exists on the |chef server|.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be uploaded. When this option is used, cookbooks that exist in groups not listed will not be uploaded.

``--no-freeze``
   A frozen cookbook requires changes to that cookbook to be submitted as a new version of that cookbook. Use this option to prevent this cookbook from being frozen. Default value: ``false`` (i.e. "frozen").

``--ssl-verify``
   Use to enable (``true``) or disable (``false``) SSL verification when uploading cookbooks to the |chef server|.

``-s``, ``--skip-syntax-check``
   Use to skip |ruby| syntax checking when uploading a cookbook to the |chef server|. Default value: ``false``.


berks vendor
-----------------------------------------------------
Use ``berks vendor`` to vendor groups of cookbooks (as specified by group name) into a directory.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks vendor PATH (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| from which cookbooks will be vendored.

``--delete``
   Use to clean the directory in which vendored cookbooks will be placed prior to executing this command.

``-e [GROUP, GROUP, ...]``, ``--except [GROUP, GROUP, ...]``
   An array of cookbook groups that will not be vendored.

``-o [GROUP, GROUP, ...]``, ``--only [GROUP, GROUP, ...]``
   An array of cookbook groups to be vendored. When this option is used, cookbooks that exist in groups not listed will not be vendored.


berks verify
-----------------------------------------------------
Use ``berks verify`` to perform a validation of the contents of resolved cookbooks.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks verify (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| from which resolved cookbooks are validated.


berks version
-----------------------------------------------------
Use ``berks version`` to display the version of |berkshelf|.


berks viz
-----------------------------------------------------
Use ``berks viz`` to show the dependency graph.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This subcommand has the following syntax:

.. code-block:: bash

   $ berks viz (options)

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command has the following options:

``-b PATH``, ``--berksfile PATH``
   The path to the |berksfile| for which the dependency graph is built.

``-o NAME``, ``--outfile NAME``
   The name of the file to which output is saved. Default value: ``graph.png``.


For more information ...
=====================================================
For more information about |berkshelf|:

* `Berkshelf Documentation <http://berkshelf.com>`_
* `How Can I Combine Berks and Local Cookbooks? <https://coderwall.com/p/j72egw/organise-your-site-cookbooks-with-berkshelf-and-this-trick>`_
