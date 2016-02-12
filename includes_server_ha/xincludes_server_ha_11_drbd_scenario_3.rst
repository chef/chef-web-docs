.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Trouble starts when the |drbd| primary is the host that becomes unavailable. The |drbd| process on the secondary makes no assumptions about whether or not it should automatically take over, based on the split-brain configurations in the ``drbd.conf`` file.

Basically, what this means is that when the primary becomes unavailable to the secondary without an explicit takeover being initiated, the secondary will assume that it itself is the wrong, ``split-brained`` host, and is the one unconnected and incorrect. It will take no automatic action.

The status of the secondary will look something like the following:

.. code-block:: bash

   version: 8.4.1 (api:1/proto:86-100)
   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:WFConnection ro:Secondary/Unknown ds:UpToDate/DUnknown C r-----
       ns:0 nr:3505480 dw:4938128 dr:0 al:0 bm:290 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

The ``ds:UpToDate/Unknown`` is important; it indicates that the secondary has all the data that was on the primary and won't lose anything if it is promoted.

If it is verified that the primary host is going to be down for a while, the secondary can be promoted to primary:

.. code-block:: bash

   $ drbdadm primary pc0

at that point the status will change to something like the following:

.. code-block:: bash

   version: 8.4.1 (api:1/proto:86-100)
   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
       ns:0 nr:3505480 dw:4938128 dr:672 al:0 bm:290 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

Notice that ``ro`` is now ``ro:Primary/Unknown``. The |chef server| can now be recovered by entering the following command:

.. code-block:: bash

   $ private-chef-ctl master-recover

This will start up the configured services and the |chef server| will be master on this host.

If the original primary can be brought back online, the cluster management script run by |keepalived| will try to do a |drbd| takeover, based on that host's original primary |chef server| master status.

The first thing it will do is attempt to promote itself to |drbd| primary, which will fail if the disk has been written to at all while this host was down, and |keepalived| will be unable to transition back to the original master. This leaves the pair of servers in a good state, with the second back-end box as the |drbd| primary |chef server| master.

|drbd| on the first back-end server will sync to the second back-end server and will become the clean secondary |fqdn|.