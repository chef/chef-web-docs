.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |keepalived| service manages the |vrrp| and cluster transitions. It should be running on both the primary and secondary servers. To transition from the primary to the secondary, simply run the following on the primary:

.. code-block:: bash

   $ private-chef-ctl stop keepalived

which will initiate a failover from the primary to the secondary. This will cause the current primary to:

#. Remove the virtual IP address.
#. Stop the services.
#. Unmount the |drbd| device.
#. Becoming secondary for the |drbd| device. 

Meanwhile, the backup will be undergoing the same steps as listed above. Use the ``ha-status`` option to view the progress:

.. code-block:: bash

   $ watch -n1 sudo private-chef-ctl ha-status





