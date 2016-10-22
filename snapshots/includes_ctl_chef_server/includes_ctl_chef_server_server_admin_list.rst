.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``list-server-admins`` subcommand is used to return a list of users who are members of the ``server-admins`` group.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl list-server-admins

and will return a list of users similar to:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan
