
=====================================================
Release Notes: Chef Server 12.1
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

What's New
=====================================================
The following items are new for Chef server 12.1:

* **chef-server-ctl key commands use the chef-client Chef::Key object** The key rotation commands (``chef-server-ctl key``) for ``create``, ``delete``, ``edit``, ``list``, and ``show`` keys for users and clients. These were a preview in the Chef server 12.0.3 release, and are now fully integrated.
* **New version headers for Chef Server API** The Chef server API uses the ``X-Ops-Server-API-Version`` header to specify the version of the API that is used as part of a request to the Chef server API.
* **New endpoints for policy and policy files** The Chef server API adds the following endpoints: ``/policies``, ``/policy_groups``, and ``/POLICY_GROUP/policies/POLICY_NAME``.
* **New endpoints for client key management** The Chef server API adds the following endpoints: ``/client/CLIENT/keys`` and ``/client/CLIENT/keys/KEY``.
* **New endpoints for user key management** The Chef server API adds the following endpoints: ``/user/USER/keys`` and ``/user/USER/keys/KEY``.
* **New configuration setting** Use the ``estatsd['protocol']`` setting to send application statistics with StatsD protocol formatting.

Key Rotation
-----------------------------------------------------
The ``knife user`` and ``knife client`` subcommands support key rotation. Use the ``create``, ``delete``, ``edit``, ``list``, and ``show`` subcommands to manage keys for users and clients, such as creating multiple expiring keys for a single user and also for basic key management.

X-Ops-Server-API-Version
-----------------------------------------------------
.. tag api_chef_server_headers_x_ops_server_api_version

Use ``X-Ops-Server-API-Version`` to specify the version of the Chef server API. For example: ``X-Ops-Server-API-Version: 1``. ``X-Ops-Server-API-Version: 0`` is supported for use with the version 12 Chef server, but will be deprecated as part of the next major release.

.. end_tag

/client/CLIENT/keys/
-----------------------------------------------------
.. tag api_chef_server_endpoint_keys_clients

The ``/client/CLIENT/keys`` endpoint has the following methods: ``GET`` and ``POST``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_clients_get

The ``GET`` method is used to retrieve all of the named client's key identifiers, associated URIs, and expiry states.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients/CLIENT/keys

**Response**

The response is similar to:

.. code-block:: javascript

   [
     { "name" : "default",
                "uri" : "https://chef.example/organizations/example/clients/client1/keys/default",
                "expired" : false },
     { "name" : "key1",
                "uri" : "https://chef.example/organizations/example/clients/client1/keys/key1",
                "expired" : true }
   ]

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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_clients_post

The ``POST`` method is used to add a key for the specified client.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/clients/CLIENT/keys

with a request body similar to:

.. code-block:: javascript

   {
     "name": "key1",
     "public_key": "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date": "infinity"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/organizations/example/clients/client1/keys/key1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/client/CLIENT/keys/KEY
-----------------------------------------------------
.. tag api_chef_server_endpoint_key_client

The ``/clients/CLIENT/keys/KEY`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_delete

The ``DELETE`` method is used to delete the specified key for the specified client.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/clients/CLIENT/keys/KEY

**Response**

The response returns the information about the deleted key and is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_get

The ``GET`` method is used to return details for a specific key for a specific client.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients/CLIENT/keys/KEY

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_put

The ``PUT`` method is used to update one or more properties for a specific key for a specific client.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/clients/CLIENT/keys/KEY

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response**

The response contains the updated inforamtion for the key, and is similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/user/USER/keys/
-----------------------------------------------------
.. tag api_chef_server_endpoint_keys_users

The ``/users/USER/keys`` endpoint has the following methods: ``GET`` and ``POST``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_users_get

The ``GET`` method is used to retrieve all of the named user's key identifiers, associated URIs, and expiry states.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users/USER/keys/

**Response**

The response is similar to:

.. code-block:: javascript

   [
     { "name" : "default",
                "uri" : "https://chef.example/users/USER/keys/default",
                "expired" : false },
     { "name" : "key1",
                "uri" : "https://chef.example/users/USER/keys/key1",
                "expired" : false}
   ]

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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_users_post

The ``POST`` method is used to add a key for the specified user.

This method has no parameters.

**Request**

.. code-block:: none

   POST /users/USER/keys/

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "key1",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "infinity"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri" : "https://chef.example/users/user1/keys/key1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/user/USER/keys/KEY
-----------------------------------------------------
.. tag api_chef_server_endpoint_key_user

The ``/users/USER/keys/KEY`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_delete

The ``DELETE`` method is used to delete the specified key for the specified user.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /users/USER/keys/KEY

**Response**

The response returns the information about the deleted key and is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_get

The ``GET`` method is used to return details for a specific key for a specific user.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users/USER/keys/KEY

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_put

The ``PUT`` method is used to update one or more properties for a specific key for a specific user.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /users/USER/keys/KEY

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response**

The response contains the updated inforamtion for the key, and is similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/policies
-----------------------------------------------------
.. tag api_chef_server_endpoint_policies

The ``/policies`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policies_get

The ``GET`` method is used to get a list of policies (including policy revisions) from the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policies

**Response**

The response groups policies by name and revision and is similar to:

.. code-block:: javascript

   {
     "aar": {
       "uri": "https://chef.example/organizations/org1/policies/aar",
       "revisions": {
         "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9": {
         },
         "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5": {
         },
         "d81e80ae9bb9778e8c4b7652d29b11d2111e763a840d0cadb34b46a8b2ca4347": {
         }
       }
     },
     "jenkins": {
       "uri": "https://chef.example/organizations/org1/policies/jenkins",
       "revisions": {
         "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073": {
         },
         "6fe753184c8946052d3231bb4212116df28d89a3a5f7ae52832ad408419dd5eb": {
         },
         "cc1a0801e75df1d1ea5b0d2c71ba7d31c539423b81478f65e6388b9ee415ad87": {
         }
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
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.

.. end_tag

/policy_groups
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_groups

The ``/policy_groups`` endpoint has the following methods: ``GET``.

.. end_tag

.. tag policy_group_relates_to_nodes

Each node has a 1:many relationship with policy settings stored on the Chef server. This relationship is based on the policy group to which the node is associated, and then the policy settings assigned to that group:

* A policy is typically named after the functional role ahost performs, such as "application server", "chat server", "load balancer", and so on
* A policy group defines a set of hosts in a deployed units, typically mapped to organizational requirements such as "dev", "test", "staging", and "production", but can also be mapped to more detailed requirements as needed

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to retrieve all of the policy groups that are stored on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policy_groups

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "dev": {
       "uri": "https://chef.example/organizations/org1/policy_groups/dev",
         "policies": {
           "aar": {
             "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
           },
           "jenkins": {
             "revision_id": "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073"
         }
       }
       },
       "production": {
       "uri": "https://chef.example/organizations/org1/policy_groups/production",
         "policies": {
           "aar": {
             "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
         }
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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

/policies/NAME
-----------------------------------------------------
The ``/policies/NAME`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``. These endpoints enable the management of policies as they relate to a specific policy group.

.. tag policy_group_relates_to_nodes

Each node has a 1:many relationship with policy settings stored on the Chef server. This relationship is based on the policy group to which the node is associated, and then the policy settings assigned to that group:

* A policy is typically named after the functional role ahost performs, such as "application server", "chat server", "load balancer", and so on
* A policy group defines a set of hosts in a deployed units, typically mapped to organizational requirements such as "dev", "test", "staging", and "production", but can also be mapped to more detailed requirements as needed

.. end_tag

Each policy group and individual policy are separate objects for the purposes of authentication. This enables each policy and policy group to have restricted access, such as for specific nodes that handle sensitive data or for specific production groups that require sign-off as part of organizational requirements.

A requestor must have permission to both the policy and the policy group in order for any action to be authorized.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete the association between a specific policy document, specific policy group, and specific policy revision. This method does not delete anything from the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/GROUP/policies/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a policy document for a specific policy group and policy.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/GROUP/policies/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to create or update an association between a specific policy document, specific policy group, and specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/GROUP/policies/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
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
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

New Config Settings
-----------------------------------------------------
The following configuration settings are new for the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``estatsd['protocol']``
     - Use to send application statistics with StatsD protocol formatting. Set this value to ``statsd`` to apply StatsD protocol formatting.

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
