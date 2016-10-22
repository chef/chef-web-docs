.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A sample client.rb file that contains the most simple way to connect to https://manage.chef.io:

.. code-block:: ruby

   log_level        :info
   log_location     STDOUT
   chef_server_url  'https://api.opscode.com/organizations/<orgname>'
   validation_client_name '<orgname>-validator'
   validation_key '/etc/chef/validator.pem'
   client_key '/etc/chef/client.pem'
