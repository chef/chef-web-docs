.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The Chef server requires that the systems on which it is running be connected to Network Time Protocol (NTP), as the Chef server is particularly sensitive to clock drift. For Red Hat and CentOS 6:

.. code-block:: bash

   $ yum install ntp

or:

.. code-block:: bash

   $ chkconfig ntpd on

or:

.. code-block:: bash

   $ service ntpd start

For Ubuntu:

.. code-block:: bash

   $ apt-get install ntp
