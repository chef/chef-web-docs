.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to set the administrator for Nagios on multiple nodes, except when the package already exists on a node:

.. code-block:: ruby

   %w{adminpassword adminpassword-repeat}.each do |setting|
     execute "debconf-set-selections::#{node['nagios']['server']['vname']}-cgi::#{node['nagios']['server']['vname']}/#{setting}" do
       command "echo #{node['nagios']['server']['vname']}-cgi #{node['nagios']['server']['vname']}/#{setting} password #{random_initial_password} | debconf-set-selections"
       not_if "dpkg -l #{node['nagios']['server']['vname']}"
     end
   end
