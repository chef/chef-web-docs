.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The following examples show how to use the Omnitruck install script. 

To install chef-client version 12.0.2:

.. code-block:: bash

   $ curl -LO https://omnitruck.chef.io/install.sh && sudo bash ./install.sh -v 12.0.2 && rm install.sh

and/or:

.. code-block:: bash

   $ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 12.0.2

To install the latest version of the Chef development kit on Microsoft Windows from the ``current`` channel:

.. code-block:: none

   . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -channel current -project chefdk
