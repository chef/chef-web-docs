.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|drbd| may be resized. First, make a backup of the |chef server| data.

* The mounted filesystem on the primary backend server is ``ext4``
* The backing device for the mounted ``ext4`` filesystem is an LVM2 volume named ``/dev/opscode/drbd``

.. note:: For more information about |lvm|, see http://www.tldp.org/HOWTO/LVM-HOWTO/. For more information about |drbd|, see http://drbd.linbit.com/users-guide/s-resizing.html.