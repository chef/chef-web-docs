.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
