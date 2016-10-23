.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

The chef-shell.rb file can be used to configure chef-shell in the same way as the client.rb file is used to configure the chef-client. For example, to configure chef-shell to authenticate to the Chef server, copy the ``node_name``, ``client_key``, and ``chef_server_url`` settings from the knife.rb file:

.. code-block:: ruby

   node_name                'your-knife-clientname'
   client_key               File.expand_path('~/.chef/my-client.pem')
   chef_server_url          'https://api.opscode.com/organizations/myorg'

and then add them to the chef-shell.rb file. Other configuration possibilities include disabling Ohai plugins (which will speed up the chef-shell boot process) or including arbitrary Ruby code in the chef-shell.rb file.
