.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Resize the logical volumes identically on both backend machines. Due to differences in the space available for logical volumes on the primary and secondary backend machines (which is typically caused by existing snapshots), the size of the logical volume should be specified in absolute terms on both sides of the |drbd| link, rathern than in percentages. Be sure to leave about 20% of the total available space free on both sides of the |drbd| link, minus any existing snapshots. Run the following command and replace ``SIZE`` with a value similar to ``10GiB``:

.. code-block:: bash

   lvextend -LSIZE /dev/opscode/drbd

For example, if the volume group has 10GB total, only 8GB should be allocated to the logical volume, which leaves 20% of the volume group available:

.. code-block:: bash

   lvextend -L8GiB /dev/opscode/drbd
