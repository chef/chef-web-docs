.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get license information for the |chef server|.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/NAME/license

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "limit_exceeded": "false"
     "node_license": "25"
     "node_count": "12"
     "upgrade_url": "http://www.chef.io/contact/on-premises-simple"
   }

When ``node_count`` is greater than ``node_license``, then ``limit_exceeded`` is ``true`` and the |chef manage| will display a notification about this status. The way to resolve this is to visit the upgrade URL, add the appropriate number of licenses, and then update the configuration settings appropriately.

The |chef server rb| file contains settings that can be used to edit the number of nodes that are under license:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``license['nodes']``
     - |license chef_server| Default value: ``25``.
   * - ``license['upgrade_url']``
     - |license url| Default value: ``"http://www.chef.io/contact/on-premises-simple"``.


**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
