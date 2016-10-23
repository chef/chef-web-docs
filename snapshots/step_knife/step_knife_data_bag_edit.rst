.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To edit the contents of a data bag, enter:

.. code-block:: bash

   $ knife data bag edit dogs tibetanspaniel

where ``dogs`` is the name of the data bag and ``tibetanspaniel`` is the name of the data bag item. This will return something similar to the following in the knife editor:

.. code-block:: javascript

   {
     "name":"data_bag_item_dogs_tibetanspaniel",
     "json_class":"Chef::DataBagItem",
     "chef_type":"data_bag_item",
     "data_bag":"dogs",
     "raw_data":
       {
         "description":"small dog that likes to sit in windows",
         "id":"tibetanspaniel"
       }
   }

Make the necessary changes to the key-value pairs under ``raw_data`` and save them.
