.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. Open ``recipes/default.rb``.
#. Add:

   .. code-block:: ruby
   
      package_name = 'httpd'
      
      package '#{package_name}'
      
      service 'httpd' do
        action :start
      end
      
      template '/var/www/html/index.html' do
        source 'index.html.erb'
      end

#. Save the file.
