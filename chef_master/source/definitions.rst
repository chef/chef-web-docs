=====================================================
Converting Definitions to Custom Resources
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/definitions.rst>`__


In 2016 with Chef Client 12.5 `custom resources </custom_resources.html>`__ were introduced to allow users to easily create their own resources within cookbooks. Custom resources are intended to replace both LWRPs and definitions in cookbook code. While not formally deprecated we *highly* suggest that existing definitions be migrated to custom resources as many features such as notifications, reporting, why-run mode, and ChefSpec unit testinng are not possible with definitions. This topic covers what a definition is and shows how to convert an existing definition to a custom resource.

Definitions
=====================================================
A definition behaved like a compile-time macro that was reusable across recipes. A definition was typically created by wrapping arbitrary code around Chef Infra resources that were declared as if they were in a recipe. A definition was then used in one (or more) actual recipes as if the definition were a resource.

Though a definition looked like a resource, and at first glance seems like it could have been used interchangeably, some important differences exist. A definition:

* Are not true resources
* Are processed when resource collection is compiled, not when a node is converged
* Did not support common resource properties, such as ``notifies``, ``subscribes``, ``only_if``, ``not_if``, and sensitive
* Did not support input validation in passed arguments like a resource does with properties
* Did not support why-run mode
* Did not support reporting to Chef Automate
* Cannot be tested with ChefSpec

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

Migrating to Custom Resources
=====================================================
We highly recommend migrating existing definitions to custom resources to unlock the full feature set of Chef Infra resources. The following example shows a definition and that same definition rewritten as a custom resources.

Initial Definition Code
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

Migrated to a Custom Resource
----------------------------------------------------
The definition is improved by rewriting it as a custom resource. This uses properties to accept input and has a single ``:create`` action:

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

Once written, the custom resource may be used in a recipe just like the any of the resources that are built into Chef Infra. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``host`` with a custom resource in the ``/resources`` directory named ``porter.rb``. Use it in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
     port 4000
   end

or:

.. code-block:: ruby

   host_porter 'www1' do
     port 4001
   end
