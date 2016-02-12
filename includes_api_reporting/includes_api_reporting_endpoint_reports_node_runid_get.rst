.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``GET`` method is used to return a list of resources for a given |reporting| run identifier. 

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``detail``
     - Optional. When ``true``, include the ``run_detail`` |json| object in the output. Default value: ``false``.
   * - ``rows``
     - Optional. The number of resources to return. Default value: ``10``.
   * - ``start``
     - Optional. The row at which the results will start. Default value: ``0``.

**Request**

.. code-block:: xml

   GET /organizations/ORG/reports/nodes/NODE/runs/RUNID

**Response**

The response is similar to:

.. code-block:: javascript

   {
     run_resources :  [
       {
         "uri" : uri,
         "cookbook_name" : string,
         "cookbook_version" : string,
         "duration" : numeric string - milliseconds,
         "id" : string,
         "type" : string,
         "name" : string,
         "result" : string,
         "initial_state" : json-object,
         "final_state" : json-object,
       }
     ],
     run_detail :
       {
         "node_name" : string,
         "updated_res_count" : integer,
         "total_res_count" : integer,
         "run_list" : string ??? TODO: Verify this is correct
         "start_time" : timestamp
         "end_time" : timestamp
         "data" : { 0..1 exception-record },
         "status"
       }
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
