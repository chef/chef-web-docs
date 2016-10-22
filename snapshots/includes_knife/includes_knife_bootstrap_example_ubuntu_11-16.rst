.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to modify the default script for Ubuntu 12.04. First, copy the bootstrap template from the default location. If the chef-client is installed from a RubyGems, the full path can be found in the gem contents:

.. code-block:: bash

   $ gem contents chef | grep ubuntu12.04-gems
   /Users/jtimberman/.rvm/gems/ruby-1.9.3-p180/gems/chef-0.10.2/lib/chef/knife/bootstrap/ubuntu12.04-gems.erb

Copy the template to the chef-repo in the ``.chef/bootstrap`` directory:

.. code-block:: bash

   $ cp /Users/jtimberman/.rvm/gems/ruby-1.9.3-p180/gems/chef-0.10.2/
      lib/chef/knife/bootstrap/ubuntu12.04-gems.erb ~/chef-repo/.chef/
      bootstrap/ubuntu12.04-gems-mine.erb

Modify the template with any editor, then specify it using the ``--distro`` option as part of the the ``knife bootstrap`` operation, or with any of the knife plug-ins that support cloud computing.

.. code-block:: bash

   $ knife bootstrap 192.168.1.100 -r 'role[webserver]' -distro ubuntu12.04-gems-mine

Alternatively, an example bootstrap template can be found in the git source for the chef-repo: https://github.com/chef/chef/tree/master/lib/chef/knife/bootstrap. Copy the template to ``~/.chef-repo/.chef/bootstrap/ubuntu12.04-apt.erb`` and modify the template appropriately.







