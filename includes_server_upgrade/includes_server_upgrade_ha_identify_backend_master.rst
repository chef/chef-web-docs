.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Run ``private chef ctl ha-status`` on both backend servers, and then identify which server returns the line identifying it as the master backend:

.. code-block:: bash

   [OK] cluster status = master