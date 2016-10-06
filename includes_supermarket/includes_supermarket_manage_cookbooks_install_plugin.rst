.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Chef 12.13 and higher
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you are using Chef 12.13 or higher, use the `knife cookbook site <https://docs.chef.io/knife_cookbook_site.html>`_ commands with BOTH Public Supermarket and Private Supermarket.

Chef 12.12 and lower
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you are using Chef 12.12 or a previous version, you will need to use ``knife supermarket``.

The ``knife supermarket`` command is a plugin that must be installed to the workstation.

If using the |chef dk|, run the following command:

.. code-block:: bash

   $ chef gem install knife-supermarket

and if not using the |chef dk|, run the following command:

.. code-block:: bash

   $ gem install knife-supermarket
