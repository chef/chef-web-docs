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
   wget http://artifact-store.example.com/chef_13.2.20-1_amd64.deb
   dpkg -i chef_13.2.20-1_amd64.deb

The install script should be accessible from your artifact store.

Chef server
=====================================================
Install Chef server using the `standalone installation instructions </install_server.html#standalone>`__. If you intend to use Chef Automate, create the ``delivery`` user and add it to your organization during this step.

Chef workstation
=====================================================

Install Chef DK
-----------------------------------------------------
Now that you've created your Chef server and organization, `install the Chef DK </install_dk.html#install-on-a-workstation>`__ on your workstation and copy the ``USER.pem`` and ``ORGANIZATION.pem`` files from the server. `Generate </install_dk.html#manually-w-o-webui>`__ your Chef repo, and create a ``.chef`` directory within your Chef repo.

Configure knife
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
