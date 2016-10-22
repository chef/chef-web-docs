
=====================================================
Release Notes: Chef Server 12.1
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

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
The ``knife user`` and ``knife client`` subcommands support key rotation. Use the ``create``, ``delete``, ``edit``, ``list``, and ``show`` subcommands to manage keys for users and clients, such as creating multiple expiring keys for a single user and also for basic key management. See https://docs.chef.io/knife_user.html and https://docs.chef.io/knife_client.html for more information about these subcommands.

X-Ops-Server-API-Version
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_server_api_version.rst

/client/CLIENT/keys/
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients_post.rst

/client/CLIENT/keys/KEY
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_put.rst

/user/USER/keys/
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users_post.rst

/user/USER/keys/KEY
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_put.rst

/policies
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policies.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policies_get.rst

/policy_groups
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_groups.rst

.. include:: ../../includes_policy/includes_policy_group_relates_to_nodes.rst

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

.. include:: ../../includes_policy/includes_policy_group_relates_to_nodes.rst

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
