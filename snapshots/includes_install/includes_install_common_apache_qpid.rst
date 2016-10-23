.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

On CentOS and Red Hat Enterprise Linux  systems, the Apache Qpid daemon is installed by default. The Chef server uses RabbitMQ for messaging. Because both Apache Qpid and RabbitMQ share the same protocol, Apache Qpid must be disabled.

To determine if Apache Qpid is installed, run the following command:

.. code-block:: bash

   $ rpm -qa | grep qpid

If Apache Qpid is installed, a response similar to the following is displayed:

.. code-block:: bash

   $ qpid-cpp-server-0.12-6.el6.x86_64

To disable Apache Qpid run:

.. code-block:: bash

   $ service qpidd stop

and then:

.. code-block:: bash

   $ chkconfig --del qpidd
