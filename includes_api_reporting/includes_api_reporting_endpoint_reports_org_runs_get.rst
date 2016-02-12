.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``GET`` method is used to return information about |chef client| runs for all nodes in the specified organization. 

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``from``
     - Optional. Use to specify the time before which node data will not be returned. Use with ``until`` to define a range.
   * - ``rows``
     - Optional. The number of resources to return. Default value: ``10``.
   * - ``start``
     - Optional. The row at which the results will start. Default value: ``0``.
   * - ``status``
     - Optional. Use to specify a status code. When a status code is provided, only nodes with that status will be returned. When a status code is not provided, all nodes will be returned. Possible values: ``aborted``, ``failure``, or ``success``.
   * - ``until``
     - Optional. Use to specify the time after which node data will not be returned. Use with ``until`` to define a range.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/org/runs

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
