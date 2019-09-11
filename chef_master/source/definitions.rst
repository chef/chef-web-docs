=====================================================
Converting Definitions to Custom Resources
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/definitions.rst>`__

Beginning with Chef Client 12.5 (released in 2016), Chef Infra uses `custom resources </custom_resources.html>`__ instead of definitions. While definitions is not deprecated---all existing definitions will continue to work---we recommend converting existing definitions to custom resource patterns. This topic explains definitions and shows how to convert an existing definition to the new custom resource pattern.

Definitions
=====================================================
A definition behaved like a compile-time macro that was reusable across recipes. A definition was typically created by wrapping arbitrary code around resources that were declared as if they were in a recipe. A definition was then used in one (or more) actual recipes as if the definition were a resource.

Though a definition looked like a resource, and at first glance seems like it could have been used interchangeably, some important differences exist. A definition:

* Was not a resource or a custom resource
* Was processed while the resource collection is compiled (whereas resources are processed while a node is converged)
* Does not support common resource properties, such as ``notifies``, ``subscribes``, ``only_if``, and ``not_if``
* Was defined from within the ``/definitions`` directory of a cookbook
* Did not support why-run mode

Syntax
=====================================================
A definition had four components:

* A resource name
* Zero or more arguments that define parameters their default values; if a default value was not specified, it was assumed to be ``nil``
* A hash that could have been used within a definition's body to provide access to parameters and their values
* The body of the definition

The basic syntax of a definition was:

.. code-block:: ruby

   define :resource_name do
     body
   end

More commonly, the usage incorporated arguments to the definition:

.. code-block:: ruby

   define :resource_name, :parameter => :argument, :parameter => :argument do
     body (likely referencing the params hash)
   end

The following simple example shows a definition with no arguments (a parameterless macro in the truest sense):

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

Or the following definition, which looks like a resource when used in a recipe, but also contained **directory** and **file** resources that were repeated, but with slightly different parameters:

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

which was then used in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
    port 4000
   end

   host_porter 'www1' do
     port 4001
   end

Definition vs. Resource
=====================================================
The following examples show:

#. A definition
#. The same definition rewritten as a custom resource
#. The same definition, rewritten again to use a `common resource property </resource_common.html>`__

As a Definition
----------------------------------------------------
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



As a Resource
----------------------------------------------------
The definition is improved by rewriting it as a custom resource:

.. code-block:: ruby

   property :port, Integer, default: 4000
   property :hostname, String, name_property: true

   action :create do

     directory "/etc/#{hostname}" do
       recursive true
     end

     file "/etc/#{hostname}/#{port}" do
       content 'some content'
     end

   end

Once built, the custom resource may be used in a recipe just like the any of the resources that are built into Chef. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``host`` with a custom resource in the ``/resources`` directory named ``porter.rb``. Use it in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
     port 4000
   end

or:

.. code-block:: ruby

   host_porter 'www1' do
     port 4001
   end

Use Common Properties
----------------------------------------------------
Unlike definitions, custom resources are able to use `common resource properties </resource_common.html>`__. For example, ``only_if``:

.. code-block:: ruby

   host_porter 'www1' do
     port 4001
     only_if '{ node['hostname'] == 'foo.bar.com' }'
   end


