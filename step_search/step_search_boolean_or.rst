.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To join queries using the ``OR`` boolean operator, enter the following:

.. code-block:: bash

   $ knife search sample "id:foo OR id:abc"

to return something like:
   
.. code-block:: bash

   {
     "total": 2,
     "start": 0,
     "rows": [
       {
         "comment": "an item named foo",
         "id": "foo",
         "animal": "pony"
       },
       {
         "comment": "an item named abc",
         "id": "abc",
         "animal": "unicorn"
       }
     ]
   }