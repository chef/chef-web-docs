.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to display the content of all groups on the server:

.. code-block:: bash

   $ knife xargs --pattern '/groups/*' cat

and will return something like:

.. code-block:: javascript

   {
     "name": "4bd14db60aasdfb10f525400cdde21",
     "users": [
       "grantmc"
     ]
   }{
     "name": "62c4e268e15fasdasc525400cd944b",
     "users": [
       "robertf"
     ]
   }{
     "name": "admins",
     "users": [
       "grantmc",
       "robertf"
     ]
   }{
     "name": "billing-admins",
     "users": [
       "dtek"
     ]
   }{
     "name": "clients",
     "clients": [
       "12345",
       "67890",
     ]
   }{
     "name": "users",
     "users": [
       "grantmc"
       "robertf"
       "dtek"
     ],
     "groups": [
       "4bd14db60aasdfb10f525400cdde21",
       "62c4e268e15fasdasc525400cd944b"
     ]
   }
