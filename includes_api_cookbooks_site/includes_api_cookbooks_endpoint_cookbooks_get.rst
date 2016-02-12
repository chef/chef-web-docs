.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a listing of the available cookbooks. Use the ``start`` and ``items`` parameters to set limits on the number of cookbooks returned. Use the ``order`` parameter to change the way results are sorted. Use the ``user`` parameter to filter cookbooks by maintainer:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``start``
     - The offset into a list of cookbooks, at which point the list of cookbooks will begin.
   * - ``items``
     - The number of items to be returned as a result of the request.
   * - ``order``
     - A token specifying how to order results. Possible values: ``recently_updated``, ``recently_added``, ``most_downloaded``, or ``most_followed``.
   * - ``user``
     - The username to filter by. Only cookbooks maintained by this user will be returned.

**Request**

.. code-block:: xml

   GET /cookbooks?start=START&items=ITEMS

or:

.. code-block:: xml

   GET /cookbooks?user=smith

**Response**

The response will return the name of the cookbook, a description, URI, the name of the individual who maintains the cookbook. In addition, the total number of cookbooks on |api cookbooks site| is shown, as well (if ``start`` is specified) the point at which the list of returned cookbooks began:

.. code-block:: javascript

   {
      "total": 5234,
      "start": 20,
      "items":
         [
           {"cookbook_name": "apache",
            "cookbook_description": "installs apache.",
            "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/apache",
            "cookbook_maintainer": "john"
           },
           {"cookbook_name": "fail2ban",
            "cookbook_description": "installs fail2ban.",
            "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/fail2ban",
            "cookbook_maintainer": "jill"
           },
           {"cookbook_name": "mysql",
            "cookbook_description": null,
            "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/mysql",
            "cookbook_maintainer": "barry"
           },
           {"cookbook_name": "capistrano",
            "cookbook_description": null,
            "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/capistrano",
            "cookbook_maintainer": "pt"
           },
           {"cookbook_name": "ptapache",
            "cookbook_description": "an alternate apache recipe.",
            "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/ptapache",
            "cookbook_maintainer": "pt"
           }
         ]
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| One or more cookbooks were returned as a result of the search query.
