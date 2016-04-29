.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If an |ssl| error is returned similar to:

.. code-block:: bash

   ERROR: Error uploading cookbook my_cookbook to the Opscode Cookbook Site: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed. Increase log verbosity (-VV) for more information.

this is because |chef server| version 12.0 (and higher) enforces |ssl| by default when sharing cookbooks. A private |supermarket| uses self-signed certificates by default. Use the ``knife ssl fetch`` and ``knife ssl check`` commands to resolve this error.

First fetch the |ssl| certificate for the private |supermarket|:

.. code-block:: bash

   $ knife ssl fetch https://your-private-supermarket

and then:

.. code-block:: bash

   $ knife ssl check https://your-private-supermarket

Re-share the cookbook. This time the message returned should be similar to:

.. code-block:: bash

   Generating metadata for my_cookbook from (...)
   Making tarball my_cookbook.tgz
   Upload complete!
