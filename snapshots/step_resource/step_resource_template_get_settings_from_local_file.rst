.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The **template** resource can be used to render a template based on settings contained in a local file on disk or to get the settings from a template in a cookbook. Most of the time, the settings are retrieved from a template in a cookbook. The following example shows how the **template** resource can be used to retrieve these settings from a local file.

The following example is based on a few assumptions:

* The environment is a Ruby on Rails application that needs render a file named ``database.yml``
* Information about the application---the user, their password, the server---is stored in a data bag on the Chef server
* The application is already deployed to the system and that only requirement in this example is to render the ``database.yml`` file

The application source tree looks something like::

   myapp/
   -> config/
      -> database.yml.erb

.. note:: There should not be a file named ``database.yml`` (without the ``.erb``), as the ``database.yml`` file is what will be rendered using the **template** resource.

The deployment of the app will end up in ``/srv``, so the full path to this template would be something like ``/srv/myapp/current/config/database.yml.erb``. 

The content of the template itself may look like this:

.. code-block:: ruby

   <%= @rails_env %>:
      adapter: <%= @adapter %>
      host: <%= @host %>
      database: <%= @database %>
      username: <%= @username %>
      password: <%= @password %>
      encoding: 'utf8'
      reconnect: true

The recipe will be similar to the following:

.. code-block:: ruby

   results = search(:node, "role:myapp_database_master AND chef_environment:#{node.chef_environment}")
   db_master = results[0]
   
   template '/srv/myapp/shared/database.yml' do
     source '/srv/myapp/current/config/database.yml.erb'
     local true
     variables(
       :rails_env => node.chef_environment,
       :adapter => db_master['myapp']['db_adapter'],
       :host => db_master['fqdn'],
       :database => "myapp_#{node.chef_environment}",
       :username => "myapp",
       :password => "SUPERSECRET",
     )
   end

where: 

* the ``search`` method in the Recipe DSL is used to find the first node that is the database master (of which there should only be one)
* the ``:adapter`` variable property may also require an attribute to have been set on a role, which then determines the correct adapter

The template will render similar to the following:

.. code-block:: ruby

   production:
     adapter: mysql
     host: domU-12-31-39-14-F1-C3.compute-1.internal
     database: myapp_production
     username: myapp
     password: SUPERSECRET
     encoding: utf8
     reconnect: true

This example showed how to use the **template** resource to render a template based on settings contained in a local file. Some other issues that should be considered when using this type of approach include:

* Should the ``database.yml`` file be in a ``.gitignore`` file?
* How do developers run the application locally?
* Does this work with chef-solo?
