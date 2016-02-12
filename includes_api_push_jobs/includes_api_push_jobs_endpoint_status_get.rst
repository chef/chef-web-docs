.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the current job status.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /_status

**Response**

The response is similar to:

.. code-block:: ruby

   {
     "status": "complete"
   }

The following values are possible: ``new``, ``voting``, ``running``, ``complete``, ``quorum_failed``, ``crashed``, ``aborted``, or ``timed_out``.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
