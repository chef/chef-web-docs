.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get output from a channel (``STDOUT`` or ``STDERR``) for an individual job.

This method has no parameters.

The Accept header for this request must be ``application/octet-stream``.

**Request**

.. code-block:: xml

   Accept: application/octet-stream
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE_NAME/stdout

**Response**

The response will return something similar to:

.. code-block:: xml

    Starting Chef Client, version 12.11.18

    ...

    Converging 23 resources

    Running handlers:
    Running handlers complete
    Chef Client finished, 23/187 resources updated in 15 seconds

**Request**

.. code-block:: xml

   Accept: application/octet-stream
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE_NAME/stderr

**Response***

The response will return something similar to:

.. code-block:: xml

    bash: no such file or directory: /usr/local/run.sh

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
