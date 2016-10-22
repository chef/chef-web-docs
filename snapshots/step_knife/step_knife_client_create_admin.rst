.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To create a chef-client that can access the Chef server API as an administrator---sometimes referred to as an "API chef-client"---with the name "exampleorg" and save its private key to a file, enter:

.. code-block:: bash

   $ knife client create exampleorg -a -f "/etc/chef/client.pem"

