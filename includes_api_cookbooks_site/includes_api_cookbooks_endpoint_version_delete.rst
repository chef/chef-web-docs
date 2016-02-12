.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to delete a cookbook version.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /cookbooks/cookbook_name/versions/version

**Response**

The response is similar to:

.. code-block:: javascript

  {
    "license": "Apache 2.0",
    "tarball_file_size": 18553,
    "version": "2.4.0",
    "average_rating": null,
    "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/apt",
    "file": "http://supermarket.chef.io/api/v1/cookbooks/apt/versions/2_4_0/download",
    "dependencies": {},
    "platforms": {
      "debian": ">= 0.0.0",
      "ubuntu": ">= 0.0.0"
    }
  }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| The cookbook version was deleted.
   * - ``400``
     - |response code 400 unsuccessful| The requested cookbook or cookbook version does not exist. For example:

       .. code-block:: javascript

          {
             "error_messages":
             ["Resource does not exist"],
             "error_code": "NOT_FOUND"
          }
   * - ``403``
     - |response code 403 unauthorized| The user is not authorized to delete the cookbook version. For example:

       .. code-block:: javascript

          {}
