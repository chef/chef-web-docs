.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If a cookbook has a dependency on a recipe that is located in another cookbook, that dependency must be declared in the metadata.rb file for that cookbook using the ``depends`` keyword.

.. note:: Declaring cookbook dependencies is not required with chef-solo.

For example, if the following recipe is included in a cookbook named ``my_app``:

.. code-block:: ruby

   include_recipe 'apache2::mod_ssl'

Then the metadata.rb file for that cookbook would have:

.. code-block:: ruby

   depends 'apache2'
