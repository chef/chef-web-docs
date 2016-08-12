.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of users on the |chef server|.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users

**Response**

The response is similar to:

.. code-block:: none

   {
     "user1"=> "https://url/for/user1"
     "user2"=> "https://url/for/user2"
	 ...
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
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|

**Optional Filtering**

 Filtering on ``/users`` can be done with the ``external_authentication_uid``. This is to support SAML authentication.

 As an example, to retrieve users whos ``external_authentication_uid`` is ``jane@doe.com``, you would do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

*New in Chef server 12.7.*

