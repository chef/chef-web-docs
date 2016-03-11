=====================================================
|supermarket|
=====================================================

.. include:: ../../includes_supermarket/includes_supermarket.rst

Benefits of a Private |supermarket|
=====================================================

A private |supermarket| provides an easily searchable cookbook repository (with friendly GUI and command line interfaces) that can run on a organization's internal network. Cookbook retrieval from a private |supermarket| is often faster than from the public |supermarket| because of closer proximity in a private network and fewer cookbooks to resolve. A private |supermarket| can also help formalize an internal cookbook release process where cookbooks are not considered released until published.

Install |supermarket|
=====================================================

.. note:: These instructions supersede and incorporate earlier blog posts:
  `Getting Started with oc-id and Supermarket <https://www.chef.io/blog/2014/08/29/getting-started-with-oc-id-and-supermarket/>`_ and `A Supermarket of Your Own: Running a Private Supermarket <https://www.chef.io/blog/2015/12/31/a-supermarket-of-your-own-running-a-private-supermarket/>`_.

Requirements
-----------------------------------------------------

To install a private Supermarket, you will need:

* an operational |chef server| version 12 to act as Oauth Provider
* an admin user account on the |chef server|
* a key for the admin user account on |chef server|
* an x86_64 compatible Linux host with at least 1 GB memory
* AWS S3 credentials if intending to store cookbooks in an S3 bucket **or** sufficient disk space on the |supermarket| host to meet your projected cookbook storage capacity needs

|chef server| version 12 includes |chef identity|, which enables |oauth| 2.0 authentication used by |chef| web applications, including |supermarket|. To run |supermarket| behind a firewall on-premises, first upgrade to |chef server| version 12 (or higher) so that |oauth| 2.0 authentication is available.


Set Up |chef identity_title|
-----------------------------------------------------
To set up |chef identity|, do the following:

#. Log on to the |chef server|—if running a multi-node |chef server| cluster, connect to the node acting as data-master—via |ssh| and elevate to an admin-level user.
#. Add the following setting to the ``/etc/opscode/chef-server.rb`` configuration file:

   .. code-block:: ruby

      oc_id['applications'] = {
        'supermarket' => {
          'redirect_uri' => 'https://supermarket.mycompany.com/auth/chef_oauth2/callback'
        }
      }

#. Run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. |oauth| 2.0 data is located in ``/etc/opscode/oc-id-applications/supermarket.json``:

   .. code-block:: javascript

      {
        "name": "supermarket",
        "uid": "0bad0f2eb04e935718e081fb71e3b7bb47dc3681c81acb9968a8e1e32451d08b",
        "secret": "17cf1141cc971a10ce307611beda7f4dc6633bb54f1bc98d9f9ca76b9b127879",
        "redirect_uri": "https://supermarket.mycompany.com/auth/chef_oauth2/callback"
      }

   The ``uid`` and ``secret`` values will be needed later on during the setup process for |supermarket|.

.. note:: You may add as many |chef identity| applications as you wish to the |chef server rb|
  configuration file. One file per application will be created so that you can see the authentication
  tokens generated for each application. The secrets are also added to the |chef identity| database for
  use by any front-end |chef server| node. It is not necessary to copy the generated JSON files to other
  nodes.

Preparing Your Supermarket
=====================================================

The best cookbook to use to set up a Supermarket is ``supermarket-omnibus-cookbook`` `found in the public Supermarket <https://supermarket.chef.io/cookbooks/supermarket-omnibus-cookbook>`_. This cookbook is attribute driven, so it's recommended that you use a wrapper cookbook to supply your customized attributes.

.. note:: The ``supermarket`` cookbook available on the public Supermarket installs |supermarket| from source and is no longer recommended. Instead, use an omnibus package to install |supermarket| with the ``supermarket-omnibus-cookbook``. Omnibus packages are located on |packagecloud| at https://packagecloud.io/chef/.

Overview of a Wrapper Cookbook
-----------------------------------------------------

Let’s go through the layers of the wrapper cookbook, cookbook, and internal cookbook within the Omnibus package.

  .. image:: ../../images/supermarket_wrapper_cookbook_diagram.png

#. First there is the wrapper cookbook where we define ``node[supermarket_omnibus]`` attributes.

#. Then there is the ``supermarket-omnibus-cookbook``, which is what our wrapper cookbook wraps around. This cookbook will:

    * Install the Supermarket omnibus rpm or deb packages
    * Writes the ``node[supermarket_omnibus]`` attributes to ``/etc/supermarket/supermarket.json``

#. Finally, we have the Supermarket omnibus rpm or deb package. This package has an internal chef cookbook which configures the already-installed package using the attributes defined in ``/etc/supermarket/supermarket.json``. When this internal cookbook is run, it is very similar to running chef solo on a server.

Creating the wrapper cookbook
-----------------------------------------------------

On your workstation, generate a new cookbook.

   .. code-block:: bash

      $ (your workstation) chef generate cookbook my-supermarket-wrapper

Then change directories into that cookbook:

   .. code-block:: bash

      $ (your workstation) cd my-supermarket-wrapper

Open the ``metadata`` file of the cookbook:

   .. code-block:: bash

      $ (your workstation) vim metadata.rb

And add this line, then save and close the file. This defines our wrapper cookbook’s dependency on the ``supermarket-omnibus-cookbook``:

   .. code-block:: ruby

      depends 'supermarket-omnibus-cookbook'

Open the default recipe within the cookbook:

   .. code-block:: bash

      $ (your workstation) vim recipes/default.rb

And add this content, which will execute the ``default`` recipe of the ``supermarket-omnibus-cookbook``.

   .. code-block:: ruby

        include_recipe 'supermarket-omnibus-cookbook'

Next define the attributes for the Supermarket installation and how it connects to the Chef Server. One solution is to hard code attributes in the wrapper cookbook’s default recipe, but a better practice is to place the attributes in a data bag (or encrypted data bag or vault), then reference them in them recipe.

At a minimum, ``chef_server_url``, ``chef_oauth2_app``, ``chef_oauth2_secret`` attributes must be defined.

Edit the default recipe again:

   .. code-block:: bash

      $ (your workstation) vim recipes/default.rb

And assume for the moment that there is a data bag called ``apps``, with an item in it called ``supermarket``:

   .. code-block:: ruby

        # calling the data bag
        app = data_bag_item('apps', 'supermarket')

Then set attributes from the databag:

   .. code-block:: ruby

        # calling the data bag
        app = data_bag_item('apps', 'supermarket')
        node.set['supermarket_omnibus']['chef_server_url'] = app['chefserverurl']
        node.set['supermarket_omnibus']['chef_oauth2_app_id'] = app['app_id']
        node.set['supermarket_omnibus']['chef_oauth2_secret'] = app['secret']

Save and close the file.

Now, retrieve the cookbooks on which ``supermarket-omnibus-cookbook`` depends.

   .. code-block:: bash

      $ (your workstation) berks install

Upload all dependent cookbooks to the Chef Server (There is more than one way to do this, use whatever works best for you and your team’s workflow).

   .. code-block:: bash

      $ (your workstation) cd ~/.berkshelf/cookbooks
      $ (your workstation) knife cookbook upload -a

Then upload the wrapper cookbook (again, there is more than one way of doing this, this is one way that works):

   .. code-block:: bash

      $ (your workstation) cd path/to/wrapper/cookbook/
      $ (your workstation) knife cookbook upload -a

Now bootstrap the Supermarket node with the Chef Server. For example, an ubuntu node in AWS would bootstrap like this:

   .. code-block:: bash

      $ (your workstation) knife bootstrap ip_address -N supermarket-node -x ubuntu --sudo

      # -N flag defines the name of the node (in this case supermarket-node)

      # -x flag defines the username to use (the default username for ubuntu instances on AWS is ubuntu)

      # --sudo runs the bootstrap command as sudo on the node

Once bootstrapping is complete, edit the new supermarket node

   .. code-block:: bash

      $ (your workstation) knife node edit supermarket-node

And add the wrapper’s default recipe to the supermarket-node’s run list then save and quit the file.

   .. code-block:: ruby

        "run_list": [
          "recipe[my_supermarket_wrapper::default]"
        ]

Now start a chef-client run on the Supermarket node. One way is to ssh to the Supermarket host.

   .. code-block:: bash

      $ (your workstation) ssh ubuntu@your-supermarket-node-public-dns

And once on the host, run chef-client. This will install and configure Supermarket.

   .. code-block:: bash

      $ (your supermarket node) sudo chef-client

Using Private Supermarket
=====================================================

Connecting to Supermarket
-----------------------------------------------------

To reach the newly spun up Private Supermarket, the Supermarket host's hostname must be resolvable from the workstation. The Private Supermarket hostname could be added to the workstation's ``/etc/hosts`` for testing purposes, but for production use, the hostname should have a DNS entry in an appropriate domain that users' workstations trust.

Visit the Supermarket hostname in the browser. A Private Supermarket will generate and use a self-signed certificate, if not supplied a certificate via the wrapper cookbook. If you receive an SSL warning while testing, accept the SSL certificate in your browser. A trusted SSL certificate should be used for production Private Supermarkets.

Click the “Create Account” link. If not already logged into the Chef Server, you will be prompted to do so. Then authorize the Supermarket application to use your Chef Server account for authentication.

Interacting with Cookbooks on Supermarket
-----------------------------------------------------

The best current and Chef supported way to interact with a private Supermarket is with the knife-supermarket plugin. (NOTE: Other tools can be used and we will go over those a little later).

First, we install knife-supermarket

If using the Chef DK

   .. code-block:: bash

      $ (your workstation) chef gem install knife-supermarket

If not using the Chef DK

   .. code-block:: bash

      $ (your workstation) gem install knife-supermarket

Now we open up our knife.rb file

   .. code-block:: bash

      $ (your workstation) vim .chef/knife.rb

And define the supermarket site for our Private Supermarket, then save and close the file.

   .. code-block:: ruby

      knife[:supermarket_site] = 'https://your-private-supermarket'

Knife Supermarket commands are the same as knife cookbook site commands, only with the ability to connect with an Private Supermarket rather than just the Public Supermarket. Please consult the docs for information on all commands that can be used with Knife Supermarket.

Let’s take the time to go over how to share a cookbook to a private Supermarket. Using knife supermarket, we would run this command:

   .. code-block:: bash

      $ (your-workstation) knife supermarket share 'my_cookbook'

When we first run this command, we might see an SSL error:

   .. code-block:: bash

      $ (your-workstation) knife supermarket share 'my_cookbook'
      Making tarball my_cookbook.tgz
      ERROR: Error uploading cookbook my_cookbook to the Opscode Cookbook Site: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed. Increase log verbosity (-VV) for more information.

This is because Chef 12 enforces SSL by default when sharing cookbooks (Chef 11 did NOT do this). Private Supermarkets, by default, use self-signed certificates. Fortunately we can fix this error through fetching and checking the private Supermarket’s ssl certificate.

   .. code-block:: bash

      $ (your-workstation) knife ssl fetch https://your-private-supermarket

Followed by:

   .. code-block:: bash

      $ (your-workstation) knife ssl check https://your-private-supermarket

Now let’s try sharing the cookbook again and we should see a success message:

   .. code-block:: bash

      $ (your-workstation) knife supermarket share 'my_cookbook'
      Generating metadata for my_cookbook from (...)
      Making tarball my_cookbook.tgz
      Upload complete!

Managing Private Supermarket
=====================================================

supermarket-ctl
-----------------------------------------------------

We can manage services and other settings of our instance with supermarket-ctl commands.

For example, running supermarket-ctl reconfigure will do an internal Chef run based on the cookbook within the omnibus package.

``supermarket-ctl make-admin username`` will make a supermarket user and admin user.

``supermarket-ctl restart`` will stop services if they are running, then start them again.

Here’s what we would see when using supermarket-ctl restart on a supermarket server.

   .. code-block:: bash

      $ (your supermarket node) sudo supermarket-ctl restart
      ok: run: nginx: (pid 1234) 1s
      ok: run: postgresql: (pid 1235) 0s
      ok: run: rails: (pid 1236) 1s
      ok: run: redis: (pid 1237) 0s
      ok: run: sidekiq: (pid 1238) 0s

Monitoring
-----------------------------------------------------

By default every installation of Supermarket includes a Monitoring URL at https://your_private_supermarket/status.

Other Tools With Private Supermarket
=====================================================

Stove
-----------------------------------------------------

Stove is an alternate utility for releasing and managing Chef Cookbooks.

Berkshelf
-----------------------------------------------------

Berkshelf can include multiple Supermarkets for dependency resolution. Cookbook dependency resolution is performed from the top down – the first source defined in the Berksfile will be searched for the cookbook before the second source.

This Berksfile would first look for the cookbook on the private Supermarket and, if it did not find a cookbook with the specified name, would look on the public Supermarket.

   .. code-block:: ruby

      source 'https://your_private_supermarket_url'
      source 'https://supermarket.chef.io'


Further Customizing a Private Supermarket
=====================================================

Configure an external database
-----------------------------------------------------

Supermarket installations can use an external database (we use Amazon RDS for the Public Supermarket). To configure this, we would need to configure the following attributes in the default recipe of the wrapper cookbook.

   .. code-block:: ruby

        node.set['supermarket_omnibus']['postgresql']['enable'] = false
        node.set['supermarket_omnibus']['database']['user']     = 'supermarket'
        node.set['supermarket_omnibus']['database']['name']     = 'supermarket'
        node.set['supermarket_omnibus']['database']['host']     = 'yourcompany...rds.amazon.com'
        node.set['supermarket_omnibus']['database']['port']     = '5432'
        node.set['supermarket_omnibus']['database']['pool']     = '25'
        node.set['supermarket_omnibus']['database']['password'] = 'topsecretneverguessit'

Configure an external cache
-----------------------------------------------------

Supermarket installations can also use an external cache store. Public Supermarket uses redis on Amazon Elasticache. To configure this, we would need to configure the following attributes in the default recipe of the wrapper cookbook.

   .. code-block:: ruby

        node.set['supermarket_omnibus']['redis']['enable'] = false
        node.set['supermarket_omnibus']['redis_url'] = 'redis://your-redis-instance:6379'

Configure cookbook storage
-----------------------------------------------------

Cookbook artifacts (the tar.gz artifacts which are uploaded to Supermarket when sharing a cookbook) can be stored either on the local filesystem of the Supermarket node (this is the default) or in an Amazon S3 bucket.

If we were using an Amazon S3 bucket, we would configure the following attributes in the default recipe of the wrapper cookbook.

   .. code-block:: ruby

        node.set['supermarket_omnibus']['s3_access_key_id'] = false
        node.set['supermarket_omnibus']['s3_bucket'] = 'supermarket'
        node.set['supermarket_omnibus']['s3_access_key_id'] = 'yoursecretaccesskey'

Additional Configuration Options
-----------------------------------------------------

For additional configuration options for a private Supermarket, please consult `the list of default attributes <https://github.com/chef/omnibus-supermarket/blob/master/cookbooks/omnibus-supermarket/attributes/default.rb>`_ included with Omnibus Supermarket. And of these attributes can be configured.

Running a Supermarket in |kitchen|
=====================================================



To run |supermarket| in |kitchen|, do the following:

#. Download the ``supermarket-omnibus-cookbook`` cookbook from:

   .. code-block:: bash

      $ git clone https://github.com/irvingpop/supermarket-omnibus-cookbook.git supermarket-omnibus-cookbook

      and then:

      $ cd supermarket-omnibus-cookbook

#. Create a |kitchen yml| file that is local to the repo: ``.kitchen.local.yml`` and then add the following:

   .. code-block:: yaml

      ---
      suites:
        - name: default
          run_list:
          - recipe[supermarket-omnibus-cookbook::default]
          attributes:
            supermarket_omnibus:
              chef_server_url: https://chefserver.mycompany.com
              chef_oauth2_app_id: 0bad0f2eb04e935718e081fb71e3b7bb47dc3681c81acb9968a8e1e32451d08b
              chef_oauth2_secret: 17cf1141cc971a10ce307611beda7f4dc6633bb54f1bc98d9f9ca76b9b127879
              chef_oauth2_verify_ssl: false

#. Install the ``vagrant-hostupdater`` plugin. This plugin enables automatically adding the names of machines to the ``/etc/hosts`` file. This is important when using |oauth| 2.0, which cares about host names. The ``redirect_uri`` value in the |chef identity| configuration reflects this name.

   .. code-block:: bash

      $ vagrant plugin install vagrant-hostsupdater

#. Start the |supermarket|, and then test it:

   .. code-block:: bash

      $ kitchen converge default-centos-66 && kitchen verify default-centos-66

#. Go to |supermarket|, and then log on as a |chef| user:

   .. code-block:: html

      https://default-centos-66

#. After logon, the following should be shown:

   .. image:: ../../images/supermarket_onpremises.png


Upload a Cookbook
-----------------------------------------------------
To upload a cookbook to |supermarket|, do the following:

#. Install the ``knife supermarket`` plugin:

   .. code-block:: bash

      $ chef gem install knife-supermarket

#. Add a setting for |supermarket| to the |knife rb| file:

   .. code-block:: ruby

      knife[:supermarket_site] = 'https://default-centos-66'

#. Resolve |ssl| errors by fetching, and then verifying the |ssl| certificate for |supermarket|:

   .. code-block:: bash

      $ knife ssl fetch https://default-centos-66

   and then:

   .. code-block:: bash

      $ knife ssl check https://default-centos-66

#. Upload the cookbook to |supermarket|:

   .. code-block:: bash

      $ knife supermarket share mycookbook "Other"


Run in Production
-----------------------------------------------------
In general, |chef| recommends that you start running |supermarket| with small virtual machines, and then increase the size of the virtual machine as necessary. Put the ``/var/opt/supermarket`` directory on a separate disk, and then use LVM so that may be expanded.


Wrapper Cookbooks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|chef| recommends to use a wrapper cookbook with role recipes to deploy |supermarket|.

All of the keys under ``node['supermarket_omnibus']`` are written out as ``/etc/supermarket/supermarket.json``. Add others as needed to override the defaults that are specified in the |supermarket| `omnibus package <https://github.com/chef/omnibus-supermarket/blob/master/cookbooks/omnibus-supermarket/attributes/default.rb>`__:

.. code-block:: ruby

   default['supermarket_omnibus']['chef_server_url'] = 'https://chefserver.mycompany.com'
   default['supermarket_omnibus']['chef_oauth2_app_id'] = '14dfcf186221781cff51eedd5ac1616'
   default['supermarket_omnibus']['chef_oauth2_secret'] = 'a49402219627cfa6318d58b13e90aca'
   default['supermarket_omnibus']['chef_oauth2_verify_ssl'] = false


Scale-out and HA
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|supermarket| is a |ruby on rails| application with a |postgresql| backend. Typical rules for scaling a |ruby on rails| application apply. To run |supermarket| in a scale-out or high availability configuration, build out the following components on the back end:

* **Database** Build a separate |postgresql| 9.3+ server (or high availability pair). Note that the following |postgresql| extensions must be installed and loaded: ``pgpsql`` and ``pg_trgm``
* **Cookbook Storage** Cookbook tarballs are stored by default in ``/var/opt/supermarket/data``. Update this to use |amazon s3| (recommended) or any |amazon s3|-compatible service. If using |amazon s3| or an |amazon s3|-compatible service is not an option, try symlinking this directory to shared storage; however, this approach has not fully tested against race conditions
* **Caching Service** Optional. |supermarket| uses |redis| as its caching service. One |redis| instance per |supermarket| application server may be run safely. Use |redis| 2.8 (or higher) for a high availability pair.


Notes
-----------------------------------------------------
The following errors and issues may be seen when running |supermarket| on premises.

Incorrect Redict URL
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The redirect URL specified for |chef identity| **MUST** match the hostname of the |supermarket| server. The URI must also be correct: ``/auth/chef_oauth2/callback``. Otherwise, an error message similar to ``The redict uri included is not valid.`` will be shown.

500 Errors At Login
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |supermarket| server must be able to reach (via HTTPS) the specified ``chef_server_url`` during |oauth| 2.0 negotiation. This type of issue is typically with name resolution and firewall rules.

Source Code Location
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The code for |supermarket| can be found at the following URLs:

* The application itself: https://github.com/chef/supermarket. Report issues to: https://github.com/chef/supermarket/issues
* The code that builds |supermarket| as an omnibus package: https://github.com/chef/omnibus-supermarket. Use a |kitchen|-based environment to build your own omnibus packages
* The cookbook that is run when ``supermarket-ctl reconfigure``: https://github.com/chef/omnibus-supermarket/tree/master/cookbooks/omnibus-supermarket

Enable Debug Logging
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |supermarket| omnibus package does not log |ruby on rails| messages by default. To enable debug logging, on the |supermarket| server, edit the ``/opt/supermarket/embedded/service/supermarket/config/environments/production.rb`` file and change line 46 (``config.log_level = :warn`` to be:

.. code-block:: ruby

   config.logger = Logger.new('/var/log/supermarket/rails/rails.log')
   config.logger.level = 'DEBUG'
   config.log_level = :debug

and then run:

.. code-block:: bash

   $ supermarket-ctl restart rails

Behind a Proxy
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If |packagecloud| fails due to being behind a proxy, update the |kitchen yml| file:

.. code-block:: yaml

   ---
   provisioner:
     name: chef_zero
     solo_rb:
       http_proxy: http://192.168.1.1
       https_proxy: http://192.168.2.2

|kitchen| is Slow
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If |kitchen| has to download and install the |chef client| omnibus package every time, do the following to speed that process up:

#. Update the |kitchen yml| file so that |kitchen| can cache the omnibus installer:

   .. code-block:: yaml

      ---
      provisioner:
        name: chef_zero
        chef_omnibus_install_options: -d /tmp/vagrant-cache/vagrant_omnibus

#. Cache the |yum| repos using the ``vagrant-cachier`` plugin:

   .. code-block:: bash

      $ vagrant plugin install vagrant-cachier

   and then create a ``$VAGRANT_HOME/Vagrantfile``:

   .. code-block:: ruby

      Vagrant.configure("2") do |config|
        config.vm.box = 'some-box'
        if Vagrant.has_plugin?("vagrant-cachier")
          config.cache.scope = :box
          config.cache.enable :chef
          config.cache.enable :apt
          config.cache.enable :yum
          config.cache.enable :gem
        end
      end


Create Cookbook
=====================================================
The following examples show how to create a simple cookbook by using the |chef ctl| command that is built into the the |chef dk|.

**Generate a chef-repo**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_repo_supermarket.rst

**Generate a cookbook**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_cookbook_supermarket.rst

**Generate a template**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_template_supermarket.rst

**Create a recipe**

.. include:: ../../step_ctl_chef/step_ctl_chef_generate_recipe_supermarket.rst

supermarket-ctl (executable)
=====================================================
.. include:: ../../includes_ctl_supermarket/includes_ctl_supermarket.rst

For more information about the |supermarket ctl| command line tool, see :doc:`supermarket-ctl </ctl_supermarket>`.

knife supermarket
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_supermarket.rst

For more information about the ``knife supermarket`` subcommand, see :doc:`knife supermarket </plugin_knife_supermarket>`.

|supermarket rb|
=====================================================
.. include:: ../../includes_config/includes_config_rb_supermarket.rst

For more information about the |supermarket rb| file, see :doc:`supermarket.rb </config_rb_supermarket>`.

|api cookbooks site|
=====================================================
.. include:: ../../includes_api_cookbooks_site/includes_api_cookbooks_site.rst

For more information about the |api cookbooks site|, see :doc:`Cookbooks Site API </api_cookbooks_site>`.
