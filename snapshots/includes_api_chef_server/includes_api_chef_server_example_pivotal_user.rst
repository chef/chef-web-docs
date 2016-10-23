.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to query the Chef server API for a listing of organizations and users. The ``/organizations`` and ``/users`` endpoints may only be accessed by the ``pivotal`` user, which is a user account that is created by Chef during the installation of the Chef server.

Run the following from a ``.chef`` directory that contains a ``pivotal.rb`` file:

.. code-block:: ruby

   require 'chef'
   require 'chef/rest'
   
   Chef::Config.from_file(".chef/pivotal.rb")
   rest = Chef::REST.new(Chef::Config[:chef_server_url])
   orgs = rest.get_rest("/organizations")
   
   puts "\n=== Listing of organizations"
   orgs.each do |org|
     puts org
   end
   
   puts "\n=== Listing of Users"
   users = rest.get_rest("/users")
   users.each do |user|
     puts user
   end

An examle of a ``.chef/pivotal.rb`` file is shown below:

.. code-block:: ruby

   current_dir = File.dirname(__FILE__)
   node_name "pivotal"
   chef_server_url "https://192.168.1.2:443"
   chef_server_root "https://192.168.1.2:443"
   client_key "#{current_dir}/pivotal.pem"

.. note:: The ``pivotal.pem`` file must exist in the specified location and the IP addresses must be correct for the Chef server.
