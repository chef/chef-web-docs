.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When the acting backup server fails, |drbd| on the master will continue to function in primary mode, whether the |drbd| on the secondary was shut down gracefully or became unavailable unexpectedly. Verify that |drbd| is functioning by running ``drbdadm role pc0`` on the primary:

.. code-block:: bash

   [root@be1 opscode]# drbdadm role pc0
   Primary/Unknown
   [root@be1 opscode]#

You can see the full status by running cat ``/proc/drbd``:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by    root@localhost.localdomain, 2012-02-06 12:59:36
 0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
       ns:672 nr:0 dw:24 dr:1697 al:2 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:130760

The disk partition is still mounted into the file system and can be used as normal.

When the secondary becomes available again, two things may happen:

* If the status of the secondary reports ``Inconsistent`` or ``UpToDate`` without manual intervention, all is well.
* If it remains ``DUnknown``, |drbd| on the secondary can be manually restarted and it will start to sync. The ``DUnknown`` status is the report which indicates that |drbd| sees no network connection to its partner.

The last field in the ``/prod/drbd`` file (``oos``) reports how far the primary is out of sync with its partner. If the secondary is down and there are a lot of writes on the primary, this number will increase. For example:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
    0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
        ns:5205048 nr:64 dw:1466728 dr:4180125 al:354 bm:261 lo:1667 pe:0 ua:0 ap:1665 ep:1 wo:b oos:361540

When the disks return to a synced state, that field will return to ``0``. While the secondary is syncing, status about the syncing process will be shown for both hosts. For the secondary, something like the following:

.. code-block:: bash

   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:SyncTarget ro:Secondary/Primary ds:Inconsistent/UpToDate C r-----
       ns:0 nr:1263008 dw:1257888 dr:0 al:0 bm:60 lo:6 pe:8 ua:5 ap:0 ep:1 wo:f oos:1670512
           [======>.............] sync'ed: 36.3% (1670512/2613068)K
           finish: 0:00:47 speed: 35,152 (18,124) want: 44,520 K/sec

and for the primary, something like the following:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
    0: cs:SyncSource ro:Primary/Secondary ds:UpToDate/Inconsistent C r-----
       ns:7259268 nr:64 dw:4279364 dr:5721317 al:949 bm:360 lo:5 pe:0 ua:5 ap:0 ep:1 wo:b oos:1121600
           [==========>.........] sync'ed: 57.3% (1121600/2613068)K
           finish: 0:00:32 speed: 34,328 (21,304) K/sec

Eventually the hosts will quiesce and report ``ds:UpToDate/UpToDate``. Depending on how long the secondary was down, how much data was written to the primary in the interim, and the speed of the shared network, this process could be nearly instantaneous, or could take several minutes. The processes used to manage the |chef server| should not require manipulation in any way during this recovery.

If the secondary host is lost completely, a new host can be installed in its place, the device built, and then |drbd| started. The new host will pair with the existing primary, sync data, and be ready to take over if necessary.