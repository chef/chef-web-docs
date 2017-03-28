=====================================================
Automate API
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_analytics.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try :doc:`Chef Automate </chef_automate>`. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate/>`__.


.. end_tag

The Automate API is a REST API that provides access to objects on the Chef Analytics server, including actions, messages, and rules.

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Encryption
=====================================================
All connections to Chef Analytics from any web browser, any API client, and any service uses HTTPS. HTTP access to the Chef Analytics platform is not allowed.

Authentication
=====================================================
Chef Analytics uses token-based authentication to the Automate API.

User Access
-----------------------------------------------------
Users authenticate to the Automate API using an OAuth 2.0 token. Chef Analytics uses the Chef Identity service (**oc-id**) that is built into the Chef server as the identity source. When a user accesses Chef Analytics from a web browser, the web browser completes the OAuth negotiation with the **oc-id** service to ensure that the token is valid.

Service Access
-----------------------------------------------------
Services authenticate to the Automate API as a privileged user using a keyed-hash message authentication code (HMAC) and is based on a similar mechanism used by Amazon Web Services (AWS) services.

A request is authenticated by concatenating elements of the request to form a string. Then a private key calculates the request signature using the HMAC, which is then added to the request as a header.

After a request is authenticated, it will fetch its copy of the private key, and then uses it to compute a signature, which is then compared against the signature in the header. If these signatures match, the service is authorized. If these signatures do not match, the system responds with an error message.

Endpoints
=====================================================
The following endpoints may be accessed globally.

/actions/ID
-----------------------------------------------------
The ``/actions/ID`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get the details for the specified action.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /actions/ID

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/actions/ID/payload
-----------------------------------------------------
The ``/actions/ID/payload`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get payload details for the specified action.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /actions/ID/payload

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/audits/ID
-----------------------------------------------------
The ``/audits/ID`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get details for the specified audit.

**Request**

.. code-block:: xml

   GET /organizations/NAME/audits/ID

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
     - OK. The request was successful.

/authentication-configuration
-----------------------------------------------------
The ``/authentication-configuration`` endpoint enables client-side JavaScript applications to connect to the **oc-id** service (an OAuth provider) by using `OAuth 2.0 Implicit flow <http://tools.ietf.org/html/rfc6749#section-1.3.2>`_. This endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get OAuth 2.0 configuration details.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /authentication-configuration

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "client_id": "abf783ad98b53496asdfe3d682f5c70b68fddsdff87c463b128d540587ab9f",
     "profile_uri": "https://api.opscode.piab/id/v1/me",
     "redirect_uri": "https://analytics.opscode.piab/auth/chef/callback",
     "scope": "",
     "site": "https://api.opscode.piab/id"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.

.. internal API used by webhooks
..
.. /messages
.. -----------------------------------------------------
.. .. include:: ../includes_api_analytics/includes_api_analytics_endpoint_messages.rst
..
.. POST
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../includes_api_analytics/includes_api_analytics_endpoint_messages_post.rst
..

/organization/NAME
-----------------------------------------------------
The ``/organizations/NAME`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get the details for the named organization.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/searches
-----------------------------------------------------
The ``/searches`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of searches, optionally by page number.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``page``
     - The page number to return.

**Request**

.. code-block:: xml

   GET /searches

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new rule for the named organization.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /searches

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "active": {
         "type": "boolean"
       },
       "name": {
         "description": "Rule name",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "rule": {
         "description": "text of rule",
         "type": "string"
       },
       "with": {
         "type": "object",
         "properties": {
           "priority": {
             "type": "integer"
           }
         },
         "required": ["priority"]
       }
     },
     "required": [ "rule", "modified_by", "with", "active"]
   }

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/searches/ID
-----------------------------------------------------
The ``/searches/ID`` endpoint has the following methods: ``DELETE``, ``GET``, ``POST``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a search item.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /searches/ID

This method has no request body.

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a search item.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /searches/ID

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new search item.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /searches/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "description": {
         "type": "string"
       },
       "id": {
         "type": "integer",
         "format": "uint"
       },
       "query": {
         "type": "string",
         "format": "search-query"
       }
     }
   }

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to modify an existing search item.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /searches/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "description": {
         "type": "string"
       },
       "id": {
         "type": "integer",
         "format": "uint"
       },
       "query": {
         "type": "string",
         "format": "search-query"
       }
     }
   }

**Response**

The response will return the JSON for the updated search item.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/user
-----------------------------------------------------
The ``/user`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get details for the current user.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /user

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "applejack",
     "properties": {
       "avatar_url": "https://gravatar.com/avatar/0a5549591ec94521799d8d44b17d3432.png?d=mm",
       "email": "applejack@mylittlepony.com",
       "gravatar_id": "0a5549591ec94543299d8d44b17d3432"
     },
     "endpoint": "/users/applejack",
     "organizations": [
       {
         "name": "ponyville",
         "endpoint": "/organizations/ponyville",
         "profile_url": "https://api.opscode.piab/organizations/ponyville/users/applejack"
       },
     ],
     "searches": []
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.

Organization Endpoints
=====================================================
Each organization-specific authentication request must include ``/organizations/NAME`` as part of the name for the endpoint. For example, the full endpoint for editing a rule:

.. code-block:: html

   PUT /organizations/NAME/rules/ID

where ``NAME`` is the name of the organization and ``ID`` is the identifier for the rule to be edited.

/actions
-----------------------------------------------------
The ``/actions`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of actions for the named organization. Use query parameters to filter the list of audits.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``before``
     - The time before which audit data is returned. For example: ``2014-11-14T18:50:09.155Z``.
   * - ``page``
     - The page number to be returned.
   * - ``since``
     - The time after which audit data is returned. For example: ``2014-11-14T18:40:09.155Z``.

**Request**

.. code-block:: xml

   GET /organizations/NAME/actions

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/actions/export
-----------------------------------------------------
The ``/actions/export`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. The ``GET`` method is used to get xxxxx.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/actions/export

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/aliases
-----------------------------------------------------
The ``/aliases`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of aliases for the specified organization.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/aliases

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "title": "array of aliases",
     "type": "array",
     "items": {
       "type": "object",
       "properties": {
         "id": {
           ...
         },
         "name": {
           ...
         },
         "org_name": {
           ...
         },
         "modified_by": {
           ...
         },
         "modified_at": {
           ...
         },
         "notification_type": {
           ...
         },
         "delivery_options": {
           ...
         }
       }
     },
     "definitions": {
       "hipchat": {
         ...
       },
       "http": {
         ...
       },
       "smtp": {
         ...
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new alias for the specified organization.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/NAME/aliases

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "name": {
         "description": "The name of the alias",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "notification_type": {
         "description": "type of alias (e.g. hipchat, http)",
         "type": "string",
         "enum": [
           "http",
           "hipchat"
         ]
       },
       "delivery_options": {
         "description": "set of settings this notification_type needs",
         "type": "object",
         "oneOf": [
           {"$ref": "#/definitions/hipchat"},
           {"$ref": "#/definitions/http"}
         ]
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       ...
     }
   }

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
   * - ``201``
     - Success.
   * - ``409``
     - Duplicate alias exists in organization.

/aliases/ID
-----------------------------------------------------
The ``/aliases/ID`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete the specified alias.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/aliases/ID

This method has no request body.

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
   * - ``204``
     - Success.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get information about the specified alias.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/aliases/ID

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "id": {
         ...
       },
       "name": {
         ...
       },
       "org_name": {
         ...
       },
       "modified_by": {
         ...
       },
       "modified_at": {
         ...
       },
       "notification_type": {
         ...
       },
       "delivery_options": {
         ...
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       "hipchat": {
         ...
       },
       "http": {
         ...
       },
       "smtp": {
         ...
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to update the details for an existing alias.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/aliases/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "name": {
         "description": "The name of the alias",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string",
         "format": "username"
       },
       "notification_type": {
         "description": "type of alias (e.g. hipchat, http)",
         "type": "string",
         "enum": [
           "http",
           "hipchat"
         ]
       },
       "delivery_options": {
         "description": "set of settings this notification_type needs",
         "type": "object",
         "oneOf": [
           {"$ref": "#/definitions/hipchat"},
           {"$ref": "#/definitions/http"}
         ]
       }
     },
     "required": [ "notification_type", "modified_by", "name" ],
     "definitions": {
       "hipchat": {
         "description": "Notifier - Hipchat schema",
         "type": "object",
         "properties": {
           "room": {
             "description": "Room to send message to",
             "type": "string"
           },
           "from": {
             "description": "Message sender",
             "type": "string"
           },
           "api_token": {
             "description": "Token to use for authentication",
             "type": "string",
             "format": "hash"
           },
           "api_version": {
             "description": "Version of hipchat api to use",
             "type": "string",
             "enum": [
               "1",
               "2"
             ]
           },
           "color": {
             "description": "Displayed message color in hipchat window",
             "type": "string",
             "enum": [
               "yellow",
                "red",
               "green",
               "purple",
               "gray",
               "random"
             ]
           },
           "notify": {
             "description": "Used to notify the room of the message...",
               "type": "string",
               "enum": [
                 "0",
                 "1"
               ]
             }
           },
           "required": [
             "template",
             "room",
             "api_token"
           ]
        },
       "http": {
         "description": "Notifier - HTTP (with auth) schema",
         "type": "object",
         "properties": {
           "url": {
             "description": "Url to send message to",
               "type": "string",
               "format": "url"
           },
           "auth": {
             "description": "Auth details",
             "type": "object",
             "properties": {
               "type": {
                 "description": "Authentication type",
                 "type": "string",
                 "enum": [
                   "basic"
                 ]
               },
               "username": {
                 "description": "Username to authenticate with",
                 "type": "string"
               },
               "password": {
                 "description": "Password to authenticate with",
                 "type": "string"
               }
             }
           }
         },
         "required": [ "url" ]
       }
     }
   }

**Response**

The response will return the JSON for the updated alias.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``204``
     - Success.

/audits
-----------------------------------------------------
The ``/audits`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of audits for the named organization. Use query parameters to filter the list of audits.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``before``
     - The time before which audit data is returned. For example: ``2014-11-14T18:50:09.155Z``.
   * - ``level``
     - The audit level. Possible values: ``error``, ``info``, and ``warn``. Use a comma to separate multiple audit levels. For example: ``error`` or ``warn, info``.
   * - ``page``
     - The page number to be returned.
   * - ``since``
     - The time after which audit data is returned. For example: ``2014-11-14T18:40:09.155Z``.
   * - ``type``
     - The types of events that trigger audits: ``action``, ``run_control``, ``run_control_group``, ``run_converge``, ``run_resource``, or ``run_start``. Use a comma to separate multiple types. For example: ``run_converge`` or ``action, run_start``.

**Request**

.. code-block:: xml

   GET /organizations/NAME/audits

**Responses**

A response for ``action`` is similar to:

.. code-block:: javascript

   {
     "id": "cb17e360-a729-4112-b5b6-713a8e213c55",
     "recorded_at": "2014-11-14T03:02:09.000Z",
     "description": "Oh oh, we didn't meet the audit criteria!",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "3e1fb0dd-eaeb-43cb-8df7-827376bc3f59",
       "tags": [
         "foo:create"
       ],
       "recorded_at": "2014-11-14T03:02:09.000Z",
       "remote_hostname": "33.33.33.10",
       "remote_request_id": null,
       "request_id": "g3IAA2QAEGVyY2hlZkAxMjcuMC4wLjEBAAPZYgAAAAUAAAAA",
       "service_hostname": "api.opscode.piab",
       "task": "create",
       "type": "action",
       "endpoint": "/actions/3e1fb0dd-eaeb-43cb-8df7-827376bc3f59",
       "user_agent": "Chef Manage/11.10.4 (ruby-1.9.3-p547; ohai-6.20.0; x86_64-linux; +http://opscode.com)",
       "requestable": {
         "name": "applejack",
         "properties": {
           "avatar_url": null,
           "email": null,
           "gravatar_id": null
         },
         "type": "user",
         "endpoint": "/users/applejack"
     },
     "entity": {
       "name": "b",
       "manage": "https://api.opscode.piab/organizations/ponyville/data_bags/b",
       "parent": null,
       "type": "bag",
       "endpoint": "/organizations/ponyville/bags/b"
       }
     }
   }

A response for ``run_control`` is similar to:

.. code-block:: javascript

   {
     "id": "2121e899-9f84-43b9-8933-53fe864e163d",
     "recorded_at": "2014-11-22T22:43:37.000Z",
     "description": "Control error",
     "level": "error",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "6035b05b-1514-4006-9edd-787212a30074",
       "name": "should be mode 600",
       "status": "success",
       "details": null,
       "resource_name": "/etc/ssh/ssh_host_dsa_key",
       "resource_type": "File",
       "context": null,
       "sequence_number": 10,
       "tags": [],
       "type": "run_control"
     }
   }

A response for ``run_control_group`` is similar to:

.. code-block:: javascript

   {
     "id": "92850c77-d581-493a-afd1-e502cfa8eb4d",
     "recorded_at": "2014-11-22T22:43:37.000Z",
     "description": "Control group had too many failures",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "6a8803b3-7a98-46e8-87a7-a7a9d5d37d97",
       "name": "Database",
       "status": "success",
       "number_success": 2,
       "number_failed": 0,
       "tags": [],
       "error": null,
       "type": "run_control_group"
     }
   }

A response for ``run_converge`` is similar to:

.. code-block:: javascript

   {
     "id": "98f9e4ac-1c97-4d9b-8175-4fca28a1d37d",
     "recorded_at": "2014-11-22T22:49:04.000Z",
     "description": "Run Converge",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "error": null,
       "id": "21e4924d-d395-49b4-8f9d-6934f2fecf24",
       "end_time": "2014-11-22T22:49:04.000Z",
       "node_name": "client1.opscode.piab",
       "run_id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "run_list": [
         "recipe[apt]"
       ],
       "status": "success",
       "start_time": "2014-11-22T22:49:04.000Z",
       "total_resource_count": 8,
       "updated_resource_count": 2,
       "type": "run_converge"
     }
   }

A response for ``run_resource`` is similar to:

.. code-block:: javascript

   {
     "id": "d833b937-1162-42af-b01c-2bcdc4891951",
     "recorded_at": "2014-11-22T21:12:25.000Z",
     "description": "Run Resource",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "9aa9fdc1-9524-45fb-81b4-123f91306b27",
       "sequence": 3,
       "resource_id": "update-notifier-common",
       "resource_name": "update-notifier-common",
       "resource_type": "apt_package",
       "resource_result": "install",
       "initial_state": {
         "version": null,
         "options": null
       },
       "final_state": {
         "version": "0.119ubuntu8.7",
         "options": null
       },
       "delta": "",
       "cookbook_name": "apt",
       "cookbook_version": "2.6.0",
       "tags": [],
       "type": "run_resource"
     }
   }

A response for ``run_start`` is similar to:

.. code-block:: javascript

   {
     "id": "33ecf37d-dea0-4063-9607-60268f45bfab",
     "recorded_at": "2014-11-22T22:49:04.000Z",
     "description": "Run Start",
     "level": "warn",
     "organization": "ponyville",
     "type": "audit",
     "auditable": {
       "id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "node_name": "client1.opscode.piab",
       "organization": "ponyville",
       "start_time": "2014-11-22T22:49:04.000Z",
       "run_id": "4a2c115e-5d99-4201-916f-eac723ed9f1d",
       "tags": [],
       "type": "run_start"
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.

/autocomplete
-----------------------------------------------------
The ``/autocomplete`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. The ``GET`` method is used to xxxxx.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/autocomplete

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
     - OK. The request was successful.
   * - ``403``
     - Unauthorized.
   * - ``500``
     - Internal error.

/rules
-----------------------------------------------------
The ``/rules`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of rules for the named organization.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organization/NAME/rules

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
     - OK. The request was successful.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new rule for the named organization.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organization/NAME/rules

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "active": {
         "type": "boolean"
       },
       "name": {
         "description": "Rule name",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "rule": {
         "description": "text of rule",
         "type": "string"
       },
       "with": {
         "type": "object",
         "properties": {
           "priority": {
             "type": "integer"
           }
         },
         "required": ["priority"]
       }
     },
     "required": [ "rule", "modified_by", "with", "active"]
   }

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
   * - ``201``
     - Created. The object was created. The location of the new rule is returned.
   * - ``409``
     - Duplicate rule name.

/rules/ID
-----------------------------------------------------
The ``/rules/ID`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a rule.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/rules/ID

This method has no request body.

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
   * - ``204``
     - Success.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get the details for a rule.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/rules/ID

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
     - OK. The request was successful.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to edit an existing rule.

This method has no parameters.

**Request**

.. code-block:: xml

   PUT /organizations/NAME/rules/ID

with a request body similar to:

.. code-block:: javascript

   {
     "type": "object",
     "properties": {
       "active": {
         "type": "boolean"
       },
       "name": {
         "description": "Rule name",
         "type": "string"
       },
       "modified_by": {
         "description": "user last modified",
         "type": "string"
       },
       "rule": {
         "description": "text of rule",
         "type": "string"
       },
       "with": {
         "type": "object",
         "properties": {
           "priority": {
             "type": "integer"
           }
         },
         "required": ["priority"]
       }
     },
     "required": [ "rule", "modified_by", "with", "active"]
   }

**Response**

The response will return the JSON for the updated rule.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``204``
     - Success.
