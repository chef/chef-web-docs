.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To query for all nodes that have the ``webserver`` role and then use SSH to run the command ``sudo chef-client``, enter:

.. code-block:: bash

   $ knife ssh "role:webserver" "sudo chef-client"
