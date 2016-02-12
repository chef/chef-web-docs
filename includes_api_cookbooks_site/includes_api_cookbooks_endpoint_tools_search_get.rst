.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a list of tools that match a search query. Use the ``start`` and ``items`` parameters to set limits on the number of tools returned:

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

   GET /tools-search?q=SEARCH_QUERY

or:

.. code-block:: xml

   GET /tools-search?q=SEARCH_QUERY&start=START&items=ITEMS

**Response**

The response will return a list of tools that match the search query. Each returned data set will include the name of the tool, a type, description, owner, source URL and URI. In addition, the total number of tools that match the query on |api cookbooks site| is shown, as well (if ``start`` is specified) the point at which the list of returned tools began:

.. code-block:: javascript

    {
      "start": 0,
      "total": 2,
      "items": [
        {
          "tool_name": "knife-spec",
          "tool_type": "knife_plugin",
          "tool_source_url": "https://github.com/sethvargo/knife-spec",
          "tool_description": "knife-spec is a knife plugin that automatically generates Chef cookbook specs (tests) stubs for use with ChefSpec.",
          "tool_owner": "sethvargo",
          "tool": "https://supermarket.chef.io/api/v1/tools/knife-spec"
        },
        {
          "tool_name": "knife-rhn",
          "tool_type": "knife_plugin",
          "tool_source_url": "https://github.com/bflad/knife-rhn",
          "tool_description": "Knife Plugin for Red Hat Network (RHN)",
          "tool_owner": "bflad",
          "tool": "https://supermarket.chef.io/api/v1/tools/knife-rhn"
        }
      ]
    }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| One or more tools were returned as a result of the search query.
