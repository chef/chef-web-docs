=====================================================
chef-vault
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_vault.rst>`__

chef-vault is a RubyGems package that is included in the Chef development kit. chef-vault allows the encryption of a data bag item by using the public keys of a list of nodes, allowing only those nodes to decrypt the encrypted values. chef-vault adds the ``knife vault`` subcommand.

* For more information about the knife subcommands, its arguments, and other uses, see https://github.com/chef/chef-vault
* For more information about using the ``chef-vault`` cookbook, its helper methods and resources, see https://github.com/chef-cookbooks/chef-vault

The ``chef-vault`` cookbook is maintained by Chef. Use it along with chef-vault itself. This cookbook adds the ``chef_vault_item`` helper method to the Recipe DSL and the ``chef_vault_secret`` resource. Use them both in recipes to work with data bag secrets.

.. warning:: 

   Chef vault is incompatible with the practice of using chef-client with a private key as ``client.pem`` and a certificate set as its public identity in the Chef server database. Chef vault requires the use of chef-client configured to use public/private key pairs. To update existing nodes to use chef-vault, first re-register your chef-client nodes with the Chef server, which will generate public/private key pairs, and then install Chef vault on each node. Chef vault will generate the following error if used with a chef-client with a private key as ``client.pem`` and a certificate set as its public identity in the Chef server database:

   .. code-block:: none

      OpenSSL::PKey::RSAError
      -----------------------
      Neither PUB key nor PRIV key:: nested asn1 error


Options for knife bootstrap
=====================================================
.. tag chef_vault_knife_bootstrap_options

Use the following options with a validatorless bootstrap to specify items that are stored in chef-vault:

``--bootstrap-vault-file VAULT_FILE``
   The path to a JSON file that contains a list of vaults and items to be updated.

``--bootstrap-vault-item VAULT_ITEM``
   A single vault and item to update as ``vault:item``.

``--bootstrap-vault-json VAULT_JSON``
   A JSON string that contains a list of vaults and items to be updated.

   .. tag knife_bootstrap_vault_json

   For example:

   .. code-block:: none

      --bootstrap-vault-json '{ "vault1": ["item1", "item2"], "vault2": "item2" }'

   .. end_tag

.. end_tag

For more information ...
=====================================================
For more information about chef-vault:

* `Joshua Timberman's blog post <https://www.chef.io/blog/2013/09/19/managing-secrets-with-chef-vault/>`_
