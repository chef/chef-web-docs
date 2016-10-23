.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To search for all nodes running CentOS in the production environment, enter:

.. code-block:: bash

   $ knife search node 'chef_environment:production AND platform:centos'
