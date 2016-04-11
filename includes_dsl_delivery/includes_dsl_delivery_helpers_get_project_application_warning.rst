.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``get_project_application`` method is called from the ``provision.rb`` recipe, be sure that ``delivery-truck::provision`` is executed before ``get_project_application`` by putting it in a ``ruby_block`` or into a separate recipe that is called from ``provision.rb`` via ``include_recipe``. If the ``get_project_application`` method is called directly in ``provision.rb``:

.. code-block:: ruby

   include_recipe 'delivery-truck::provision'
   get_project_application(<project_app_name_string>)

you will get an error because the |chef client| will execute ``get_project_application`` at compile time before it has run ``include_recipe 'delivery-truck::provision'``. It is recommended to either use ``get_project_application`` in ``deploy.rb``, a project cookbook, in a ``ruby_block`` or in a separate ``include_recipe`` that is executed after ``include_recipe 'delivery-truck::provision'``.
