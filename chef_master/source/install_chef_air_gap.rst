=====================================================
Install Chef in an air-gapped environment
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_chef_air_gap.rst>`__

This guide will show you how to run a fully functional Chef environment within an `air-gapped <https://en.wikipedia.org/wiki/Air_gap_(networking)>`__ network.

Prerequisites
=====================================================

Since a variety of different practices are used to create an air-gapped network, this guide focuses solely on the implementation of Chef software - as such, it makes the following assumptions:

* You have a way to get packages to your air-gapped machines
* Machines on your air-gapped network are able to resolve each other via DNS
* A server's Fully Qualified Domain Name (FQDN) is the name that will be used by other servers to access it
* You have a private Ruby gem mirror to supply gems as needed
* You have an artifact store for file downloads. At a minimum, it should have the following packages available:
    * Chef DK
    * Chef client
    * Chef Supermarket
    * An `install script </#create-an-install-script>`__ for Chef client

Required cookbooks
-----------------------------------------------------
This guide will link to the required cookbooks for each piece of software in that software's respective section, but this is a full list of the cookbooks required to complete the entire guide:

For Chef Supermarket:

* `supermarket-omnibus-cookbook <https://supermarket.chef.io/cookbooks/supermarket-omnibus-cookbook>`_
* `chef-ingredient <https://supermarket.chef.io/cookbooks/chef-ingredient>`_
* `hostsfile <https://supermarket.chef.io/cookbooks/hostsfile>`_ 

For Chef Automate Workflow:

* `delivery-sugar <https://supermarket.chef.io/cookbooks/delivery-sugar>`_
* `delivery-truck <https://supermarket.chef.io/cookbooks/delivery-truck>`_

Required Gems
-----------------------------------------------------
The following Ruby gems are required to install private Supermarket via the supermarket-omnibus-cookbook:

* mixlib-install
* mixlib-shellout
* mixlib-versioning
* artifactory

These should be accessible from your Gem mirror. 

Create an install script
-----------------------------------------------------
An install script is used to install Chef client when bootstrapping a new node. It simply pulls the Chef client package from your artifact store, and then installs it. For example, on Debian-based Linux systems, it would look similar to this:

.. code-block:: bash

   #!/bin/bash

   cd /tmp/
   wget http://packages.example.com/chef_13.2.20-1_amd64.deb
   dpkg -i chef_13.2.20-1_amd64.deb

The install script should be accessible from your artifact store.

Chef server
=====================================================
In this section you'll install the Chef server, and create your organization and user.  Note that in order to configure Supermarket later in this guide, you will need a user that is a member of the ``admins`` group.

.. note:: If you intend to use Chef Automate, create the ``delivery`` user and add it to your organization during this step.

#. Download the package from https://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. tag install_chef_server_install_package

   .. This topic is hooked in globally to install topics for Chef server applications.

   As a root user, install the Chef server package on the server, using the name of the package provided by Chef. For Red Hat Enterprise Linux and CentOS:

   .. code-block:: bash

      $ sudo rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ sudo dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef server will be installed.

   .. end_tag

#. Run the following to start all of the services:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   Because the Chef server is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.

#. .. tag ctl_chef_server_user_create_admin

   Run the following command to create an administrator:

   .. code-block:: bash

      $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl user-create stevedanno Steve Danno steved@chef.io 'abc123' --filename /path/to/stevedanno.pem

   .. end_tag

#. .. tag ctl_chef_server_org_create_summary

   Run the following command to create an organization:

   .. code-block:: bash

      $ chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` option will associate the ``user_name`` with the ``admins`` security group on the Chef server.

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user stevedanno --filename /path/to/4thcoffee-validator.pem

   .. end_tag

Chef workstation
=====================================================

Install Chef DK
-----------------------------------------------------
#. Your workstation should have a copy of the Chef DK `installer package <https://downloads.chef.io/chefdk>`__. Use the appropriate tool to run the installer:

   .. code-block:: bash

      dpkg -i chefdk_2.0.28-1_amd64.deb

#. Use the ``chef generate app`` command to generate your Chef repo:

   .. code-block:: bash

      chef generate app chef-repo

#. Within your Chef repo, create a ``.chef`` directory:

   .. code-block:: bash

      mkdir /chef-repo/.chef

#. Copy the ``USER.pem`` and ``ORGANIZATION.pem`` files from the server, and move them into the ``.chef`` directory.

   .. code-block:: bash

      scp ssh-user@chef-server.example.com:/path/to/pem/files /chef-repo/.chef/

Create a bootstrap template
-----------------------------------------------------
By default, ``knife bootstrap`` uses the ``chef-full`` template to bootstrap a node. This template contains a number of useful features, but it also attempts to pull an installation script from ``omnitruck.chef.io``. In this section, you'll copy the contents of the ``chef-full`` template to a custom template, and then modify the package and Ruby gem sources.

#. Navigate to the ``.chef`` directory, and create a ``bootstap`` directory within it:

   .. code-block:: bash

      mkdir bootstrap

#. Move to the ``bootstrap`` directory and create a blank template file; this example will use ``airgap.erb`` for the template name:

   .. code-block:: bash

      touch airgap.erb

#. Still in the ``bootstrap`` directory, issue the following command to copy the ``chef-full`` configuration to your new template:

   .. code-block:: bash

      find /opt/chefdk/embedded/lib/ruby -type f -name chef-full.erb -exec cat {} \; > airgap.erb

   This command searches for the ``chef-full`` template file under ``/opt/chefdk/embedded/lib/ruby``, and then outputs the contents of the file to ``airgap.erb``. If you used a different template file name, be sure to replace ``airgap.erb`` with the template file you created during the last step.

#. Update ``airgap.erb`` to replace ``omnitruck.chef.io`` with the URL of ``install.sh`` on your artifact store:

   .. code-block:: ruby

      install_sh="<%= knife_config[:bootstrap_url] ? knife_config[:bootstrap_url] : "http://packages.example.com/install.sh" %>"

#. Still in your text editor, locate the following line near the bottom of your ``airgap.erb`` file:

   .. code-block:: ruby

      cat > /etc/chef/client.rb <<'EOP'
      <%= config_content %>
      EOP

   Beneath it, add the following, replacing ``gems.example.com`` with the URL of your gem mirror:

   .. code-block:: ruby

      cat >> /etc/chef/client.rb <<'EOP'
      rubygems_url "http://gems.example.com"
      EOP

   This appends the appropriate ``rubygems_url`` setting to the ``/etc/chef/client.rb`` file that is created during bootstrap, which ensures that your nodes use your internal gem mirror.

Configure knife
-----------------------------------------------------
Within the ``.chef`` directory, create a ``knife.rb`` file and replace ``USER`` and ``ORGANIZATION`` with the user and organization that you created on your Chef server; replace ``chef-server.example.com`` with your Chef server URL:

.. code-block:: ruby

   current_dir = File.dirname(__FILE__)
   log_level                :info
   log_location             STDOUT
   node_name                'USER'
   client_key               "#{current_dir}/USER.pem"
   validation_client_name   'ORGANIZATION-validator'
   validation_key           "#{current_dir}/ORGANIZATION.pem"
   chef_server_url          'https://chef-server.example.com/organizations/ORGANIZATION'
   cache_type               'BasicFile'
   cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
   cookbook_path            ["#{current_dir}/../cookbooks"]
   knife[:bootstrap_template] = "#{current_dir}/bootstrap/airgap.erb"

The ``knife[:bootstrap_template]`` option in this example allows you to specify the template that ``knife bootstrap`` will use by default when bootstrapping a node. It should point to your custom template within the ``bootstrap`` directory.

Now that ``knife`` is configured, copy the SSL certificates from your Chef server to your trusted certificates:

.. code-block:: ruby

   knife ssl fetch

Private Supermarket
=====================================================
Private Supermarket allows you to host your own internal version of the `Chef supermarket <https://supermarket.chef.io>`__ within your air-gapped network.

Requirements
-----------------------------------------------------
In this section, you will use a wrapper around the `supermarket-omnibus-cookbook <https://supermarket.chef.io/cookbooks/supermarket-omnibus-cookbook>`__ to install private Supermarket. The Supermarket cookbook depends upon the following cookbooks:

* `chef-ingredient <https://supermarket.chef.io/cookbooks/chef-ingredient>`_ 
* `hostsfile <https://supermarket.chef.io/cookbooks/hostsfile>`_ 

The following Gems must be accessible via your Gem mirror:

* mixlib-install
* mixlib-shellout
* mixlib-versioning
* artifactory

Your ``cookbooks`` directory must have all three of these cookbooks installed before you will be able to use the Supermarket cookbook wrapper. In addition the necessary cookbooks, a private Chef Supermarket has the following requirements:

* An operational Chef server (version 12.0 or higher) to act as the OAuth 2.0 provider
* A user account on the Chef server with ``admins`` privileges
* A key for the user account on the Chef server
* An x86_64 compatible Linux host with at least 1 GB memory
* System clocks synchronized on the Chef server and Supermarket hosts
* Sufficient disk space to meet project cookbook storage capacity or credentials to store cookbooks in an Amazon Simple Storage Service (S3) bucket

Configure credentials
-----------------------------------------------------

First, you'll configure Chef Identity credentials for Supermarket. Chef Identity is an OAuth 2.0 service packaged with the Chef server, that allows you to use the same credentials to access both server and Supermarket.

#. Log on to the Chef server via SSH and elevate to an admin-level user. If running a multi-node Chef server cluster, log on to the node acting as the primary node in the cluster.
#. Update the ``/etc/opscode/chef-server.rb`` configuration file.

   .. tag config_ocid_application_hash_supermarket

   To define OAuth 2 information for Chef Supermarket, create a Hash similar to:

      .. code-block:: ruby

         oc_id['applications'] ||= {}
         oc_id['applications']['supermarket'] = {
           'redirect_uri' => 'https://supermarket.mycompany.com/auth/chef_oauth2/callback'
         }

   .. end_tag

#. Reconfigure the Chef server.

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

#. Retrieve Supermarket's OAuth 2.0 client credentials:

   Depending on your Chef server version and configuration (see :ref:`chef-server.rb <config_rb_server_insecure_addon_compat>`), this can be retrieved via :ref:`chef-server-ctl oc-id-show-app supermarket <ctl_chef_server_oc_id_show_app>` or is located in ``/etc/opscode/oc-id-applications/supermarket.json``:

   .. code-block:: javascript

      {
        "name": "supermarket",
        "uid": "0bad0f2eb04e935718e081fb71asdfec3681c81acb9968a8e1e32451d08b",
        "secret": "17cf1141cc971a10ce307611beda7ffadstr4f1bc98d9f9ca76b9b127879",
        "redirect_uri": "https://supermarket.mycompany.com/auth/chef_oauth2/callback"
      }

Create a Wrapper
-----------------------------------------------------

#. Generate the cookbook:

   .. code-block:: bash

      $ chef generate cookbook my_supermarket_wrapper

#. Change directories into that cookbook:

   .. code-block:: bash

      $ cd my_supermarket_wrapper

#. Defines the wrapper cookbook’s dependency on the ``supermarket-omnibus-cookbook`` cookbook. Open the ``metadata.rb`` file of the newly-created cookbook, and then add the following line:

   .. code-block:: ruby

      depends 'supermarket-omnibus-cookbook'

#. Save and close the ``metadata.rb`` file.

#. Open the ``/recipes/default.rb`` recipe located within the newly-generated cookbook and add the following content:

   .. code-block:: ruby

      include_recipe 'supermarket-omnibus-cookbook'

   This ensures that the ``default.rb`` file in the ``supermarket-omnibus-cookbook`` is run.

Define Attributes
-----------------------------------------------------
Define the attributes for the Chef Supermarket installation and how it connects to the Chef server. One approach would be to hard-code attributes in the wrapper cookbook's ``default.rb`` recipe. A better approach is to place these attributes in a :doc:`data bag </data_bags>`, and then reference them from the recipe. For example, the data bag could be named ``apps`` and then a data bag item within the data bag could be named ``supermarket``. The following attributes are required:

* ``chef_server_url``: the url for your chef server.
* ``chef_oauth2_app_id``: the Chef Identity uid from ``/etc/opscode/oc-id-applications/supermarket.json``
* ``chef_oauth2_secret``: The Chef Identity secret from ``/etc/opscode/oc-id-applications/supermarket.json``
* ``package_url``: The location of the Supermarket package on your artifact store

To define these attributes, do the following:

#. Open the ``recipes/default.rb`` file and add the following, **before** the ``include_recipe`` line that was added in the previous step. This example uses a data bag named ``apps`` and a data bag item named ``supermarket``:

   .. code-block:: ruby

      app = data_bag_item('apps', 'supermarket')

#. Set the attributes from the data bag:

   .. code-block:: ruby

      node.override['supermarket_omnibus']['chef_server_url'] = app['chef_server_url']
      node.override['supermarket_omnibus']['chef_oauth2_app_id'] = app['chef_oauth2_app_id']
      node.override['supermarket_omnibus']['chef_oauth2_secret'] = app['chef_oauth2_secret']
      node.override['supermarket_omnibus']['package_url'] = app['package_url']

   Note that the ``['package_url']`` setting points to the location of the Supermarket package on your artifact store. When finished, the ``/recipes/default.rb`` file should have code similar to:

   .. code-block:: ruby

      app = data_bag_item('apps', 'supermarket')

      node.override['supermarket_omnibus']['chef_server_url'] = app['chef_server_url']
      node.override['supermarket_omnibus']['chef_oauth2_app_id'] = app['chef_oauth2_app_id']
      node.override['supermarket_omnibus']['chef_oauth2_secret'] = app['chef_oauth2_secret']

      include_recipe 'supermarket-omnibus-cookbook'

   Alternatively, if you chose not to use a data bag to store these values, your ``default.rb`` should look similar to this:

   .. code-block:: ruby

      node.override['supermarket_omnibus']['chef_server_url'] = 'https://chef-server.example.com:443'
      node.override['supermarket_omnibus']['chef_oauth2_app_id'] = '0bad0f2eb04e935718e081fb71asdfec3681c81acb9968a8e1e32451d08b'
      node.override['supermarket_omnibus']['chef_oauth2_secret'] = '17cf1141cc971a10ce307611beda7ffadstr4f1bc98d9f9ca76b9b127879'
      node.override['supermarket_omnibus']['package_url'] = 'http://packages.example.com/supermarket_3.1.22-1_amd64.deb'


      include_recipe 'supermarket-omnibus-cookbook'

#. Save and close the ``recipes/default.rb`` file.

#. Upload all of your cookbooks to the Chef server:

   .. code-block:: ruby

      knife cookbook upload -a

Bootstrap Supermarket
-----------------------------------------------------
Bootstrap the node on which Chef Supermarket is to be installed. For example, to bootstrap a node running Ubuntu on Amazon Web Services (AWS), the command is similar to:

.. code-block:: bash

   $ knife bootstrap ip_address -N supermarket-node -x ubuntu --sudo

where:

* ``-N`` defines the name of the Chef Supermarket node: ``supermarket-node``
* ``-x`` defines the (ssh) user name: ``ubuntu``
* ``--sudo`` ensures that sudo is used while running commands on the node during the bootstrap operation

When the bootstrap operation is finished, do the following:

#. Add the wrapper cookbook's ``/recipes/default.rb`` recipe to the run-list:

   .. code-block:: bash

      $ knife node run_list set supermarket-node recipe[my_supermarket_wrapper::default]

   where ``supermarket-node`` is the name of the node that was just bootstrapped.

#. Start the chef-client on the newly-bootstrapped Chef Supermarket node. For example, using SSH:

   .. code-block:: bash

      $ ssh ubuntu@your-supermarket-node-public-dns

#. After accessing the Chef Supermarket node, run the chef-client:

   .. code-block:: bash

      $ sudo chef-client

Connect to Supermarket
-----------------------------------------------------
To reach the newly spun up private Chef Supermarket, the hostname must be resolvable from a workstation. For production use, the hostname should have a DNS entry in an appropriate domain that is trusted by each user's workstation.

#. Visit the Chef Supermarket hostname in the browser. A private Chef Supermarket will generate and use a self-signed certificate, if a certificate is not supplied as part of the installation process (via the wrapper cookbook).
#. If an SSL notice is shown due to your self-signed certificate while connecting to Chef Supermarket via a web browser, accept the SSL certificate. A trusted SSL certificate should be used for  private Chef Supermarket that is used in production.
#. After opening Chef Supermarket in a web browser, click the **Create Account** link. A prompt to log in to the Chef server is shown. Authorize the Chef Supermarket to use the Chef server account for authentication. **Important:** If you intend to use Supermarket in conjunction with Chef Automate, you should log into to Supermarket as the ``delivery`` user.

.. note:: The redirect URL specified for Chef Identity **MUST** match the FQDN hostname of the Chef Supermarket server. The URI must also be correct: ``/auth/chef_oauth2/callback``. Otherwise, an error message similar to ``The redirect uri included is not valid.`` will be shown.

Configuration updates
-----------------------------------------------------
Knife
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Update the ``knife.rb`` file on your workstation to use your private Supermarket:

.. code-block:: ruby

   knife[:supermarket_site] = 'https://supermarket.example.com'

Berkshelf
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If you're using Berkshelf, update your ``Berksfile`` to replace ``https://supermarket.chef.io`` with the URL of your private Supermarket:

.. code-block:: ruby

   source 'https://supermarket.example.com'

Upload cookbooks to Supermarket
-----------------------------------------------------

To upload new cookbooks to your private Supermarket, use the ``knife cookbook site share`` command on your workstation:

.. code-block:: ruby

   knife cookbook site share chef-ingredient

Chef Automate
=====================================================

Installation
-----------------------------------------------------

#. Upload and install the latest stable Chef Automate package for your operating system from `<https://downloads.chef.io/automate/>`_ on the Chef Automate server machine.

   For Debian:

   .. code-block:: bash

      dpkg -i PATH_TO_AUTOMATE_SERVER_PACKAGE

   For Red Hat Enterprise Linux or CentOS:

   .. code-block:: bash

      rpm -Uvh PATH_TO_AUTOMATE_SERVER_PACKAGE

#. In Chef Automate 0.6.64 and above, you have the option of running the ``preflight-check`` command. This command is optional, but you are encouraged to use it, as it can uncover common environmental problems prior to the actual setup process. For example, there may be required ports that are unavailable, which would have to be rectified prior to setup.

   .. code-block:: bash

      sudo automate-ctl preflight-check

   This triggers a series of validation steps on your system that will be sent to stdout as
   they are run, along with whether they are passing or failing. The end of the
   check will include a report of all failures and remediation steps that you can
   take to fix them.

   .. note:: As shown in the example above, this command requires root user privileges.

   Please refer to the troubleshooting section for more information about the error codes and remediation steps.

#. Ensure that the Chef Automate license file and the ``delivery`` user key you created earlier in the Chef Server setup are located on the Chef Automate server.

#. Run the ``automate-ctl setup`` command with the ``--supermarket-fqdn`` option to specify the URL of your private Supermarket. This command requires root user privileges. 

   .. code-block:: bash

      sudo automate-ctl setup --supermarket-fqdn supermarket.example.com

   ``automate-ctl setup`` automatically prompts for the following information:

   * The full path and file name of your Chef Automate license file. For example: ``/root/automate.license``.

   * The ``delivery`` user key that you created on your Chef server. For example: ``/root/delivery.pem``.

   * The URL of your Chef server, which contains the fully-qualified domain name of the Chef server and the name of the organization you created when you created the ``delivery`` user.

   * The external fully-qualified domain name of the Chef Automate server. This is just the name of the system, not a URL. For example: ``host.4thcoffee.co``.

   *  The name of your enterprise. For example: ``4thcoffee_inc``. Currently, only one enterprise is allowed in Chef Automate.

   .. tag automate_supermarket

   .. note:: To enable Chef Automate to upload cookbooks to a private Supermarket, you have to manually log into the Supermarket server with the ``delivery`` user, and when it prompts you to enable the user for Supermarket, enter ``yes``. Also, you must copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt`` on the Chef Automate server.

   .. end_tag

Once setup of your Chef Automate server completes, you will be prompted to apply the configuration.
This will apply the configuration changes and bring services online, or restart them if you've previously
run setup and applied configuration at that time. You can bypass this prompt by passing in the argument
``--configure`` to the ``setup`` command, which will run it automatically, or pass in ``--no-configure`` to skip it.

.. note:: Your Chef Automate server will not be available for use until you either agree to apply the configuration, or manually run ``sudo automate-ctl reconfigure``.

If you've applied the configuration, you will also be prompted to set up a Chef Automate runner and submit additional information. In addition to installing runners during setup, you can also install push jobs-based build nodes after your Chef Automate setup completes using the command ``sudo automate-ctl install-build-node``. If you need to install additional runners, run ``sudo automate-ctl install-runner``. These commands can be run each time you want to install a new build node or runner. See the next section for installation instructions.

After setup successfully completes and a configuration has been applied, login credentials are reported in the completion output; however, they are also saved to ``/etc/delivery/ENTERPRISE_NAME-admin-credentials``.

If you plan on using the workflow capabilities of Automate, you will need to have the following cookbooks available on your Private supermarket:

* `delivery-sugar <https://supermarket.chef.io/cookbooks/delivery-sugar>`_
* `delivery-truck <https://supermarket.chef.io/cookbooks/delivery-truck>`_

For more information about ``automate-ctl`` and how to use it, see :doc:`ctl_automate_server`.

Configure node data collection
------------------------------------------------------------

Configure a Data Collector token in Chef Automate
+++++++++++++++++++++++++++++++++++++++++++++++++++++

All messages sent to Chef Automate are performed over HTTP and are authenticated with a pre-shared key called a ``token.`` Every Chef Automate installation configures a default token by default, but we strongly recommend that you create your own.

To set your own token, add the following to your ``/etc/delivery/delivery.rb`` file:

.. code-block:: ruby

   data_collector['token'] = 'sometokenvalue'

... and then run ``automate-ctl reconfigure``

If you do not configure a token, the default token value is: ``93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506``


Configure your Chef server to point to Chef Automate
+++++++++++++++++++++++++++++++++++++++++++++++++++++

In addition to forwarding Chef run data to Automate, Chef server will send messages to Chef Automate whenever an action is taken on a Chef server object, such as when a cookbook is uploaded to the Chef server or when a user edits a role.

To enable this feature on Chef Server versions 12.14 and later, channel the token setting through our veil secrets library because the token is considered a secret and, as such, cannot appear in ``/etc/opscode/chef-server.rb``. On Chef Server versions 12.14 and above, you must make the following to change the data collector token:

.. code-block:: ruby

   chef-server-ctl set-secret data_collector token 'TOKEN'
   chef-server-ctl restart nginx

To enable this feature on Chef Server versions 12.13 and earlier, add the following settings to ``/etc/opscode/chef-server.rb`` on the Chef server:

.. code-block:: ruby

   data_collector['root_url'] = 'https://my-automate-server.mycompany.com/data-collector/v0/'
   data_collector['token'] = 'TOKEN'

where ``my-automate-server.mycompany.com`` is the fully-qualified domain name of your Chef Automate server, and
``TOKEN`` is either the default value or the token value you configured in the `prior section <#configure-a-data-collector-token-in-chef-automate>`__.

Save the file and run ``chef-server-ctl reconfigure`` to complete the process.

Additional configuration options include:

 * ``data_collector['timeout']``: timeout in milliseconds to abort an attempt to send a message to the
   Chef Automate server. Default: ``30000``.
 * ``data_collector['http_init_count']``: number of Chef Automate HTTP workers Chef server should start.
   Default: ``25``.
 * ``data_collector['http_max_count']``: maximum number of Chef Automate HTTP workers Chef server should
   allow to exist at any time. Default: ``100``.
 * ``data_collector['http_max_age']``: maximum age a Chef Automate HTTP worker should be allowed to live,
   specified as an Erlang tuple. Default: ``{70, sec}``.
 * ``data_collector['http_cull_interval']``: how often Chef server should cull aged-out Chef Automate
   HTTP workers that have exceeded their ``http_max_age``, specified as an Erlang tuple. Default: ``{1,
   min}``.
 * ``data_collector['http_max_connection_duration']``: maximum duration an HTTP connection is allowed
   to exist before it is terminated, specified as an Erlang tuple. Default: ``{70, sec}``.
 * ``opscode_erchef['max_request_size']``: When the request body size is greater than this value, a ``413 Request Entity Too Large`` error   is returned. Default value: ``1000000``.  
