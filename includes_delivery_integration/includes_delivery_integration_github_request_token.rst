.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Log in to the |chef delivery| server and run the following command.

**For GitHub Enterprise**

.. code-block:: bash

   delivery-ctl setup-github-enterprise-token $DELIVERY_ENTERPRISE

**For GitHub.com**

.. code-block:: bash

   delivery-ctl setup-github-token $DELIVERY_ENTERPRISE

Follow the URL given to finish authorizing |chef delivery| with |github|.

.. note:: If you are using a service account with GitHub Enterprise, you need to complete the OAuth process as the service account user.
