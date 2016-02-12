.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To delete a server using the ``--purge`` option. which will delete every |chef client| and node:

.. code-block:: bash

   $ knife google server delete www1 --purge -Z us-central2-a