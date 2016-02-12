=====================================================
|api compliance|
=====================================================

The |api compliance| is a REST-based API that is designed to be easy and predictable and to have resource-oriented URL endpoints. It uses common HTTP verbs and response codes to indicate API errors. Therefore the API can be understood by standard HTTP clients and libraries. In general the API uses JSON as data input and output format.

The |api compliance| is located at ``https://hostname/api/`` for on-premises installations of the |chef compliance| server.

About API Requests
=====================================================
Some notes about API requests:

* Examples in this document use ``-u "$API_KEY:"`` to represent the retrieved API key. A retrieved API key is similar to: ``VS3x1XSg4Hk/wxw8IP+2XpmoKynR7urxglaGfLfFRXbxYljxNW5mksOSNj+BkO2DVoQehGosBnqCJA8WAz3Jyg==``. Set the ``API_KEY`` variable based on the API key that is assigned to your organization. Find a complete bash example under `/oauth/token <#oauth-token>`_.
* When running commands as an administrator and if the ``API_KEY`` is not used, some requests to the |api compliance| will return ``403`` (forbidden) if the user making the requests does not have appropriate permissions.
* Any time a |json| block is part of a request to the |api compliance|, the content type ``application/json`` must also be specified. Use the ``-H`` option: ``-H "Content-Type: application/json"``.
* The ``Authorization: Basic base64encodedpassword`` header must contain a username and password with permission to authenticate to the |chef compliance| server. Successful authentication will return a valid |api compliance| token.

  |chef compliance| uses the API token to allow access to the |api compliance|. The API key must be included as part of `every HTTP Basic Authentication request <http://en.wikipedia.org/wiki/Basic_access_authentication>`__ to the |api compliance| with the API key included as part of the header:

  .. code-block:: javascript

     Authorization: Basic API_KEY

  where the ``API_KEY`` is a valid |company_name| |api compliance| token similar to ``VS3x1XSg4Hk/wxw8IP+2XpmoKynR7urxglaGfLfFRXbxYljxNW5mksOSNj+BkO2DVoQehGosBnqCJA8WAz3Jyg==``.

  A password is not required. HTTP Basic Authentication uses a colon (``:``) to separate the username and password. For example, a ``curl`` API call with the above token can be used in ``bash`` like this:

  .. code-block:: bash

     API_HOST="example.com"
     curl -X GET "https://$API_HOST/api/users" \
     -u "VS3x1XSg4Hk/wxw8IP+2XpmoKynR7urxglaGfLfFRXbxYljxNW5mksOSNj+BkO2DVoQehGosBnqCJA8WAz3Jyg==:"

  **The colon (``:``) at the end of the key is easy to miss, but you must specify it when using ``curl``.**

Response Codes
=====================================================
The |api compliance| uses conventional HTTP response codes to highlight a request success or failure. The following codes are used:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK -- Everything worked as expected.
   * - ``400``
     - Bad Request -- In most cases a required parameter is missing.
   * - ``401``
     - Unauthorized -- No valid API key provided.
   * - ``402``
     - Request Failed -- Parameters were valid but request failed.
   * - ``403``
     - Forbidden -- You do not have the permission to execute the request.
   * - ``404``
     - Not Found -- The specified resource could not be found.
   * - ``429``
     - Too Many Requests -- You reached the rate limit.
   * - ``500``, ``501``, ``502``, ``503``
     - Server Error -- Something went wrong.

In general, ``2xx`` codes indicate success, ``4xx`` indicate a request error (e.g. data is missing) and ``5xx`` indicate an error with the |api compliance|.

/version
=====================================================
The ``/version`` endpoint has the following method: ``GET``.

GET
-----------------------------------------------------
Use this method to get the version of the |api compliance| without authentication.

**Request**

.. code-block:: xml

   GET /api/version

Example tested in ``bash``:

.. code-block:: bash

   # Define a variable for the hostname of the |chef compliance| server
   API_HOST="example.com"
   curl -X GET "https://$API_HOST/api/version"

.. note:: If you don't have a trusted SSL certificate and would like to turn off curl's verification of the certificate, use the -k (or --insecure) option.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "api": "chef-compliance",
     "version": "1.0.1"
   }

/oauth/token
=====================================================
The ``/oauth/token`` endpoint has the following methods: ``POST``.

POST
-----------------------------------------------------
Use this method to request an API token valid for 24 hours:

**Request**

.. code-block:: xml

   POST /api/oauth/token

Here's an example on how to get the API token into a variable that will be used later:

.. code-block:: bash

    API_HOST="example.com"
    USERNAME="john"
    # Get the json output in a variable
    JSON=$(curl -s -S -X POST "https://$API_HOST/api/oauth/token" -u "$USERNAME" -d "grant_type=client_credentials")
    # Extract the access token and store it in the API_KEY variable
    API_KEY=$(echo $JSON | sed -e "s/.*access_token\":\"\([^\"]*\)\".*/\1/")
    # List users by adding a colon (:) after the API token
    curl -X GET "https://$API_HOST/api/users" -u "$API_KEY:"

You can use ``-u "$USERNAME:$PASSWORD"`` if you don't want to be prompted for the password.

**Response**

The response for the ``/api/oauth/token`` call will return a |json| object similar to:

.. code-block:: javascript

   {
     "access_token": "VS3x1XSg4Hk/wxw8IP+2XpmoKynR7urxglaGfLfFRXbxYljxNW5mksOSNj+BkO2DVoQehGosBnqCJA8WAz3Jyg==",
     "expires_in": 86399,
     "token_type": "chef token"
   }

/logout
=====================================================

POST
-----------------------------------------------------
Delete the API token for the current user.

**Request**

.. code-block:: xml

  POST /api/logout

For example:

.. code-block:: bash

  curl -X POST "https://$API_HOST/api/logout" -u "$API_KEY:"

**Response**

No Content

/compliance
=====================================================
The ``/compliance`` endpoint has the following methods: ``GET`` and ``POST``. The ``GET`` method may be used to return information about owners, all users, a named user, to download a profile as a |tar gz| file, and to upload profiles (including as |tar gz| or |zip| files).

GET (all users)
-----------------------------------------------------
Use to return the compliance profile for the all users.

**Request**

.. code-block:: xml

   GET /api/user/compliance

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/user/compliance" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "base": {
       "cis-ubuntu-level1": {
         "id": "cis-ubuntu-level1",
         "owner": "admin",
         "name": "admin/cis-ubuntu-level1",
         "title": "CIS Ubuntu 14.04 LTS Server Benchmark Level 1",
         "version": "1.0.0",
         "summary": "CIS Ubuntu 14.04 LTS Server Benchmark",
         "description": "# CIS Ubuntu 14.04 LTS Server Benchmark\n\ncopyright",
         "license": "Proprietary, All rights reserved",
         "copyright": "Chef Software, Inc.",
         "copyright_email": "grantmc@chef.io"
        }
     },
     "john": {
       "linux": {
         "id": "linux",
         "owner": "chef",
         "name": "chef/linux",
         "title": "Basic Linux",
         "version": "1.0.0",
         "summary": "Verify that Linux nodes are configured securely",
         "description": "# Basic Linux Compliance Profile\n\ncopyright",
         "license": "Proprietary, All rights reserved",
         "copyright": "Chef Software, Inc.",
         "copyright_email": "grantmc@chef.io"
       },
     ...
     }
   }

GET (named user)
-----------------------------------------------------
Use to return profile details about the named user.

**Request**

.. code-block:: xml

   GET /api/owners/OWNER/compliance/PROFILE

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/compliance/ssh" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "ssh",
     "owner": "chef",
     "name": "chef/ssh",
     "title": "Basic SSH",
     "version": "1.0.0",
     "summary": "Verify that SSH Server and SSH Client are configured securely",
     "description": "# Basic SSH Compliance Profile\n\ncopyright",
     "license": "Proprietary, All rights reserved",
     "copyright": "Chef Software, Inc.",
     "copyright_email": "grantmc@chef.io",
     "rules": {
       "spec/ssh_folder_spec": {
         "title": "SSH folder configuration",
           "rules": {
             "chef/ssh/basic-1": {
               "impact": 1,
               "title": "/etc/ssh should be a directory",
               "desc": "In order for OpenSSH to function correctly..."
             },
           ...
         }
       }
     }
   }

GET (owner)
-----------------------------------------------------
This method returns a list of all compliance profiles for the named owner.

**Request**

.. code-block:: xml

   GET /api/owners/OWNER/compliance

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/compliance" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "linux": {
       "id": "linux",
       "owner": "chef",
       "name": "chef/linux",
       "title": "Basic Linux",
       "version": "1.0.0",
       "summary": "Verify that Linux nodes are configured securely",
       "description": "# Basic Linux Compliance Profile\n\ncopyright",
       "license": "Proprietary, All rights reserved",
       "copyright": "Chef Software, Inc.",
       "copyright_email": "grantmc@chef.io"
       },
     "mysql": {
       "id": "mysql",
       "owner": "chef",
       "name": "chef/mysql",
       "title": "Basic MySQL",
       "version": "1.0.0",
       "summary": "Verify that MySQL Server is configured securely",
       "description": "# Basic MySQL Compliance Profile\n\ncopyright",
       "license": "Proprietary, All rights reserved",
       "copyright": "Chef Software, Inc.",
       "copyright_email": "grantmc@chef.io"
     },
     ...
   }

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - Integer. The profile identifier.
   * - ``owner``
     - String. The profile owner.
   * - ``version``
     - String. The version of the profile.
   * - ``title``
     - String. A human-readable title for the profile.
   * - ``summary``
     - String. A description of the primary purpose of the profile.
   * - ``description``
     - String. A description for the profile.
   * - ``license``
     - String. The license for the profile.
   * - ``copyright``
     - String. The individual or organization that holds the copyright.
   * - ``copyright_email``
     - String. The email for the ``copyright`` holder.}


GET (profile as tar.gz)
-----------------------------------------------------
Use to download a profile as |tar gz| file. A profile, once downloaded, may be edited locally, and then re-uploaded back to the |chef compliance| server using the ``POST`` method.

**Request**

.. code-block:: xml

   GET /api/owners/OWNER/compliance/PROFILE/tar

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/compliance/ssh/tar" -u "$API_KEY:" > /tmp/profile.tar.gz
   tar -zxvf /tmp/profile.tar.gz

POST
-----------------------------------------------------
Use to upload a compliance profile as a |tar gz| or |zip|. This process will extract the owner and identifier, and then use that information to place the profile into the correct location on the |chef compliance| server.

**Request**

.. code-block:: xml

   POST /api/owners/OWNER/compliance

For example:

.. code-block:: bash

   tar -cvzf /tmp/newprofile.tar.gz newprofile
   curl -k -X POST "https://$API_HOST/api/owners/john/compliance?contentType=application/x-gtar" \
   -u "$API_KEY:" --form "file=@/tmp/newprofile.tar.gz"

   zip -r /tmp/newprofile.zip newprofile
   curl -k -X POST "https://$API_HOST/api/owners/john/compliance?contentType=application/zip" \
   -u "$API_KEY:" --form "file=@/tmp/newprofile.zip"


POST (profile as tar.gz)
-----------------------------------------------------
Use to upload a profile using a |tar gz| file.

**Request**

.. code-block:: xml

   POST /api/owners/OWNER/compliance/PROFILE/tar

For example:

.. code-block:: bash

   tar -cvzf /tmp/newprofile.tar.gz newprofile
   curl -X POST "https://$API_HOST/api/owners/john/compliance/newprofile/tar" \
   -u "$API_KEY:" --data-binary "@/tmp/newprofile.tar.gz"

POST (profile as Zip)
-----------------------------------------------------
Use to upload a profile using a |zip| file. A |zip| file may be created with a command similar to:

.. code-block:: bash

   $ zip -r /tmp/newprofile.zip profile_directory

or it may be created from the context menus in the |windows| and/or |mac os x| graphical user interfaces.

**Request**

.. code-block:: xml

   POST /api/owners/OWNER/compliance/PROFILE/zip

For example:

.. code-block:: bash

   zip -r /tmp/newprofile.zip newprofile
   curl -X POST "https://$API_HOST/api/owners/john/compliance/newprofile/zip" \
   -u "$API_KEY:" --data-binary "@/tmp/newprofile.zip"

.. The example above seems to be a mix of API request + command line stuff. What does the actual request look like?

/envs
=====================================================
The ``/envs`` endpoint has the following methods: ``DELETE``, ``GET``(for both all environments or for a single, named environment), and ``POST``.

DELETE
-----------------------------------------------------
Use to delete the named environment.

**Request**

.. code-block:: xml

   DELETE /api/owners/USER/envs/ENV

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/owners/john/envs/production" -u "$API_KEY:"

**Response**

No Content

GET (named environment)
-----------------------------------------------------
Use to return details about the named environment.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "production",
     "owner": "john",
     "name": "",
     "lastScan": "0001-01-01T00:00:00Z",
     "complianceStatus": 0,
     "patchlevelStatus": 0,
     "unknownStatus": 0
   }

GET (all environments)
-----------------------------------------------------
Use to get a list of all environments.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "production",
       "owner": "john",
       "name": "",
       "lastScan": "0001-01-01T00:00:00Z",
       "complianceStatus": 0,
       "patchlevelStatus": 0,
       "unknownStatus": 0
     }
   ]

POST
-----------------------------------------------------
Use to create an environment.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - String. Required. The identifier for the environment.

**Request**

.. code-block:: xml

   POST /api/owners/USER/envs

where ``/USER`` is the identifier for a user or an organization.

For example:

.. code-block:: bash

   curl -v -X POST "https://$API_HOST/api/owners/john/envs" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{"id":"my_new_env"}'

**Response**

No Content

/jobs
=====================================================
The ``/jobs`` endpoint has the following methods: ``DELETE``, ``GET``(for both all jobs or for a single, named job), and ``POST``.

DELETE
-----------------------------------------------------
Use to delete a job.

**Request**

.. code-block:: xml

   DELETE /api/owners/USER/jobs/JOB_ID

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/owners/john/jobs/c8ba8e88-7e45-4253-9081-cbb17a5f0c76" -u "$API_KEY:"

**Response**

No Content

GET (all jobs)
-----------------------------------------------------
Use to get a list of all jobs.

**Request**

.. code-block:: xml

   GET /api/owners/USER/jobs

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/jobs" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [{
     "id": "76fdce4d-0734-441c-b01b-6dd6bfce081a",
     "status": "done",
     "nextRun": "2015-07-21T20:55:00Z",
     "schedule": "2015-07-21T20:55:00Z"
   },
   {
     "id": "c8ba8e88-7e45-4253-9081-cbb17a5f0c76",
     "status": "scheduled",
     "name": "Rec",
     "nextRun": "2015-07-21T23:11:00Z",
     "schedule": {
       "month": "*",
       "day": "21",
       "weekday": "*",
       "hour": "23",
       "minute": "11"
     }
   },
   {
     "id": "e0d5bbf0-a1c4-4c50-ad09-fc1486068e8c",
     "status": "skipped",
     "nextRun": "0001-01-01T00:00:00Z",
     "schedule": "2015-07-21T20:25:00Z"
   }]

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - UUID. The identifier of the job run.
   * - ``name``
     - String. The name of the job.
   * - ``nextRun``
     - ISO date. The time of the next scheduled run, in UTC. For example: ``2015-07-21T20:50:00Z``.
   * - ``schedule``
     - Cron or ISO date. The schedule for the job run. For example: ``2015-07-21T20:50:00Z`` or ``{ "month": "*", "day": "21", "weekday": "*", "hour": "23", "minute": "11" }``.
   * - ``status``
     - String. The status of the job run: ``done``, ``scheduled``, or ``skipped``.

GET (named job)
-----------------------------------------------------
Use to return details about the named job.

**Request**

.. code-block:: xml

   GET /api/owners/USER/jobs/JOB_ID

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/jobs/c8ba8e88-7e45-4253-9081-cbb17a5f0c76" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "c8ba8e88-7e45-4253-9081-cbb17a5f0c76",
     "status": "scheduled",
     "name": "Rec",
     "nextRun": "2015-07-21T23:11:00Z",
     "schedule": {
       "month": "*",
       "day": "21",
       "weekday": "*",
       "hour": "23",
       "minute": "11"
     },
     "tasks": [{
       "type": "scan",
       "environments": [{
         "nodes": ["u12", "u14"],
         "id": "production"
       }],
       "compliance": [{
         "owner": "chef",
         "profile": "linux"
       }, {
         "owner": "chef",
         "profile": "ssh"
       }],
       "patchlevel": [{
         "profile": "default",
         "force": false
       }]
     }]
   }

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - UUID. The identifier of the job run.
   * - ``name``
     - String. The name of the job.
   * - ``nextRun``
     - ISO date. The time of the next scheduled run, in UTC. For example: ``2015-07-21T20:50:00Z``.
   * - ``schedule``
     - Cron or ISO date. The schedule for the job run. For example: ``2015-07-21T20:50:00Z`` or ``{ "month": "*", "day": "21", "weekday": "*", "hour": "23", "minute": "11" }``.
   * - ``status``
     - String. The status of the job run: ``done``, ``scheduled``, or ``skipped``.
   * - ``tasks``
     - An array of compliance scans or patch runs. Two types of tasks are available: ``scan`` and ``patchrun``. The |json| object for ``tasks`` is similar to:

       .. code-block:: javascript

          "tasks": [{
            "compliance": [{
             "owner": "chef",
              "profile": "linux"
            }, {
              "owner": "chef",
              "profile": "ssh"
            }],
            "environments": [{
              "id": "production",
              "nodes": ["u12", "u14"]
            }],
            "patchlevel": [{
              "profile": "default"
            }],
            "type": "scan"
          }]

.. note the mention of "patch runs" above ^^^

POST
-----------------------------------------------------
Use to create a job.

**Request**

.. code-block:: xml

   POST /api/owners/USER/jobs

The request uses a |json| object similar to:

.. code-block:: javascript

   {
     "id": "c8ba8e88-7e45-4253-9081-cbb17a5f0c76",
     "name": "Rec",
     "schedule": {
       "hour": "23",
       "minute": "11",
       "day": "21",
       "month": "*",
       "weekday": "*"
     },
     "tasks": [{
       "compliance": [{
        "owner": "chef",
         "profile": "linux"
       }, {
         "owner": "chef",
         "profile": "ssh"
       }],
       "environments": [{
         "id": "production",
         "nodes": ["u12", "u14"]
       }],
       "patchlevel": [{
         "profile": "default"
       }],
       "type": "scan"
     }]
   }

For example:

.. code-block:: bash

   curl -v -X POST "https://$API_HOST/api/owners/john/jobs" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

/keys
=====================================================
The ``/keys`` endpoint has the following methods: ``DELETE``, ``GET``, ``PATCH``, and ``POST``.

DELETE
-----------------------------------------------------
Use to delete the named key pair that is available to the named user.

**Request**

.. code-block:: xml

   DELETE /api/owners/USER/keys/KEY_NAME

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/owners/john/keys/vagrant" -u "$API_KEY:"

**Response**

No Content

GET
-----------------------------------------------------
Use to get the list of key pairs available to the named user.

**Request**

.. code-block:: xml

   GET /api/owners/USER/keys

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/keys" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [{
     "owner": "admin",
     "id": "vagrant",
     "name": "vagrant",
     "public": "ssh-rsa\
                AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YV\
                r+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCg\
                zUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8Hf\
                dOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPX\
                Q2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFU\
                GaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c\
                9WhQ== vagrant insecure public key"
   }]

PATCH
-----------------------------------------------------
Use to edit the details for the named key pair that is available to the named user.

**Request**

.. code-block:: xml

   PATCH /api/owners/USER/keys/KEY_NAME

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/owners/john/keys/vagrant" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

POST
-----------------------------------------------------
Use to add a key pair to be available to the named user.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - String. The key identifier.
   * - ``name``
     - String. The human-readable name of the key.
   * - ``private``
     - String. The private key, in |open ssh| format.
   * - ``public``
     - String. The public key, in |open ssh| format.

**Request**

.. code-block:: xml

   POST /api/owners/USER/keys

with a |json| object similar to:

.. code-block:: javascript

   {
     "name": "vagrant",
     "id": "vagrant",
     "private": "-----BEGIN RSA PRIVATE\
                KEY-----\nMIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+\
                kz4TjGYe7gHzI\nw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCg\
                zUFtdOKLv6IedplqoP\nkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8\
                HfdOV0IAdx4O7PtixWKn5y2\nhMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL\
                +GPXQ2MWZWFYbAGjyiYJnAmCP3NO\nTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R\
                4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW\nyLbIbEgE98OHlnVYCzRdK8jlqm\
                8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd\nELs4jJsdyky+ewdZeNds5\
                tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1\nBw7XpgUwFgeUJwUl\
                zQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf\nTK2Lg6EdbUE\
                CZpigBKbKZHNYcelXtTt/nP3r3s=\n-----END RSA PRIVATE KEY-----",
     "public": "ssh-rsa\
                AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YV\
                r+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCg\
                zUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8Hf\
                dOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPX\
                Q2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFU\
                GaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c\
                9WhQ== vagrant insecure public key"
   }

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/owners/john/keys" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

/nodes
=====================================================
The ``/nodes`` endpoint has the following methods: ``POST``, ``PATCH`` and ``DELETE``. It is used for bulk operations, potentially across multiple environments.

POST (bulk)
-----------------------------------------------------
Use to create one or multipe nodes.

**Request**

.. code-block:: xml

   POST /api/owners/USER/nodes

with a |json| object similar to:

.. code-block:: javascript

  [
    {
      "id": "lb1.example.com",
      "hostname": "lb1.example.com",
      "name": "Load Balancer 1",
      "environment": "production",
      "loginUser": "root",
      "loginMethod": "ssh",
      "loginKey": "john/nameofkey"
    },
    {
      "id": "lb2.example.com",
      "hostname": "lb2.example.com",
      "name": "Load Balancer 2",
      "environment": "production",
      "loginUser": "root",
      "loginMethod": "ssh",
      "loginKey": "john/nameofkey"
    }
  ]

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/owners/john/nodes" -H "Content-Type: application/json" -u "$API_KEY:" \
   -d '[{"id":"lb1.example.com","hostname":"lb1.example.com","name":"Load Balancer 1","environment":"production","loginUser":"root","loginMethod":"ssh","loginKey":"john/nameofkey"},{"id":"lb2.example.com","hostname":"lb2.example.com","name":"Load Balancer 2","environment":"production","loginUser":"root","loginMethod":"ssh","loginKey":"john/nameofkey"}]'

**Response**

No Content

PATCH (bulk)
-----------------------------------------------------
Use to update one or multiple nodes in one request.

**Request**

.. code-block:: xml

   PATCH /api/owners/USER/nodes

with a |json| object similar to:

.. code-block:: javascript

  [
    {
      "id": "lb1.example.com",
      "hostname": "lb1.example.com",
      "name": "Load Balancer 1 - updated",
      "environment": "production",
      "loginUser": "root",
      "loginMethod": "ssh",
      "loginKey": "john/nameofkey"
    },
    {
      "id": "lb2.example.com",
      "hostname": "lb2.example.com",
      "name": "Load Balancer 2 - updated",
      "environment": "production",
      "loginUser": "root",
      "loginMethod": "ssh",
      "loginKey": "john/nameofkey"
    }
  ]

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/owners/john/nodes" -H "Content-Type: application/json" -u "$API_KEY:" \
   -d '[{"id":"lb1.example.com","hostname":"lb1.example.com","name":"Load Balancer 1 - updated","environment":"production","loginUser":"root","loginMethod":"ssh","loginKey":"john/nameofkey"},{"id":"lb2.example.com","hostname":"lb2.example.com","name":"Load Balancer 2 - updated","environment":"production","loginUser":"root","loginMethod":"ssh","loginKey":"john/nameofkey"}]'

**Response**

No Content

DELETE (bulk)
-----------------------------------------------------
Delete one or multiple nodes specified in the payload of the request.

**Request**

.. code-block:: xml

   DELETE /api/owners/USER/nodes

with a |json| object similar to:

.. code-block:: javascript

  [
    {
      "id": "lb1.example.com",
      "environment": "production"
    },
    {
      "id": "lb.qa.example.com",
      "environment": "qa"
    }
  ]

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200" \
   -u "$API_KEY:" -d '[{"id":"lb1.example.com","environment":"production"},{"id":"lb.qa.example.com","environment":"qa"}]'

**Response**

No Content

/envs/ENV/nodes
=====================================================
The ``/envs/ENV/nodes`` endpoint has the following methods: ``GET``, ``POST`` and ``DELETE``. The ``GET`` method may be used to return information about nodes, including by environment, by named node, node status, connectivity status, lists of installed packages, compliance state, and patch state.

.. ^^^ REFERENCE TO PATCH

GET (nodes by environment)
-----------------------------------------------------
Use to get a list of all nodes for the named environment.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "192.168.100.200",
       "environment": "production",
       "owner": "john",
       "name": "",
       "hostname": "192.168.100.200",
       "loginMethod": "ssh",
       "loginUser": "root",
       "loginPassword": "",
       "loginKey": "sshpublickey",
       "loginPort": 0,
       "disableSudo": false,
       "sudoOptions": "",
       "sudoPassword": "",
       "lastScan": "0001-01-01T00:00:00Z",
       "lastScanID": "",
       "arch": "",
       "family": "",
       "release": "",
       "complianceStatus": 0,
       "patchlevelStatus": 0,
       "unknownStatus": 0
     }
   ]

GET (named node)
-----------------------------------------------------
Use to return details about the named node.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes/NODE

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "192.168.100.200",
     "environment": "production",
     "owner": "john",
     "name": "",
     "hostname": "192.168.100.200",
     "loginMethod": "ssh",
     "loginUser": "root",
     "loginPassword": "",
     "loginKey": "sshpublickey",
     "loginPort": 0,
     "disableSudo": false,
     "sudoOptions": "",
     "sudoPassword": "",
     "lastScan": "0001-01-01T00:00:00Z",
     "lastScanID": "",
     "arch": "",
     "family": "",
     "release": "",
     "complianceStatus": 0,
     "patchlevelStatus": 0,
     "unknownStatus": 0
   }

POST
-----------------------------------------------------
Use to create a node.

**Request**

.. code-block:: xml

   POST /api/owners/USER/envs/ENV/nodes

with a |json| object similar to:

.. code-block:: javascript

   {
     "loginUser": "root",
     "loginMethod": "ssh",
     "loginKey": "john/nameofkey",
     "hostname": "192.168.100.200",
     "loginPort": 22,
     "id": "192.168.100.200"
   }

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/owners/john/envs/production/nodes" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

DELETE
-----------------------------------------------------
Delete a node from an environment.

**Request**

.. code-block:: xml

   DELETE /api/owners/USER/envs/ENV/nodes/NODE

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200" -u "$API_KEY:"

**Response**

No Content

PATCH
-----------------------------------------------------
Use to update a node.

**Request**

.. code-block:: xml

   PATCH /api/owners/USER/envs/ENV/nodes/NODE

with a |json| object similar to:

.. code-block:: javascript

  {
    "hostname": "lb1.example.com",
    "name": "Load Balancer 1 - new",
    "loginUser": "root",
    "loginMethod": "ssh",
    "loginKey": "john/nameofkey"
  }

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/owners/john/envs/ENV/nodes/lb1.example.com" -H "Content-Type: application/json" -u "$API_KEY:" \
   -d '{"hostname":"lb1.example.com","name":"Load Balancer 1 - new","environment":"production","loginUser":"root","loginMethod":"ssh","loginKey":"john/nameofkey"}'

**Response**

No Content

GET (connectivity)
-----------------------------------------------------
Use to show the connectivity state for the named node.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes/NODE/connectivity

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200/connectivity" -u "$API_KEY:"

**Response**

The request will return one of the following response code:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - Success.
   * - ``402``
     - Request Failed -- Node is not reachable. A failed response returns one of the following messages:

       Connection timeout:

       .. code-block:: javascript

          {
            "error":"connection timed out",
            "message":"Failed to connect to {destination}, connection timed out."
          }

       Connection refused:

       .. code-block:: javascript

          {
            "error":"connection refused",
            "message":"Failed to connect to {destination}, connection refused."
          }

       Authentication failure:

       .. code-block:: javascript

          {
            "error":"authentication failed",
            "message":"Authentication failed for {destination}"
          }

       Sudo password required:

       .. code-block:: javascript

          {
            "error":"sudo password required",
            "message":"Failed to run commands on {destination}: "+
            "The node is configured to use sudo, but sudo requires a password to run commands."
          }

       Incorrect sudo password:

       .. code-block:: javascript

          {
            "error":"wrong sudo password",
            "message":"Failed to run commands on {destination}: Sudo password is incorrect."
          }

       Cannot use sudo:

       .. code-block:: javascript

          {
            "error":"no sudo",
            "message":"Failed to run commands on {destination}: "+
            "Cannot use sudo, please deactivate it or configure sudo for this user."
          }

GET (compliance)
-----------------------------------------------------
Use to show the compliance state for the named node.

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes/NODE/compliance

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200/compliance" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "failures": 1,
       "impact": 1,
       "log": "Linux kernel parameter \"net.ipv4.tcp_syncookies\" value should eq 1",
       "profileID": "linux",
       "profileOwner": "chef",
       "rule": "chef/linux/sysctl-ipv4-9.2",
       "skipped": false
     },
     {
       "failures": 1,
       "impact": 0.5,
       "log": "Path \"/tmp\" should be mounted",
       "profileID": "linux",
       "profileOwner": "chef",
       "rule": "chef/linux/fs-1",
       "skipped": false
     },
     ...
   ]

GET (patch)
-----------------------------------------------------
Use to show the patch state for the named node.

.. ATTN: remove this, right?

**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes/NODE/patches

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200/patches" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "arch": "amd64",
       "criticality": 0,
       "installedVersion": "2.7.3-0ubuntu3.6",
       "name": "python2.7-minimal",
       "repo": "Ubuntu:12.04/precise-updates",
       "type": "deb",
       "version": "2.7.3-0ubuntu3.8"
     },
     ...
   ]

GET (packages)
-----------------------------------------------------
Use to show the list of installed packages for the named node.


**Request**

.. code-block:: xml

   GET /api/owners/USER/envs/ENV/nodes/NODE/packages

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/envs/production/nodes/192.168.100.200/packages" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "arch": "add",
       "name": "adduser",
       "repo": "",
       "type": "deb",
       "version": "3.113ubuntu2"
     },
     {
       "arch": "commandline",
       "name": "apt",
       "repo": "",
       "type": "deb",
       "version": "0.8.16~exp12ubuntu10.24"
     },
     ...
   ]

/orgs
=====================================================
The ``/orgs`` endpoint has the following methods: ``DELETE``, ``GET``(for both all organizations or for a single, named organizatin). ``PATCH``, and ``POST``.

DELETE
-----------------------------------------------------
Use to delete the named organization. The user of this endpoint must have administrative rights.

.. warning:: Deleting an organization will delete all assigned teams, nodes, environments, and scan reports.

**Request**

.. code-block:: xml

   DELETE /api/orgs/ORG

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/orgs/acme" -u "$API_KEY:"

**Response**

No Content

GET (all organizations)
-----------------------------------------------------
Use to get a list of all organizations.

**Request**

.. code-block:: xml

   GET /api/orgs

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/orgs" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "acme",
       "name": "Acme Industries"
     }
   ]

GET (named organization)
-----------------------------------------------------
Use to return details about the named organization.

**Request**

.. code-block:: xml

   GET /api/orgs/ORG

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/orgs/acme" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "acme",
     "name": "Acme Industries"
   }

PATCH
-----------------------------------------------------
Use to edit the name of an organization.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``name``
     - String. The name of the organization.

**Request**

.. code-block:: xml

   PATCH /api/orgs

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/orgs/acme" -H "Content-Type: application/json" \
   -u "$API_KEY:" -d '{"id":"acme","name":"Acme Industries #2"}'

**Response**

No Content

POST
-----------------------------------------------------
Use to create an organization.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - String. Required. The identifier for the organization.
   * - ``name``
     - String. Required. The name of the organization.

**Request**

.. code-block:: xml

   POST /api/orgs

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/orgs" -H "Content-Type: application/json" \
   -u "$API_KEY:" -d '{"id":"acme","name":"Acme Industries"}'

**Response**

No Content

/scans
=====================================================
The ``/scans`` endpoint has a single method: ``GET`` that may be used to get details for all scans or for a single, named scan.

GET (all scan reports)
-----------------------------------------------------
Use to get a list of all scan reports.

.. note:: All scan reports belong to a named user. Scan reports can be configured to scan nodes from various environments.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "a74566b9-b527-437f-480f-e56c5b8a1791",
       "owner": "john",
       "start": "2015-05-22T01:10:37.133367688Z",
       "end": "2015-05-22T01:10:42.491573741Z",
       "nodeCount": 1,
       "complianceProfiles": 1,
       "patchlevelProfiles": 1,
       "complianceStatus": 0,
       "patchlevelStatus": 0,
       "unknownStatus": 0,
       "failedCount": 0
     }
   ]

GET (named scan report)
-----------------------------------------------------
Use to return details about the named scan report.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "a74566b9-b527-437f-480f-e56c5b8a1791",
     "owner": "admin",
     "start": "2015-05-22T01:10:37.133367688Z",
     "end": "2015-05-22T01:10:42.491573741Z",
     "nodeCount": 1,
     "complianceProfiles": 1,
     "patchlevelProfiles": 1,
     "complianceStatus": 0,
     "patchlevelStatus": 0,
     "unknownStatus": 0,
     "failedCount": 0,
     "complianceSummary": {
       "success": 0,
       "minor": 0,
       "major": 43,
       "critical": 2,
       "skipped": 0,
       "total": 45
     },
     "patchlevelSummary": {
     "success": 0,
     "minor": 0,
     "major": 0,
     "critical": 0,
     "unknown": 0,
     "total": 0
     }
   }

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``critical``
     - Float. The number of failed rules.
   * - ``end``
     - ISO date. The time at which a scan report ended.
   * - ``id``
     - String. The scan report identifier.
   * - ``major``
     - Float. The number of rules that contain major errors.
   * - ``minor``
     - Float. The number of rules that contain minor errors.
   * - ``nodeCount``
     - Integer. The number of nodes that were tested.
   * - ``failedCount``
     - Integer. The number of nodes that were failed to be tested.
   * - ``owner``
     - String. The owner of the scan.
   * - ``skipped``
     - Float. The number of nodes with skipped rules.
   * - ``start``
     - ISO date. The time at which a scan report started.
   * - ``success``
     - Float. The number of successful rules.

POST
-----------------------------------------------------
Use to create a new scan.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``compliance``
     - An array of selected profiles.
   * - ``environments``
     - An array of environments and selected nodes.
..
.. ATTN: Christoph or Dominick
.. remove this parameter or keep it in the parameter table?
..
..    * - ``patchlevel``
..      - An array of items in the patch level scan profile.
..

**Request**

.. code-block:: xml

   POST /api/owners/USER/scans

with a |json| object similar to:

.. code-block:: javascript

   {
     "compliance": [{
       "owner": "chef",
       "profile": "linux"
     },{
       "owner": "chef",
       "profile": "ssh"
     }],
     "environments": [{
       "id": "production",
       "nodes": ["192.168.100.200"]
     }],
     "patchlevel": [{
       "profile" : "default"
       }]
   }

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/owners/john/scans" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id" : "57130678-1a1f-405d-70bf-fe570a25621e"
   }

/scans/SCAN_ID/rules
=====================================================
The ``/scans/SCAN_ID/rules`` endpoint has the following methods: ``GET``.

GET (named scan)
-----------------------------------------------------
Use to get the executed compliance rules for the named scan.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID/rules

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID/rules" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "chef": {
       "linux": {
         "chef/linux/basic-1": {
           "log": "",
           "complianceStatus": 1,
           "unknownStatus": 0
         },
         "chef/linux/fs-1": {
           "log": "",
           "complianceStatus": 0.5,
           "unknownStatus": 0
         },
       ...
     }
   }

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``complianceStatus``
     - Integer. The Common Vulnerability Scoring System (CVSS) range, `a measurement of the level of concern for a vulnerability <https://en.wikipedia.org/wiki/CVSS>`__, as compared to other vulnerabilities. Scores range from ``0.0`` to ``10.0``. High scores are in the 7.0-10.0 range, medium scores are in the 4.0-6.9 range, and low scores are from 0.0-3.9 range.
   * - ``log``
     - String. The rule description.

/scans/SCAN_ID/nodes
=====================================================
The ``/scans/SCAN_ID/nodes`` endpoint has a single method: ``GET``.

GET (all nodes)
-----------------------------------------------------
Use to get all scans for all nodes.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID/nodes

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID/nodes" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "environment": "production",
       "node": "192.168.59.107:11024",
       "complianceStatus": 0,
       "patchlevelStatus": -1,
       "unknownStatus": 0,
       "arch": "",
       "family": "",
       "release": "",
       "connectSuccess": false,
       "connectMessage": "Failed to verify connectivity to sshPassword://root@192.168.56.239:0 using login password : exit status 1",
       "complianceSummary": {
         "success": 0,
         "minor": 0,
         "major": 43,
         "critical": 2,
         "skipped": 0,
         "total": 45
       },
       "patchlevelSummary": {
         "success": 0,
         "minor": 0,
         "major": 0,
         "critical": 0,
         "unknown": 0,
         "total": 0
       },
       "patchStatus": null
     }
   ]

/scans/SCAN_ID/envs/ENV
=====================================================
The ``/scans/SCAN_ID/envs/ENV`` endpoint has a single method: ``GET`` that may be used to get compliance, patch, or package details by node.

.. remove reference to patch? ^^^

GET (compliance by node)
-----------------------------------------------------
Use to get the compliance results for the named node and the named environment.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID/envs/ENV/nodes/NODE/compliance

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID/envs/production/nodes/192.168.100.200/compliance" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "profileOwner": "chef",
       "profileID": "linux",
       "rule": "chef/linux/basic-1",
       "impact": 1,
       "failures": 1,
       "skipped": false,
       "log": "Path \"/etc/ssh\" should be directory"
     },
     ...
   ]

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``failures``
     - Integer. The amount of failures per rule. Use ``-1`` to skip and ``0`` for no failures.
   * - ``impact``
     - Float. The impact of the compliance results. Must be a value between ``0`` and ``1``.
   * - ``log``
     - String. The error log.
   * - ``profileID``
     - String. The compliance rules identifier.
   * - ``profileOwner``
     - String. The owner of the compliance rules.
   * - ``rule``
     - String. The rule identifier.

..
.. ATTN: Christoph or Dominick
.. remove the GET (patches by node) section below?
..

GET (patches by node)
-----------------------------------------------------
Use to get the available patches for the named node and the named environment.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID/envs/ENV/nodes/NODE/patches

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID/envs/production/nodes/192.168.100.200/patches" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "arch": "amd64",
       "criticality": 0,
       "installedVersion": "2.7.3-0ubuntu3.6",
       "name": "python2.7-minimal",
       "repo": "Ubuntu:12.04/precise-updates",
       "type": "deb",
       "version": "2.7.3-0ubuntu3.8"
     }
     ...
   ]

It contains the following attributes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``arch``
     - String. The CPU architecture.
   * - ``criticality``
     - Integer. The Common Vulnerability Scoring System (CVSS) range, `a measurement of the level of concern for a vulnerability <https://en.wikipedia.org/wiki/CVSS>`__, as compared to other vulnerabilities. Scores range from ``0.0`` to ``10.0``. High scores are in the 7.0-10.0 range, medium scores are in the 4.0-6.9 range, and low scores are from 0.0-3.9 range.
   * - ``name``
     - String. The name of the package.
   * - ``repo``
     - String. The package repository.
   * - ``version``
     - String. The package version.

GET (packages by node)
-----------------------------------------------------
Use to get the installed packages for the named node and the named environment.

**Request**

.. code-block:: xml

   GET /api/owners/USER/scans/SCAN_ID/envs/ENV/nodes/NODE/packages

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/scans/SCAN_ID/envs/production/nodes/192.168.100.200/packages" -u "$API_KEY:"

where ``SCAN_ID`` is similar to ``90def607-1688-40f5-5a4c-161c51fd8aac``.

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "arch": "add",
       "name": "adduser",
       "repo": "",
       "type": "deb",
       "version": "3.113ubuntu2"
     },
     {
       "arch": "commandline",
       "name": "apt",
       "repo": "",
       "type": "deb",
       "version": "0.8.16~exp12ubuntu10.24"
     },
     ...
   ]

/server/config
=====================================================
The ``/server/config`` endpoint has the following methods: ``GET`` and ``PATCH``.

.. note:: Some parameters of the |chef compliance| server are exposed and are configurable from the |api compliance|.

.. CHRISTOPH: do we know which paramaters? Many or a small set of specific parameters?

GET
-----------------------------------------------------
Use to return the global configuration for the |chef compliance| server. The configuration may be edited via the |api compliance| or by using the COMPLIANCE_CONFIG_FILE. Only parameters that may be safely tuned are exposed. All timeout configuration settings are defined in seconds, i.e. ``1800`` is ``30 minutes``. << CHRISTOPH: can you point me to the list of tunable settings for the Compliance Server?

**Request**

.. code-block:: xml

   GET /api/server/config

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/server/config" \
   -H "Content-Type: application/json" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
    "port": null,
    "host": null,
    "colors": null,
    "detectTimeout": 30,
    "scanTimeout": 1800,
    "updateTimeout": 1800,
    "home": null
    }

PATCH
-----------------------------------------------------
Use to edit the global configuration for the |chef compliance| server.

**Request**

.. code-block:: xml

   PATCH /api/server/config

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/server/config" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

/summary
=====================================================

GET
-----------------------------------------------------
Get a quick summary(number of nodes and environments) of the account.

**Request**

.. code-block:: xml

   GET /api/owners/OWNER/summary

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/owners/john/summary" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "nodeCount": 2,
     "envCount": 2
   }

/teams
=====================================================
The ``/teams`` endpoint has the following methods: ``DELETE``, ``GET``(for both all teams or for a single, named team). ``PATCH``, and ``POST``.

DELETE
-----------------------------------------------------
Use to delete a team from the named organization.

.. warning:: The ``owners`` team cannot be deleted.

**Request**

.. code-block:: xml

   DELETE /api/orgs/ORG/teams/TEAM

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/orgs/acme/teams/audit" -u "$API_KEY:"

**Response**

No Content

GET (all teams)
-----------------------------------------------------
Use to get a list of all teams. Each organization has a ``owners`` team, by default.

**Request**

.. code-block:: xml

   GET /api/orgs/ORG/teams

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/orgs/acme/teams" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "owners",
       "org": "acme",
       "name": "Owners"
     }
   ]

GET (named team)
-----------------------------------------------------
Use to return details about the named team.

**Request**

.. code-block:: xml

   GET /api/orgs/ORG/teams/TEAM

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/orgs/acme/teams/owners" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "owners",
     "org": "acme",
     "name": "Owners",
     "members": [
       "admin"
     ],
     "permissions": {
       "harden": "true",
       "manage": "true",
       "patch": "true",
       "scan": "true"
     }
   }

PATCH
-----------------------------------------------------
Use to edit the details for a team that belongs to the named organization.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``name``
     - Required. The name of the user.
   * - ``permissions``
     - Object. The permissions to assign to the team: ``harden``, ``manage``, ``patch``, or ``scan``.

**Request**

.. code-block:: xml

   PATCH /api/orgs/ORG/teams/TEAM

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/orgs/acme/teams/audit" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

POST
-----------------------------------------------------
Use to create a new team within the named organization.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - Required. The user identifier.
   * - ``name``
     - Required. The name of the user.
   * - ``permissions``
     - Object. The permissions to assign to the team: ``harden``, ``manage``, ``patch``, or ``scan``.

**Request**

.. code-block:: xml

   POST /api/orgs/ORG/teams

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/orgs/acme/teams" \
   -H "Content-Type: application/json" -u "$API_KEY:" \
   -d '{"id":"manageteam","name":"Manage Only Team","permissions":{"manage":"true"}}'

**Response**

No Content

/teams/TEAM/members
=====================================================
The ``/teams/TEAM/members`` endpoint has the following methods: ``DELETE``, ``GET``, ``PATCH``, and ``POST``.

DELETE
-----------------------------------------------------
Use to delete a team member.

**Request**

.. code-block:: xml

   DELETE /api/orgs/ORG/teams/TEAM/members/MEMBER

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/orgs/acme/teams/audit/members/bob" -u "$API_KEY:"

**Response**

No Content

GET
-----------------------------------------------------
Use to get a list of team memberships.

**Request**

.. code-block:: xml

   GET /api/orgs/ORG/teams/TEAM/members

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/orgs/acme/teams/owners/members" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "owners",
     "org": "acme",
     "name": "Owners",
     "members": [
       "admin"
     ],
     "permissions": {
       "harden": "true",
       "manage": "true",
       "patch": "true",
       "scan": "true"
     }
   }

PATCH
-----------------------------------------------------
Use to edit team membership details for the named team member.

**Request**

.. code-block:: xml

   PATCH /api/orgs/ORG/teams/TEAM/members/MEMBER

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/orgs/acme/teams/audit" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

POST
-----------------------------------------------------
Use to add one (or more) a members to the named team.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``users``
     - Required. An array of user identifiers. Full JSON example: '{["bob","mary"]}'

**Request**

.. code-block:: xml

   POST /api/orgs/ORG/teams/TEAM/members

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/orgs/acme/teams/owners/members" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{["bob"]}'

**Response**

No Content

/users
=====================================================
The ``/users`` endpoint has a single method: ``GET`` that may be used to get details for all users or for a single, named user.

GET (all users)
-----------------------------------------------------
Use to get a list of all users.

**Request**

.. code-block:: xml

   GET /api/users

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/users" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   [
     {
       "id": "john",
       "name": "Core Admin"
     }
   ]


GET (named user)
-----------------------------------------------------
Use to return details about the named user.

**Request**

.. code-block:: xml

   GET /api/users/USER

For example:

.. code-block:: bash

   curl -X GET "https://$API_HOST/api/users/john" -u "$API_KEY:"

**Response**

The response will return a |json| object similar to:

.. code-block:: javascript

   {
     "id": "john",
     "name": "Core Admin",
     "preferences": null,
     "permissions": {
       "site_admin": "true"
     }
   }

POST
-----------------------------------------------------
Use to create a new user.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``id``
     - Required. The user identifier.
   * - ``name``
     - String. The name of the user.
   * - ``pass``
     - String. The unencrypted password for the user.

**Request**

.. code-block:: xml

   POST /api/users

For example:

.. code-block:: bash

   curl -X POST "https://$API_HOST/api/users" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'

**Response**

No Content

PATCH
-----------------------------------------------------
Use to edit the details for an existing user.

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``name``
     - String. The name of the user.
   * - ``pass``
     - String. The unencrypted password for the user.

**Request**

.. code-block:: xml

   PATCH /api/users/USER

For example:

.. code-block:: bash

   curl -X PATCH "https://$API_HOST/api/users/bob" \
   -H "Content-Type: application/json" -u "$API_KEY:" -d '{ JSON_BLOCK }'


**Response**

No Content

DELETE
-----------------------------------------------------
Use to delete an existing user.

**Request**

.. code-block:: xml

   DELETE /api/users/USER

For example:

.. code-block:: bash

   curl -X DELETE "https://$API_HOST/api/users/bob" -u "$API_KEY:"

**Response**

No Content