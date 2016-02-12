.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the details for a cookbook.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /cookbooks/COOKBOOK_NAME

**Response**

The response will return details for a cookbook, including name of the cookbook, the category to which it belongs, the name of the individual who maintains the cookbook, the URI for the latest version and previous versions, its description, and so on it also includes metrics about the cookbooks namely number of downloads and followers:

.. code-block:: javascript

   {
     "name": "yum",
     "maintainer": "opscode",
     "description": "Configures various yum components on Red Hat-like systems",
     "category": "Package Management",
     "latest_version": "http://supermarket.chef.io/api/v1/cookbooks/yum/versions/3_2_2",
     "external_url": "http://github.com/chef-cookbooks/yum",
     "average_rating": null,
     "created_at": "2011-04-20T22:16:12.000Z",
     "updated_at": "2014-06-11T19:06:37.000Z",
     "deprecated": false,
     "versions": [
       "http://supermarket.chef.io/api/v1/cookbooks/yum/versions/3_2_2",
       "http://supermarket.chef.io/api/v1/cookbooks/yum/versions/3_2_0"
     ],
     "metrics": {
       "downloads": {
         "total": 8500
         "versions": {
           "3.2.0": 399,
           "3.2.2": 1
         }
      },
      "followers": 55
     }
   }

If a cookbook is deprecated, that status is noted by the ``deprecated`` field (being ``true``):

.. code-block:: javascript

   {
     "name": "apache",
     "category": "web servers",
     ...
     "deprecated": true,
     ...
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| The requested cookbook exists.
   * - ``400``
     - |response code 400 unsuccessful| The requested cookbook does not exist. For example:

       .. code-block:: javascript

          {
             "error_messages":
             ["Resource does not exist"],
             "error_code": "NOT_FOUND"
          }
