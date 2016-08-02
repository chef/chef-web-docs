.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This endpoint opens a Server-Sent-Events (SSE) feed with the Push Jobs server.

This method has no parameters.

The Accept header for this request must be ``application/event-stream``.

As specified in the SSE protocol, you may request all events since a particular ID by including the optional ``Last-Event-ID`` Header.
If the ID is omitted, or not recognized, the stream will start from the beginning of the job.

**Completed Jobs**
In the job feed, for a brief period after a job completes, the event stream will remain available. The request will behave as normal,
which means the client will see the stream of events from the beginning of the job (or if specified, the ``Last-Event-ID``), through to
the job completion, and then the connection will be immediately closed by the server. The amount of time before it completes is configurable,
but defaults to 5 seconds.

If a request is made for the feed after the waiting period, then the request will result in a single event, a "summary" event, which contains
the same data as requesting a named-job resource. In this case, any ``Last-Event-ID`` will be ignored.


**Request**

.. code-block:: xml

   Accept: text/event-stream
   GET /organizations/ORG_NAME/pushy/jobs_status_feed/JOBID

**Response**

The response will return something similar to:

.. code-block:: xml

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d1
   data: {"timestamp":"2014-07-10 05:17:40.995958Z","command":"ls /etc/chef","run_timeout":300,"user":"rebecca","quorum":2,"node_count":2}

   event: quorum_vote
   id: dcd37f50-2d77-4761-895b-33134dbf87d2
   data: {"timestamp":"2014-07-10 05:17:41.995958Z","node":"NODE1","status":"success"}

   event: quorum_vote
   id: dcd37f50-2d77-4761-895b-33134dbf87d3
   timestamp:
   data: {"timestamp":"2014-07-10 05:17:42.995958Z","node":"NODE2","status":"success"}

   event: quorum_succeeded
   id: dcd37f50-2d77-4761-895b-33134dbf87d4
   data: {"timestamp":"2014-07-10 05:17:43.995958Z"}

   event: run_start
   id: dcd37f50-2d77-4761-895b-33134dbf87d5
   data: {"timestamp":"2014-07-10 05:17:44.995958Z","node":"NODE1"}

   event: run_start
   id: dcd37f50-2d77-4761-895b-33134dbf87d6
   data: {"timestamp":"2014-07-10 05:17:45.995958Z","node":"NODE2"}

   event: run_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d7
   data: {"timestamp":"2014-07-10 05:17:46.995958Z","node":"NODE1","status":"success"}

   event: run_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d58
   timestamp: "
   data: {"timestamp":"2014-07-10 05:17:47.995958Z","node":"NODE2","status":"success"}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d9
   data": {"timestamp":"2014-07-10 05:17:48.995958Z","status":"complete"}

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``204``
     - No Content. Do not reconnect.
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
