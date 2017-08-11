=====================================================
Install Chef in an air-gapped environment
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_chef_air_gap.rst>`__

This guide will show you how to run a fully functional Chef environment within an `air-gapped <https://en.wikipedia.org/wiki/Air_gap_(networking)>`__ network.

Prerequisites
=====================================================

Since a variety of different practices are used to create an air-gapped network, this guide focuses solely on the implementation of Chef software - as such, it makes the following assumptions:

* You have a way to get packages to your air-gapped machines.
* Machines on your air-gapped network are able to resolve each other via DNS.
* A server's Fully Qualified Domain Name (FQDN) is the name that will be used by other servers to access it.
* You have a private Ruby gem mirror to supply gems as needed.
* You have an artifact store for file downloads. At a minimum, it should have the following packages available:
    * Chef DK
    * Chef client
    * Chef Supermarket
    * An `install script </#create-an-install-script>`__ for Chef client

Create an install script
-----------------------------------------------------
An install script is used to install Chef client when bootstrapping a new node. It simply pulls the Chef client package from your artifact store, and then installs it. For example, on Debian-based Linux systems, it looks like this:

.. code-block:: bash

   #!/bin/bash

   cd /tmp/
   wget http://packages.example.com/chef_13.2.20-1_amd64.deb
   dpkg -i chef_13.2.20-1_amd64.deb

The install script should be accessible from your artifact store.

Chef server
=====================================================
If you intend to use Chef Automate, create the ``delivery`` user and add it to your organization during this step. Note that in order to configure Supermarket later in this guide, you will need a user that is a member of the ``admins`` group.

#. Download the package from https://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. tag install_chef_server_install_package

   .. This topic is hooked in globally to install topics for Chef server applications.

   As a root user, install the Chef server package on the server, using the name of the package provided by Chef. For Red Hat Enterprise Linux and CentOS:

   .. code-block:: bash

      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ dpkg -i /tmp/chef-server-core-<version>.deb

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
By default, ``knife bootstrap`` uses the ``chef-full`` template to bootstrap a node. This template contains a number of useful features, but it also attempts to pull an installation script from ``omnitruck.chef.io``. In this section, you'll copy the contents of the ``chef-full`` template to a custom template, and then modify the package source.

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
Private Supermarket allows you to host your own internal version of the `Chef supermarket <https://supermarket.chef.io>`__ within your air-gapped network. In this section, you will use a wrapper cookbook with the `Supermarket omnibus cookbook <https://supermarket.chef.io/cookbooks/supermarket-omnibus-cookbook>`__ to install private Supermarket.

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
