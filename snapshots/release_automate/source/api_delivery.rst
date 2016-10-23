.. THIS PAGE IS IDENTICAL TO docs.chef.io/api_delivery.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/delivery/ PATH.

=====================================================
Chef Automate API
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The Chef Automate API is a REST API that provides access to the ``_status`` object on the Chef Automate server.

The Chef Automate API is located at https://hostname/api/.

_status
=====================================================
The ``/_status`` endpoint can be used to check the health of the Chef Automate server. A Chef Automate instance may be configured as a standalone server or as a disaster recovery pair with primary and standby servers. The response from this endpoint depends on the type of configuration. This endpoint is located at ``/_status``.

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

The top-level ``status`` value refers to the state of the core Chef Automate server only. It will return ``pong`` as long as the Chef Automate server is healthy even if there's a problem with one of the upstream systems; however, a response code of 500 will be returned in that case (as described in the response code section below). 

.. note:: ``lsyncd`` should always report a status of ``not_running`` in a standalone configuration: any other value would indicate that it's configured when it shouldn't be (``lsync`` should only run on a disaster recovery primary).

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
           "status": "pong",
           "latency": "0"
         }
       }
     ]
   }

In this configuration, the ``postgres`` and ``lsyncd`` upstreams will indicate the current state of disaster recovery replication.  For PostgreSQL, it will both indicate that it knows what the standby IP is supposed to be and the current ``location``. If the PostgreSQL replication is working correctly, it should match the value of the PostgreSQL ``xlog`` location reported by the standby (see below).

For ``lsyncd``, if the replication is up-to-date, ``latency`` should return 0; it may be above zero if changes have been queued up for replication, but it should quickly drop back down once the ``lsyncd`` server syncs changes (which should happen either after a fixed delay or when a certain number of changes have queued up). If it instead maintains a number above zero (or even continues to grow), that would indicate that there's an issue replicating git data in Chef Automate.

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
            "status": "not_running",
         }
       }
     ]
   }

In this configuration, ``lsyncd`` should not be running; any other value would indicate a problem. For ``postgres``, if the replication is up-to-date, the ``location`` should match the value of the location on the primary it's replicating. If it's lagging (or behind and doesn't change), that would indicate an issue with PostgreSQL replication.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - All services are OK. The response will show the service status as ``pong`` or ``not_running``. For example:
       
       .. code-block:: javascript
       
          {
            "status": "pong",
            "configuration mode": "standalone",
            "upstreams": [
              {
                "postgres": {
                  "status": "pong"
                },
                "lsyncd": {
                  "status": "not_running"
                }
              }
            ]
          }

   * - ``500``
     - One (or more) services are down. The response will show the service status as ``fail`` or ``degraded``. For example:
       
       .. code-block:: javascript
       
          {
            "status": "pong",
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
            ]
          }

       For example, if replication is not running:

       .. code-block:: javascript
       
          {
            "status": "pong",
            "configuration mode": "primary",
            "upstreams": [
              {
                "postgres": {
                  "status": "degraded",
                  "replication": "fail",
                  "description": "Replication is not running. Check your configuration."
                },
                "lsyncd": {
                  "status": "pong",
                  "latency": "0"
                }
              }
            ]
          }
