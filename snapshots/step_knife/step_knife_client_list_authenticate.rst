.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To verify that an API client can authenticate to the 
Chef server correctly, try getting a list of clients using ``-u`` and ``-k`` options to specify its name and private key:

.. code-block:: bash

   $ knife client list -u ORGNAME -k .chef/ORGNAME.pem

