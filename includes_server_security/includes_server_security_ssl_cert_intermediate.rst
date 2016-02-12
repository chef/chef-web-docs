.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To use an intermediate certificate, append both the server and intermediate certificates into a single ``.crt`` file. For example:

.. code-block:: bash

   $ cat server.crt intermediate.crt >> /var/opt/opscode/nginx/ca/FQDN.crt
