.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

All cookbooks should pass |foodcritic| rules before being uploaded.

.. code-block:: bash

   $ foodcritic -f all your-cookbook

should return nothing.