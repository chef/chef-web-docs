.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``load_current_value`` method inside an ``action`` block in a custom resource to load the specified property value from the node, and then use that value when the resource is converged. For example, the value of a property like:

.. code-block:: ruby

   page_not_found '<h1>This page is not found!</h1>'

may replace the value of the ``page_not_found`` property with the default value. Use the ``load_current_value`` method to guard against this behavior. For example:

.. code-block:: ruby

   action :some_action do
   
     load_current_value do
       if File.exist?('/var/www/html/index.html')
         homepage IO.read('/var/www/html/index.html')
       end
       if File.exist?('/var/www/html/404.html')
         page_not_found IO.read('/var/www/html/404.html')
       end
     end
   
   end

This tells the recipe what the current values for ``homepage`` and ``page_not_found`` and ensures those values are are not changed when the |chef client| configures the node.

The ``load_current_value`` method may also be used to compare a property value to the desired property, and then apply the desired value as specified by the ``converge_if_changed`` method.
