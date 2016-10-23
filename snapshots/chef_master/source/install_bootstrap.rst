=====================================================
Bootstrap a Node
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

knife bootstrap
=====================================================
.. include:: ../../includes_install/includes_install_chef_client.rst

**Run the bootstrap command**

.. include:: ../../step_knife/step_knife_bootstrap_install_chef_client.rst

Validatorless Bootstrap
=====================================================
.. include:: ../../includes_knife/includes_knife_bootstrap_no_validator.rst

knife bootstrap Options
-----------------------------------------------------
Use the following options with a validatorless bootstrap to specify items that are stored in chef-vault:

``--bootstrap-vault-file VAULT_FILE``
   The path to a JSON file that contains a list of vaults and items to be updated.

``--bootstrap-vault-item VAULT_ITEM``
   A single vault and item to update as ``vault:item``.

``--bootstrap-vault-json VAULT_JSON``
   A JSON string that contains a list of vaults and items to be updated.

   .. include:: ../../step_knife/step_knife_bootstrap_vault_json.rst

Examples
=====================================================
The ``--bootstrap-vault-*`` options add the client identify of the bootstrapping node to the permissions list of the specified vault item. This enables the newly-bootstrapped chef-client to be able to read items from the vault. Only a single client is authorized at a time for acces to the vault. (The ``-S`` search query option with the ``knife vault create`` subcommand does the same.)

Recreate a data bag item
-----------------------------------------------------
The following example shows how to recreate a data bag item:

.. code-block:: bash

   $ knife vault delete sea power
   Do you really want to delete sea/power? (Y/N) Y
   Deleted chef_vault_item[sea/power]

   $ echo "{\"some\":\"content for them\"}" > sea-power-content.json

   $ cat sea-power-content.json
   {"some":"content for them"}

   $ knife vault create sea power -M client -A sean_horn,angle -J sea-power-content.json

No clients, because the ``-S`` option was not specified while creating the vault.

At this time, only the users ``sean_horn`` and ``angle`` are authorized to read and manage the vault.

.. code-block:: bash

   $ knife vault show sea power  --mode client -p all
   admins:
     sean_horn
     angle
   clients:
   id:           power
   search_query: 
   some:         content for them


It is definitely an encrypted databag, see?

.. code-block:: bash

   $ knife data_bag show sea power
   WARNING: Encrypted data bag detected, but no secret provided for decoding.  Displaying encrypted data.
   id:   power
   some:
   cipher:         aes-256-cbc
   encrypted_data: c7Axnyg+1KDxBPOZdYN9QuIYx6dmSmK70unAQbn12Lygvsv2g9DPJJbueXVh
   +yxL
   iv:             ONoVR7OjPZiAzaqOZ30bjg==
   version:        1
   
Use --bootstrap-vault-file
-----------------------------------------------------

Use the ``sea:power`` recreation step above first, to follow the difference in the vault permissions.

.. code-block:: bash

   echo "{\"sea\":\"power\"}" > sea-power-bootstrap-vault-file.json

   $ knife bootstrap localhost -p 2200 -N ubuntu-12.04 -r 'role[group1]' --ssh-user vagrant --sudo --bootstrap-vault-file sea-power-bootstrap-vault-file.json
   Node ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Client ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Creating new client for ubuntu-12.04
   Creating new node for ubuntu-12.04
   Connecting to localhost
   localhost -----> Existing Chef installation detected
   localhost Starting first Chef Client run...
   localhost Starting Chef Client, version 12.2.1
   localhost resolving cookbooks for run list: ["delay-test-reporting"]
   localhost Synchronizing Cookbooks:
   localhost   - delay-test-reporting
   localhost Compiling Cookbooks...
   localhost Converging 1 resources
   localhost Recipe: delay-test-reporting::default
   localhost   * execute[sleep 30] action run
   localhost     - execute sleep 30
   localhost
   localhost Running handlers:
   localhost Running handlers complete
   localhost Chef Client finished, 1/1 resources updated in 34.307257232 seconds

The client ``ubuntu-12.04`` was added to the ``chef-vault`` during the bootstrap.

.. code-block:: bash

   $ knife vault show sea power  --mode client -p all
   admins:
     sean_horn
     angle
   clients:      ubuntu-12.04
   id:           power
   search_query:
   some:         content for them

Use --bootstrap-vault-item
-----------------------------------------------------

Use the ``sea:power`` re-creation step above first, to follow the difference in the vault permissions.

.. code-block:: bash

   $ knife bootstrap localhost -p 2200 -N ubuntu-12.04 -r 'role[group1]' --ssh-user vagrant --sudo --bootstrap-vault-item sea:power
   Node ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Client ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Creating new client for ubuntu-12.04
   Creating new node for ubuntu-12.04
   Connecting to localhost
   localhost -----> Existing Chef installation detected
   localhost Starting first Chef Client run...
   localhost Starting Chef Client, version 12.2.1
   localhost resolving cookbooks for run list: ["delay-test-reporting"]
   localhost Synchronizing Cookbooks:
   localhost   - delay-test-reporting
   localhost Compiling Cookbooks...
   localhost Converging 1 resources
   localhost Recipe: delay-test-reporting::default
   localhost   * execute[sleep 30] action run
   localhost     - execute sleep 30
   localhost
   localhost Running handlers:
   localhost Running handlers complete
   localhost Chef Client finished, 1/1 resources updated in 34.322229474
   seconds

During the above run, the ``sea:power`` vault item was updated with the ``ubuntu-12.04`` client during the validatorless bootstrap. Previously, it only had the two admins authorized to view the content

.. code-block:: bash

   $ knife vault show sea power -p all
   admins:
     sean_horn
     angle
   clients:      ubuntu-12.04
   id:           power
   search_query: role:stuff
   some:         secret stuff for them

Then, let's check the ``ubuntu-12.04`` client. Install the ``chef-vault`` gem in the embedded chef-client:

.. code-block:: bash

   $ sudo /opt/chef/embedded/bin/gem install chef-vault --no-ri --no-rdoc
   Fetching: chef-vault-2.6.1.gem (100%)
   Successfully installed chef-vault-2.6.1
   1 gem installed

The client itself can decrypt and read the encrypted databag contents as well.

.. code-block:: bash

   $ sudo /opt/chef/bin/knife vault show sea power -c /etc/chef/client.rb -M client -p all
   admins:
     sean_horn
     angle
   clients:      ubuntu-12.04
   id:           power
   search_query: role:group1
   some:         secret stuff for them

Success! The client is authorized to view the content of the ``sea:power`` databag item

Use --bootstrap-vault-json
-----------------------------------------------------
Use the ``sea:power`` re-creation step above first, to follow the difference in the vault permissions.

.. code-block:: bash

   $ knife bootstrap localhost -p 2200 -N ubuntu-12.04 -r 'role[group1]' --ssh-user vagrant --sudo --bootstrap-vault-json '{"sea": "power"}'
   Node ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Client ubuntu-12.04 exists, overwrite it? (Y/N) Y
   Creating new client for ubuntu-12.04
   Creating new node for ubuntu-12.04
   Connecting to localhost
   localhost -----> Existing Chef installation detected
   localhost Starting first Chef Client run...
   localhost Starting Chef Client, version 12.2.1
   localhost resolving cookbooks for run list: ["delay-test-reporting"]
   localhost Synchronizing Cookbooks:
   localhost   - delay-test-reporting
   localhost Compiling Cookbooks...
   localhost Converging 1 resources
   localhost Recipe: delay-test-reporting::default
   
   localhost   * execute[sleep 30] action run
   localhost     - execute sleep 30
   localhost
   localhost Running handlers:
   localhost Running handlers complete
   localhost Chef Client finished, 1/1 resources updated in 33.732784033 seconds

.. code-block:: bash

   $ knife vault show sea power -M client -p all
   admins:
     sean_horn
     angle
   clients:      ubuntu-12.04
   id:           power
   search_query:
   some:         content for them

Unattended Installs
=====================================================
.. include:: ../../includes_install/includes_install_chef_client_unattended_bootstrap.rst

**Setting the initial run-list**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_bootstrap_initial_run_list.rst
