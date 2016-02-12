.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To establish failover between the two backend servers, do the following:

#. On the primary backend server, define it as the primary shared device. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ drbdadm primary --force pc0

   For |ubuntu|:

   .. code-block:: bash
      
      $ drbdadm -- --overwrite-data-of-peer primary pc0

#. On the primary backend server, mount the file system. For example, a file system named ``ext4``:

   .. code-block:: bash
      
      $ mkfs.ext4 /dev/drbd0

   then:

   .. code-block:: bash
      
      $ mkdir -p /var/opt/opscode/drbd/data

   and then:

   .. code-block:: bash
      
      $ mount /dev/drbd0 /var/opt/opscode/drbd/data

#. Synchronize |drbd|. This process **MUST** be allowed to complete to ensure that |drbd| is synchronized with all devices. 

   .. note:: Under normal operation, |drbd| dedicates only a portion of the available disk bandwidth to initial/complete re-synchronization. This ensures that new data written to the shared device is also synchronized.

   |drbd| can be configured to utilize more bandwidth during the initial synchronization. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ drbdadm disk-options --resync-rate=1100M pc0

   For |ubuntu|:

   .. code-block:: bash
      
      $ drbdsetup /dev/drbd0 syncer -r 1100M

   To observe the synchronization process, run the following:

   .. code-block:: bash

      $ watch -n1 cat /proc/drbd

   Output similar to the following will be shown:

   .. code-block:: bash

      cat /proc/drbd output
   
      version: 8.4.1 (api:1/proto:86[STRIKEOUT:100)
      GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by
      dag@Build64R6, 2011]12[STRIKEOUT:21 06:08:50
        0: cs:SyncSource ro:Primary/Secondary ds:UpToDate/Inconsistent C r]—-
        ns:3071368 nr:0 dw:0 dr:3075736 al:0 bm:187 lo:0 pe:13 ua:4 ap:0 ep:1
        wo:b oos:12685660
        [==>……………..] sync'ed: 19.5% (12388/15372)M
        finish: 0:11:00 speed: 19,188 (24,468) K/sec

   Synchronization is complete hen the ``ds:`` section reads ``UpToDate/UpToDate``.

#. When synchronization is complete, run the following command on the primary backend server:

   .. code-block:: bash

      $ touch /var/opt/opscode/drbd/drbd_ready

#. Reconfigure the primary |chef server|:

   .. code-block:: bash
      
      $ sudo chef-server-ctl reconfigure

#. Run the following command on the secondary backend server:

   .. code-block:: bash

      $ touch /var/opt/opscode/drbd/drbd_ready

#. Reconfigure the secondary |chef server|:

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

