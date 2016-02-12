.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

So far, the scenarios have not described any data loss. When the hosts in the high availability pair are synced, either can be lost and the data will be safe.

If you get to a situation in which the primary host is lost and unrecoverable, but the last status of the |drbd| pair was reporting that the secondary node was in an ``Inconsistent`` state, it is very likely that some data will be lost. The |drbd| status on the remaining host will look something like the following:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
   0: cs:WFConnection ro:Secondary/Unknown ds:Inconsistent/DUnknown C r-----
      ns:0 nr:210572 dw:210572 dr:0 al:0 bm:13 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:40552

As long as good source code management is practiced with cookbooks and other files in the |chef repo|, any missing bits can be re-uploaded after there is a working cluster. In some cases, newly-created users or organizations will need to be re-created. Other actions, such as |chef client| runs and uploads may fail while the cluster is in an ``Inconsistent`` state, but will be fine after there is a working cluster.

When the primary back-end server has been lost while the secondary back-end server is in an ``Inconsistent`` state and it's not going to be back online quickly, the best thing to do is to provision another host to become the new |chef server| cluster partner for the secondary back-end server, and then build it out. If the new host has an IP address that is different from the primary back-end server, change the configuration on the secondary back-end server, and then reconfigure.

In this situation, the |chef server| may be freaking out a bit, so turn off the daemons using the ``chef-server-ctl stop`` command.

Once the new host is identified and the |drbd| devices on that host are ready, bring up |drbd| and get it talking to the secondary back-end server. This secondary server should not want to be the primary server; it should be waiting for the old primary server to return. Start up |drbd| on the new host and verify that it is listening on the correct port and that the status in ``/proc/drbd`` is reporting that the host is up, but in the ``WFConnect: waiting for connection`` state.

By the time you get the new node is up, the secondary back-end server may have taken itself into ``standalone`` mode, which means that it is no longer listening on the network port. In this situation, run the following commands to get the secondary back-end server to talk to the new node:

.. code-block:: bash

   $ drbdadm primary --force pc0

and:

.. code-block:: bash

   $ drbdadm connect pc0

At this point, the new host should be synchronizing with the secondary back-end server. The secondary back-end server will forget all about the data it was missing from the now-gone primary back-end server, and the process of bringing the |chef server| back online can begin.

Running a fast network between the primary and secondary hosts, and keeping it full throttle for |drbd| transfers, will go a long way to mitigating the any damage that may be done in the event of a loss of the primary from an un-synced cluster.