.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, the ``site.rb`` file in the ``exampleco`` cookbook could be similar to:

.. code-block:: ruby

   property :homepage, String, default: '<h1>Hello world!</h1>'

   action :create do
     package 'httpd'

     service 'httpd' do
       action [:enable, :start]
     end

     file '/var/www/html/index.html' do
       content homepage
     end
   end

   action :delete do
     package 'httpd' do
       action :delete
     end
   end

where

* ``homepage`` is a property that sets the default HTML for the ``index.html`` file with a default value of ``'<h1>Hello world!</h1>'``
* the ``action`` block uses the built-in collection of resources to tell the |chef client| how to install |apache|, start the service, and then create the contents of the file located at ``/var/www/html/index.html``
* ``action :create`` is the default resource; ``action :delete`` must be called specifically (because it is not the default resource)

Once built, the custom resource may be used in a recipe just like the any of the resources that are built into |chef|. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``exampleco`` with a custom resource named ``site.rb`` is used in a recipe like this:

.. code-block:: ruby

   exampleco_site 'httpd' do
     homepage '<h1>Welcome to the Example Co. website!</h1>'
     action :create
   end

and to delete the exampleco website, do the following:

.. code-block:: ruby

   exampleco_site 'httpd' do
     action :delete
   end
