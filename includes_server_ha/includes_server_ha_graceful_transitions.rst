.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |keepalived| service manages the |vrrp| and cluster transitions. It should be running on both the primary and secondary servers. To transition from the primary to the secondary, simply run the following command on the primary |chef server|:

.. code-block:: bash

   $ chef-server-ctl stop keepalived

This will initiate a failover from the primary to the secondary |chef server| and will cause the current primary |chef server| to remove the virtual IP address, stop all services, unmount the |drbd| device, and then become the secondary |chef server| for the |drbd| device. Meanwhile, the secondary |chef server| will undergo a similar process, but become the primary |chef server|. 

To view the progress of this transition, use the following command:

.. code-block:: bash

   $ watch -n1 sudo chef-server-ctl ha-status





