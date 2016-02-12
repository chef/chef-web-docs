.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The |chef server| requires that the systems on which it is running be connected to |ntp|, as the |chef server| is particularly sensitive to clock drift. For |redhat| and |centos| 6:

.. code-block:: bash

   $ yum install ntp

or:

.. code-block:: bash

   $ chkconfig ntpd on

or:

.. code-block:: bash

   $ service ntpd start

For |ubuntu|:

.. code-block:: bash

   $ apt-get install ntp
