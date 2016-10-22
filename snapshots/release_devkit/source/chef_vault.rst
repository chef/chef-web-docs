.. THIS PAGE IS IDENTICAL TO docs.chef.io/chef_vault.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef-vault
=====================================================

chef-vault is a RubyGems package that is included in the Chef development kit. chef-vault allows the encryption of a data bag item by using the public keys of a list of nodes, allowing only those nodes to decrypt the encrypted values. chef-vault adds the ``knife vault`` subcommand. 

* For more information about the knife subcommands, its arguments, and other uses, see https://github.com/chef/chef-vault
* For more information about using the ``chef-vault`` cookbook, its helper methods and resources, see https://github.com/chef-cookbooks/chef-vault

The ``chef-vault`` cookbook is maintained by Chef. Use it along with chef-vault itself. This cookbook adds the ``chef_vault_item`` helper method to the Recipe DSL and the ``chef_vault_secret`` resource. Use them both in recipes to work with data bag secrets.

Options for knife bootstrap
=====================================================
.. include:: ../../includes_chef_vault/includes_chef_vault_knife_bootstrap_options.rst

For more information ...
=====================================================
For more information about chef-vault:

* `Joshua Timberman's blog post <https://www.chef.io/blog/2013/09/19/managing-secrets-with-chef-vault/>`_
