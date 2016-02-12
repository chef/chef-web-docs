.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Persistent data on the backend server of the |chef server| is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the |chef server|. These disks should:

* Utilize hardware |raid|
* Be configured in either |raid1|

This assumes that:

* ~300GB of raw, unpartitioned disk space is available
* The disk space presents as a single device. For example: ``/dev/sdb``.
* The storage is added to a volume group named ``opscode`` and is presented to the |chef server| by mounting on ``/var/opt/opscode`` before a reconfiguration

The following commands properly set up disk configuration on the backend server:

.. code-block:: bash

   $ pvcreate /dev/sdb

and:

.. code-block:: bash

   $ vgcreate opscode /dev/sdb

and:

.. code-block:: bash

   $ lvcreate -l 80%VG -n tiered opscode
