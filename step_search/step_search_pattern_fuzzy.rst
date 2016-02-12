.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To use a fuzzy search pattern enter something similar to:

.. code-block:: bash

   $ knife search client "name:boo~"
   
where ``boo~`` defines the fuzzy search pattern. This will return something similar to:

.. code-block:: javascript

   {
     "total": 1,
     "start": 0,
     "rows": [
       {
         "public_key": "too long didn't read",
         "name": "foo",
         "_rev": "1-f11a58043906e33d39a686e9b58cd92f",
         "json_class": "Chef::ApiClient",
         "admin": false,
         "chef_type": "client"
       }
     ]
   }
