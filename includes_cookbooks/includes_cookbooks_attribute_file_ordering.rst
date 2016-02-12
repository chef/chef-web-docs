.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: This approach, as of |chef| 11-0, is no longer the recommended way to define attribute dependencies. Starting with |chef| 11-0, attribute dependencies should be defined using a cookbook's |metadata rb| file.

When the |chef client| loads cookbook attribute files, the |chef client| first identifies all of the cookbook dependencies, then identifies all of the attributes defined in those cookbooks, and then evaluates these attributes based on the order defined in the run-list. If one attribute file must be loaded before another, use the ``include_attribute`` method.

.. code-block:: ruby

   include_attribute 'name_of_cookbook'

For example, if a cookbook requires that attributes from the |cookbook apache2| cookbook must be available, add the following to that cookbook's attribute file:

.. code-block:: ruby

   include_attribute 'apache2'

The |chef client| will then load the ``apache2/attributes/default.rb`` file before continuing the processing of the current attribute file. If a specific attribute file (and not the default attribute file) must be loaded, use the double colon (``::``) pattern (similar to the ``include_recipe`` method) and provide the name fo the attribute file after the double colon. For example:

.. code-block:: ruby

   include_attribute 'apache2::mod_ssl'

This will load the ``apache2/attributes/mod_ssl.rb`` file in the |cookbook apache2| cookbook.
