=====================================================
Server Data Storage
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_data.rst>`__

Managing how data is stored on the Chef server is sometimes necessary, such as resizing DRBD logical volumes, volume groups, and space available on the primary backend machine.

Resize DRBD
=====================================================
DRBD may be resized online. First, make a `backup </server_backup_restore.html>`__ of the Chef server data.

* The mounted filesystem on the primary backend server is ``ext4``
* The backing device for the mounted ``ext4`` filesystem is an LVM2 volume named ``/dev/opscode/drbd``

.. note:: For more information about logical volume manager (LVM), see http://www.tldp.org/HOWTO/LVM-HOWTO/. For more information about DRBD, see http://drbd.linbit.com/users-guide/s-resizing.html.

Devices
-----------------------------------------------------
After backing up the Chef server data, make a note of the current size of the ``/dev/opscode/drbd`` logical volume and mountpoint. Run the following commands:

.. code-block:: bash

   sudo lvdisplay -v --units 4096k /dev/opscode/drbd

and then:

.. code-block:: bash

   df -k /var/opt/opscode/drbd/data

Verify that DRBD is in good shape on both backend machines. Both the primary and secondary machines should show states similar to ``Primary/Secondary UpToDate/UpToDate``.

Run the following command:

.. code-block:: bash

   cat /proc/drbd

.. note:: Save these results to compare them to the same data post-resize.

Volume Groups
-----------------------------------------------------
Resize the volume group on both backend systems. Run the following commands and replace ``sdb1`` for the correct device name:

.. code-block:: bash

   pvcreate /dev/sdb1

and then:

.. code-block:: bash

   vgextend opscode /dev/sdb1

Logical Volumes
-----------------------------------------------------
Resize the logical volumes identically on both backend machines. Due to differences in the space available for logical volumes on the primary and secondary backend machines (which is typically caused by existing snapshots), the size of the logical volume should be specified in absolute terms on both sides of the DRBD link, rather than in percentages. Be sure to leave about 20% of the total available space free on both sides of the DRBD link, minus any existing snapshots. Run the following command and replace ``SIZE`` with a value similar to ``10GiB``:

.. code-block:: bash

   lvextend -LSIZE /dev/opscode/drbd

For example, if the volume group has 10GB total, only 8GB should be allocated to the logical volume, which leaves 20% of the volume group available:

.. code-block:: bash

   lvextend -L8GiB /dev/opscode/drbd

Primary Backend
-----------------------------------------------------
Resize DRBD on the current primary backend to extend the size of the DRBD device. Run the following command:

.. code-block:: bash

   sudo drbdadm resize pc0

The size of the ``/dev/drbd0`` backing device's mountpoint should grow. This change may take some time to complete, as DRBD may want to synchronize the changes across the network, even though they are empty blocks.

Primary File System
-----------------------------------------------------
Resize the file system only on the current primary backend. Run the following command:

.. code-block:: bash

   sudo resize2fs /dev/drbd/by-disk/opscode/drbd

Verify Resize
-----------------------------------------------------
To verify the results of resizing DRBD, run the following commands and compare the results to the same data that was collected prior to resizing DRBD:

.. code-block:: bash

   sudo lvdisplay -v --units 4096k /dev/opscode/drbd

and then:

.. code-block:: bash

   df -k /var/opt/opscode/drbd/data
