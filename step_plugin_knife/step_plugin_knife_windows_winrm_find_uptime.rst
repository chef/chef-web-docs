.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To find the uptime of all web servers, enter:

.. code-block:: bash

   $ knife winrm "role:web" "net stats srv" -x Administrator -P password
