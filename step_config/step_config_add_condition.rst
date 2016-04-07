.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use a ``case`` statement to apply different values based on whether the setting exists on the front-end or back-end servers. Add code to the server configuration file similar to the following:

.. code-block:: ruby

   role_name = ChefServer["servers"][node['fqdn']]["role"]
   case role_name
   when "backend"
     # backend-specific configuration here
   when "frontend"
     # frontend-specific configuration here
   end
