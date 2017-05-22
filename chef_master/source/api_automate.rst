=====================================================
Chef Automate API
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The Chef Automate API is a REST API.

Authentication Methods
=====================================================

Authentication to the Chef Automate server occurs via a specific set of HTTP headers and two types of tokens:

* ``user token`` is a short-lived (seven days) token and can be obtained from the Chef Automate dashboard by entering this URL in your browser:
  
  .. code-block:: none

     https://YOUR_AUTOMATE_HOST/e/YOUR_AUTOMATE_ENTERPRISE/#/dashboard?token

* ``data_collector token`` is a long-lived token that can be set for your Chef Automate instance in ``/etc/delivery/delivery.rb``. Add ``data_collector['token'] = 'sometokenvalue'``, save your changes and then run ``sudo automate-ctl reconfigure``.

Required Headers
-----------------------------------------------------

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
=====================================================


/api/_status
-----------------------------------------------------
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
   :widths: 100 400
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

.. _compliance-profile-api:

/compliance/profiles/OWNER
-----------------------------------------------------
The Chef Automate server may store multiple compliance profiles, namespaced by owners.

The endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of compliance profiles namespaced by OWNER on the Chef Automate server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /compliance/profiles/OWNER

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: none

   {
     "linux": {
       "id": "linux",
       "name": "linux",
       "title": "Basic Linux",
   ...
   }

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
     - Not Found. The OWNER specified in the request was not found.


POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to upload a compliance profile(as a tarball) namespaced by OWNER.

This method has no parameters.

**Request**

.. code-block:: none

   POST /compliance/profiles/OWNER

For example:

.. code-block:: bash

   tar -cvzf /tmp/newprofile.tar.gz /home/user/newprofile
   curl -X POST "https://my-auto-server.test/compliance/profiles/john" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..." \
   --form "file=@/tmp/newprofile.tar.gz"

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


/compliance/profiles/OWNER/PROFILE
-----------------------------------------------------
Endpoint targeting specific compliance profile.

The following methods are available: ``GET`` and ``DELETE``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return details of a particular profile.

This method has no parameters.

**Request**

.. code-block:: none

   GET /compliance/profiles/OWNER/PROFILE

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux" \
   -H "chef-delivery-enterprise: acme" \
   -H "chef-delivery-user: john" \
   -H "chef-delivery-token: 7djW35..."

**Response**

The response is similar to:

.. code-block:: none

   {
     "id": "linux",
     "owner": "john",
     "name": "linux",
     "title": "Basic Linux",
       "controls": {
        "basic-1": {
   ...
   }

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
     - Not Found. The OWNER specified in the request was not found.


DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to remove a particular profile.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /compliance/profiles/OWNER/PROFILE

For example:

.. code-block:: bash

   curl -X DELETE "https://my-auto-server.test/compliance/profiles/john/linux" \
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
     - Not Found. The OWNER or PROFILE specified in the request was not found.


/compliance/profiles/OWNER/PROFILE/tar
-----------------------------------------------------

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` is used to download a profile as a tarball.

This method has no parameters.

**Request**

.. code-block:: none

   GET /compliance/profiles/OWNER/PROFILE/tar

For example:

.. code-block:: bash

   curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux" \
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
     - Not Found. The OWNER or PROFILE specified in the request was not found.
