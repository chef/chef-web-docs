.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **service** resource block manages the state of a service. For example:

.. code-block:: ruby

   service "tomcat" do
     action :start
   end

will start the Apache Tomcat service.

The full syntax for all of the properties that are available to the **service** resource is:

.. code-block:: ruby

   service 'name' do
     init_command               String
     notifies                   # see description
     pattern                    String
     priority                   Integer, String, Hash
     provider                   Chef::Provider::Service
     reload_command             String
     restart_command            String
     service_name               String # defaults to 'name' if not specified
     start_command              String
     status_command             String
     stop_command               String
     subscribes                 # see description
     supports                   Hash
     timeout                    Integer # Microsoft Windows only
     action                     Symbol # defaults to :nothing if not specified
   end

where 

* ``service`` is the resource; depending on the platform, more specific providers are run: ``Chef::Provider::Service::Init``, ``Chef::Provider::Service::Init::Debian``, ``Chef::Provider::Service::Upstart``, ``Chef::Provider::Service::Init::Freebsd``, ``Chef::Provider::Service::Init::Gentoo``, ``Chef::Provider::Service::Init::Redhat``, ``Chef::Provider::Service::Solaris``, ``Chef::Provider::Service::Windows``, or ``Chef::Provider::Service::Macosx``
* ``name`` is the name of the resource block; when the ``path`` property is not specified, ``name`` is also the path to the directory, from the root
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``init_command``, ``pattern``, ``priority``, ``provider``, ``reload_command``, ``restart_command``, ``service_name``, ``start_command``, ``status_command``, ``stop_command``, ``supports``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
