.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A definition has four components:

* A resource name
* Zero or more arguments that define parameters their default values; if a default value is not specified, it is assumed to be ``nil``
* A hash that can be used within a definition's body to provide access to parameters and their values
* The body of the definition

The basic syntax of a definition is:

.. code-block:: ruby

   define :resource_name do
     body
   end

More commonly, the usage incorporates arguments to the definition:

.. code-block:: ruby

   define :resource_name, :parameter => :argument, :parameter => :argument do
     body (likely referencing the params hash)
   end

The following simplistic example shows a definition with no arguments (a parameterless macro in the truest sense): 

.. code-block:: ruby

   define :prime_myfile do
     file '/etc/myfile' do
       content 'some content'
     end
   end

An example showing the use of parameters, with a parameter named ``port`` that defaults to ``4000`` rendered into a **template** resource, would look like:
 		 
 .. code-block:: ruby
 		 
   define :prime_myfile, port: 4000 do
     template '/etc/myfile' do
       source 'myfile.erb'
       variables({
         port: params[:port],
       })
     end
   end

Or the following definition, which looks like a resource when used in a recipe, but also contains resources---**directory** and **file**---that are repeated, but with slightly different parameters:

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

which is then used in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
    port 4000
   end
   
   host_porter 'www1' do
     port 4001
   end
