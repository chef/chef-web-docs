.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the STDOUT, or STDERR, of an individual job.

This method has no parameters.

The Accept header for this request must be ``application/octet-stream``

**Request**

.. code-block:: xml

   Accept: application/octet-stream
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE/stdout

**Response***

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
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE/stderr

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
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
