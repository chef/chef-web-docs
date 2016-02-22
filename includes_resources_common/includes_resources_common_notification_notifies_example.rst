.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example notifies the |resource service| resource to immediately restart |apache|:

.. code-block:: ruby

   resource 'name' do
     ...
     notifies :restart, 'service[httpd]', :immediately
   end
