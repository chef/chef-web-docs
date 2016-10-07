.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


On your workstation, generate a new cookbook using the ``chef`` command line interface:

#. Generate the cookbook:

   .. code-block:: bash

      $ chef generate cookbook my_supermarket_wrapper

#. Change directories into that cookbook:

   .. code-block:: bash

      $ cd my_supermarket_wrapper

#. Defines the wrapper cookbook’s dependency on the ``supermarket-omnibus-cookbook`` cookbook. Open the |metadata rb| file of the newly-created cookbook, and then add the following line:

   .. code-block:: ruby

      depends 'supermarket-omnibus-cookbook'

#. Save and close the |metadata rb| file.

#. Open the ``/recipes/default.rb`` recipe located within the newly-generated cookbook and add the following content:

   .. code-block:: ruby

      include_recipe 'supermarket-omnibus-cookbook'

   This ensures that the ``default.rb`` file in the ``supermarket-omnibus-cookbook`` is run.
