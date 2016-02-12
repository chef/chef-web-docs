.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


From the |chef repo|, run the following command to verify the list of |kitchen| instances:

.. code-block:: bash

   $ kitchen list

to return a list similar to:

.. code-block:: bash

   Instance             Driver   Provisioner  Verifier  Transport  Last Action
   default-ubuntu-1404  Vagrant  ChefZero     Busser    Ssh        <Not Created>
   default-centos-71    Vagrant  ChefZero     Busser    Ssh        <Not Created>

There are two available default platforms---|ubuntu| 12.04 and |centos| 6.5---that are pre-configured to use the |vagrant| driver that is included with the |chef dk|.
