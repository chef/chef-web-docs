.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of cookbooks that match a search query. Use the ``start`` and ``items`` parameters to set limits on the number of cookbooks returned:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``q``
     - |SEARCH_QUERY|
   * - ``start``
     - |start|
   * - ``items``
     - |rows|

**Request**

.. code-block:: xml

   GET /search?q=SEARCH_QUERY

or:

.. code-block:: xml

   GET /search?q=SEARCH_QUERY&start=START&items=ITEMS

**Response**

The response will return a list of cookbooks by name and description and will return a list of cookbooks that match the search query. Each returned data set will include the name of the cookbook, a description, the URI, and the name of the individual who maintains the cookbook. In addition, the total number of cookbooks on |api cookbooks site| is shown, as well (if ``start`` is specified) the point at which the list of returned cookbooks began:

.. code-block:: javascript

   {
     "total": 2,
     "start": 0,
     "items": [
       {
         "cookbook_name": "apache",
         "cookbook_description": "installs a web server.",
         "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/apache",
         "cookbook_maintainer": "jtimberman"
       },
       {
         "cookbook_name": "webserver",
         "cookbook_description": "installs apache.",
         "cookbook": "http://supermarket.chef.io/api/v1/cookbooks/webserver",
         "cookbook_maintainer": "raxmus"
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
