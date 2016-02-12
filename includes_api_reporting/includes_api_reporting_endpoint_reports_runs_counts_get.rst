.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``GET`` method is used to return the frequency of |chef client| runs, per-minute, per-hour, per-day, or per-week.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``granularity``
     - Required. The length of time for which |chef client| run counts are returned. Possible values: ``hour``, ``minute``, ``day``, or ``week``.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/runs/counts

**Response**

The response is similar to:

.. code-block:: javascript

   {
   
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``404``
     - |response code 404 not found|
   * - ``406``
     - Invalid request. The protocol version is incorrect.
