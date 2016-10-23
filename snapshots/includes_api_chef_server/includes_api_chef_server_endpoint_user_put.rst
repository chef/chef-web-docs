.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``PUT`` method is used to update a specific user. If values are not specified for the ``PUT`` method, the Chef server will use the existing values rather than assign default values.

``PUT`` accepts a boolean: ``{ "private_key": "true" }``. If this is specified, a new private key is generated.

If values are missing, they will not be overwritten. If ``public_key`` is null, the public key will not be overwritten.

.. note:: ``PUT`` supports renames. If ``PUT /users/foo`` is requested with ``{ "name: "bar""}``, then it will rename ``foo`` to ``bar`` and all of the content previously associated with ``foo`` will be associated with ``bar``.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /users/NAME

with a request body similar to:

.. code-block:: none

   POST /users { "name": "Grant McLennan" }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Grant McLennan",
     "private_key": "-----BEGIN PRIVATE KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PRIVATE KEY-----"
     "admin": false
   }

If a new private key was generated, both the private and public keys are returned.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created. (This response code is only returned when the user is renamed.)
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action. (This response code is only returned when a user is renamed, but a user already exists with that name.)
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
