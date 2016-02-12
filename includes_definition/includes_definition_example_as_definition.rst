.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following definition processes unique hostnames and ports, passed on as parameters:
 		 
.. code-block:: ruby
 		 
   define :host_porter, :port => 4000, :hostname => nil do
     params[:hostname] ||= params[:name]

     directory '/etc/#{params[:hostname]}' do
       recursive true
     end

     file '/etc/#{params[:hostname]}/#{params[:port]}' do
       content 'some content'
     end
   end
