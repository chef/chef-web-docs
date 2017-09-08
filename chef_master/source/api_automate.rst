=================
Chef Automate API
=================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The Chef Automate API is a REST API.

Stability Index
===============

Stability: 0 - Deprecated
-------------------------

This feature is known to be problematic, and changes are planned. Do not rely on it. Use of the feature may cause warnings. Backwards compatibility should not be expected.

Stability: 1 - Experimental
---------------------------

This feature is subject to change. It may change or be removed in future versions.

Stability: 2 - Stable
---------------------

The API has proven satisfactory. Compatibility is a high priority, and will not be broken unless absolutely necessary.

Authentication Methods
======================

Authentication to the Chef Automate server occurs via a specific set of HTTP headers and two types of tokens:

* ``user token`` is a short-lived (seven days) token and can be obtained from the Chef Automate dashboard by entering this URL in your browser:

  .. code-block:: none

     https://YOUR_AUTOMATE_HOST/e/YOUR_AUTOMATE_ENTERPRISE/#/dashboard?token

* ``data_collector token`` is a long-lived token that can be set for your Chef Automate instance in ``/etc/delivery/delivery.rb``. Add ``data_collector['token'] = 'sometokenvalue'``, save your changes and then run ``sudo automate-ctl reconfigure``.

Required Headers
----------------

The following authentication headers are required:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Feature
     - Description
   * - ``chef-delivery-enterprise``
     - .. tag api_chef_automate_headers_enterprise

       The name of the Chef Automate enterprise to use.

       .. end_tag

   * - ``chef-delivery-user``
     - .. tag api_chef_automate_headers_delivery_user

       The Chef Automate user to use for the API calls.

       .. end_tag

   * - ``chef-delivery-token``
     - .. tag api_chef_automate_headers_delivery_token

       The Chef Automate user token used in conjunction with ``chef-delivery-user``.

       .. end_tag

   * - ``x-data-collector-auth``
     - .. tag api_chef_automate_headers_data_collector_auth

       Set this to ``version=1.0`` in order to use the long-lived ``data_collector`` authentication instead of authenticating via ``chef-delivery-user`` and ``chef-delivery-token``.

       .. end_tag

   * - ``x-data-collector-token``
     - .. tag api_chef_automate_headers_data_collector_token

       The value of the ``data_collector`` token as set in ``/etc/delivery/delivery.rb`` if ``x-data-collector-auth`` is used.

       .. end_tag


The Chef Automate API is located at ``https://hostname`` and has the following endpoints:

API Endpoints
=============


/api/_status
------------
The ``/api/_status`` endpoint can be used to check the health of the Chef Automate server without authentication. A Chef Automate instance may be configured as a standalone server or as a disaster recovery pair with primary and standby servers. The response from this endpoint depends on the type of configuration. This endpoint is located at ``/api/_status``.

**Request**

.. code-block:: xml

   GET /api/_status

This method has no request body.

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/api/_status"

**Response**

For a standalone server, the response will be similar to:

.. code-block:: json

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

.. code-block:: json

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

.. code-block:: json

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
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - All services are OK. The response will show the service status as ``pong`` or ``not_running``. For example:

       .. code-block:: json

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

       .. code-block:: json

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
                  "status": "not_running"
                }
              }
            ]
          }

       For example, if replication is not running:

       .. code-block:: json

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

Compliance API
==============

Filters
-------

As the name implies, filters serve to narrow the scope of a search. There are many endpoints in the Compliance API that
support filters.  For each endpoint that supports filters, ``filter`` is listed as one of it's parameters.  In all cases
when ``filter`` is included as a parameter, all filters listed below are allowed for inclusion.

+----------------+--------------------------------------------------+
| Name           | Filters search results based on scans that have: |
+================+==================================================+
|``start_time``  | end_times that are >= ``start_time``             |
+----------------+--------------------------------------------------+
|``end_time``    | end_times that are <= ``end_time``               |
+----------------+--------------------------------------------------+
|``environment`` | run in ``environment``                           |
+----------------+--------------------------------------------------+
|``node_id``     | run on target with ``node_id``                   |
+----------------+--------------------------------------------------+
|``node_name``   | run on target with ``node_name``                 |
+----------------+--------------------------------------------------+
|``platform``    | run on ``platform``                              |
+----------------+--------------------------------------------------+
|``profile_id``  | run against this ``profile_id``                  |
+----------------+--------------------------------------------------+


.. note::
         Timestamps, are returned in and **must** be written in RFC 3339 format.
         The following are examples of acceptable ``start_time`` and ``end_time`` values for inclusion in a filter:

            - ``2017-03-06T09:18:40Z``
            - ``2017-03-06T09:18:40+00:00``

.. _compliance-market-api:

/compliance/market
------------------
The Chef Automate server may store multiple compliance profiles.

The endpoint has the following methods: ``GET``.

GET (profiles)
++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get a list of compliance market profiles on the Chef Automate server.

**Request**

.. code-block:: none

   GET /compliance/market/profiles

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/market/profiles" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

    [
      {
        "name": "linux-baseline",
        "title": "DevSec Linux Security Baseline",
        "maintainer": "DevSec Hardening Framework Team",
        "copyright": "DevSec Hardening Framework Team",
        "copyright_email": "hello@dev-sec.io",
        "license": "Apache 2 license",
        "summary": "Test-suite for best-practice Linux OS hardening",
        "version": "2.1.0",
        "supports": [
          {
            "os-family": "linux"
          }
        ],
        "depends": null
      },
      {
        "name": "postgres-baseline",
        "title": "Hardening Framework Postgres Hardening Test Suite",
        "maintainer": "DevSec Hardening Framework Team",
        "copyright": "DevSec Hardening Framework Team",
        "copyright_email": "hello@dev-sec.io",
        "license": "Apache 2 license",
        "summary": "Test-suite for best-practice postgres hardening",
        "version": "2.0.1",
        "supports": [
          {
            "os-family": "unix"
          }
        ],
        "depends": null
      },
      {
        "name": "ssh-baseline",
        "title": "DevSec SSH Baseline",
        "maintainer": "DevSec Hardening Framework Team",
        "copyright": "DevSec Hardening Framework Team",
        "copyright_email": "hello@dev-sec.io",
        "license": "Apache 2 license",
        "summary": "Test-suite for best-practice SSH hardening",
        "version": "2.2.0",
        "supports": [
          {
            "os-family": "unix"
          }
        ],
        "depends": null
      }
    ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.

GET (profile by ``:name``)
++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get the profile of a given ``:name``.

**Request**

.. code-block:: none

   GET /compliance/market/profiles/:name

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/market/profiles/linux-baseline" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
      {
         "name": "linux-baseline",
         "title": "DevSec Linux Security Baseline",
         "maintainer": "DevSec Hardening Framework Team",
         "copyright": "DevSec Hardening Framework Team",
         "copyright_email": "hello@dev-sec.io",
         "license": "Apache 2 license",
         "summary": "Test-suite for best-practice Linux OS hardening",
         "version": "2.1.0",
         "supports": [
            {
               "os-family": "linux"
            }
         ],
         "depends": null
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.

GET (profile by ``:name`` & ``:version``)
+++++++++++++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get one specific :version of a profile of a given ``:name``.

**Request**

.. code-block:: none

   GET /compliance/market/profiles/:name/version/:version

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/market/profiles/linux-baseline/version/2.1.0" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
      {
         "name": "linux-baseline",
         "title": "DevSec Linux Security Baseline",
         "maintainer": "DevSec Hardening Framework Team",
         "copyright": "DevSec Hardening Framework Team",
         "copyright_email": "hello@dev-sec.io",
         "license": "Apache 2 license",
         "summary": "Test-suite for best-practice Linux OS hardening",
         "version": "2.1.0",
         "supports": [
            {
               "os-family": "linux"
            }
         ],
         "depends": null
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.

GET (profile tar by ``:name``)
++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get the latest version of a market profile tarball as specified by the ``:name`` parameter.

**Request**

.. code-block:: none

   GET /compliance/market/profiles/:name/tar

For example:

.. code-block:: bash

   curl -o linux-baseline.tar \
   "https://my-auto-server.test/compliance/market/profiles/linux-baseline/tar" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

TAR STREAM - download of the file requested (if it exists)


**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested profile was not found.

GET (profile tar by ``:name`` & ``:version``)
+++++++++++++++++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get the market profile tarball for the given ``:name`` and ``:version``.

**Request**

.. code-block:: none

   GET /compliance/market/profiles/:name/version/:version/tar

For example:

.. code-block:: bash

   curl -o linux-baseline.tar \
   "https://my-auto-server.test/compliance/market/profiles/linux-baseline/version/2.1.0/tar" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

TAR STREAM - download of the file requested (if it exists)


**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested profile was not found.


.. _compliance-nodes-api:

/compliance/nodes
-----------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then aggregate the compliance results from the
latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (nodes)
+++++++++++
Stability: **2 - Stable**

The ``GET`` method returns aggregated compliance results across one or more nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``order``   | string     || The direction of the sort.                     | ``desc``                  |
|             |            || Can be either ``asc`` or ``desc``.             |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``page``    | integer    | Page number for paginated data.                 |  ``1``                    |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``per_page``| integer    | Items per page.                                 |  ``10``                   |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``sort``    | string     || What to sort results by.                       | ``latest_report.end_time``|
|             |            || Can be any of the following:                   |                           |
|             |            |                                                 |                           |
|             |            | - ``environment``                               |                           |
|             |            | - ``latest_report.controls.failed.critical``    |                           |
|             |            | - ``latest_report.controls.failed.total``       |                           |
|             |            | - ``latest_report.end_time``                    |                           |
|             |            | - ``latest_report.status``                      |                           |
|             |            | - ``name``                                      |                           |
|             |            | - ``platform``                                  |                           |
|             |            | - ``status``                                    |                           |
+-------------+------------+-------------------------------------------------+---------------------------+


**Request**

.. code-block:: none

   GET /compliance/nodes

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/nodes" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "id": "74a54a28-c628-4f82-86df-61c43866db6a",
       "name": "teal-spohn",
       "platform": {
         "name": "centos"
       },
       "environment": "DevSec Prod Alpha",
       "latest_report": {
         "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
         "end_time": "2017-04-04T10:18:41+01:00",
         "status": "failed",
         "controls": {
           "total": 113,
           "passed": {
             "total": 22
           },
           "skipped": {
             "total": 68
           },
           "failed": {
             "total": 23,
             "minor": 0,
             "major": 0,
             "critical": 23
           }
         }
       }
     },
     {
       "id": "99516108-8126-420e-b03e-a90a52f25751",
       "name": "red-brentwood",
       "platform": {
         "name": "debian"
       },
       "environment": "DevSec Prod Zeta",
       "latest_report": {
         "id": "44024b50-2e0d-42fa-a57c-25e05e48a1b5",
         "end_time": "2017-03-06T09:18:41Z",
         "status": "failed",
         "controls": {
           "total": 59,
           "passed": {
             "total": 23
           },
           "skipped": {
             "total": 14
           },
           "failed": {
             "total": 22,
             "minor": 0,
             "major": 0,
             "critical": 22
           }
         }
       }
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

GET (node by ``:id``)
+++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get the profile of a given node ``:id``.

**Request**

.. code-block:: none

   GET /compliance/nodes/:id

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/nodes/74a54a28-c628-4f82-86df-61c43866db6a" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "id": "74a54a28-c628-4f82-86df-61c43866db6a",
     "name": "teal-spohn",
     "platform": {
       "name": "centos",
       "release": "5.11"
     },
     "environment": "DevSec Prod Alpha",
     "latest_report": {
       "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
       "end_time": "2017-04-04T10:18:41+01:00",
       "status": "failed",
       "controls": {
         "total": 113,
         "passed": {
           "total": 22
         },
         "skipped": {
           "total": 68
         },
         "failed": {
           "total": 23,
           "minor": 0,
           "major": 0,
           "critical": 23
         }
       }
     },
     "profiles": [
       {
         "name": "linux-baseline",
         "version": "2.0.1",
         "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015"
       },
       {
         "name": "ssh-baseline",
         "version": "2.1.1",
         "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68"
       }
     ]
   }

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``404``
     - Not Found. The resource was not found.
   * - ``500``
     - Internal Server Error. Problem on the backend.

.. _compliance-profile-api:

/compliance/profiles
--------------------
The Chef Automate server may store multiple compliance profiles, namespaced by owners.

The endpoint has the following methods: ``GET`` and ``POST``.

GET (by ``:owner``)
+++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get a list of compliance profiles namespaced by ``:owner`` on the Chef Automate server.

**Request**

.. code-block:: none

   GET /compliance/profiles/:owner

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "name": "linux-baseline",
       "title": "DevSec Linux Security Baseline",
       "maintainer": "DevSec Hardening Framework Team",
       "copyright": "DevSec Hardening Framework Team",
       "copyright_email": "hello@dev-sec.io",
       "license": "Apache 2 license",
       "summary": "Test-suite for best-practice Linux OS hardening",
       "version": "2.1.0",
       "supports": [
         {
           "os-family": "linux"
         }
       ],
       "depends": null
     },
     {
       "name": "ssh-baseline",
       "title": "DevSec SSH Baseline",
       "maintainer": "DevSec Hardening Framework Team",
       "copyright": "DevSec Hardening Framework Team",
       "copyright_email": "hello@dev-sec.io",
       "license": "Apache 2 license",
       "summary": "Test-suite for best-practice SSH hardening",
       "version": "2.2.0",
       "supports": [
         {
           "os-family": "unix"
         }
       ],
       "depends": null
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The :owner specified in the request was not found.


POST
++++
Stability: **2 - Stable**

The ``POST`` method is used to upload a compliance profile (as a tarball) namespaced by ``:owner``.

**Request**

.. code-block:: none

   POST /compliance/profiles/:owner

For example:

.. code-block:: bash

   tar -cvzf /tmp/new-profile.tar.gz /home/user/new-profile
   curl -X POST "https://my-auto-server.test/compliance/profiles/john" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..." \
   --form "file=@/tmp/new-profile.tar.gz"

**Response**

No Content

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Error. Profile check failed.


GET (by ``:owner`` & ``:name``)
+++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to return details of a particular profile ``:name`` belonging to an ``:owner``.

This method has no parameters.

**Request**

.. code-block:: none

   GET /compliance/profiles/:owner/:name

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "name": "linux-baseline",
       "title": "DevSec Linux Security Baseline",
       "maintainer": "DevSec Hardening Framework Team",
       "copyright": "DevSec Hardening Framework Team",
       "copyright_email": "hello@dev-sec.io",
       "license": "Apache 2 license",
       "summary": "Test-suite for best-practice Linux OS hardening",
       "version": "2.1.0",
       "supports": [
         {
           "os-family": "linux"
         }
       ],
       "depends": null
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The ``:profile`` specified in the request was not found.

GET (by ``:owner`` & ``:name`` & ``:version``)
++++++++++++++++++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to return details of a particular ``:version`` of a profile ``:name``, belonging to an ``:owner``.

This method has no parameters.

**Request**

.. code-block:: none

   GET /compliance/profiles/:owner/:name/version/:version

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "name": "linux-baseline",
       "title": "DevSec Linux Security Baseline",
       "maintainer": "DevSec Hardening Framework Team",
       "copyright": "DevSec Hardening Framework Team",
       "copyright_email": "hello@dev-sec.io",
       "license": "Apache 2 license",
       "summary": "Test-suite for best-practice Linux OS hardening",
       "version": "2.1.0",
       "supports": [
         {
           "os-family": "linux"
         }
       ],
       "depends": null
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The ``:profile`` specified in the request was not found.



DELETE
++++++
Stability: **2 - Stable**

The ``DELETE`` method is used to remove a particular ``:version`` of a profile ``:name``, belonging to an ``:owner``.

**Request**

.. code-block:: none

   DELETE /compliance/profiles/:owner/:name/version/:version

For example:

.. code-block:: bash

   curl -X DELETE "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

No Content

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The ``:owner`` or ``:name`` specified in the request was not found.

GET (profile tar by ``:owner`` and ``:name``)
+++++++++++++++++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` is used to download tarball of a particular a profile ``:name``, belonging to an ``:owner``.

**Request**

.. code-block:: none

   GET /compliance/profiles/:owner/:name/tar

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/tar" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..." > /tmp/profile.tar.gz

**Response**

TAR STREAM

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The ``:owner`` or ``:name`` specified in the request was not found.

GET (profile tar by ``:owner`` ``:name`` ``:version``)
++++++++++++++++++++++++++++++++++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` is used to download tarball of a particular ``:version`` of a profile ``:name``, belonging to an ``:owner``.

**Request**

.. code-block:: none

   GET /compliance/profiles/:owner/:name/version/:version/tar

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0/tar" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..." > /tmp/profile.tar.gz

**Response**

TAR STREAM

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The ``:owner`` or ``:profile`` specified in the request was not found.


.. _compliance-reports-api:

/compliance/reports
-------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), from the latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (reports)
+++++++++++++
Stability: **2 - Stable**

The ``GET`` method returns aggregated compliance results across one or more nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``order``   | string     || The direction of the sort.                     | ``desc``                  |
|             |            || Can be either ``asc`` or ``desc``.             |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``page``    | integer    | Page number for paginated data.                 |  ``1``                    |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``per_page``| integer    | Items per page.                                 |  ``10``                   |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``sort``    | string     || What to sort results by.                       | ``latest_report.end_time``|
|             |            || Can be any of the following:                   |                           |
|             |            |                                                 |                           |
|             |            | - ``node_name``                                 |                           |
|             |            | - ``latest_report.end_time``                    |                           |
|             |            | - ``latest_report.status``                      |                           |
|             |            | - ``latest_report.controls.failed.total``       |                           |
|             |            | - ``latest_report.controls.failed.critical``    |                           |
+-------------+------------+-------------------------------------------------+---------------------------+


**Request**

.. code-block:: none

   GET /compliance/reports

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/reports" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
       "node_id": "74a54a28-c628-4f82-86df-61c43866db6a",
       "node_name": "teal-spohn",
       "end_time": "2017-04-04T10:18:41+01:00",
       "status": "failed",
       "controls": {
         "total": 113,
         "passed": {
           "total": 22
         },
         "skipped": {
           "total": 68
         },
         "failed": {
           "total": 23,
           "minor": 0,
           "major": 0,
           "critical": 23
         }
       }
     },
     {
       "id": "bb93e1b2-36d6-439e-ac70-a41504242605",
       "node_id": "74a54a28-c628-4f82-86df-61c43866db6a",
       "node_name": "teal-spohn",
       "end_time": "2017-04-03T10:18:41+01:00",
       "status": "failed",
       "controls": {
         "total": 113,
         "passed": {
           "total": 22
         },
         "skipped": {
           "total": 68
         },
         "failed": {
           "total": 23,
           "minor": 0,
           "major": 0,
           "critical": 23
         }
       }
     },
     {
       "id": "44024b50-2e0d-42fa-a57c-25e05e48a1b5",
       "node_id": "99516108-8126-420e-b03e-a90a52f25751",
       "node_name": "red-brentwood",
       "end_time": "2017-03-06T09:18:41Z",
       "status": "failed",
       "controls": {
         "total": 59,
         "passed": {
           "total": 23
         },
         "skipped": {
           "total": 14
         },
         "failed": {
           "total": 22,
           "minor": 0,
           "major": 0,
           "critical": 22
         }
       }
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

GET (report by ``:id``)
+++++++++++++++++++++++
Stability: **2 - Stable**

The ``GET`` method is used to get the report of a given report ``:id``.

**Request**

.. code-block:: none

   GET /compliance/reports/:id

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/reports/74a54a28-c628-4f82-86df-61c43866db6a" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: none

   {
     "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
     "version": "1.17.0",
     "profiles": [
       {
         "name": "linux-baseline",
         "title": "DevSec Linux Security Baseline",
         "version": "2.0.1",
         "summary": "Test-suite for best-practice os hardening",
         "license": "",
         "copyright": "Hardening Framework Team",
         "copyright_email": "hello@hardening.io",
         "controls": [
         .
         .
         .
         ]
       }
     ]
   }

**Response Codes**

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The resource was not found.

.. _compliance-search-api:

/compliance/search/profiles
---------------------------
Retrieves a list of profile summary data, based on the filters and parameters listed below.

The endpoint has the following methods: ``GET``.

GET (list of profiles)
++++++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns a list of profile summary data filtered down using `Filters`_.

**Parameters**

The following parameters are applicable to /search/profiles:

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``order``   | string     || The direction of the sort.                     | ``desc``                  |
|             |            || Can be either ``asc`` or ``desc``.             |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``page``    | integer    | Page number for paginated data.                 |  ``1``                    |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``per_page``| integer    | Items per page.                                 |  ``10``                   |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``sort``    | string     || What to sort results by.                       | ``latest_report.end_time``|
|             |            || Can be any of the following:                   |                           |
|             |            |                                                 |                           |
|             |            | - ``node_name``                                 |                           |
|             |            | - ``latest_report.end_time``                    |                           |
|             |            | - ``latest_report.status``                      |                           |
|             |            | - ``latest_report.controls.failed.total``       |                           |
|             |            | - ``latest_report.controls.failed.critical``    |                           |
+-------------+------------+-------------------------------------------------+---------------------------+


**Request**

.. code-block:: none

   GET /compliance/search/profiles

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/search/profiles" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "name": "apache-baseline",
       "title": "DevSec Apache Baseline",
       "id": "65707cb4299e5e821c687f6d5a704ffd3e21f6139a9ad0cc3b438c343b129d8c",
       "version": "2.0.1"
     },
     {
       "name": "linux-baseline",
       "title": "DevSec Linux Security Baseline",
       "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
       "version": "2.0.1"
     },
     {
       "name": "linux-baseline",
       "title": "DevSec Linux Security Baseline",
       "id": "9f40334d8d485a70b7fd1c8387b0116a29512714c7bfb32a563ec3c97090ff59",
       "version": "2.1.0"
     },
     {
       "name": "ssh-baseline",
       "title": "DevSec SSH Baseline",
       "id": "f42d2f48c9acd48f52324d52ec575ca9028e405eb303f69cb34d79eb0e588b5c",
       "version": "2.2.0"
     },
     {
       "name": "ssh-baseline",
       "title": "DevSec SSH Baseline",
       "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68",
       "version": "2.1.1"
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not Found. The resource was not found.


.. _compliance-stats-api:

/compliance/stats/failures
--------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then aggregate the compliance results from the
latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (failures)
++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated stats failure results across one or more nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``size``    | integer    || The top <size> records make up the aggregation.| ``10``                    |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``types``   | string     || Required to have at least one type set.        |                           |
|             |            || A '+' delimited list of the following:         |                           |
|             |            |                                                 |                           |
|             |            | - ``control``                                   |                           |
|             |            | - ``environment``                               |                           |
|             |            | - ``platform``                                  |                           |
|             |            | - ``profile``                                   |                           |
+-------------+------------+-------------------------------------------------+---------------------------+


**Request**

.. code-block:: none

   GET /compliance/stats/failures

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/stats/failures?types=profile+control&size=3" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "profiles": [
       {
         "name": "linux-baseline",
         "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
         "failures": 2
       }
     ],
     "controls": [
       {
         "name": "os-02",
         "profile": "",
         "failures": 2
       },
       {
         "name": "os-05",
         "profile": "",
         "failures": 2
       },
       {
         "name": "sysctl-01",
         "profile": "",
         "failures": 2
       }
     ]
   }


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.

/compliance/stats/profiles
--------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (profiles)
++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated stats profile results across one or more nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``size``    | integer    || The number of profiles to consider in summary. | ``10000``                 |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/profiles

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/stats/profiles?size=4" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "name": "linux-baseline",
       "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
       "failures": 45,
       "majors": 0,
       "minors": 0,
       "criticals": 45,
       "passed": 45,
       "skipped": 0
     },
     {
       "name": "apache-baseline",
       "id": "65707cb4299e5e821c687f6d5a704ffd3e21f6139a9ad0cc3b438c343b129d8c",
       "failures": 0,
       "majors": 0,
       "minors": 0,
       "criticals": 0,
       "passed": 0,
       "skipped": 14
     },
     {
       "name": "ssh-baseline",
       "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68",
       "failures": 0,
       "majors": 0,
       "minors": 0,
       "criticals": 0,
       "passed": 0,
       "skipped": 68
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

GET (profile summary by ``:profile_id``)
++++++++++++++++++++++++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated stats profile summary results across one or more nodes per ``:profile_id``.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/profiles/:profile_id/summary

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/stats/profiles/b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015/summary?size=4" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "stats": {
       "failed": 45,
       "passed": 45,
       "skipped": 0,
       "failed_nodes": 2,
       "total_nodes": 2
     },
     "name": "linux-baseline",
     "title": "DevSec Linux Security Baseline",
     "supports": [
       {
         "os-family": "linux"
       }
     ],
     "version": "2.0.1",
     "license": "Apache 2 license",
     "maintainer": "Hardening Framework Team",
     "copyright": "Hardening Framework Team",
     "copyright_email": "hello@hardening.io",
     "summary": "Test-suite for best-practice os hardening"
   }


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

GET (profile controls stats by ``:profile_id``)
+++++++++++++++++++++++++++++++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated controls stats per ``:profile_id`` across latest scans on all or filtered nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/profiles/:profile_id/controls

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/stats/profiles/b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015/controls" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "control": "os-01",
       "title": "Trusted hosts login",
       "passed": 2,
       "failed": 0,
       "skipped": 0,
       "impact": 1
     },
     {
       "control": "os-02",
       "title": "Check owner and permissions for /etc/shadow",
       "passed": 0,
       "failed": 2,
       "skipped": 0,
       "impact": 1
     },
     {
       "control": "os-03",
       "title": "Check owner and permissions for /etc/passwd",
       "passed": 2,
       "failed": 0,
       "skipped": 0,
       "impact": 1
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

/compliance/stats/summary
-------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then provide summary including number of
nodes, environments, platforms and profiles, the pass or failed status, duration, and earliest scan start_time.

The endpoint has the following methods: ``GET``.

GET (summary)
+++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns summary data across latest scans on all or filtered nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/summary

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/stats/summary" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "stats": {
       "nodes": 2,
       "platforms": 2,
       "environments": 2,
       "profiles": 3
     },
     "status": "failed",
     "duration": 2505600.636833,
     "start_date": "2017-03-06T09:18:40Z"
   }

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

/compliance/stats/summary/controls
----------------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (summary controls)
++++++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated stats for all controls across latest scans on all or filtered nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/summary/controls

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/stats/summary/controls" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "failures": 45,
     "majors": 0,
     "minors": 0,
     "criticals": 45,
     "passed": 45,
     "skipped": 82
   }

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

/compliance/stats/summary/nodes
-------------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: ``GET``.

GET (summary nodes)
+++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns aggregated stats for all nodes across latest scans on all or filtered nodes.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/summary/nodes

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/stats/summary/nodes" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "compliant": 0,
     "skipped": 0,
     "noncompliant": 2,
     "high_risk": 2,
     "medium_risk": 0,
     "low_risk": 0
   }

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

/compliance/stats/trend/controls
--------------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), aggregate the control results from the latest scans, build a date histogram, and return it.

The endpoint has the following methods: ``GET``.

GET (controls trend)
++++++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns a date histogram of aggregated control-oriented compliance data.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``interval``| integer    || The granularity in seconds of the trend data.  | ``86400`` (#secs in a day)|
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/trend/controls

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/stats/trend/controls?filters=start_time:2017-04-01T00%3A00%3A00%2B00%3A00+end_time:2017-04-05T00%3A00%3A00%2B00%3A00&interval=86400" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "report_time": "2017-04-02T00:00:00+0000",
       "passed": 23,
       "failed": 22,
       "skipped": 14
     },
     {
       "report_time": "2017-04-03T00:00:00+0000",
       "passed": 23,
       "failed": 22,
       "skipped": 14
     },
     {
       "report_time": "2017-04-04T00:00:00+0000",
       "passed": 45,
       "failed": 45,
       "skipped": 82
     },
     {
       "report_time": "2017-04-05T00:00:00+0000",
       "passed": 45,
       "failed": 45,
       "skipped": 82
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

/compliance/stats/trend/nodes
-----------------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), aggregate the compliance
results from the latest scans, build a date histogram, and return it.

The endpoint has the following methods: ``GET``.

GET (nodes trend)
+++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns a date histogram  of aggregated node-oriented compliance data.

**Parameters**

+-------------+------------+-------------------------------------------------+---------------------------+
| Parameter   | Type       | Description                                     | Default                   |
+=============+============+=================================================+===========================+
| ``filters`` | string     || The search keywords, as well as any qualifiers.|                           |
|             |            || Any and all `Filters`_ may be used.            |                           |
+-------------+------------+-------------------------------------------------+---------------------------+
| ``interval``| integer    || The granularity in seconds of the trend data.  | ``86400`` (#secs in a day)|
+-------------+------------+-------------------------------------------------+---------------------------+

**Request**

.. code-block:: none

   GET /compliance/stats/trend/nodes

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/stats/trend/nodes?filters=start_time:2017-04-01T00%3A00%3A00%2B00%3A00+end_time:2017-04-05T00%3A00%3A00%2B00%3A00&interval=86400" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "report_time": "2017-04-02T00:00:00+0000",
       "passed": 0,
       "failed": 1,
       "skipped": 0
     },
     {
       "report_time": "2017-04-03T00:00:00+0000",
       "passed": 0,
       "failed": 1,
       "skipped": 0
     },
     {
       "report_time": "2017-04-04T00:00:00+0000",
       "passed": 0,
       "failed": 2,
       "skipped": 0
     },
     {
       "report_time": "2017-04-05T00:00:00+0000",
       "passed": 0,
       "failed": 2,
       "skipped": 0
     }
   ]


**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``500``
     - Internal Server Error. Problem on the backend.

.. _compliance-suggestions-api:

/compliance/suggestions
-----------------------
Get the latest scan data for all nodes (or nodes that match `Filters`_), then for each profile, aggregate the compliance
results from the latest scans and build a date histogram and return it.

The endpoint has the following methods: ``GET``.

GET (suggestions)
+++++++++++++++++
Stability: **1 - Experimental**

The ``GET`` method returns a date histogram  of aggregated node-oriented compliance data.

**Parameters**

+-------------+------------+---------------------------------------------+---------+
| Parameter   | Type       | Description                                 | Default |
+=============+============+=============================================+=========+
| ``type``    | string     || Required. The ``type`` for which           |         |
|             |            || we want suggestions.                       |         |
|             |            || The value can be any of the following:     |         |
|             |            |                                             |         |
|             |            | - ``environment``                           |         |
|             |            | - ``node``                                  |         |
|             |            | - ``platform``                              |         |
|             |            | - ``profile``                               |         |
+-------------+------------+---------------------------------------------+---------+
| ``text``    | string     || Required. The ``text`` we search for within|         |
|             |            || our type.                                  |         |
+-------------+------------+---------------------------------------------+---------+
| ``size``    | integer    | The number of suggestions we want.          | 10      |
+-------------+------------+---------------------------------------------+---------+

**Request**

.. code-block:: none

   GET /compliance/suggestions

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/suggestions?type=environment&text=Prod&size=5 \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   [
     {
       "text": "DevSec Prod Alpha",
       "score": 4.4892697
     },
     {
       "text": "DevSec Prod Zeta",
       "score": 3.9768348
     }
   ]

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad Request. Something is wrong with the request. Client should look closely at the request they're making.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.

.. _compliance-version-api:

/compliance/version
-------------------
Get the version of Compliance API.

The endpoint has the following methods: ``GET``.

GET (version)
+++++++++++++
Stability: **2 - Stable**

The ``GET`` method returns the version of the running Compliance API.

**Request**

.. code-block:: none

   GET /compliance/version

For example:

.. code-block:: bash

   curl -X GET \
   "https://my-auto-server.test/compliance/version \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: json

   {
     "api": "compliance",
     "version": "1.9.65"
   }

**Response Codes**

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user who made the request is not authorized to perform the action.
