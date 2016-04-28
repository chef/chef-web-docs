.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
