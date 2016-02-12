.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to authenticate a user. This endpoint is used by the Chef Identity Service to authenticate users of |supermarket| and |chef analytics| to the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/authenticate_user

with a request body similar to:

.. code-block:: javascript

   {
     "username" : "grantmc"
     "password" : "p@ssw0rd"
   }

**Response**

This method has no response body.

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

