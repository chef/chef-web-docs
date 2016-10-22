.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The SSL certificates that are used by the chef-client may be verified by specifying the path to the client.rb file. Use the ``--config`` option (that is available to any knife command) to specify this path:

.. code-block:: bash

   $ knife ssl check --config /etc/chef/client.rb
