.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get a listing of the available tools. Use the ``start`` and ``items`` parameters to set limits on the number of tools returned. Use the ``order`` parameter to change the way results are sorted.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``start``
     - The offset into a list of tools, at which point the list of tools will begin.
   * - ``items``
     - The number of items to be returned as a result of the request.
   * - ``order``
     - A token specifying how to order results. Possible values: ``recently_added``.

**Request**

.. code-block:: xml

   GET /tools?start=START&items=ITEMS

or:

.. code-block:: xml

   GET /tools?order=recently_added

**Response**

The response will return the name of the tool, a type, description, owner, source URL and URI. In addition, the total number of tools on |api cookbooks site| is shown, as well (if ``start`` is specified) the point at which the list of returned tools began:

.. code-block:: javascript

    {
      "start": 0,
      "total": 56,
      "items": [
        {
          "tool_name": "Berkflow",
          "tool_type": "chef_tool",
          "tool_source_url": "https://github.com/reset/berkflow",
          "tool_description": "A Cookbook-Centric Deployment workflow tool",
          "tool_owner": "reset",
          "tool": "https://supermarket.chef.io/api/v1/tools/berkflow"
        },
        {
          "tool_name": "Berkshelf",
          "tool_type": "chef_tool",
          "tool_source_url": "https://github.com/berkshelf/berkshelf",
          "tool_description": "A Chef Cookbook manager",
          "tool_owner": "reset",
          "tool": "https://supermarket.chef.io/api/v1/tools/berkshelf"
        },
        {
          "tool_name": "Berkshelf-API",
          "tool_type": "chef_tool",
          "tool_source_url": "https://github.com/berkshelf/berkshelf-api",
          "tool_description": "Berkshelf dependency API server",
          "tool_owner": "reset",
          "tool": "https://supermarket.chef.io/api/v1/tools/berkshelf-api"
        },
        {
          "tool_name": "ChefAPI",
          "tool_type": "chef_tool",
          "tool_source_url": "https://github.com/sethvargo/chef-api",
          "tool_description": "ChefAPI is a dependency-minimal Ruby client for interacting with a Chef Server. It adopts many patterns and principles from Rails",
          "tool_owner": "sethvargo",
          "tool": "https://supermarket.chef.io/api/v1/tools/chef-api"
        }
      ]
    }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok| One or more tools were returned.
