.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The URL for the |chef server| needs to be updated on all nodes and workstations. In the |client rb| file on each node and in the |knife rb| file on each workstation, update the following setting:

.. code-block:: ruby

   chef_server_url "https://url.for.server"

.. note:: Any node that is bootstrapped from a workstation with the updated URL will automatically be assigned the new URL for the |chef server|. Only existing nodes prior to the upgrade require the URL update.
