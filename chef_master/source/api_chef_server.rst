=====================================================
Chef Server API
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_chef_server.rst>`__

.. tag api_chef_server_summary

The Chef server API is a REST API that provides access to objects on the Chef server, including nodes, environments, roles, cookbooks (and cookbook versions), and to manage an API client list and the associated RSA public key-pairs.

.. end_tag

Requirements
=====================================================
.. tag api_chef_server_requirements

The Chef server API has the following requirements:

* Access to a Chef server running version 0.10.x or above.
* The ``Accept`` header must be set to ``application/json``.
* For ``PUT`` and ``POST`` requests, the ``Content-Type`` header must be set to ``application/json``.
* The ``X-Chef-Version`` header must be set to the version of the Chef server API that is being used.
* A request must be signed using ``Mixlib::Authentication``.
* A request must be well-formatted. The easiest way to ensure a well-formatted request is to use the ``Chef::REST`` library.

Changed in Chef Client 12.7, now code that uses ``Chef::Rest`` must use ``require 'chef/rest'``

.. end_tag

Authentication Headers
=====================================================
.. tag api_chef_server_headers

Authentication to the Chef server occurs when a specific set of HTTP headers are signed using a private key that is associated with the machine from which the request is made. The request is authorized if the Chef server can verify the signature using the public key. Only authorized actions are allowed.

.. note:: Most authentication requests made to the Chef server are abstracted from the user. Such as when using knife or the Chef server user interface. In some cases, such as when using the ``knife exec`` subcommand, the authentication requests need to be made more explicitly, but still in a way that does not require authentication headers. In a few cases, such as when using arbitrary Ruby code or cURL, it may be necessary to include the full authentication header as part of the request to the Chef server.

.. end_tag

Header Format
-----------------------------------------------------
.. tag api_chef_server_headers_format

All hashing is done using SHA-1 and encoded in Base64. Base64 encoding should have line breaks every 60 characters. Each canonical header should be encoded in the following format:

.. code-block:: none

   Method:HTTP_METHOD
   Hashed Path:HASHED_PATH
   X-Ops-Content-Hash:HASHED_BODY
   X-Ops-Timestamp:TIME
   X-Ops-UserId:USERID

where:

* ``HTTP_METHOD`` is the method used in the API request (``GET``, ``POST``, and so on)
* ``HASHED_PATH`` is the path of the request: ``/organizations/NAME/name_of_endpoint``. The ``HASHED_PATH`` must be hashed using SHA-1 and encoded using Base64, must not have repeated forward slashes (``/``), must not end in a forward slash (unless the path is ``/``), and must not include a query string.
* The private key must be an RSA key in the SSL .pem file format. This signature is then broken into character strings (of not more than 60 characters per line) and placed in the header.

The Chef server decrypts this header and ensures its content matches the content of the non-encrypted headers that were in the request. The timestamp of the message is checked to ensure the request was received within a reasonable amount of time. One approach generating the signed headers is to use `mixlib-authentication <https://github.com/chef/mixlib-authentication>`_, which is a class-based header signing authentication object similar to the one used by the chef-client.

.. end_tag

Required Headers
-----------------------------------------------------
The following authentication headers are required:

.. list-table::
   :widths: 130 400
   :header-rows: 1

   * - Feature
     - Description
   * - ``Accept``
     - .. tag api_chef_server_headers_accept

       The format in which response data from the Chef server is provided. This header must be set to ``application/json``.

       .. end_tag

   * - ``Content-Type``
     - .. tag api_chef_server_headers_content_type

       The format in which data is sent to the Chef server. This header is required for ``PUT`` and ``POST`` requests and must be set to ``application/json``.

       .. end_tag

   * - ``Host``
     - .. tag api_chef_server_headers_host

       The host name (and port number) to which a request is sent. (Port number ``80`` does not need to be specified.) For example: ``api.opscode.com`` (which is the same as ``api.opscode.com:80``) or ``api.opscode.com:443``.

       .. end_tag

   * - ``X-Chef-Version``
     - .. tag api_chef_server_headers_x_chef_version

       The version of the chef-client executable from which a request is made. This header ensures that responses are in the correct format. For example: ``12.0.2`` or ``11.16.x``.

       .. end_tag

   * - ``X-Ops-Authorization-N``
     - .. tag api_chef_server_headers_x_ops_authorization

       One (or more) 60 character segments that comprise the canonical header. A canonical header is signed with the private key used by the client machine from which the request is sent, and is also encoded using Base64. If more than one segment is required, each should be named sequentially, e.g. ``X-Ops-Authorization-1``, ``X-Ops-Authorization-2``, ``X-Ops-Authorization-N``, where ``N`` represents the integer used by the last header that is part of the request.

       .. end_tag

   * - ``X-Ops-Content-Hash``
     - .. tag api_chef_server_headers_x_ops_content_hash

       The body of the request. The body should be hashed using SHA-1 and encoded using Base64. All hashing is done using SHA-1 and encoded in Base64. Base64 encoding should have line breaks every 60 characters.

       .. end_tag

   * - ``X-Ops-Server-API-Version``
     - .. tag api_chef_server_headers_x_ops_server_api_version

       Use ``X-Ops-Server-API-Version`` to specify the version of the Chef server API. For example: ``X-Ops-Server-API-Version: 1``. ``X-Ops-Server-API-Version: 0`` is supported for use with the version 12 Chef server, but will be deprecated as part of the next major release.

       .. end_tag

   * - ``X-Ops-Sign``
     - .. tag api_chef_server_headers_x_ops_sign

       Set this header to the following value: ``version=1.0``.

       .. end_tag

   * - ``X-Ops-Timestamp``
     - .. tag api_chef_server_headers_x_ops_timestamp

       The timestamp, in ISO-8601 format and with UTC indicated by a trailing ``Z`` and separated by the character ``T``. For example: ``2013-03-10T14:14:44Z``.

       .. end_tag

   * - ``X-Ops-UserId``
     - .. tag api_chef_server_headers_x_ops_userid

       The name of the API client whose private key will be used to create the authorization header.

       .. end_tag

.. note:: Use ``X-Ops-Server-API-Info`` to identify the version of the Chef server API.

Example
-----------------------------------------------------
.. tag api_chef_server_headers_example

The following example shows an authentication request:

.. code-block:: none

   GET /organizations/NAME/nodes HTTP/1.1
     Accept: application/json
     Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3
     X-Ops-Sign: algorithm=sha1;version=1.0;
     X-Ops-Userid: user_id
     X-Ops-Timestamp: 2014-12-12T17:13:28Z
     X-Ops-Content-Hash: 2jmj7l5rfasfgSw0ygaVb/vlWAghYkK/YBwk=
     X-Ops-Authorization-1: BE3NnBritishaf3ifuwLSPCCYasdfXaRN5oZb4c6hbW0aefI
     X-Ops-Authorization-2: sL4j1qtEZzi/2WeF67UuytdsdfgbOc5CjgECQwqrym9gCUON
     X-Ops-Authorization-3: yf0p7PrLRCNasdfaHhQ2LWSea+kTcu0dkasdfvaTghfCDC57
     X-Ops-Authorization-4: 155i+ZlthfasfasdffukusbIUGBKUYFjhbvcds3k0i0gqs+V
     X-Ops-Authorization-5: /sLcR7JjQky7sdafIHNfsBQrISktNPower1236hbFIayFBx3
     X-Ops-Authorization-6: nodilAGMb166@haC/fttwlWQ2N1LasdqqGomRedtyhSqXA==
     Host: api.opscode.com:443
     X-Ops-Server-API-Info: 1
     X-Chef-Version: 12.0.2
     User-Agent: Chef Knife/12.0.2 (ruby-2.1.1-p320; ohai-8.0.0; x86_64-darwin12.0.2; +http://chef.io)

.. end_tag

Knife API Requests
-----------------------------------------------------
.. tag plugin_knife_summary

A knife plugin is a set of one (or more) subcommands that can be added to knife to support additional functionality that is not built-in to the base set of knife subcommands. Many of the knife plugins are built by members of the Chef community and several of them are built and maintained by Chef. A knife plugin is installed to the ``~/.chef/plugins/knife/`` directory, from where it can be run just like any other knife subcommand.

.. end_tag

.. tag plugin_knife_using_authenticated_requests

A knife plugin can be used to make authenticated API requests to the Chef server using the following methods:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``rest.delete_rest``
     - Use to delete an object from the Chef server.
   * - ``rest.get_rest``
     - Use to get the details of an object on the Chef server.
   * - ``rest.post_rest``
     - Use to add an object to the Chef server.
   * - ``rest.put_rest``
     - Use to update an object on the Chef server.

For example:

.. code-block:: ruby

   module MyCommands
     class MyNodeDelete < Chef::Knife
       #An implementation of knife node delete
       banner 'knife my node delete [NODE_NAME]'

     def run
       if name_args.length < 1
         show_usage
         ui.fatal("You must specify a node name.")
         exit 1
       end
       nodename = name_args[0]
          api_endpoint = "nodes/#{nodename}"
          # Again, we could just call rest.delete_rest
          nodey = rest.get_rest(api_endpoint)
          ui.confirm("Do you really want to delete #{nodey}")
          nodey.destroy
        end
      end
   end

.. end_tag

Global Endpoints
=====================================================
.. tag api_chef_server_endpoints_global

A global endpoint may be used to access all of the organizations on the Chef server.

.. end_tag

/license
-----------------------------------------------------
.. note:: This endpoint is used for information purposes only and to trigger a notification in the Chef management console about the number of licenses owned vs. the number of licenses that should be owned. No other action is taken and the functionality and behavior of the Chef server and any added component does not change.

The ``/license`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get license information for the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/license

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "limit_exceeded": "false",
     "node_license": "25",
     "node_count": "12",
     "upgrade_url": "http://www.chef.io/contact/on-premises-simple"
   }

When ``node_count`` is greater than ``node_license``, then ``limit_exceeded`` is ``true`` and the Chef management console will display a notification about this status. The way to resolve this is to visit the upgrade URL, add the appropriate number of licenses, and then update the configuration settings appropriately.

The chef-server.rb file contains settings that can be used to edit the number of nodes that are under license:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``license['nodes']``
     - The number of licensed nodes. Default value: ``25``.
   * - ``license['upgrade_url']``
     - The URL to visit for more information about how to update the number of nodes licensed for an organization. Default value: ``"http://www.chef.io/contact/on-premises-simple"``.

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

/organizations
-----------------------------------------------------
The Chef server may contain multiple organizations.

The ``/organizations`` endpoint has the following methods: ``GET`` and ``POST``.

.. warning:: This endpoint may only be accessed by the ``pivotal`` user, which is created as part of the installation process for the Chef server. (See the "Query for Users and Orgs" example below for an example of how to access this endpoint with the ``pivotal`` user.)

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of organizations on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/organizations

**Response**

The response is similar to:

.. code-block:: none

   {
     "org_name1"=>"https://url/for/org_name1"
     "org_name2"=>"https://url/for/org_name2"
	 ...
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create an organization on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations

with a request body similar to:

.. code-block:: javascript

   {
     "name": "chef",
     "full_name": "Chef Software, Inc.",
   }

where:

* ``name`` must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.
* ``full_name`` must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``Chef Software, Inc.``.

.. note:: An organization isn't usable until a user that belongs to the ``admins`` group is associated with the organization.

**Response**

The response is similar to:

.. code-block:: javascript

   { "org_name": "https://url/for/org_name" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action.

/organizations/NAME
-----------------------------------------------------
An organization is a single instance of a Chef server, including all of the nodes that are managed by that Chef server and each of the workstations that will run knife and access the Chef server using the Chef server API.

The ``/organizations/NAME`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete an organization.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "chef",
     "full_name": "Chef Software, Inc",
     "guid": "f980d1asdfda0331235s00ff36862"
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

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get the details for the named organization.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME

**Response**

The response is similar to:

.. code-block:: none

   {
     "name": "chef",
     "full_name": "Chef Software, Inc",
     "guid": "f980d1asdfda0331235s00ff36862"
	    ...
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

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to create an organization.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "chef",
     "full_name": "Chef Software, Inc"
   }

**Response**

The response will return the JSON for the updated organization.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``410``
     - Gone. Unable to update private key.

/users
-----------------------------------------------------
A user is an individual account that is created to allow access to the Chef server. For example:

* A hosted Chef server account
* The user that operates the workstation from which a Chef server will be managed

The ``/users`` endpoint has the following methods: ```GET`` and ``POST``.

.. warning:: This endpoint may only be accessed by the ``pivotal`` user, which is created as part of the installation process for the Chef server. (See the "Query for Users and Orgs" example below for an example of how to access this endpoint with the ``pivotal`` user.)

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of users on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users

**Response**

The response is similar to:

.. code-block:: none

   {
     "user1"=> "https://url/for/user1"
     "user2"=> "https://url/for/user2"
	 ...
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

**Optional Filtering**

 Filtering on ``/users`` can be done with the ``external_authentication_uid``. This is to support SAML authentication.

 As an example, to retrieve users whos ``external_authentication_uid`` is ``jane@doe.com``, you would do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

*New in Chef server 12.7.*

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a user on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /users

with a request body similar to:

.. code-block:: javascript

   {
     "name": "robert-forster",
     "display_name": "robert",
     "email": "robert@noreply.com",
     "first_name": "robert",
     "last_name": "robert",
     "middle_name": "",
     "password": "yeahpass",
     "public_key": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoYyN0AIhUh7Fw1+gQtR+ \n0/HY3625IUlVheoUeUz3WnsTrUGSSS4fHvxUiCJlNni1sQvcJ0xC9Bw3iMz7YVFO\nWz5SeKmajqKEnNywN8/NByZhhlLdBxBX/UN04/7aHZMoZxrrjXGLcyjvXN3uxyCO\nyPY989pa68LJ9jXWyyfKjCYdztSFcRuwF7tWgqnlsc8pve/UaWamNOTXQnyrQ6Dp\ndn+1jiNbEJIdxiza7DJMH/9/i/mLIDEFCLRPQ3RqW4T8QrSbkyzPO/iwaHl9U196\n06Ajv1RNnfyHnBXIM+I5mxJRyJCyDFo/MACc5AgO6M0a7sJ/sdX+WccgcHEVbPAl\n1wIDAQAB \n-----END PUBLIC KEY-----\n\n"
   }


where:

* ``name`` must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores. For example: ``chef``.
* ``email``, ``name``, and ``password`` are all required to be present and have a value.
* During the POST, the ``public_key`` value will be broken out and resubmitted to the keys portion of the API in the latest Chef Server versions.

**Response**

The response is similar to:

.. code-block:: javascript

   { "user_name": "https://url/for/user_name" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     -  Not found. The requested object does not exist.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/users/NAME
-----------------------------------------------------
The ``/users/USER_NAME`` endpoint has the following methods: ``DELETE``, ``GET``, ``POST``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a user.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /users/USER_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Grant McLennan",
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
The ``GET`` method is used to return the details for a user.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users/USER_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Robert Forster",
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new user. If a public key is not specified, both public and private keys will be generated and returned. If a public key is specified, only the public key will be returned.

This method has no parameters.

**Request**

.. code-block:: none

   POST /users/USER_NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "Robert Forster"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Robert Forster",
     "private_key": "-----BEGIN PRIVATE KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PRIVATE KEY-----"
     "admin": true
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to update a specific user. If values are not specified for the ``PUT`` method, the Chef server will use the existing values rather than assign default values.

.. note:: ``PUT`` supports renames. If ``PUT /users/foo`` is requested with ``{ "name: "bar""}``, then it will rename ``foo`` to ``bar`` and all of the content previously associated with ``foo`` will be associated with ``bar``.

.. note:: As of 12.1.0, the ``"public_key"``, ``"private_key"``, and ``"create_key"`` parameters in PUT requests to clients/users will cause a 400 response.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /users/NAME

with a request body similar to:

.. code-block:: none

   POST /users { "name": "Grant McLennan" }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "Grant McLennan",
     "private_key": "-----BEGIN PRIVATE KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PRIVATE KEY-----"
     "admin": false
   }

If a new private key was generated, both the private and public keys are returned.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created. (This response code is only returned when the user is renamed.)
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action. (This response code is only returned when a user is renamed, but a user already exists with that name.)
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/users/USER/keys/
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

/users/USER/keys/KEY
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

Organization Endpoints
=====================================================
.. tag api_chef_server_endpoints

Each organization-specific authentication request must include ``/organizations/NAME`` as part of the name for the endpoint. For example, the full endpoint for getting a list of roles:

.. code-block:: none

   GET /organizations/NAME/roles

where ``ORG_NAME`` is the name of the organization.

.. end_tag

/association_requests
-----------------------------------------------------
Users may be invited to join organizations via the web user interface in the Chef management console or via the ``POST`` endpoint in the Chef server API.

The ``/association_requests`` endpoint has the following methods: ``DELETE``, ``GET``, and ``POST``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a pending invitation.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/association_requests/ID

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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of pending invitations.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/association_requests

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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create an invitation.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/association_requests

**Response**

This method has no response body.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     -  Not found. The requested object does not exist.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/authenticate_user
-----------------------------------------------------
The ``/authenticate_user`` endpoint has the following methods: ``POST``.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to authenticate a user. This endpoint is used by the Chef Identity Service to authenticate users of Chef Supermarket and Chef Analytics to the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/authenticate_user

with a request body similar to:

.. code-block:: javascript

   {
     "username" : "grantmc",
     "password" : "p@ssw0rd"
   }

**Response**

This method has no response body.

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

/clients/CLIENT/keys/
-----------------------------------------------------
.. tag api_chef_server_endpoint_keys_clients

The ``/clients/CLIENT/keys`` endpoint has the following methods: ``GET`` and ``POST``.

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

/clients/CLIENT/keys/KEY
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

/clients
-----------------------------------------------------
Use the ``/clients`` endpoint to manage an API client list and their associated RSA public key-pairs. The ``/clients`` endpoint has the following methods: ``GET`` and ``POST``.

.. note:: In general, the API client list should be managed using knife or the Chef server management console, as opposed to the Chef server API.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return the API client list on the Chef server, including nodes that have been registered with the Chef server, the chef-validator clients, and the chef-server-webui clients for the entire organization.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "org1-validator" : "https://chef.example/orgaizations/org1/clients/org1-validator",
     "client1" : "https://chef.example/orgaizations/org1/clients/client1"
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new API client.

.. note:: As of 12.1.0, the ``"admin"`` parameter is no longer supported in client/user creation and support.  If used in the ``POST`` or ``PUT`` of a client or user, then it is ignored.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/clients

with a request body similar to:

.. code-block:: javascript

   {
     "name": "name_of_API_client",
     "create_key": true
   }

where ``name_of_API_client`` is the name of the API client to be created and ``admin`` indicates whether the API client will be run as an admin API client.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/orgaizations/org1/clients/client1",
     "chef_key": {
       "name": "default",
       "public_key": "-----BEGIN PUBLIC KEY-----",
       "private_key": "-----BEGIN RSA PRIVATE KEY-----"
   }

Store the private key in a safe place. It will be required later (along with the client name) to access the Chef server when using the Chef server API.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/clients/NAME
-----------------------------------------------------
The ``/clients/NAME`` endpoint is used to manage a specific API client. This endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to remove a specific API client.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/clients/NAME

This method has no request body.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "client1",
     "validator" : "false"
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
The ``GET`` method is used to return a specific API client.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "user1",
     "validator" : "false"
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
The ``PUT`` method is used to update a specific API client. If values are not specified for the ``PUT`` method, the Chef server will use the existing values rather than assign default values.

.. note:: ``PUT`` supports renames. If ``PUT /user/foo`` is requested with ``{ "name: "bar""}``, then it will rename ``foo`` to ``bar`` and all of the content previously associated with ``foo`` will be associated with ``bar``.

.. note:: As of 12.1.0, the ``"admin"`` parameter is no longer supported in client/user creation and support.  If used in the ``POST`` or ``PUT`` of a client or user, then it is ignored.

.. note:: As of 12.1.0, including ''"public_key"``, ``"private_key"``, or ``"create_key"`` in PUT requests requests to clients/users will cause a 400 response.

**Request**

.. code-block:: none

   PUT /organizations/NAME/clients/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "monkeypants",
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri" : "https://chef.example/orgaizations/org1/clients/client1"
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
     - Created. The object was created. (This response code is only returned when the client is renamed.)
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action. (This response code is only returned when a client is renamed, but a client already exists with that name.)
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/containers
-----------------------------------------------------
The ``/containers`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of containers.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/containers

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "clients": "https://url/for/containers/clients",
     "containers": "https://url/for/containers/containers",
     "cookbooks": "https://url/for/containers/cookbooks",
     "data": "https://url/for/containers/data",
     "environments": "https://url/for/containers/environments",
     "groups": "https://url/for/containers/groups",
     "nodes": "https://url/for/containers/nodes",
     "roles": "https://url/for/containers/roles",
     "sandboxes": "https://url/for/containers/sandboxes"
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

/cookbooks
-----------------------------------------------------
.. tag cookbooks_summary

A cookbook is the fundamental unit of configuration and policy distribution. A cookbook defines a scenario and contains everything that is required to support that scenario:

* Recipes that specify the resources to use and the order in which they are to be applied
* Attribute values
* File distributions
* Templates
* Extensions to Chef, such as custom resources and libraries

.. end_tag

When a cookbook is uploaded, only files that are new or updated will be included. This approach minimizes the amount of storage and time that is required during the modify-upload-test cycle. To keep track of which files have already been uploaded, the chef-client uses a checksum and assigns a checksum to each file. These checksums are used in the cookbook version manifest, alongside the same records that store the file description (name, specificity, and so on), as well as the checksum and the URL from which the file's contents can be retrieved.

The ``/cookbooks`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a hash of all cookbooks and cookbook versions.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``num_versions=n``
     - The number of cookbook versions to include in the response, where ``n`` is the number of cookbook versions. For example: ``num_versions=3`` returns the three latest versions, in descending order (newest to oldest). Use ``num_versions=all`` to return all cookbook versions. If ``num_versions`` is not specified, a single cookbook version is returned. ``0`` is an invalid input (an empty array for the versions of each cookbook is returned).

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "apache2": {
       "url": "https://localhost/cookbooks/apache2",
       "versions": [
         {"url": "https://localhost/cookbooks/apache2/5.1.0",
          "version": "5.1.0"},
         {"url": "https://localhost/cookbooks/apache2/4.2.0",
          "version": "4.2.0"}
       ]
     },
     "nginx": {
       "url": "https://localhost/cookbooks/nginx",
       "versions": [
         {"url": "https://localhost/cookbooks/nginx/1.0.0",
          "version": "1.0.0"},
         {"url": "https://localhost/cookbooks/nginx/0.3.0",
          "version": "0.3.0"}
       ]
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

/cookbooks/_latest
-----------------------------------------------------
The ``/cookbooks/_latest`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a list of the most recent cookbook versions.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/_latest

**Response**

For example, if cookbooks ``foo`` and ``bar`` both exist on the Chef server and both with versions ``0.1.0`` and ``0.2.0``, the response is similar to:

.. code-block:: javascript

  {
    "foo": "https://localhost/cookbooks/foo/0.2.0",
    "bar": "https://localhost/cookbooks/bar/0.2.0"
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

/cookbooks/_recipes
-----------------------------------------------------
The ``/cookbooks/_recipes`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return the names of all recipes in the most recent cookbook versions.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/_recipes

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
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

/cookbooks/NAME
-----------------------------------------------------
The ``/cookbooks/NAME`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a hash that contains a key-value pair that corresponds to the specified cookbook, with a URL for the cookbook and for each version of the cookbook.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "apache2": {
       "url": "https://localhost/cookbooks/apache2",
       "versions": [
         {"url": "https://localhost/cookbooks/apache2/5.1.0",
          "version": "5.1.0"},
         {"url": "https://localhost/cookbooks/apache2/4.2.0",
          "version": "4.2.0"}
       ]
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

/cookbooks/NAME/version
-----------------------------------------------------
.. tag cookbooks_version

A cookbook version represents a set of functionality that is different from the cookbook on which it is based. A version may exist for many reasons, such as ensuring the correct use of a third-party component, updating a bug fix, or adding an improvement. A cookbook version is defined using syntax and operators, may be associated with environments, cookbook metadata, and/or run-lists, and may be frozen (to prevent unwanted updates from being made).

A cookbook version is maintained just like a cookbook, with regard to source control, uploading it to the Chef server, and how the chef-client applies that cookbook when configuring nodes.

.. end_tag

The ``/cookbooks/NAME/VERSION`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a cookbook version.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/cookbooks/NAME/VERSION

**Response**

This method has no response body. Unused ``checksum`` values will be garbage collected.

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
The ``GET`` method is used to return a description of a cookbook, including its metadata and links to component files.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/cookbooks/NAME/VERSION

where ``VERSION`` can be ``_latest`` in order to float to head.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "cookbook_name": "getting-started",
     "files": [

     ],
     "chef_type": "cookbook_version",
     "definitions": [

     ],
     "libraries": [

     ],
     "attributes": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "attributes/default.rb",
         "specificity": "default",
         "name": "default.rb",
         "checksum": "fa0fc4abf3f6787fdsaasadfrc5c35de667c"
       }
     ],
     "recipes": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "recipes/default.rb",
         "specificity": "default",
         "name": "default.rb",
         "checksum": "7e79b1ace7728fdsadfsdaf857e60fc69"
       }
     ],
     "providers": [

     ],
     "resources": [

     ],
     "templates": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "templates/default/chef-getting-started.txt.erb",
         "specificity": "default",
         "name": "chef-getting-started.txt.erb",
         "checksum": "a29d6f2545sdffds1f140c3a78b1fe"
       }
     ],
     "root_files": [
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": ".DS_Store",
         "specificity": "default",
         "name": ".DS_Store",
         "checksum": "c107b500aafd12asdffdsdf5c2a7d6"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "metadata.json",
         "specificity": "default",
         "name": "metadata.json",
         "checksum": "20f09570e54dasdf0f3ae01e6401c90f"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "metadata.rb",
         "specificity": "default",
         "name": "metadata.rb",
         "checksum": "71027aefasd487fdsa4cb6994b66ed"
       },
       {
         "url": "https://domain.com/org_name/(...rest of URL)",
         "path": "README.rdoc",
         "specificity": "default",
         "name": "README.rdoc",
         "checksum": "8b9275e56fee974easdfasdfbb729"
       }
     ],
     "name": "getting-started-0.4.0",
     "frozen?": false,
     "version": "0.4.0",
     "json_class": "Chef::CookbookVersion",
     "metadata": {
       "maintainer": "Maintainer",
       "attributes": { },
       "suggestions": { },
       "recipes": { "getting-started": "" },
       "dependencies": { },
       "platforms": { },
       "groupings": { },
       "recommendations": { },
       "name": "getting-started",
       "description": "description",
       "version": "0.4.0",
       "maintainer_email": "sysadmin@opscode.com",
       "long_description": "= DESCRIPTION:\n\nThis cookbook is used to do some things.\n\n",
       "providing": { "getting-started": ">= 0.0.0" },
       "replacing": { },
       "conflicting": { },
       "license": "Apache 2.0"
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
The ``PUT`` method is used to create or update a cookbook version.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/cookbooks/NAME/VERSION

with a request body similar to:

.. code-block:: javascript

   {
     "definitions": [
       {
         "name": "unicorn_config.rb",
         "checksum": "c92b659171552e896074caa58dada0c2",
         "path": "definitions/unicorn_config.rb",
         "specificity": "default"
       }
     ],
     "name": "unicorn-0.1.2",
     "attributes": [],
     "files": [],
     "json_class": "Chef::CookbookVersion",
     "providers": [],
     "metadata": {
       "dependencies": {"ruby": [], "rubygems": []},
       "name": "unicorn",
       "maintainer_email": "ops@opscode.com",
       "attributes": {},
       "license": "Apache 2.0",
       "suggestions": {},
       "platforms": {},
       "maintainer": "Opscode, Inc",
       "long_description": "= LICENSE AND AUTHOR:\n\nAuthor:: Adam Jacob...",
       "recommendations": {},
       "version": "0.1.2",
       "conflicting": {},
       "recipes": {"unicorn": "Installs unicorn rubygem"},
       "groupings": {},
       "replacing": {},
       "description": "Installs/Configures unicorn",
       "providing": {}
     },
     "libraries": [],
     "templates": [
       {
         "name": "unicorn.rb.erb",
         "checksum": "36a1cc1b225708db96d48026c3f624b2",
         "path": "templates/default/unicorn.rb.erb",
         "specificity": "default"
       }
     ],
     "resources": [],
     "cookbook_name": "unicorn",
     "version": "0.1.2",
     "recipes": [
       {
         "name": "default.rb",
         "checksum": "ba0dadcbca26710a521e0e3160cc5e20",
         "path": "recipes/default.rb",
         "specificity": "default"
       }
     ],
     "root_files": [
       {
         "name": "README.rdoc",
         "checksum": "d18c630c8a68ffa4852d13214d0525a6",
         "path": "README.rdoc",
         "specificity": "default"
       },
       {
         "name": "metadata.rb",
         "checksum": "967087a09f48f234028d3aa27a094882",
         "path": "metadata.rb",
         "specificity": "default"
       },
       {
         "name": "metadata.json",
         "checksum": "45b27c78955f6a738d2d42d88056c57c",
         "path": "metadata.json",
         "specificity": "default"
       }
     ],
     "chef_type": "cookbook_version"
   }

where the ``checksum`` values must have already been uploaded to the Chef server using the sandbox endpoint. Once a file with a particular checksum has been uploaded by the user, redundant uploads are not necessary. Unused ``checksum`` values will be garbage collected.

**Response**

This method has no response body.

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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/data
-----------------------------------------------------
.. tag data_bag

A data bag is a global variable that is stored as JSON data and is accessible from a Chef server. A data bag is indexed for searching and can be loaded by a recipe or accessed during a search.

.. end_tag

The ``/data`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a list of all data bags on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/data

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "users": "https://localhost/data/users",
     "applications": "https://localhost/data/applications"
   }

shown as a list of key-value pairs, where (in the example above) ``users`` and ``applications`` are the names of data bags and ``https://localhost/data/foo`` is the path to the data bag.

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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new data bag on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/data

with a request body that contains the key-value pair for the data bag and is similar to:

.. code-block:: javascript

   {
     "name": "users"
   }

where (in the example above) ``name`` is the key and "users" is the value.

**Response**

The response is similar to:

.. code-block:: javascript

   {
      "chef_type": "environment",
      "data_bag": "data123",
      "id": "12345"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/data/NAME
-----------------------------------------------------
The ``/data/NAME`` endpoint is used to view and update data for a specific data bag. This endpoint has the following methods: ``GET`` and ``POST``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a data bag.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/data/NAME

This method has no request body.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "id": "adam",
     "real_name": "Adam Brent Jacob"
   }

where the key-value pairs represent the last state of the data bag item.

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
The ``GET`` method is used to return a hash of all entries in the specified data bag.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/data/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
      "adam": "https://localhost/data/users/adam"
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new data bag item.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/data/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "id": "adam",
     "real_name": "Adam Jacob"
   }

where ``id`` is required.

**Response**

This method has no response body.

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     -  Not found. The requested object does not exist.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/data/NAME/ITEM
-----------------------------------------------------
.. tag data_bag_item

A data bag is a container of related data bag items, where each individual data bag item is a JSON file. knife can load a data bag item by specifying the name of the data bag to which the item belongs and then the filename of the data bag item. The only structural requirement of a data bag item is that it must have an ``id``:

.. code-block:: javascript

   {
     /* This is a supported comment style */
     // This style is also supported
     "id": "ITEM_NAME",
     "key": "value"
   }

where

* ``key`` and ``value`` are the ``key:value`` pair for each additional attribute within the data bag item
* ``/* ... */`` and ``// ...`` show two ways to add comments to the data bag item

.. end_tag

The ``/data/NAME/ITEM`` endpoint allows the key-value pairs within a data bag item to be viewed and managed. This endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a key-value pair in a data bag item.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/data/NAME/ITEM

This method has no request body.

For example, run the following command:

.. code-block:: bash

   $ knife raw /data/dogs

which returns a list of data bags on the server:

.. code-block:: javascript

   {
     "pomeranian": "https://api.opscode.com/organizations/ORG_NAME/data/dogs/pomeranian",
     "shihtzu": "https://api.opscode.com/organizations/ORG_NAME/data/dogs/shihtzu",
     "tibetanspaniel": "https://api.opscode.com/organizations/ORG_NAME/data/dogs/tibetanspaniel"
   }

Run the following command:

.. code-block:: bash

   $ knife raw -m DELETE /data/dogs/shihtzu

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "data_bag_item_dogs_shihtzu",
     "json_class": "Chef::DataBagItem",
     "chef_type": "data_bag_item",
     "data_bag": "dogs",
     "raw_data": {
       "description": "small annoying dog that doesn't bark all that often",
       "id": "shihtzu"
     }
   }

Run the following command:

.. code-block:: bash

   $ knife raw /data/dogs

to view an updated list:

.. code-block:: javascript

   {
     "pomeranian": "https://api.opscode.com/organizations/ORG_NAME/data/dogs/pomeranian",
     "tibetanspaniel": "https://api.opscode.com/organizations/ORG_NAME/data/dogs/tibetanspaniel"
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
The ``GET`` method is used to view all of the key-value pairs in a data bag item.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/data/NAME/ITEM

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "real_name": "Adam Jacob",
     "id": "adam"
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
The ``PUT`` method is used to replace the contents of a data bag item with the contents of this request.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/data/NAME/ITEM

with a request body similar to:

.. code-block:: javascript

   {
     "real_name": "Adam Brent Jacob",
     "id": "adam"
   }

where ``id`` is required.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "real_name": "Adam Brent Jacob",
     "id": "adam"
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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/environments
-----------------------------------------------------
.. tag environment

An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef server. Every organization begins with a single environment called the ``_default`` environment, which cannot be modified (or deleted). Additional environments can be created to reflect each organization's patterns and workflow. For example, creating ``production``, ``staging``, ``testing``, and ``development`` environments. Generally, an environment is also associated with one (or more) cookbook versions.

.. end_tag

The ``/environments`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a data structure that contains a link to each available environment.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "_default": "https://api.opscode.com/organizations/org_name/environments/_default",
     "webserver": "https://api.opscode.com/organizations/org_name/environments/webserver"
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new environment.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/environments

with a request body similar to:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {},
     "json_class": "Chef::Environment",
     "description": "",
     "cookbook_versions": {},
     "chef_type": "environment"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   { "uri": "https://localhost/environments/dev" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/environments/_default
-----------------------------------------------------
The ``/environments/_default`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get information about the ``_default`` environment on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/_default

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "_default",
     "description": "The default Chef environment",
     "json_class": "Chef::Environment",
     "chef_type": "environment",
     "default_attributes": {

     },
     "override_attributes": {

     },
     "cookbook_versions": {

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

/environments/NAME
-----------------------------------------------------
The ``/environments/NAME`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete an environment.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/environments/NAME

**Response**

The response will return the JSON for the environment that was deleted, similar to:

.. code-block:: javascript

   {
     "name":"backend",
     "description":"",
     "cookbook_versions":{},
     "json_class":"Chef::Environment",
     "chef_type":"environment",
     "default_attributes":{},
     "override_attributes":{}
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
The ``GET`` method is used to return the details for an environment as JSON.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "_default",
     "description": "The default Chef environment",
     "json_class": "Chef::Environment",
     "chef_type": "environment",
     "default_attributes": { }
     "override_attributes": { },
     "cookbook_versions": { },
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
The ``PUT`` method is used to update the details of an environment on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/environments/NAME

with a request body that contains the updated JSON for the environment and is similar to:

.. code-block:: javascript

   {
     "name": "dev",
     "attributes": {},
     "json_class": "Chef::Environment",
     "description": "The Dev Environment",
     "cookbook_versions": {},
     "chef_type": "environment"
   }

**Response**

The response will return the updated environment.

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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/environments/NAME/cookbooks/NAME
-----------------------------------------------------
The ``/environments/NAME/cookbooks/NAME`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a hash of key-value pairs for the requested cookbook.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``num_versions=n``
     - The number of cookbook versions to include in the response, where ``n`` is the number of cookbook versions. For example: ``num_versions=3`` returns the three latest versions, in descending order (newest to oldest). Use ``num_versions=all`` to return all cookbook versions. If ``num_versions`` is not specified, a single cookbook version is returned. ``0`` is an invalid input (an empty array for the versions of each cookbook is returned).

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/cookbooks/NAME

where the first instance of ``NAME`` is the name of the environment, and the second instance is the name of the cookbook.

**Response**

The response is similar to:

.. code-block:: none

   {
     "apache2": {
       "url": "https://localhost/cookbooks/apache2",
       "versions": [
         {"url": "https://localhost/cookbooks/apache2/5.1.0",
          "version": "5.1.0"},
         {"url": "https://localhost/cookbooks/apache2/4.2.0",
          "version": "4.2.0"}
       ]
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

/environments/NAME/cookbook_versions
-----------------------------------------------------
The ``/environments/NAME/cookbook_versions`` endpoint has the following methods: ``POST``.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to return a hash of the cookbooks and cookbook versions (including all dependencies) that are required by the ``run_list`` array. Version constraints may be specified using the ``@`` symbol after the cookbook name as a delimiter. Version constraints may also be present when the ``cookbook_versions`` attributes is specified for an environment or when dependencies are specified by a cookbook.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/environments/NAME/cookbook_versions

with a request body similar to:

.. code-block:: javascript

   {
     "run_list": [
       "zed@0.0.1",
       "bar",
       "mysql",
       "gem",
       "nginx@0.99.2",
       "cron",
       "foo"
     ]
   }

where ``@x.x.x`` represents a constraint for a cookbook version.

**Response**

The response will return a list of cookbooks that are required by the ``run_list`` array contained in the request. The cookbooks that are returned are often the latest versions of each cookbook. Depending on any constraints present in the request or on dependencies a cookbook may have for specific cookbook versions, a request may not always return the latest cookbook version for each cookbook.

The response is similar to:

.. code-block:: javascript

   {
     "cookbook_name": {
       "recipes": [
         {
           "name": "default.rb",
           "path": "recipes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "recipe_name.rb",
           "path": "recipes/recipe_name.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           ...
         }
       ],
       "definitions": [

       ],
       "libraries": [

       ],
       "attributes": [

       ],
       "files": [

       ],
       "templates": [
         {
           "name": "template_name.erb",
           "path": "templates/default/template_name.erb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           ...
         }
       ],
       "resources": [

       ],
       "providers": [

       ],
       "root_files": [
         {
           "name": "metadata.rb",
           "path": "metadata.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "cookbook_name": "cookbook_name-1.0.2",
       "metadata": {
         "name": "cookbook_name",
         "description": "description",
         "long_description": "",
         "maintainer": "maintainer",
         "maintainer_email": "maintainer@email.com",
         "license": "license",
         "platforms": {
         },
         "dependencies": {
           "cookbook_name": ">= 0.0.0",
           "cookbook_name": ">= 1.2.3",
           ...
           "cookbook_name": ">= 0.1.0"
         },
         "recommendations": {
         },
         "suggestions": {
         },
         "conflicting": {
         },
         "providing": {
           "cookbook_name": ">= 0.0.0",
           "cookbook_name::recipe_name": ">= 0.0.0",
           "cookbook_name::recipe_name": ">= 1.2.3",
           "cookbook_name::recipe_name": ">= 0.1.0"
         },
         "replacing": {
         },
         "attributes": {
         },
         "groupings": {
         },
         "recipes": {
           "cookbook_name": "description",
           "cookbook_name::recipe_name": "",
           ...
           "cookbook_name::recipe_name": ""
         },
         "version": "0.0.0"
       },
       "version": "0.0.0",
       "name": "cookbook_name-1.0.2",
       "frozen?": false,
       "chef_type": "cookbook_version",
       "json_class": "Chef::CookbookVersion"
     },
     "cookbook_name": {
        "recipes": [
         {
           "name": "default.rb",
           "path": "recipes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
       ],
       "definitions": [

       ],
       "libraries": [
         {
           "name": "library_file.rb",
           "path": "libraries/library_file.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "attributes": [
         {
           "name": "default.rb",
           "path": "attributes/default.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         }
       ],
       "files": [

       ],
       "templates": [

       ],
       "resources": [

       ],
       "providers": [

       ],
       "root_files": [
         {
           "name": ".gitignore",
           "path": ".gitignore",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": ".kitchen.yml",
           "path": ".kitchen.yml",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "CHANGELOG.md",
           "path": "CHANGELOG.md",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "CONTRIBUTING",
           "path": "CONTRIBUTING",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "LICENSE",
           "path": "LICENSE",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "metadata.json",
           "path": "metadata.json",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "metadata.rb",
           "path": "metadata.rb",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
         {
           "name": "README.md",
           "path": "README.md",
           "checksum": "12345efg78912346abcddefg789",
           "specificity": "default",
           "url": "https://URL"
         },
       ],
       "chef_type": "cookbook_version",
       "name": "cookbook_name-1.0.2",
       "cookbook_name": "cookbook_name",
       "version": "1.0.2",
       "metadata": {
         "name": "cookbook_name",
         "description": "description",
         "long_description": "",
         "maintainer": "maintainer",
         "maintainer_email": "maintainer@email.com",
         "license": "license",
         "platforms": {
         },
         "dependencies": {
         },
         "recommendations": {
         },
         "suggestions": {
         },
         "conflicting": {
         },
         "providing": {
         },
         "replacing": {
         },
         "attributes": {
         },
         "groupings": {
         },
         "recipes": {
         },
         "version": "1.0.2"
       },
       "frozen?": true,
       "json_class": "Chef::CookbookVersion"
     },
     "cookbook_name": {
      ...
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
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``412``
     - Not allowed. A set of cookbooks and/or cookbook versions could not be found that met all of the requirements of the run-list. A cookbook in the run-list may not exist. A dependency may be present for a cookbook that does not exist. A constraint on a cookbook made by a run-list, environment, or cookbook version, may not match an available cookbook version.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/environments/NAME/cookbooks
-----------------------------------------------------
The ``/environments/NAME/cookbooks`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of cookbooks and cookbook versions that are available to the specified environment.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``num_versions=n``
     - The number of cookbook versions to include in the response, where ``n`` is the number of cookbook versions. For example: ``num_versions=3`` returns the three latest versions, in descending order (newest to oldest). Use ``num_versions=all`` to return all cookbook versions. If ``num_versions`` is not specified, a single cookbook version is returned. ``0`` is an invalid input (an empty array for the versions of each cookbook is returned).

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/cookbooks

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "apache2": {
       "url": "https://localhost/cookbooks/apache2",
       "versions": [
         {"url": "https://localhost/cookbooks/apache2/5.1.0",
          "version": "5.1.0"},
         {"url": "https://localhost/cookbooks/apache2/4.2.0",
          "version": "4.2.0"}
       ]
     },
     "nginx": {
       "url": "https://localhost/cookbooks/nginx",
       "versions": [
         {"url": "https://localhost/cookbooks/nginx/1.0.0",
          "version": "1.0.0"},
         {"url": "https://localhost/cookbooks/nginx/0.3.0",
          "version": "0.3.0"}
       ]
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

/environments/NAME/nodes
-----------------------------------------------------
The ``/environments/NAME/nodes`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a list of nodes in a given environment.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/nodes

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "blah": "https://api.opscode.com/org/org_name/nodes/_default",
     "boxer": "https://api.opscode.com/org/org_name/nodes/frontend",
     "blarrrrgh": "https://api.opscode.com/org/org_name/nodes/backend"
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

/environments/NAME/recipes
-----------------------------------------------------
The ``/environments/NAME/recipes`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a list of recipes available to a given environment.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/recipes

where the first instance of ``NAME`` is the name of the environment, and the second instance is the name of the recipe.

**Response**

The response is similar to:

.. code-block:: none

   [
     "ant",
     "apache2",
     "apache2::mod_auth_openid",
     "apache2::mod_authnz_ldap",
     "apt",
     "aws",
     "capistrano",
     "chef",
     "chef::bootstrap_client",
     "chef-client::config",
     "chef-client",
     ...
   ]

The list of recipes will be the default recipes for a given cookbook. If an environment has multiple versions of a cookbook that matches its constraints, only the recipes from the latest version of that cookbook will be reported.

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

/environments/NAME/roles/NAME
-----------------------------------------------------
The ``/environments/NAME/roles/NAME`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return the ``run_list`` attribute of the role (when the name of the environment is ``_default``) or to return ``env_run_lists[environment_name]`` (for non-default environments).

.. note:: The behavior of this endpoint is identical to ``GET /roles/NAME/environments/NAME``; it is recommended (but not required) that ``GET /roles/NAME/environments/NAME`` be used instead of this endpoint.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/environments/NAME/roles/NAME

where the first instance of ``NAME`` is the name of the environment, and the second instance is the name of the role.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "run_list": [
       "recipe[recipe_name]",
       "role[role_name]",
       "recipe[recipe_name]",
       "role[role_name]",
       "recipe[recipe_name]",
       "role[role_name]"
     ]
   }

The chef-client will pick up the ``_default`` run-list if ``env_run_list[environment_name]`` is null or nonexistent.

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

/groups
-----------------------------------------------------
The ``/groups`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of groups on the Chef server for a single organization.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/groups

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "33a5c28a8efe11e195005fsaes25400298d3f": "https://url/for/group1",
     "admins": "https://url/for/groups/admins",
     "billing-admins": "https://url/for/billing-admins",
     "clients": "https://url/for/clients",
     "developers": "https://url/for/developers",
     "users": "https://url/for/groups/users"
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

/groups/GROUP_NAME
-----------------------------------------------------
The ``/groups/GROUP_NAME`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of users that belong to a group.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/groups/GROUP_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "actors": [
       "pivotal",
       "grantmc"
     ],
     "users": [
     "pivotal",
       "grantmc"
     ],
     "clients": [

     ],
     "groups": [

     ],
     "orgname": "inbetweens",
     "name": "admins",
     "groupname": "admins"
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

/nodes
-----------------------------------------------------
.. tag node

A node is any machine---physical, virtual, cloud, network device, etc.---that is under management by Chef.

.. end_tag

The ``/nodes`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a hash of URIs for nodes on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/nodes

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "latte": "https://localhost/nodes/latte"
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new node.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/nodes

with a request body similar to:

.. code-block:: javascript

   {
     "name": "latte",
     "chef_type": "node",
     "json_class": "Chef::Node",
     "attributes": {
       "hardware_type": "laptop"
     },
     "overrides": {},
     "defaults": {},
     "run_list": [ "recipe[unicorn]" ]
   }

where ``name`` is the name of the node. Other attributes are optional. The order of the ``run_list`` attribute matters.

**Response**

The response is similar to:

.. code-block:: javascript

   { "uri": "https://localhost/nodes/latte" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/nodes/NAME
-----------------------------------------------------
The ``/nodes/NAME`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a node.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/nodes/NAME

**Response**

The response will return the last known state of the node, similar to:

.. code-block:: javascript

   {
     "overrides": {},
     "name": "latte",
     "chef_type": "node",
     "json_class": "Chef::Node",
     "attributes": {
       "hardware_type": "laptop"
     },
     "run_list": [
       "recipe[apache2]"
     ],
     "defaults": {}
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
The ``GET`` method is used to return the details of a node as JSON.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/nodes/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "node_name",
     "chef_environment": "_default",
     "run_list": [
       "recipe[recipe_name]"
     ]
     "json_class": "Chef::Node",
     "chef_type": "node",
     "automatic": { ... },
     "normal": { "tags": [ ] },
     "default": { },
     "override": { }
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
The ``PUT`` method is used to update a node.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/nodes/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "overrides": {},
     "name": "latte",
     "chef_type": "node",
     "json_class": "Chef::Node",
     "attributes": {
       "hardware_type": "laptop"
     },
     "run_list": [
       'recipe[cookbook_name::recipe_name],
       role[role_name]'
     ],
     "defaults": {}
   }

**Response**

The response will return the updated node.

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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

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

/principals/NAME
-----------------------------------------------------
The ``/principals/NAME`` endpoint has the following methods: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of public keys for clients and users in order to ensure that enough information is present for authorized requests.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/principals/NAME

**Response**

For a user, the response is similar to:

.. code-block:: javascript

   {
     "name": "normal_user",
     "type": "user",
     "public_key": "-----BEGIN PUBLIC KEY-----\n
                   MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyVPW9YXa5PR0rgEW1updSxygB\n
                   wmVpDnHurgQ7/gbh+PmY49EZsfrZSbKgSKy+rxdsVoSoU+krYtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLtzGO1Ma/VzHnFqoOeSCKHXDhmHwJAjGDTPAgCJQiI\n
                   eau6cDNJRiJ7j0/xBwIDAQAB\n
                   -----END PUBLIC KEY-----"
   }

and for a client, similar to:

.. code-block:: javascript

   {
     "name": "client_node",
     "type": "client",
     "public_key": "-----BEGIN PUBLIC KEY-----\n
                   MIEfGVG0GCSqGSIb3DQEBAQUAA4RRFEDCVgftg67j8dgsdfges0rgEW1updSxygB\n
                   wmVpDnHuqwe7/gbh+PmY49EZsfrZSbKgSKy+rxKJHREGJ5tgCtHvYIwVfr2tk0FP\n
                   nhAWJaFH654KpuCNG6x6iMLt5FGH1Ma/VzHnFqoOeSCKHDhmHwJAjGDTPAgCJQiI\n
                   elk8UFCN45Jj0/xBwIDAQAB\n
                   -----END PUBLIC KEY-----"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``404``
     - Not found. The requested object does not exist.

/roles
-----------------------------------------------------
.. tag role

A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function. Each role consists of zero (or more) attributes and a run-list. Each node can have zero (or more) roles assigned to it. When a role is run against a node, the configuration details of that node are compared against the attributes of the role, and then the contents of that role's run-list are applied to the node's configuration details. When a chef-client runs, it merges its own attributes and run-lists with those contained within each assigned role.

.. end_tag

The ``/roles`` endpoint has the following methods: ``GET`` and ``POST``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get a list of roles along with their associated URIs.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/roles

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "webserver": "https://localhost/roles/webserver"
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

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new role on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/roles

with a request body similar to:

.. code-block:: javascript

   {
     "name": "webserver",
     "chef_type": "role",
     "json_class": "Chef::Role",
     "default_attributes": {},
     "description": "A webserver",
     "run_list": [
       "recipe[unicorn]",
       "recipe[apache2]"
     ],
     "override_attributes": {}
   }

**Response**

The response is similar to:

.. code-block:: javascript

   { "uri": "https://localhost/roles/webserver" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/roles/NAME
-----------------------------------------------------
The ``/roles/NAME`` endpoint has the following methods: ``GET``, ``DELETE``, and ``PUT``.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a role on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/roles/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "webserver",
     "chef_type": "role",
     "json_class": "Chef::Role",
     "default_attributes": {},
     "description": "A webserver",
     "run_list": [
       "recipe[apache2]"
     ],
     "override_attributes": {}
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
The ``GET`` method is used to return the details for a role as JSON.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/roles/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "webserver",
     "chef_type": "role",
     "json_class": "Chef::Role",
     "default_attributes": {},
     "description": "A webserver",
     "run_list": [
       "recipe[unicorn]",
       "recipe[apache2]"
     ],
     "override_attributes": {}
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
The ``PUT`` method is used to update a role on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/roles/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "name": "webserver",
     "chef_type": "role",
     "json_class": "Chef::Role",
     "default_attributes": {},
     "description": "A webserver",
     "run_list": [
       "recipe[apache2]"
     ],
     "override_attributes": {}
   }

**Response**

The response will return the JSON for the updated role.

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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/roles/NAME/environments
-----------------------------------------------------
The ``/roles/NAME/environments`` endpoint has the following method: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method returns a list of the environments that have environment-specific run-lists in the given role as JSON data.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/roles/NAME/environments

**Response**

The response is similar to:

.. code-block:: javascript

   ["_default","production","qa"]

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

/roles/NAME/environments/NAME
-----------------------------------------------------
The ``/roles/NAME/environments/NAME`` endpoint has the following method: ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method returns the environment-specific run-list (``env_run_lists[environment_name]``) for a role.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/roles/NAME/environments/NAME

where the first ``NAME`` is the name of the role and the second is the name of the environment.

**Response**

The response is similar to:

.. code-block:: javascript

    {"run_list":["recipe[foo]"]}

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

/sandboxes
-----------------------------------------------------
A sandbox is used to commit files so they only need to be updated one time, as opposed to every time a cookbook is uploaded. The ``/sandboxes`` endpoint has the following methods: ``POST``.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new sandbox. This method accepts a list of checksums as input and returns the URLs against which to ``PUT`` files that need to be uploaded.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/sandboxes

with a request body similar to:

.. code-block:: javascript

   {"checksums": {
     "385ea5490c86570c7de71070bce9384a":null,
     "f6f73175e979bd90af6184ec277f760c":null,
     "2e03dd7e5b2e6c8eab1cf41ac61396d5":null
     }
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {"uri":
    "https://api.opscode.com/organizations/testorg/sandboxes/eff7b6f8b3ef44c6867216662d5eeb5f",
    "checksums":
      {"385ea5490c86570c7de71070bce9384a":
        {"url":
         "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true},
          "f6f73175e979bd90af6184ec277f760c"=>
        {"url":
          "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true},
          "2e03dd7e5b2e6c8eab1cf41ac61396d5":
        {"url":
          "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
          "needs_upload":true}
      },
    "sandbox_id"=>"eff7b6f8b3ef44c6867216662d5eeb5f"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful. A hash that maps each checksum to a hash that contains a boolean ``needs_upload`` field and a URL if ``needs_upload`` is set to ``true``.
   * - ``400``
     - Bad request. The object has already been committed or one (or more) of the objects were not properly uploaded. The payload does not contain a well-formed ``checksums`` parameter that is a hash containing a key for each checksum.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/sandboxes/ID
-----------------------------------------------------
Each sandbox has a unique identifier. The ``/sandboxes/ID`` endpoint has the following methods: ``PUT``.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to commit files that are in a sandbox to their final location so that changes to cookbooks will not require re-uploading the same data.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/sandboxes/ID

with a request body similar to:

.. code-block:: javascript

   {"is_completed":true}

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "guid": guid,
     "name": guid,
     "checksums":
       {"385ea5490c86570c7de71070bce9384a":
       {"url":
         "https://s3.amazonaws.com/opscode-platform-production-data/organization-(...)",
         "needs_upload":true}
     },
     "create_time": <get an example of time format>,
     "is_completed": true
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/search
-----------------------------------------------------
.. tag search

Search indexes allow queries to be made for any type of data that is indexed by the Chef server, including data bags (and data bag items), environments, nodes, and roles. A defined query syntax is used to support search patterns like exact, wildcard, range, and fuzzy. A search is a full-text query that can be done from several locations, including from within a recipe, by using the ``search`` subcommand in knife, the ``search`` method in the Recipe DSL, the search box in the Chef management console, and by using the ``/search`` or ``/search/INDEX`` endpoints in the Chef server API. The search engine is based on Apache Solr and is run from the Chef server.

.. end_tag

The ``/search`` endpoint allows nodes, roles, data bags, environments to be searched. This endpoint has the following methods: ``GET``.

.. note:: At the end of every chef-client run, the node object is saved to the Chef server. From the Chef server, each node object is then added to the Apache Solr search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first.

.. note:: This endpoint does not have any ACL restrictions, which means it may be used by any user or client that is able to make the request to the Chef server.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a data structure that contains links to each available search index. By default, the ``role``, ``node``, ``client``, and ``data bag`` indexes will always be available (where the ``data bag`` index is the name of the data bag on the Chef server). Search indexes may lag behind the most current data at any given time. If a situation occurs where data needs to be written and then immediately searched, an artificial delay (of at least 10 seconds) is recommended.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/search

This method has no request body.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "node": "https://localhost/search/node",
     "role": "https://localhost/search/role",
     "client": "https://localhost/search/client",
     "users": "https://localhost/search/users"
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

/search/INDEX
-----------------------------------------------------
Use the ``/search/INDEX`` endpoint to access the search indexes on the Chef server. The ``/search/INDEX`` endpoint has the following methods: ``GET`` and ``POST``.

.. tag search_query_syntax

A search query is comprised of two parts: the key and the search pattern. A search query has the following syntax:

.. code-block:: ruby

   key:search_pattern

where ``key`` is a field name that is found in the JSON description of an indexable object on the Chef server (a role, node, client, environment, or data bag) and ``search_pattern`` defines what will be searched for, using one of the following search patterns: exact, wildcard, range, or fuzzy matching. Both ``key`` and ``search_pattern`` are case-sensitive; ``key`` has limited support for multiple character wildcard matching using an asterisk ("*") (and as long as it is not the first character).

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return all of the data that matches the query in the ``GET`` request.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``q``
     - The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.
   * - ``rows``
     - The number of rows to be returned.
   * - ``sort``
     - The order in which search results are to be sorted.
   * - ``start``
     - The row at which return results begin.

**Request**

.. code-block:: none

   GET /organizations/NAME/search/INDEX

**Response**

The response contains the total number of rows that match the request and is similar to:

.. code-block:: javascript

   {
    "total": 1,
    "start": 0,
    "rows": [
       {
        "overrides": {"hardware_type": "laptop"},
        "name": "latte",
        "chef_type": "node",
        "json_class": "Chef::Node",
        "attributes": {"hardware_type": "laptop"},
        "run_list": ["recipe[unicorn]"],
        "defaults": {}
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
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A partial search query allows a search query to be made against specific attribute keys that are stored on the Chef server. A partial search query can search the same set of objects on the Chef server as a full search query, including specifying an object index and providing a query that can be matched to the relevant index. While a full search query will return an array of objects that match (each object containing a full set of attributes for the node), a partial search query will return only the values for the attributes that match. One primary benefit of using a partial search query is that it requires less memory and network bandwidth while the chef-client processes the search results.

To create a partial search query, use the ``search`` method, and then specify the key paths for the attributes to be returned. Each key path should be specified as an array of strings and is mapped to an arbitrary short name. For example:

.. code-block:: ruby

   search(:node, 'role:web',
     :filter_result => { 'name' => [ 'name' ],
                'ip'   => [ 'ipaddress' ],
                'kernel_version' => [ 'kernel', 'version' ]
              }
   ) do |result|
     puts result['name']
     puts result['ip']
     puts result['kernel_version']
   end

In the previous example, two attributes will be extracted (on the Chef server) from any node that matches the search query. The result will be a simple hash with keys ``name``, ``ip``, and ``kernel_version``.

The ``POST`` method is used to return partial search results. For example, if a node has the following:

.. code-block:: none

   {
     'x' => 'foo',
     'kernel' => { 'a' => 1, 'foo' => 'bar', 'version' => [ 1, 2, 3 ] }
   }

a partial search query can be used to return something like:

.. code-block:: none

   { 'kernel_version' => [ 1, 2, 3 ] }

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``q``
     - The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.
   * - ``rows``
     - The number of rows to be returned.
   * - ``sort``
     - The order in which search results are to be sorted.
   * - ``start``
     - The row at which return results begin.

**Request**

.. code-block:: none

   POST /organizations/NAME/search

with a request body similar to:

.. code-block:: none

   {
     "name": [ "name" ],
     "ip": [ "ipaddress" ],
     "kernel_version": [ "kernel", "version" ]
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "latte",
     "ip": "123.4.5.6789",
     "kernel_version": {"linux": "1.2.3"}
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
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

_status
-----------------------------------------------------
.. tag api_chef_server_endpoint_status

The ``/_status`` endpoint can be used to check the status of communications between the front and back end servers. This endpoint is located at ``/_status`` on the front end servers.

**Request**

.. code-block:: none

   api.get("https://chef_server.front_end.url/_status")

This method has no request body.

**Response**

The response will return something like the following:

.. code-block:: javascript

   {
     "status": "pong",
     "upstreams":
       {
         "service_name": "pong",
         "service_name": "pong",
         ...
       }
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
            "status":"fail",
            "upstreams":
              {
                "service_name": "fail",
                "service_name": "pong",
                ...
              }
          }

.. end_tag

/universe
-----------------------------------------------------
.. tag api_chef_server_endpoint_universe

Use the ``/universe`` endpoint to retrieve the known collection of cookbooks, and then use it with Berkshelf and Chef Supermarket.

The ``/universe`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_universe_get

The ``GET`` method is used to retrieve the universe data.

This method has no parameters.

**Request**

.. code-block:: none

   GET /universe

**Response**

The response will return an embedded hash, with the name of each cookbook as a top-level key. Each cookbook will list each version, along with its location information and dependencies:

.. code-block:: javascript

   {
     "ffmpeg": {
       "0.1.0": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/ffmpeg/0.1.0/download"
         "location_type": "supermarket",
         "dependencies": {
           "git": ">= 0.0.0",
           "build-essential": ">= 0.0.0",
           "libvpx": "~> 0.1.1",
           "x264": "~> 0.1.1"
         },
       },
       "0.1.1": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/ffmpeg/0.1.1/download"
         "location_type": "supermarket",
         "dependencies": {
           "git": ">= 0.0.0",
           "build-essential": ">= 0.0.0",
           "libvpx": "~> 0.1.1",
           "x264": "~> 0.1.1"
         },
       },
      "pssh": {
       "0.1.0": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/pssh.1.0/download"
         "location_type": "supermarket",
         "dependencies": {},
       }
     }
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful. One (or more) cookbooks and associated cookbook version information was returned.

.. end_tag

/updated_since
-----------------------------------------------------
.. tag api_chef_server_endpoint_org_name_updated_since

The ``/updated_since`` endpoint ensures that replica instances of the Chef server are able to synchronize with the primary Chef server. The ``/organizations/NAME/updated_since`` endpoint has the following methods: ``GET``.

.. end_tag

.. warning:: This update is available after Chef replication is installed on the Chef server.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_org_name_updated_since_get

The ``GET`` method is used to return the details of an organization as JSON.

**Request**

.. code-block:: none

   GET /organizations/NAME/objects_since?seq=NUM

where ``NUM`` is the largest integer previously returned as an identifier.

**Response**

The response will return an array of paths for objects that have been created, updated, or deleted since ``NUM``, similar to:

.. code-block:: javascript

   [
     {
       "action": "create",
       "id": 1,
       "path": "/roles/foo"
     },
     {
       "action": "create",
       "id": 2,
       "path": "/roles/foo2"
     },
     {
       "action": "create",
       "id": 3,
       "path": "/roles/foo3"
     },
     {
       "action": "update",
       "id": 4,
       "path": "/roles/foo3"
     }
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

Examples
=====================================================
The following sections show examples of using the Chef server API.

Query for Users and Orgs
-----------------------------------------------------
The following example shows how to query the Chef server API for a listing of organizations and users. The ``/organizations`` and ``/users`` endpoints may only be accessed by the ``pivotal`` user, which is a user account that is created by Chef during the installation of the Chef server.

Run the following from a ``.chef`` directory that contains a ``pivotal.rb`` file:

.. code-block:: ruby

   require 'chef'
   require 'chef/rest'

   Chef::Config.from_file(".chef/pivotal.rb")
   rest = Chef::REST.new(Chef::Config[:chef_server_url])
   orgs = rest.get_rest("/organizations")

   puts "\n=== Listing of organizations"
   orgs.each do |org|
     puts org
   end

   puts "\n=== Listing of Users"
   users = rest.get_rest("/users")
   users.each do |user|
     puts user
   end

An examle of a ``.chef/pivotal.rb`` file is shown below:

.. code-block:: ruby

   current_dir = File.dirname(__FILE__)
   node_name "pivotal"
   chef_server_url "https://192.168.1.2:443"
   chef_server_root "https://192.168.1.2:443"
   client_key "#{current_dir}/pivotal.pem"

.. note:: The ``pivotal.pem`` file must exist in the specified location and the IP addresses must be correct for the Chef server.
