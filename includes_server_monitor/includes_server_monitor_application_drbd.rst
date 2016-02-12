.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|drbdadm| is the management tool for |drbd|. It can be used to obtain status information and to alter the state of the |drbd| cluster. For more information about |drbdadm|, see http://www.drbd.org/users-guide/re-drbdadm.html.

``/proc/drbd`` is a virtual file that displays real-time status information about all currently-configured |drbd| resources. Use the following command to view the contents of this virtual file:

.. code-block:: bash

   $ cat /proc/drbd

Use ``chef-server-ctl ha-status`` along with ``/proc/drbd`` to help evaluate the current state of the cluster. Follow the split-brain recovery procedures for |drbd| if the cluster becomes two unconnected pieces.