.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A data bag is defined using JSON. chef-solo will look for data bags in ``/var/chef/data_bags``, but this location can be modified by changing the setting in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   data_bag_path '/var/chef-solo/data_bags'

Create a data bag by creating folders. For example:

.. code-block:: bash

   mkdir /var/chef-solo/data_bags

and:

.. code-block:: bash

   mkdir /var/chef-solo/data_bags/admins

and then create a JSON file in that location:

.. code-block:: javascript

   {
     "id": "ITEM_NAME"
   }

where the name of the file is the ``ITEM_NAME``, for example:

.. code-block:: ruby

   /var/chef-solo/data_bags/admins/ITEM_NAME.json
