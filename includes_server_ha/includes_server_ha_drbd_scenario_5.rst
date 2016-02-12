.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Sometimes |drbd| hedges its bets, and puts both nodes in a pair into secondary mode. When this happens, you can look at the contents of ``/proc/drbd`` on both hosts and see if either of them is showing out of sync. If they are both ``oos:0``, just pick one and promote it to primary using the ``drbdadm primary pc0`` command. If one or both of the hosts is out of sync, choose the one with the lower amount of ``oos`` and promote it to primary.

If the chosen node won't promote, run the following commands on the other host to reset its disk state:

.. code-block:: bash

   $ drbdadm wipe-md pc0

and:

.. code-block:: bash

   $ drbdadm create-md pc0

That will tell |drbd| to abandon what is on the node and start over, and should allow it to sync with the primary.