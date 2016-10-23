.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The contents of a data bag can be loaded into a recipe. For example, a data bag named ``apps`` and a data bag item named ``my_app``:

.. code-block:: javascript

   {
     "id": "my_app",
     "repository": "git://github.com/company/my_app.git"
   }

can be accessed in a recipe, like this:

.. code-block:: ruby

   my_bag = data_bag_item('apps', 'my_app')

The data bag item's keys and values can be accessed with a Hash:

.. code-block:: ruby

   my_bag['repository'] #=> 'git://github.com/company/my_app.git'
