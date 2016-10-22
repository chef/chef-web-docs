.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to return a list of the most recent cookbook versions.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/_latest

**Response**

For example, if cookbooks ``foo`` and ``bar`` both exist on the Chef server and both with versions ``0.1.0`` and ``0.2.0``, the response is similar to:

.. code-block:: javascript

  {
    "foo": "https://localhost/cookbooks/foo/0.2.0",
    "bar": "https://localhost/cookbooks/bar/0.2.0"
  }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
