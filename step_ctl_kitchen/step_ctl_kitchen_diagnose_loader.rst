.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command returns data as |yaml|:

.. code-block:: yaml

   ---
   timestamp: 2014-04-15 18:59:58.460470000 Z
   kitchen-version: 1.2.2.dev
   instances:
     default-ubuntu-1404
       # ...
     default-centos-65
       # ...

When |kitchen| is being used to test cookbooks, |kitchen| will track state data:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       state_file:
         hostname: 192.168.123.456
         last_action: create
         port: '22'
         ssh_key: "/Users/username/path/to/key"
         username: vagrant
     default-centos-65
       # ...

and will track information that was given to a driver:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       driver:
         box: opscode-ubuntu-12.04
         box_url: https://URL/path/to/filename.box
         kitchen_root: "/Users/username/Projects/sandbox/"

and will track information about provisioners:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       provisioner:
         attributes: {}
         chef_omnibus_url: https://www.chef.io/chef/install.sh
         clients_path: 
         name: chef_zero

