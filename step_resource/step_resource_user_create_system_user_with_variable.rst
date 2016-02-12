.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to create a system user. In this instance, the ``home`` value is calculated and stored in a variable called ``user_home`` which sets the user's ``home`` attribute.

.. code-block:: ruby

   user_home = "/home/#{node['cookbook_name']['user']}"

   user node['cookbook_name']['user'] do
     gid node['cookbook_name']['group']
     shell '/bin/bash'
     home user_home
     system true
     action :create
   end
