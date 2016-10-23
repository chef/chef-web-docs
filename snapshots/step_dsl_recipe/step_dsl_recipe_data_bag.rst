.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. The following is an example of using the ``data_bag`` method:

.. code-block:: ruby

   data_bag('users') #=> ['sandy', 'jill']

Iterate over the contents of the data bag to get the associated ``data_bag_item``:

.. code-block:: ruby

   data_bag('users').each do |user|
     data_bag_item('users', user)
   end

The ``id`` for each data bag item will be returned as a string.