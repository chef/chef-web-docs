.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get details for the current user.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /user
   
**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "applejack",
     "properties": {
       "avatar_url": "https://gravatar.com/avatar/0a5549591ec94521799d8d44b17d3432.png?d=mm",
       "email": "applejack@mylittlepony.com",
       "gravatar_id": "0a5549591ec94543299d8d44b17d3432"
     },
     "endpoint": "/users/applejack",
     "organizations": [
       {
         "name": "ponyville",
         "endpoint": "/organizations/ponyville",
         "profile_url": "https://api.opscode.piab/organizations/ponyville/users/applejack"
       },
     ],
     "searches": []
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|

