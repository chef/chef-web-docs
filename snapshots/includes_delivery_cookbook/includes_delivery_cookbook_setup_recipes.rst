.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``build-cookbook`` should define the same phases as the recipes included in the ``delivery-truck`` cookbook: ``default.rb``, ``deploy.rb``, ``functional.rb``, ``lint.rb``, ``provision.rb``, ``publish.rb``, ``quality.rb``, ``security.rb``, ``smoke.rb``, ``syntax.rb``, and ``unit.rb``. For example, a build cookbook's recipe directory should contain an identical list of recipes. For example, run:

.. code-block:: bash

   $ ls .delivery/build-cookbook/recipes/

the list of recipes should be:

.. code-block:: bash

   default.rb
   deploy.rb
   functional.rb
   lint.rb
   provision.rb
   publish.rb
   quality.rb
   security.rb
   smoke.rb
   syntax.rb
   unit.rb

Each recipe corresponds to a specific phase in the Chef Automate pipeline. The recipes in the ``build-cookbook`` should include the same-named recipe in the ``delivery-truck`` cookbook. For example, to include the ``lint.rb`` recipe from the ``delivery-truck`` cookbook, update the ``lint.rb`` recipe in the ``build-cookbook`` to add the following:

.. code-block:: ruby

   include_recipe 'delivery-truck::lint'

and then add to the ``unit.rb`` recipe:

.. code-block:: none

   include_recipe 'delivery-truck::unit'

and so on for all of the recipes. This ensures that all of the default behavior for all of the phases for the entire pipeline is available to this ``build-cookbook``.
