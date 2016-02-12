.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Log in to the |chef delivery| server and run the following command. Follow the URL given to finish authorizing |chef delivery| to |github|.

**For GitHub Enterprise**

.. code-block:: bash

   delivery-ctl setup-github-enterprise-token $DELIVERY_ENTERPRISE

**For GitHub.com**

.. code-block:: bash

   delivery-ctl setup-github-token $DELIVERY_ENTERPRISE
