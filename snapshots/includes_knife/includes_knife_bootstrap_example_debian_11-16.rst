.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use the ``knife bootstrap`` subcommand to create a client configuration file (/etc/chef/client.rb) that uses Hosted Chef as the Chef server. The configuration file will look something like:

.. code-block:: ruby

   log_level        :info
   log_location     STDOUT
   chef_server_url  'https://api.opscode.com/organizations/ORGNAME'
   validation_client_name 'ORGNAME-validator'

The ``knife bootstrap`` subcommand will look in three locations for the template that is used during the bootstrap operation. The locations are:

#. A bootstrap directory in the installed knife library; the actual location may vary, depending how the chef-client is installed
#. A bootstrap directory in the ``$PWD/.chef``, e.g. in ``~/chef-repo/.chef``
#. A bootstrap directory in the users ``$HOME/.chef``

If, in the example above, the second location was used, then create the ``.chef/bootstrap/`` directory in the chef-repo, and then create the Embedded Ruby (ERB) template file by running commands similar to the following:

.. code-block:: bash

   $ mkdir ~/.chef/bootstrap

and then:

.. code-block:: bash

   $ vi ~/.chef/bootstrap/debian5.0-apt.erb

When finished creating the directory and the Embedded Ruby (ERB) template file, edit the template to run the SSH commands. Then set up the validation certificate and the client configuration file.

Finally, run the chef-client on the node using a ``knife bootstrap`` command that specifies a run-list (the ``-r`` option). The bootstrap template can be called using a command similar to the following:

.. code-block:: bash

   $ knife bootstrap mynode.example.com -r 'role[webserver]','role[production]' --distro debian5.0-apt


