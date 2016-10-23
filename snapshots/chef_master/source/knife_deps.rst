=====================================================
knife deps
=====================================================

.. include:: ../../includes_knife/includes_knife_deps.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_deps_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

.. include:: ../../includes_knife/includes_knife_deps_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Find dependencies for a node**

.. To find the dependencies for a node:

.. code-block:: bash

   $ knife deps nodes/node_name.json 

**Find dependencies for a role**

.. To find the dependencies for a role:

.. code-block:: bash

   $ knife deps roles/role_name.json

**Find dependencies for a cookbook**

.. To find the dependencies for a cookbook:

.. code-block:: bash

   $ knife deps cookbooks/cookbook_name.json

**Find dependencies for an environment**

.. To find the dependencies for an environment:

.. code-block:: bash

   $ knife deps environments/environment_name.json

**Find dependencies for a combination of nodes, roles, and so on**

To find the dependencies for a combination of nodes, cookbooks, roles, and/or environments:

.. code-block:: bash

   $ knife deps cookbooks/git.json cookbooks/github.json roles/base.json environments/desert.json nodes/mynode.json

**Use a wildcard**

A wildcard can be used to return all of the child nodes. For example, all of the environments:

.. code-block:: bash

   $ knife deps environments/*.json

**Return as tree**

Use the ``--tree`` option to view the results with structure:

.. code-block::  bash

   $ knife deps roles/webserver.json

to return something like:

.. code-block:: none

   roles/webserver.json
     roles/base.json
       cookbooks/github
         cookbooks/git
       cookbooks/users
     cookbooks/apache2

**Pass knife deps output to knife upload**

The output of ``knife deps`` can be passed to ``knife upload``:

.. code-block:: bash

   $ knife upload `knife deps nodes/*.json

**Pass knife deps output to knife xargs**

The output of ``knife deps`` can be passed to ``knife xargs``:

.. code-block:: bash

   $ knife deps nodes/*.json | xargs knife upload
