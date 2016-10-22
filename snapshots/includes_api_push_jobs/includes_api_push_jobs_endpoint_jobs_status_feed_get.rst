.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This endpoint opens a Server-Sent-Events (SSE) feed for job starts and completions within the entire organization.

This method has no parameters.

The Accept header for this request must be ``application/event-stream``.

As specified in the SSE protocol, you may request all events since a particular ID by including the optional ``Last-Event-ID`` Header.
If this header is not included, no events will be produced until the next activity in the organization produces an event. If the ``Last-Event-ID``
header is passed but not recognized, it is assumed that the ID has already expired, and the feed will produce the events as far back as are recorded,
proceeded by a synthetic ``start_of_history``. The expiration time of organization events is 60 seconds (configurable).

**Request**

.. code-block:: xml

   Accept: text/event-stream
   Last-Event-ID: dcd37f50-2d77-4761-895b-33134dbf87d1
   GET /organizations/ORG_NAME/pushy/jobs_status_feed

**Response**

The response will return something similar to:

.. code-block:: xml

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d1
   data: {"timestamp":"2014-07-10 05:10:40.995958Z","job":"B","command":"chef-client","run_timeout":300,"user":"rebecca","quorum":2,"node_count":2}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d2
   data: {"timestamp":"2014-07-10 05:15:48.995958Z","job":"A","status":"success"}

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d3
   data: {"timestamp":"2014-07-10 05:17:40.995958Z","job":"C","command":"cat /etc/passwd","run_timeout":300,"user":"charles","quorum":2,"node_count":2}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d4
   data: {"timestamp":"2014-07-10 05:17:41.995958Z","job":"C","status":"success"}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d5
   data: {"timestamp":"2014-07-10 05:20:48.995958Z","job":"B","status":"success"}

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``204``
     - No Content. Do not reconnect.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
