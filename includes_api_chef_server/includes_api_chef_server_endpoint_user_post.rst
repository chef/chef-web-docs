.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new user. If a public key is not specified, both public and private keys will be generated and returned. If a public key is specified, only the public key will be returned.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /users/USER_NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "Robert Forster"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Robert Forster",
     "private_key": "-----BEGIN PRIVATE KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PRIVATE KEY-----"
     "admin": true
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - |response code 201 created|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``409``
     - |response code 409 conflict|
   * - ``413``
     - |response code 413 entity_too_large|

