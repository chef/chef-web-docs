.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``/_status`` endpoint can be used to check the health of the |delivery| server. A |delivery| instance may be configured as a standalone server or as a disaster recovery pair with primary and standby servers. The response from this endpoint depends on the type of configuration. This endpoint is located at ``/_status``.

**Request**

.. code-block:: xml

   GET /_status

This method has no request body.

**Response**

For a standalone server, the response will be similar to:

.. code-block:: javascript

   {
     "status": "pong",
     "configuration mode": "standalone",
     "upstreams": [
       {
         "postgres": {
           "status": "pong",
         },
         "lsyncd": {
           "status": "not_running",
         }
       }
     ]
   }


For the primary server in a disaster recovery pair, the response will be similar to:

.. code-block:: javascript

   {
     "status": "pong",
     "configuration mode": "primary",
     "upstreams": [
       {
         "postgres": {
           "status": "pong",
           "standby_ip_address": "192.168.33.13",
           "pg_current_xlog_location": "0/3000D48"
         },
         "lsyncd": {
           "status": "not_running",
           "latency": "0"
         }
       }
     ]
   }


For the standby server in a disaster recovery pair, the response will be similar to:

.. code-block:: javascript

   {
     "status": "pong",
     "configuration mode": "cold_standby",
     "upstreams": [
       {
         "postgres": {
           "status": "pong",
           "pg_last_xlog_receive_location": "0/3000D48"
         },
         "lsyncd": {
            "status": "pong",
         }
       }
     ]
   }


**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - All communications are OK. 
   * - ``500``
     - One (or more) services are down. For example:
       
       .. code-block:: javascript
       
          {
            "status": "fail",
            "configuration mode": "cold_standby",
            "upstreams": [
              {
                "postgres": {
                "status": "fail",
                  "pg_last_xlog_receive_location": "0/3000D48"
              },
              "lsyncd": {
                "status": "not_running",
              }
            }
          ]
        }
