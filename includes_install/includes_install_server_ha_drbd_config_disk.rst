.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Persistent data on a backend |chef server| is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the |chef server|. These disks should:

* Utilize hardware |raid|
* Be configured in either |raid1| or |raid5|
* Be identical across both of your backend servers

The recommended configuration utilizes the |linux| |lvm| as the backing store for |drbd|. This assumes that:

* ~300GB of raw, unpartitioned disk space is available
* The disk space presents as a single device, ``/dev/sdb``
* The storage is added to a volume group named ``opscode``
* The storage is added in a logical volume group named ``drbd``
* The volume group should have adequate space to enable |lvm| snapshots to be used for backups; this amount depends on many factors, including how much changes in-between snapshots, how long the snapshots will be kept, and the (eventual) size of the |chef server| database; a decent starting point when sizing |lvm| snapshots is ~10% of the raw, unpartitioned disk space

The following commands would properly set up the backend disk configuration for |drbd|:

.. code-block:: bash

   $ pvcreate /dev/sdb

and:

.. code-block:: bash

   $ vgcreate opscode /dev/sdb

and:

.. code-block:: bash

   $ lvcreate -l 80%VG -n drbd opscode

.. warning:: Talk with your systems administrators about disk configuration if you are at all uncertain of how to configure a new logical volume with |lvm|, as the operations can be destructive.

