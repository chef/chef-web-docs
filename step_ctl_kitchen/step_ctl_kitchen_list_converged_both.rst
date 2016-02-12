.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To verify if both instances have been converged, run the following command:

.. code-block:: bash

   $ kitchen list

.. code-block:: bash

   Instance             Driver   Provisioner  Verifier  Transport  Last Action
   default-ubuntu-1404  Vagrant  ChefZero     Busser    Ssh        Converged
   default-centos-71    Vagrant  ChefZero     Busser    Ssh        Converged
