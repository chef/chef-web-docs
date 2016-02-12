.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An encrypted data bag item is decrypted with a |knife| command similar to:

.. code-block:: bash

   $ knife data bag show --secret-file /tmp/my_data_bag_key passwords mysql

that will return |json| output similar to:

.. code-block:: javascript

   {
     "id": "mysql",
     "pass": "thesecret123",
     "user": "fred"
   }
