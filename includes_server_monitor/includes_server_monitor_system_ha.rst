.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


All components of computer systems fail, and ethernet networks, while being generally very robust, are no exception. A high availability configuration of the |chef server| that uses |drbd| depends on a functioning network to begin and maintain replication between the back end servers on which the |chef server| is running.

To become aware of failure at the earliest opportunity, the ``/proc/drbd`` psuedo file should be monitored for signs
that cluster replication has stopped or is falling behind:

.. code-block:: bash

   $ cat /proc/drbd

A healthy connection state is similar to:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 09b6d528b3b3de50462cd7831c0a3791abc665c3 build by linbit@buildsystem.linbit, 2011-10-12 09:07:35
    0: cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate C r-----
       ns:0 nr:0 dw:0 dr:656 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:0

An unhealthy connection state from the perspective of the initial primary machine is similar to:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 09b6d528b3b3de50462cd7831c0a3791abc665c3 build by linbit@buildsystem.linbit, 2011-10-12 09:07:35
    0: cs:WFConnection ro:Primary/Secondary ds:UpToDate/Unknown C r---
       ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:54192

where this shows lost communication with the secondary machine and ``oos:`` at non-zero (and increasing). This connection state is not fatal, but does represent a degraded state for the cluster where the machines are no longer in sync and are building up a queue of unwritten writes on the originating side that must eventually be synchronized to the secondary machine after the network stabilizes.
