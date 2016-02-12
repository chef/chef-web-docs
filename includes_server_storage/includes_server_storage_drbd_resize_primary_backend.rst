.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Resize |drbd| on the current primary backend to extend the size of the |drbd| device. Run the following command:

.. code-block:: bash

   sudo drbdadm resize pc0

The size of the ``/dev/drbd0`` backing device's mountpoint should grow. This change may take some time to complete, as |drbd| may want to synchronize the changes across the network, even though they are empty blocks.
