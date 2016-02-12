.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This topic is NOT included in the knife-bootstrap topic

To register nodes with |chef hosted|, run the following bootstrap command on every node:

.. code-block:: bash

   knife bootstrap NODE_IP_ADDRESS -d migration -x platform --sudo

The exact command will depend on how the actual environment is configured on each node. For example, to bootstrap and register a node that is running |ubuntu|, enter something like:

.. code-block:: bash

   knife bootstrap NODE_IP_ADDRESS -d migration -x ubuntu --sudo
