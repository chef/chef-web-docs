=====================================================
|supermarket|
=====================================================

.. include:: ../../includes_supermarket/includes_supermarket.rst


Install |supermarket|
=====================================================

.. note:: This section superscedes an earlier blog post:  https://www.chef.io/blog/2014/08/29/getting-started-with-oc-id-and-supermarket/.

|chef server| version 12 includes |chef identity|, which enables |oauth| 2.0 authentication used by |chef| web applications, including |supermarket|. To run |supermarket| behind a firewall on-premises, first upgrade to |chef server| version 12 (or higher) so that |oauth| 2.0 authentication is available.


Set Up |chef identity_title|
-----------------------------------------------------
To set up |chef identity|, do the following:

#. Log on to the |chef server| via |ssh| and elevated to an admin-level user.
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

.. note:: You may add as many |chef identity| applications as you wish to the |chef server rb| configuration file. One file per application will be created.


Run in |kitchen|
-----------------------------------------------------

.. note:: The community |supermarket| cookbook installs |supermarket| from source and is not used for that reason. Instead, use an omnibus package to install |supermarket|. Omnibus packages are located on |packagecloud| at https://packagecloud.io/chef/stable.

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

#. Install the |subcommand knife supermarket| plugin:

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
* The code that builds |supermarket| as an omnibus package: https://github.com/chef/omnibus-supermarket. Use https://github.com/chef/omnibus-supermarket#kitchen-based-build-environment to build your own omnibus packages
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

|subcommand knife supermarket|
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_supermarket.rst

For more information about the |subcommand knife supermarket| subcommand, see :doc:`knife supermarket </plugin_knife_supermarket>`. 

|supermarket rb|
=====================================================
.. include:: ../../includes_config/includes_config_rb_supermarket.rst

For more information about the |supermarket rb| file, see :doc:`supermarket.rb </config_rb_supermarket>`. 

|api cookbooks site|
=====================================================
.. include:: ../../includes_api_cookbooks_site/includes_api_cookbooks_site.rst

For more information about the |api cookbooks site|, see :doc:`Cookbooks Site API </api_cookbooks_site>`. 