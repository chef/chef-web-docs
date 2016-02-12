.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The functionality of other |knife| plugins can be accessed from a plugin by using the ``deps`` method to ensure the necessary files are available. The ``deps`` method acts as a lazy loader, ensuring that dependencies are only loaded into |knife| when the plugin which requires them is run. Use the following syntax just below the class declaration:

.. code-block:: ruby

   class subclassName < Chef::Knife
   
   deps do
     require 'chef/knife/name_of_command'
     require 'chef/search/query'
     # other dependencies, as needed
   end

where the actual path may vary from plugin to plugin, but is typically located in the ``chef/knife/`` directory.

.. note:: Using the ``deps`` method instead of ``require`` is recommended, especially if the environment in which |knife| is being run contains a lot of plugins and/or any of those plugins have a lot of dependencies and/or requirements on other plugins and search functionality.
