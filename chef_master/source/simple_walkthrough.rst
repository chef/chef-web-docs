=====================================================
Simple Walkthrough
=====================================================

The |chef dk| is a package that contains everything you need to start using |chef|, along with a collection of tools and libaries that can help improve the code you are using to run your business.

Install the |chef dk_title|
=====================================================
.. include:: ../../includes_install/includes_install_chef_dk.rst

.. 
.. What's in the |chef dk_title|?
.. -----------------------------------------------------
.. .. include:: ../../includes_chef_dk/includes_chef_dk_tools.rst
.. 
.. .. include:: ../../includes_chef_dk/includes_chef_dk_tools_main.rst
.. 

Set the System |ruby|
=====================================================
.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby.rst

.. note:: You may need to restart your shell for this change to be visible.

Your First Cookbook
=====================================================
We have already used the |chef ctl| ``verify`` subcommand to verify the installation of the |chef dk|. Now let's use the |chef ctl| ``generate`` subcommand to create the |chef repo|, which is the main folder in which your |chef| code will be stored. Run the following command:

.. code-block:: bash

   $ chef generate app name
   
where ``name`` is a name that you have chosen for the both the |chef repo| and the default cookbook. We are calling ours ``chef-repo``; you can call yours whatever you want. You should have a directory structure at ``/Users/your_username/cookbook_name/`` similar to::

   /chef-repo
     /.git
     .gitignore
     .kitchen.yml
     /cookbooks
       /chef-repo
         Berksfile
         chefignore
         metadata.rb
         /recipes
           default.rb
     README.md


Update Default Recipe
=====================================================
Open the ``default.rb`` recipe in the cookbook you just created. Add the following resource to that recipe:

.. code-block:: ruby

   file "#{ENV['HOME']}/test.txt" do
     content 'This file created by Chef!'
   end

This recipe creates a file called ``test.txt`` at the path defined by the ``HOME`` environment variable. (To view that path, run ``echo "$HOME"`` in the command shell.)

Run the |chef client_title|
=====================================================
Next, we'll run the |chef client|. This is done via the command line and the command must be run from within the |chef repo|. 

* Use the ``--local-mode`` flag to run the |chef client| locally on your machine exactly the same as if the |chef client| were able to communicate with a |chef server|. Local mode does not require a connection to a |chef server|, public or private keys, or configuring of nodes. Many people use local mode for simple, local testing of recipes and cookbooks, often as a pre-cursor to running unit and integration tests against the same recipes and cookbooks.
* Use the ``--override-runlist`` flag to run only the recipe we have just created. (More about the run-list later.) 

To run a cookbook's default recipe, only the name of the cookbook needs to be specified because the name of the cookbook is directly associated with the default recipe. 

The following command will create the file ``test.txt``:

.. code-block:: bash

   $ chef-client --local-mode --override-runlist chef-repo

where ``chef-repo`` is the name of your cookbook.

As the |chef client| adds the file to your system, output similar to the following is shown:

.. code-block:: bash

   Starting Chef Client, version 11.14.0.alpha.1
   [2014-06-13T16:13:10-07:00] WARN: No config file found or specified on command line, using command line options.
   [2014-06-13T16:13:11-07:00] WARN: SSL validation of HTTPS requests is disabled. 
   [2014-06-13T16:13:13-07:00] WARN: Run List override has been provided.
   [2014-06-13T16:13:13-07:00] WARN: Original Run List: []
   [2014-06-13T16:13:13-07:00] WARN: Overridden Run List: [recipe[chef-repo]]
   resolving cookbooks for run list: ["chef-repo"]
   Synchronizing Cookbooks:
     - chef-repo
   Compiling Cookbooks...
   Converging 1 resources
   Recipe: chef-repo::default
     * file[/Users/grantmc/test.txt] action create
       - create new file /Users/grantmc/test.txt
       - update content in file /Users/grantmc/test.txt from none to d9c88f
           --- /Users/grantmc/test.txt	2014-06-13 16:13:13.000000000 -0700
           +++ /var/folders/l0/6xjyqtvn60zdt7jk6n07wz2m0000gp/T/.test.txt20140613-9526-179gcje	2014-06-13 16:13:13.000000000 -0700
           @@ -1 +1,2 @@
           +This file created by Chef!
   
   [2014-06-13T16:13:13-07:00] WARN: Skipping final node save because override_runlist was given
   
   Running handlers:
   Running handlers complete
   
   Chef Client finished, 1/1 resources updated in 2.418878 seconds

That's it. The warnings, for the moment, can be ignored. Check the root of the path defined by the ``HOME`` environment variable and find the file named ``test.txt``. The file should contain ``This file created by Chef!``. Open that file, edit the string, and then save that file. Re-run the |chef client|. Or delete the file. In both cases, re-run the |chef client|. |chef| will return the system to the state that is defined by the recipe.

We'll come back to working with |chef| later on. Let's set up |kitchen| so that we can use it to build a virtual machine against which we can run |chef|.

|kitchen_title| Setup
=====================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

You will need some type of virtualization software for |kitchen|. |vagrant| is the default driver for |kitchen|. Install |vagrant|. |vagrant| requires |virtualbox|, so install |virtualbox|. Once you're ready, we'll keep using the same cookbook created earlier.

Update Metadata
-----------------------------------------------------
In that cookbok, let's update the metadata. Open the ``metadata.rb`` file. It will look similar to:

.. code-block:: ruby

   name             ''
   maintainer       ''
   maintainer_email ''
   license          ''
   description      'Installs/Configures '
   long_description 'Installs/Configures '
   version          '0.1.0'

for now, let's just update the name and version settings, like this:

.. code-block:: ruby

   name 'chef-repo'
   maintainer 'docs'
   maintainer_email 'docs@chef.io'
   license 'Apache License, Version 2.0'
   description 'example metadata.rb'
   long_description 'This is an example metadata.rb file used in docs.chef.io.'
   version '0.1.0'

Verify |kitchen yml|
-----------------------------------------------------
Because |kitchen| is installed as part of the |chef dk|, the |kitchen yml| file is already created:

.. code-block:: yaml

   ---
   driver:
     name: vagrant
   
   provisioner:
     name: chef_zero
   
   platforms:
     - name: ubuntu-14.04
     - name: centos-7.1
   
   suites:
     - name: default
       run_list:
         - recipe[chef-repo::default]
       attributes:

Verify that the default provisioner is |chef zero|:

.. code-block:: yaml

   ...
   
   provisioner:
     name: chef_zero
   
   ...

Verify that the default recipe contains the name of the cookbook that was generated earlier:

.. code-block:: yaml

   suites:
     - name: default
       run_list:
         - recipe[chef-repo::default]
       attributes:

where ``chef-repo`` is the name of your cookbook.

This is all of the configuration |kitchen| needs at this time. Let's set up some |kitchen| instances, and then build virtual machines that can run |chef|.

View Instance List
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_list_created_none.rst

Create |centos| Instance
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_create_centos_default.rst

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_list_created_one.rst

Create |ubuntu| Instance
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_create_ubuntu_default.rst

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_list_created_both.rst

Now we're all set up! We're going to use the same recipe and cookbook that we already created.

Converge |centos|
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_converge_centos_default.rst

Converge |ubuntu|
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_converge_ubuntu_default.rst

Verify Instance List
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_list_converged_both.rst

Now you can run your cookbooks in a virtual instance managed by |kitchen| on multiple platforms (|ubuntu| and |centos|).

Configure NTP
=====================================================
Instead of putting a text file on these |kitchen| instances, let's try something more useful and install |ntp|. Within the cookbook we're already using, let's update the default recipe to install and configure |ntp| using the |resource package|, |resource template|, and |resource service| resources, a template file, and an attributes file.

Add Template
-----------------------------------------------------
The |resource template| resource looks for templates in a cookbook's ``/templates`` directory. Template files in this directory must be |erb| files. The |chef ctl| has an argument that will handle most of this process for you. Let's create that directory and the template file we'll use to configure |ntp| using this command. Let's use the same cookbook we've been using. From within that cookbook repo, run the following command:

.. code-block:: bash

   $ chef generate template ntp.conf

which will return something similar to:

.. code-block:: bash

   Compiling Cookbooks...
     Recipe: code_generator::template
       * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo/templates/default] action create
         - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo/templates/default
       * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/templates/default/ntp.conf.erb] action create
         - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/templates/default/ntp.conf.erb
         - update content in file /Users/grantmc/chef-repo/cookbooks/chef-repo/templates/default/ntp.conf.erb from none to e3b0c4

and a directory structure in that cookbook similar to::

   /chef-repo
     /.git
	 .gitignore
     .kitchen.yml
     /cookbooks
       /chefdocs
         Berksfile
         chefignore
         metadata.rb
         /recipes
           default.rb
		 /templates
		   /default
		     ntp.conf.erb
     README.md

and an empty ``ntp.conf.erb`` file. Let's edit this file and define its contents. Open this file and add the following:

.. code-block:: ruby

   restrict default kod nomodify notrap nopeer noquery
   restrict -6 default kod nomodify notrap nopeer noquery
   restrict 127.0.0.1
   restrict -6 ::1
   server <%= @ntp_server %>
   server  127.127.1.0     # local clock
   driftfile /var/lib/ntp/drift
   keys /etc/ntp/keys

Add Attributes
-----------------------------------------------------
The name of the init script that is used to run |ntp| is ``ntp`` on |debian|-based platforms (such as |ubuntu|) and is ``ntpd`` on |redhat enterprise linux|-based platforms. Let's use an attribute in our cookbook to tell the |chef client| what to do on both platforms using a single cookbook attribute. Like for templates, the |chef ctl| has an argument that will handle most of this process for you. Let's create that directory and the default attribute file we'll use to tell the |chef client| how to handle the attribute. Let's use the same cookbook we've been using. From within that cookbook repo, run the following command:

.. code-block:: bash

   $ chef generate attribute default

which will return something similar to:

.. code-block:: bash

   Compiling Cookbooks...
     Recipe: code_generator::attribute
       * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes] action create
         - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes
       * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/default.rb] action create
         - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/default.rb
         - update content in file /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/default.rb from none to e3b0c4

and a directory structure in that cookbook similar to::

   /chef-repo
     /.git
	 .gitignore
     .kitchen.yml
     /cookbooks
       /chefdocs
	     /attributes
		   default.rb
         Berksfile
         chefignore
         metadata.rb
         /recipes
           default.rb
		 /templates
		   /default
		     ntp.conf.erb
     README.md

and an empty ``default.rb`` file under ``/attributes``. Let's edit this file and define its contents. Open this file and add the following:

.. code-block:: ruby

   default[:ntp][:service] =
     case platform_family
       when 'rhel', 'fedora'
         'ntpd'
       when 'debian'
         'ntp'
       else
         'ntpd'
     end

This attribute uses conditions to tell the |chef client| the correct name of the init script that will be used to start |ntp|, by platform. The attribute that is being set by this code block is ``node[:ntp][:service]`` and the |chef client| can use this attribute to identify the correct init script for |ntp| on any node and for any platform. If |debian|, use ``ntp`` and for everything else use ``ntpd``.

Edit Recipe
-----------------------------------------------------
To install |ntp|, a recipe needs to do three things:

# Install |ntp|
# Create a configuration file; this will be done using the ``ntp.conf.erb`` template file
# Start the ``ntp`` or ``ntpd`` service, depending on the platform; this will be done using the ``node[:ntp][:service]`` attribute

Open the ``default.rb`` recipe file and replace the contents of that file with the following:

.. code-block:: ruby

   package 'ntp' do
     action :install
   end
   
   template '/etc/ntp.conf' do
     source 'ntp.conf.erb'
     variables( :ntp_server => 'time.nist.gov' )
     notifies :restart, 'service[ntp_service]'
   end
   
   service 'ntp_service' do
     service_name node[:ntp][:service]
     action [:enable, :start]
   end

The |resource package| resource installs the |ntp| package. The |resource template| resource gets the template file from the cookbook, and then uses it to create a ``ntp.conf`` file in the ``/etc/ntp.conf`` directory on the node, after which it notifies the |resource service| resource to restart the ``ntp`` or ``ntpd`` service. The |resource service| resource ensures that the ``ntp`` or ``ntpd`` service is started and enabled.

Install NTP on |centos|
-----------------------------------------------------
Now let's install |ntp| in |centos|. From the |chef repo|, run:

.. code-block:: bash

   $ kitchen converge default-centos-71

As it installs, the |chef client| will report back something similar to the following: 

.. code-block:: bash

   -----> Starting Kitchen (v1.2.2.dev)
   -----> Converging <default-centos-71>...
          Preparing files for transfer
          Preparing cookbooks from project directory
          Removing non-cookbook files before transfer
          Preparing nodes
          Transferring files to <default-centos-71>
          [2014-07-10T20:43:50+00:00] INFO: Starting chef-zero on port 8889 with repository at repository at /tmp/kitchen
          One version per cookbook
          [2014-07-10T20:43:50+00:00] INFO: Forking chef instance to converge...
          Starting Chef Client, version 12.4.1
          [2014-07-10T20:34:52+00:00] INFO: *** Chef 12.4.1 ***
          [2014-07-10T20:34:52+00:00] INFO: Chef-client pid: 4229
          [2014-07-10T20:35:00+00:00] INFO: Setting the run_list to ["recipe[chef-repo::default]"] from CLI options
          [2014-07-10T20:35:00+00:00] INFO: Run List is [recipe[chef-repo::default]]
          [2014-07-10T20:35:00+00:00] INFO: Run List expands to [chef-repo::default]
          [2014-07-10T20:35:00+00:00] INFO: Starting Chef Run for default-centos-71
          [2014-07-10T20:35:00+00:00] INFO: Running start handlers
          [2014-07-10T20:35:00+00:00] INFO: Start handlers complete.
          [2014-07-10T20:35:00+00:00] INFO: HTTP Request Returned 404 Not Found : Object not found: /reports/nodes/default-centos-71/runs
          resolving cookbooks for run list: ["chef-repo::default"]
          [2014-07-10T20:35:00+00:00] INFO: Loading cookbooks [chef-repo@0.1.0]
          Synchronizing Cookbooks:
          [2014-07-10T20:35:00+00:00] INFO: Storing updated cookbooks/chef-repo/attributes/default.rb in the cache.
            - chef-repo
          Compiling Cookbooks...   
          Converging 3 resources
          Recipe: chef-repo::default
            * package[ntp] action install[2014-07-10T20:35:00+00:00] INFO: Processing package[ntp] action install (chef-repo::default line 10)
            * service[ntp_service] action enable[2014-07-10T20:35:18+00:00] INFO: Processing service[ntp_service] action enable (chef-repo::default line 14)   
            * service[ntp_service] action start[2014-07-10T20:35:18+00:00] INFO: Processing service[ntp_service] action start (chef-repo::default line 14)
            * template[/etc/ntp.conf] action create[2014-07-10T20:35:18+00:00] INFO: Processing template[/etc/ntp.conf] action create (chef-repo::default line 19)
          [2014-07-10T20:35:18+00:00] INFO: template[/etc/ntp.conf] backed up to /tmp/kitchen/backup/etc/ntp.conf.chef-20140710203518.551604
          [2014-07-10T20:35:18+00:00] INFO: template[/etc/ntp.conf] updated file contents /etc/ntp.conf
              - update content in file /etc/ntp.conf from 12d181 to 5b4e15
              - restore selinux security context
          [2014-07-10T20:35:18+00:00] INFO: template[/etc/ntp.conf] sending restart action to service[ntp_service] (delayed)
            * service[ntp_service] action restart[2014-07-10T20:35:18+00:00] INFO: Processing service[ntp_service] action restart (chef-repo::default line 14)
          [2014-07-10T20:35:20+00:00] INFO: service[ntp_service] restarted
              - restart service service[ntp_service]
          [2014-07-10T20:35:20+00:00] INFO: Chef Run complete in 20.062008227 seconds
          Running handlers:
          [2014-07-10T20:35:20+00:00] INFO: Running report handlers
          Running handlers complete
          [2014-07-10T20:35:20+00:00] INFO: Report handlers complete
          Chef Client finished, 2/5 resources updated in 27.444399186 seconds
          Finished converging <default-centos-71> (0m30.97s).
   -----> Kitchen is finished. (0m31.28s)

Install NTP on |ubuntu|
-----------------------------------------------------
And finally, install |ntp| in |ubuntu|. From the |chef repo|, run:

.. code-block:: bash

   $ kitchen converge default-ubuntu-1404

As it installs, the |chef client| will report back something similar to the following: 

.. code-block:: bash

   -----> Starting Kitchen (v1.2.2.dev)
   -----> Converging <default-ubuntu-1404>...
          Preparing files for transfer
          Preparing cookbooks from project directory
          Removing non-cookbook files before transfer
          Preparing nodes
          Transferring files to <default-ubuntu-1404>
          [2014-07-10T20:41:26+00:00] INFO: Starting chef-zero on port 8889 with repository at repository at /tmp/kitchen       
          One version per cookbook       
          [2014-07-10T20:41:26+00:00] INFO: Forking chef instance to converge...       
          Starting Chef Client, version 12.4.1       
          [2014-07-10T20:41:26+00:00] INFO: *** Chef 12.4.1 ***       
          [2014-07-10T20:41:26+00:00] INFO: Chef-client pid: 2106       
          [2014-07-10T20:41:28+00:00] INFO: Setting the run_list to ["recipe[chef-repo::default]"] from CLI options       
          [2014-07-10T20:41:28+00:00] INFO: Run List is [recipe[chef-repo::default]]       
          [2014-07-10T20:41:28+00:00] INFO: Run List expands to [chef-repo::default]       
          [2014-07-10T20:41:28+00:00] INFO: Starting Chef Run for default-ubuntu-1404       
          [2014-07-10T20:41:28+00:00] INFO: Running start handlers       
          [2014-07-10T20:41:28+00:00] INFO: Start handlers complete.       
          [2014-07-10T20:41:28+00:00] INFO: HTTP Request Returned 404 Not Found : Object not found: /reports/nodes/default-ubuntu-1404/runs       
          resolving cookbooks for run list: ["chef-repo::default"]       
          [2014-07-10T20:41:28+00:00] INFO: Loading cookbooks [chef-repo@0.1.0]       
          Synchronizing Cookbooks:       
          [2014-07-10T20:41:28+00:00] INFO: Storing updated cookbooks/chef-repo/attributes/default.rb in the cache.       
            - chef-repo       
          Compiling Cookbooks...       
          Converging 3 resources       
          Recipe: chef-repo::default       
            * package[ntp] action install[2014-07-10T20:41:28+00:00] INFO: Processing package[ntp] action install (chef-repo::default line 10)       
            * service[ntp_service] action enable[2014-07-10T20:41:28+00:00] INFO: Processing service[ntp_service] action enable (chef-repo::default line 14)    
            * service[ntp_service] action start[2014-07-10T20:41:28+00:00] INFO: Processing service[ntp_service] action start (chef-repo::default line 14)       
          [2014-07-10T20:41:28+00:00] INFO: service[ntp_service] started
              - start service service[ntp_service]
            * template[/etc/ntp.conf] action create[2014-07-10T20:41:28+00:00] INFO: Processing template[/etc/ntp.conf] action create (chef-repo::default line 19)
          [2014-07-10T20:41:28+00:00] INFO: template[/etc/ntp.conf] backed up to /tmp/kitchen/backup/etc/ntp.conf.chef-20140710204128.387392       
          [2014-07-10T20:41:28+00:00] INFO: template[/etc/ntp.conf] updated file contents /etc/ntp.conf       
               - update content in file /etc/ntp.conf from 12d181 to 5b4e15       
          [2014-07-10T20:41:28+00:00] INFO: template[/etc/ntp.conf] sending restart action to service[ntp_service] (delayed)       
            * service[ntp_service] action restart[2014-07-10T20:41:28+00:00] INFO: Processing service[ntp_service] action restart (chef-repo::default line 14)       
          [2014-07-10T20:41:29+00:00] INFO: service[ntp_service] restarted
              - restart service service[ntp_service]
          [2014-07-10T20:41:29+00:00] INFO: Chef Run complete in 1.372541156 seconds       
          Running handlers:       
          [2014-07-10T20:41:29+00:00] INFO: Running report handlers       
          Running handlers complete       
          [2014-07-10T20:41:29+00:00] INFO: Report handlers complete       
          Chef Client finished, 3/5 resources updated in 3.313988417 seconds       
          Finished converging <default-ubuntu-1404> (0m6.49s).
   -----> Kitchen is finished. (0m6.79s)

.. note:: Did it work? Sometimes on the |ubuntu| platform the |apt| cache gets out of date and the |chef client| is unable to download the correct package. This will result in an exception and the |chef client| run will fail. Add this to the default recipe to run the ``apt-get-update`` command at the start of the |chef client| run:

   .. code-block:: ruby

      execute 'apt-get-update' do
        command 'apt-get update'
        ignore_failure true
      end

   The |resource execute| resource block won't run on |centos| because the |centos| platform uses the |yum| package manager, and not the |apt| package manager.

   Re-run the following command:

   .. code-block:: bash

      $ kitchen converge default-ubuntu-1404


Verify Instance List
-----------------------------------------------------
To verify if both instances have been converged, run the following command:

.. code-block:: bash

   $ kitchen list

.. code-block:: bash

   Instance             Driver   Provisioner  Verifier  Transport  Last Action
   default-ubuntu-1404  Vagrant  ChefZero     Busser    Ssh        Converged
   default-centos-71    Vagrant  ChefZero     Busser    Ssh        Converged

.. 
.. Add |debian|
.. -----------------------------------------------------
.. It's simple to add additional platforms for testing. For example, let's add support in |kitchen| for |debian|. First, update the |kitchen yml| file:
.. 
.. .. code-block:: javascript
.. 
..    platforms:
..      - name: ubuntu-14.04
..      - name: centos-7.1
..      - name: debian-8.1
.. 
.. Run the following command:
.. 
.. .. code-block:: bash
.. 
..    $ kitchen list
.. 
.. .. code-block:: bash
.. 
..    Instance             Driver   Provisioner  Verifier  Transport  Last Action
..    default-ubuntu-1404  Vagrant  ChefZero     Busser    Ssh        Converged
..    default-centos-71    Vagrant  ChefZero     Busser    Ssh        Converged
..    default-debian-81    Vagrant  ChefZero     Busser    Ssh        <Not Created>
.. 
.. Run the following command:
.. 
.. .. code-block:: bash
.. 
..    $ kitchen create default-debian-81
.. 
.. Re-run ``kitchen list`` and the last action for ``default-debian-81`` is updated to ``Created``.
.. 
.. Now run the following command:
.. 
.. .. code-block:: bash
.. 
..    $ kitchen create default-debian-81
.. 
.. and the recipe will converge on the node just like it did for the |ubuntu| and |centos| instances and the last action is updated to ``Converged``.
.. 
.. Compare the results of all three converge processes to see how |chef| behaves on all three platforms. While there are some differences between the platforms, the results are identical.
.. 


.. 
.. More About Resources
.. =====================================================
.. The |chef client| includes many built-in resources: |resource execute|, |resource directory|, |resource package|, |resource service|, |resource file|, |resource template|, |resource user|, |resource script|, and |resource scm_git|.
.. 
.. The sections below quickly describe the most popular resources. For the full list of built-in |chef| resources, see `Resources <https://docs.chef.io/resource.html#resources>`_. You can also `create your own resources <https://docs.chef.io/lwrp_custom.html>`_ or `use the resources built into the community cookbooks <http://supermarket.chef.io>`_.
.. 
.. Execute Commands
.. -----------------------------------------------------
.. Commands are executed using the |resource execute| resource using an attribute to specify the actual command to run. See `execute <https://docs.chef.io/resource_execute.html>`_ for more information about executing commands.
.. 
.. Manage Directories
.. -----------------------------------------------------
.. Directories are hierarchies of folders that comprise all the information stored on a computer. There are two ways to manage directories. The first is via the |resource directory| resource, which manages directories starting from the root directory. And the second is the |resource remote_directory|, which transfers directory structures defined in cookbooks to nodes. See `directory <https://docs.chef.io/resource_directory.html>`_ for more information about managing directories. If the directory is defined in a cookbook, use `remote_directory <https://docs.chef.io/resource_remote_directory.html>`_ instead.
.. 
.. Manage Packages
.. -----------------------------------------------------
.. Packages are collections of files that comprise software applications or some part of an operating system. Use the package resource to manage these packages, unless they are sourced via |rubygems| and installed directly from within recipes or are sourced from a cookbook. See `package <https://docs.chef.io/resource_package.html>`_ for more information about managing packages. There are quite a few platform-specific package resources as well, though most of the time simply using the |resource package| is all that's necessary. For packages that are located in cookobooks, use `chef_gem <https://docs.chef.io/resource_chef_gem.html>`_. And for packages that are only included via recipes, use `gem_package <https://docs.chef.io/resource_gem_package.html>`_.
.. 
.. Manage Services
.. -----------------------------------------------------
.. Services can be started, stopped, enabled, disabled, reloaded, and restarted. See `service <https://docs.chef.io/resource_service.html>`_ for more information about managing services.
.. 
.. Manage Files
.. -----------------------------------------------------
.. Files are managed in several ways. The |resource file| resource manages files that are already present on a node. Files are transferred to nodes from cookbooks using the |resource cookbook_file| resource and are transferred to nodes from remote locations using the |resource remote_file| resource. See `file <https://docs.chef.io/resource_file.html>`_ for more information about managing files, `remote_file <https://docs.chef.io/resource_remote_file.html>`_ for transferring files from remote locations, and `cookbook_file <https://docs.chef.io/resource_cookbook_file.html>`_ for transferring files that are located in cookbooks.
.. 
.. Manage Templates
.. -----------------------------------------------------
.. Templates are used to generate files based on variables and logic contained within the template file. |chef| uses |erb| templates and |ruby| expressions and statements to define the template file. Template source files must be located within cookbooks. See `template <https://docs.chef.io/resource_template.html>`_ for more information about managing files using |erb| templates.
.. 
.. Manage Users, Groups
.. -----------------------------------------------------
.. Users and groups can be added, updated, removed. User passwords can be locked and unlocked. See `group <https://docs.chef.io/resource_user.html>`_ for more information about managing users and user passwords. The `group <https://docs.chef.io/resource_group.html>`__ resource manges groups.
.. 
.. Use Script Interpreters
.. -----------------------------------------------------
.. Script interpreters execute scripts on a node, similar to the |resource execute| resource, and with the ability to specify the interpreter that the |chef client| should use. See `script <https://docs.chef.io/resource_script.html>`_ for more (general) information about using scripts in recipes. Interpreter-specific resources are available, with `bash <https://docs.chef.io/resource_bash.html>`_ being the most popular. Also available: `csh <https://docs.chef.io/resource_csh.html>`_, `perl <https://docs.chef.io/resource_perl.html>`_, `powershell_script <https://docs.chef.io/resource_powershell_script.html>`__, `python <https://docs.chef.io/resource_python.html>`_, and `ruby <https://docs.chef.io/resource_ruby.html>`_. Two |windows|-specific resources are also available: `batch <https://docs.chef.io/resource_batch.html>`_ and `powershell_script <https://docs.chef.io/resource_powershell_script.html>`__.
.. 
.. Use Source Control
.. -----------------------------------------------------
.. Most users of |chef| keep their code in some type of version source control. |chef| can interact with this code from recipes. |git| is a very popular choice. The `git <https://docs.chef.io/resource_git.html>`_ resource is used to manage files that exist in a |git| repository. There is also a resource for `subversion <https://docs.chef.io/resource_subversion.html>`_, another popular version source control tool.
.. 
.. 
.. About Cookbooks
.. =====================================================
.. .. include:: ../../includes_cookbooks/includes_cookbooks.rst
.. 
.. Every cookbook follows a defined structure, but individiaul cookbooks can take on many different styles depending on how your organization wants to manage its code, who authored them, and how they are intended to be used. Some cookbooks contain only a single, default recipe. Others may contain only a library file. Some may contain only a few attributes. And other cookbooks may contain several custom resources along with many attributes and templates, and so on.
.. 
.. Some cookbooks you will build yourself. Some cookbooks will be provided by the community. Most community cookbooks will be managed using |berkshelf|, which is a dependency manager included in the |chef dk|. Occasionally, a community cookbook will be forked, but more often a wrapper cookbook is created to handle your organization-specific requirements while still allowing use of the community cookbook.
.. 
.. The most important thing to know about cookbooks is that there are lots of ways to build good ones. There are patterns to follow, there are guidelines. There are recomended ways of dealing with attributes. There are recommended ways of creating custom resources. But ultimately, a good cookbook is the one that works for your organization. Ideally, this cookbook works across your infrastructure. Most organizations have a mix of private (internal) and public (community) cookbooks in use in their organization.
.. 
.. 
.. Cookbook Patterns
.. -----------------------------------------------------
.. .. include:: ../../includes_cookbook/includes_cookbook_pattern.rst
.. 
.. 
.. About |ruby|
.. =====================================================
.. .. include:: ../../includes_ruby/includes_ruby.rst
.. 

Conclusion
=====================================================
.. include:: ../../includes_chef/includes_chef_about.rst
