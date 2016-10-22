.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To deploy from a private git repository without using the ``application`` cookbook, first ensure that:

* the private key does not have a passphrase, as this will pause a chef-client run to wait for input
* an SSH wrapper is being used
* a private key has been added to the node

and then remove a passphrase from a private key by using code similar to:

.. code-block:: bash

   ssh-keygen -p -P 'PASSPHRASE' -N '' -f id_deploy
