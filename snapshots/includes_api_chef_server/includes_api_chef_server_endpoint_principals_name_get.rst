.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of public keys for clients and users in order to ensure that enough information is present for authorized requests.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/principals/NAME

**Response**

For a user, the response is similar to:

.. code-block:: javascript

   {
     "name": "normal_user",
     "type": "user",
     "public_key": "-----BEGIN PUBLIC KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PUBLIC KEY-----"
   }

and for a client, similar to:

.. code-block:: javascript

   {
     "name": "client_node",
     "type": "client",
     "public_key": "-----BEGIN PUBLIC KEY-----\n
                   MIEfGVG0GCSqGSIb3DQEBAQUAA4RRFEDCVgftg67j8dgsdfges0rgEW1updSxygB\n
                   wmVpDnHuqwe7/gbh+PmY49EZsfrZSbKgSKy+rxKJHREGJ5tgCtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLt5FGH1Ma/VzHnFqoOeSCKHDhmHwJAjGDTPAgCJQiI\n
                   elk8UFCN45Jj0/xBwIDAQAB\n
                   -----END PUBLIC KEY-----"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.
