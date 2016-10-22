=====================================================
knife tag 
=====================================================

.. include:: ../../includes_chef/includes_chef_tags.rst

.. include:: ../../includes_knife/includes_knife_tag.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

create
=====================================================
Use the ``create`` argument to add one or more tags to a node.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife tag create NODE_NAME [TAG...]


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create tags**

To create tags named ``seattle``, ``portland``, and ``vancouver``, enter:

.. code-block:: bash

   $ knife tag create node seattle portland vancouver



delete
=====================================================
Use the ``delete`` argument to delete one or more tags from a node.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife tag delete NODE_NAME [TAG...]


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete tags**

To delete tags named ``denver`` and ``phoenix``, enter:

.. code-block:: bash

   $ knife tag delete node denver phoenix

Type ``Y`` to confirm a deletion.



list
=====================================================
Use the ``list`` argument to list all of the tags that have been applied to a node.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife tag list [NODE_NAME...]


Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of tags**

To view the tags for a node named ``devops_prod1``, enter:

.. code-block:: bash

   $ knife tag list devops_prod1



