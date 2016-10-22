=====================================================
knife show 
=====================================================

.. include:: ../../includes_knife/includes_knife_show.rst

Syntax
=====================================================
This subcommand has the following syntax:

.. code-block:: bash

   $ knife show [PATTERN...] (options)


Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--local``
   Show local files instead of remote files.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.



Examples
=====================================================
The following examples show how to use this knife subcommand:

**Show all cookbooks**

To show all cookbooks in the ``cookbooks/`` directory:

.. code-block:: bash

   $ knife show cookbooks/

or, (if already in the ``cookbooks/`` directory in the local chef-repo):

.. code-block:: bash

   $ knife show


**Show roles and environments**

.. To show roles and environments:

.. code-block:: bash

   $ knife show roles/ environments/
