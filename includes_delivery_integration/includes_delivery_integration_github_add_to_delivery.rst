.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To add the |github| |oauth| app to |chef delivery|, log in to the |chef delivery| server and run the following command:

**For Github Enterprise**

.. code-block:: bash

   delivery-ctl setup-github-enterprise $GHE_SERVER_ROOT_URL $CLIENT_ID $CLIENT_SECRET

**For Github.com**

.. code-block:: bash

   delivery-ctl setup-github $CLIENT_ID $CLIENT_SECRET
