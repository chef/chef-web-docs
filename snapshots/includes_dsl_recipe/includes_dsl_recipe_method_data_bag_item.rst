.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``data_bag_item`` method can be used in a recipe to get the contents of a data bag item. 

The syntax for the ``data_bag_item`` method is as follows:

.. code-block:: ruby

   data_bag_item(bag_name, item, secret)

where ``secret`` is the secret used to load an encrypted data bag. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.
