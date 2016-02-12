.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``DELETE`` method is used to delete a key-value pair in a data bag item.

This method has no parameters.

**Request**

.. code-block:: xml

   DELETE /organizations/NAME/data/NAME/ITEM

This method has no request body.

For example, run the following command:

.. code-block:: bash

   $ knife raw /data/dogs

which returns a list of data bags on the server:

.. code-block:: xml

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
     - |response code 200 ok|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
