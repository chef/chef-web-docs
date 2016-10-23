.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.



Use the ``resource_name`` method at the top of a custom resource to declare a custom name for that resource. For example:

.. code-block:: ruby

   resource_name :custom_name

where ``:custom_name`` is the resource name as it may be used in a recipe. For example, a cookbook named ``website`` and a custom resource file named ``httpd`` is by default used in a recipe with ``website_httpd``. If ``:custom_name`` is ``web_httpd`` then it may be used like this:

.. code-block:: ruby

   web_httpd 'name' do
     # properties
   end
