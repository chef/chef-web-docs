.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create a new cookbook.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /cookbooks/COOKBOOK_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "apt",
     "maintainer": "opscode",
     "description": "Configures apt and apt services and LWRPs for managing apt repositories and preferences",
     "category": "Package Management",
     "latest_version": "http://supermarket.chef.io/api/v1/cookbooks/apt/versions/2_4_0",
     "external_url": "http://github.com/chef-cookbooks/apt",
     "average_rating": null,
     "created_at": "2009-10-25T23:48:48.000Z",
     "updated_at": "2014-05-15T17:45:14.000Z"
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| The cookbook was posted to the |api cookbooks site|.
   * - ``400``
     - |response code 400 unsuccessful| The cookbook was not posted to the |api cookbooks site|. For example:

       .. code-block:: javascript

          {
             "error_messages":
             ["You're not authorized to upload this cookbook."],
             "error_code": "UNAUTHORIZED"
          }
