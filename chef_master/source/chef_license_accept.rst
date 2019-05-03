=====================================================
Accepting the Chef License
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_license_embedded.rst>`__

This page aims to document how to accept the Chef license for all Chef Software products.
For an overview of the license, see the `Chef license </chef_license.html>`__ documentation.
There are two types of license: MLSA and EULA.
The MLSA applies to customers with a commercial contract with Chef Software, and the EULA covers all other cases.

-----------------------------------------------------
Accept the Chef MLSA
-----------------------------------------------------
There are three ways to accept the Chef MLSA:

#. When running ``chef-<PRODUCT-NAME>-ctl reconfigure`` the Chef MLSA is printed. Type ``yes`` to accept it. Anything other than typing ``yes`` rejects the Chef MLSA, and the upgrade process will exit. Typing ``yes`` adds a ``.license.accepted`` file to the ``/var/opt/<PRODUCT-NAME>/`` directory. As long as this file exists in this directory, the Chef MLSA is accepted and the reconfigure process will not prompt for ``yes``.

#. Run the ``chef-<PRODUCT-NAME>-ctl reconfigure`` command using the ``--accept-license`` option. This automatically types ``yes`` and skips printing the Chef MLSA.

#. Add a ``.license.accepted`` file to the ``/var/opt/<PRODUCT-NAME>/`` directory. The contents of this file do not matter. As long as this file exists in this directory, the Chef MLSA is accepted and the reconfigure process will not prompt for ``yes``.

-----------------------------------------------------
 Accept the Chef EULA
-----------------------------------------------------

Workstation Products
=====================================================
* Chef Workstation, which also contains
    * Chef Infra
    * Chef InSpec
    * Push Jobs Client
* Chef Infra
* Chef InSpec
* Habitat

These products are typically installed on a user's workstation.
Two methods are generally used to accept the license for these products:

#. ``--chef-license <value>`` argument passed to the command line invocation.

#. ``CHEF_LICENSE=<value>`` as an environment variable.

``<value>`` can be specified as one of the following:

#. ``accept`` - Accepts the license and attempts to persist a marker file locally. Persisting these marker files means future invocations do not require accepting the license again.

#. ``accept-silent`` - Similar to ``accept`` except no messaging is sent to STDOUT

#. ``accept-no-persist`` - Similar to ``accept-silent`` except no marker file is persisted. Future invocation will require accepting the license again.

If no command line argument or environment variable is set, these products will attempt to request acceptance through an interactive prompt.
If the prompt cannot be displayed, then the product will fail with an exit code 172.

If the product attempts to persist the accepted license and fails, a message will be sent to STDOUT, but product invocation will continue successfully.
In a future invocation, however, the license would need to be accepted again.

Products with specific features or differences from this general behavior are documented below.

Chef Workstation
-----------------------------------------------------
Chef Workstation contains multiple Chef Software products.
When invoking the ``chef`` command line tool and accepting the license, users are required to accept the license for all the embedded products as well.
The same license applies to all products, but each product must have its own license acceptance.
``chef --chef-license accept`` will accept the license for Chef Workstation, Chef Infra Client, Chef InSpec, and Push Jobs Client.

Chef Infra Client
-----------------------------------------------------
In addition to the above methods, users can specify ``chef_license = 'accept'`` in their Chef Infra Client and Chef Infra Server config.
On a workstation, this can be specified in ``~/.chef/config.rb`` or ``~/.chef/knife.rb``, and on a node, it can be specified in ``/etc/chef/client.rb``.
This method of license acceptance is backwards-compatible to non-EULA versions of Chef Infra.

Habitat
-----------------------------------------------------
The Habitat license can be accepted by setting either environment variables ``HAB_LICENSE=accept`` or ``HAB_LICENSE=accept-no-persist``, or by executing ``hab license accept``.
If neither of these are set, the first ``hab`` invocation will ask the user to accept the license through an interactive prompt.

Note: This does not apply to packages installed using Habitat.
In those cases, a Habitat configuration is set per package.
Documentation for this is coming soon.

Server Products
=====================================================
* Chef Server, which also contains
    * Push Jobs Server
* Chef Automate
* Supermarket

Server products are typically installed and managed by some kind of process supervisor.
Chef Software server products do not allow interactive license acceptance because process supervisors do not easily allow interactivity.
Instead, the license is accepted during the ``reconfigure`` command or ``upgrade`` command for the Omnibus ctl command.
For example:

* ``chef-server-ctl reconfigure --chef-license=accept``
* ``CHEF_LICENSE=accept-no-persist supermarket-ctl reconfigure``

In addition, the Chef license can be accepted via the omnibus configuration file.
Specify ``chef_license 'accept'`` in the ``chef-server.rb`` or ``supermarket.rb`` configuration.

Chef Automate
-----------------------------------------------------
Automate has its own reconfigure tool, ``automate-ctl``.
This tool walks users through the install and setup of Automate.
The Chef license is accepted after that in the browser.
Please follow the in-product prompts.

Remote Management Products
=====================================================
* Test Kitchen
* ``knife bootstrap`` in Chef Infra
* Vagrant
* Chef Terraform Provisioner
* Habitat Terraform Provisioner
* Packer

These products install or manage Chef on a remote instance.
If a user has accepted the appropriate product license locally, it will be automatically transferred to the remote instance.
For example, if a user has accepted the Chef Infra license locally and converges a Test Kitchen instance with the Chef provisioner, it will succeed by copying the acceptance to the remote instance.
We aim to support this behavior, so Workstation users do not have their workflow affected, but any differences from that behavior are documented below.

Test Kitchen
-----------------------------------------------------
Test Kitchen is not owned by or covered by the Chef license, but installing Chef Client on a test instance is covered by the EULA.
Without accepting the license, the converge will fail on the test instance.

The Chef provisioner in Test Kitchen >= 2.3 has been updated to simplify accepting this license on behalf of the test instance.
Users can set the ``CHEF_LICENSE`` environment variable or add ``chef_license: accept`` to their provisioner config in their `kitchen.yml`.
Specifying `accept` will attempt to persist the license acceptance locally.
If a local license marker file is detected, no configuration is required; acceptance is automatically transferred to the test instance.

To disable this persistence, specify ``accept-no-persist`` on every test instance converge.

``kitchen-inspec`` uses Chef InSpec as a library, and is not covered by the EULA when installed as a gem, but is covered by the EULA when packaged as part of the ChefDK installation.
Accept the license in a similar way to the Chef Infra license - specify the ``CHEF_LICENSE`` environment variable, specify the ``chef_license`` config under the verifier section in ``kitchen.yml`` or persist the acceptance locally.

Pin to Chef 14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You can pin to a specific version of chef in your kitchen.yml:

.. code-block:: none

  provisioner:
    name: chef_zero
    product_name: chef
    product_version: 14.12.3

``knife bootstrap``
-----------------------------------------------------
``knife bootstrap`` requires users to accept the Chef Infra license locally before bootstrapping a remote instance.
In most usage cases (via Chef Workstation), this license will already have been accepted and will transfer across transparently.
But if a user installs Chef Workstation and the first command they ever run is ``knife bootstrap``, ``knife bootstrap`` will perform the same license acceptance flow as the Chef Infra product.

Pin to Chef 14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Specify the following argument:

.. code-block:: bash

  knife bootstrap --bootstrap-version 14.12.3

Vagrant
-----------------------------------------------------
This license acceptance can be done via the arguments API:

.. code-block:: ruby

   config.vm.provision "chef_zero" do |chef|
     chef.arguments = "--chef-license accept"
     ...
   end

See `<https://www.vagrantup.com/docs/provisioning/chef_common.html#arguments>`__ for details.
This argument is not backwards-compatible so instead users can use the `custom config path <https://www.vagrantup.com/docs/provisioning/chef_common.html#custom_config_path>`__ and point at a local file, which specifies the ``chef_license`` config.
The environment variable is not currently supported.

Pin to Chef 14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This version pinning can be done via the version API:

.. code-block:: ruby

   config.vm.provision "chef_zero" do |chef|
     chef.version = "14.12.3"
     ...
   end

For more information, see `<https://www.vagrantup.com/docs/provisioning/chef_common.html#version>`__

Chef Terraform Provisioner
-----------------------------------------------------
The license can be accepted via the Chef Infra config file, which is specified by the ``client_options`` Terraform
config:

.. code-block:: none

    provisioner "chef" {
      ...
      client_options = ["chef_license 'accept'"]
      # If left out this will default to latest
      version         = "15"
    }

Pin to Chef 14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In your Terraform provisioner config:

.. code-block:: none

    provisioner "chef" {
      ...
      version         = "14.12.3"
    }


Packer
-----------------------------------------------------
Use a custom `Chef configuration template <https://www.packer.io/docs/provisioners/chef-client.html#chef-configuration>`__.
In your provisioners config:

.. code-block:: json

    {
      "type":              "chef-client",
      "config_template":   "path/to/client.rb"
    }

In ``path/to/client.rb``:

.. code-block:: ruby

    ...
    chef_license "accept"

You may also add it to the `execute_command <https://www.packer.io/docs/provisioners/chef-client.html#execute_command>`__, but this is not backwards-compatible, so it is not suggested.

Pin to Chef 14
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In your Packer provisioners config:

.. code-block:: json

    {
      "type":              "chef-client",
      "install_command":   "curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 14.12.9"
    }

Habitat Terraform Provisioner
-----------------------------------------------------
Documentation coming soon.

Pin to Habitat 0.79
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In your provisioner config:

.. code-block:: none

    provisioner "habitat" {
      ...
      version         = "0.79.1"
    }

Pre-upgrade support
=====================================================
Chef Software aims to make upgrading from a non-EULA version to a EULA version as simple as possible.
For some products (Chef Infra 14.12.9, Chef InSpec 3.9.3), we added backwards-compatible support for the `--chef-license`` command that performs a no-op.
This allows customers to start specifying that argument in whatever way they manage those products before upgrading.

Alternatively, users can specify the `CHEF_LICENSE` environment variable when invoking any of the EULA products to accept the license.
This environment variable is ignored by non-EULA products, and so is backwards-compatible to older versions.

``chef-client`` cookbook
-----------------------------------------------------
For users that manage their Chef Infra installation using the ``chef-client`` cookbook, we added a new attribute that can be specified.
Specify the node attribute ``node['chef_client']['chef_license'] = 'accept'`` when running the cookbook to apply the license acceptance in a backwards-compatible way.

This functionality allows users to set that attribute for a Chef Infra 14 install, upgrade to Chef 15, and have the product continue to work correctly.
