.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following syntax:

.. code-block:: bash

   $ knife search INDEX SEARCH_QUERY

where ``INDEX`` is one of ``client``, ``environment``, ``node``, ``role``, or the name of a data bag and ``SEARCH_QUERY`` is the search query syntax for the query that will be executed.

``INDEX`` is implied if omitted, and will default to ``node``. For example:

.. code-block:: bash

   $ knife search '*:*' -i

will return something similar to:

.. code-block:: bash

   8 items found
   
   centos-62-dev
   opensuse-1203
   ubuntu-1304-dev
   ubuntu-1304-orgtest
   ubuntu-1204-ohai-test
   ubuntu-1304-ifcfg-test
   ohai-test
   win2k8-dev

and is the same search as:

.. code-block:: bash

   $ knife search node '*:*' -i

If the ``SEARCH_QUERY`` does not contain a colon character (``:``), then the default query pattern is ``tags:*#{@query}* OR roles:*#{@query}* OR fqdn:*#{@query}* OR addresses:*#{@query}*``, which means the following two search queries are effectively the same:

.. code-block:: bash

   $ knife search ubuntu

or:

.. code-block:: bash

   $ knife search node "tags:*ubuntu* OR roles:*ubuntu* OR fqdn:*ubuntu* (etc.)"