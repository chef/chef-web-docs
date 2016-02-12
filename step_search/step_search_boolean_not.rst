.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To negate search results using the ``NOT`` boolean operator, enter the following:

.. code-block:: bash

   $ knife search sample "(NOT id:foo)"

to return something like:
   
.. code-block:: bash

   {
     "total": 4,
     "start": 0,
     "rows": [
       {
         "comment": "an item named bar",
         "id": "bar",
         "animal": "cat"
       },
       {
         "comment": "an item named baz",
         "id": "baz"
         "animal": "dog"
       },
       {
         "comment": "an item named abc",
         "id": "abc",
         "animal": "unicorn"
       },
       {
         "comment": "an item named qux",
         "id": "qux",
         "animal", "penguin"
       }
     ] 
   }
