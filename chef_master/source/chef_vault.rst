=====================================================
``chef-vault``
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_vault.rst>`__

``chef-vault`` is a RubyGems package that is included in the Chef development kit. ``chef-vault`` allows the encryption of a data bag item by using the public keys of a list of nodes, allowing only those nodes to decrypt the encrypted values. ``chef-vault`` adds the ``knife vault`` subcommand. 

.. note:: ``chef-vault`` does not currently support alternate keying mechanisms like GPG and Amazon KMS. 

* For more information about the knife subcommands, its arguments, and other uses, see https://github.com/chef/chef-vault
* For more information about using the ``chef-vault`` cookbook, its helper methods and resources, see https://github.com/chef-cookbooks/chef-vault

The ``chef-vault`` cookbook is maintained by Chef. Use it along with chef-vault itself. This cookbook adds the ``chef_vault_item`` helper method to the Recipe DSL and the ``chef_vault_secret`` resource. Use them both in recipes to work with data bag secrets.

.. warning:: 

   Chef vault requires the use of chef-client configured to use public/private key pairs. Chef vault is incompatible with the practice of using chef-client with a private key as ``client.pem`` and a certificate set as its public identity in the Chef server database. To update existing nodes to use chef-vault, first re-register your chef-client nodes with the Chef server, which will generate public/private key pairs, and then install Chef vault on each node. Chef vault will generate the following error if used with a chef-client with a private key as ``client.pem`` and a certificate set as its public identity in the Chef server database:

   .. code-block:: none

      OpenSSL::PKey::RSAError
      -----------------------
      Neither PUB key nor PRIV key:: nested asn1 error

INSTALLATION:
=====================================================
If you are installing ``chef-vault`` independently of the Chef Development Kit, then first verify that you have  the latest version Chef installed. Versions earlier than 0.10.0 don't support plugins:

.. code-block:: shell

    gem install chef

This plugin is distributed as a Ruby Gem. To install it, run:

.. code-block:: shell

    gem install chef-vault

Depending on your system's configuration, you may need to run this command
with root privileges.

``knife vault`` commands
=====================================================

### knife.rb

To set 'client' as the default mode, add the following line to the knife.rb file.

.. code-block:: shell

      knife[:vault_mode] = 'client'

To set the default list of admins for creating and updating vaults, add the following line to the knife.rb file.

.. code-block:: shell
      
      knife[:vault_admins] = [ 'example-alice', 'example-bob', 'example-carol' ]

(These values can be overridden on the command line by using ``-A``)

knife examples
-------------------------------------------------------

The syntax for ``knife vault`` commands is: 

.. code-block:: shell
   
   knife vault SUBCOMMAND VAULT ITEM VALUES

These are the commands that are used to take data in JSON format and encrypt that data into chef-vault style encrypted data bags in chef.

* ``vault`` - This is the name of the vault in which to store the encrypted item.  This is analogous to a chef data bag name
* ``item`` - The name of the item going in to the vault.  This is analogous to a chef data bag item id
* ``values`` - This is the JSON clear text data to be stored in the vault encrypted.  This is analogous to a chef data bag item data

vault commands
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### create
Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for clients role:webserver, client1 & client2 and admins admin1 & admin2

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -C "client1,client2" -A "admin1,admin2"

Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for clients role:webserver and admins admin1 & admin2

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -A "admin1,admin2"

Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for clients role:webserver, client1 & client2

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -C "client1,client2"

Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for clients role:webserver

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver"

Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for clients client1 & client2

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -C "client1,client2"

Create a vault called passwords and put an item called root in it with the given values for username and password encrypted for admins admin1 & admin2

    knife vault create passwords root '{"username": "root", "password": "mypassword"}' -A "admin1,admin2"

Create a vault called passwords and put an item called root in it encrypted for admins admin1 & admin2.  *Leaving the data off the command-line will pop an editor to fill out the data*

    knife vault create passwords root -A "admin1,admin2"

Note: A JSON file can be used in place of specifying the values on the command line, see global options below for details

update
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Update the values in username and password in the vault passwords and item root.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}'

Update the values in username and password in the vault passwords and item root and add role:webserver, client1 & client2 to the encrypted clients and admin1 & admin2 to the encrypted admins.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -C "client1,client2" -A "admin1,admin2"

Update the values in username and password in the vault passwords and item root and add role:webserver to the encrypted clients and admin1 & admin2 to the encrypted admins.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -A "admin1,admin2"

Update the values in username and password in the vault passwords and item root and add role:webserver to the encrypted clients.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver"

Update the values in username and password in the vault passwords and item root and add client1 & client2 to the encrypted clients.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}' -C "client1,client2"

Update the values in username and password in the vault passwords and item root and add admin1 & admin2 to the encrypted admins.  Will overwrite existing values if values already exist!

    knife vault update passwords root '{"username": "root", "password": "mypassword"}' -A "admin1,admin2"

Add role:webserver to encrypted clients for the vault passwords and item root.

    knife vault update passwords root -S "role:webserver"

Add client1 & client2 to encrypted clients for the vault passwords and item root.

    knife vault update passwords root -C "client1,client2"

Add admin1 & admin2 to encrypted admins for the vault passwords and item root.

    knife vault update passwords root -A "admin1,admin2"

Add admin1 & admin2 to encrypted admins and role:webserver, client1 & client2 to encrypted clients for the vault passwords and item root.

    knife vault update passwords root -S "role:webserver" -C "client1,client2" -A "admin1,admin2"

Add admin1 & admin2 to encrypted admins and role:webserver to encrypted clients for the vault passwords and item root.

    knife vault update passwords root -S "role:webserver" -A "admin1,admin2"

Add admin1 & admin2 to encrypted admins and client1 & client2 to encrypted clients for the vault passwords and item root.

    knife vault update passwords root -C "client1,client2" -A "admin1,admin2"

Note: A JSON file can be used in place of specifying the values on the command line, see global options below for details

remove
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Remove the values in username and password from the vault passwords and item root.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}'

Remove the values in username and password from the vault passwords and item root and remove role:webserver, client1 & client2 from the encrypted clients and admin1 & admin2 from the encrypted admins.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -C "client1,client2" -A "admin1,admin2"

Remove the values in username and password from the vault passwords and item root and remove role:webserver from the encrypted clients and admin1 & admin2 from the encrypted admins.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver" -A "admin1,admin2"

Remove the values in username and password from the vault passwords and item root and remove client1 & client2 from the encrypted clients and admin1 & admin2 from the encrypted admins.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -C "client1,client2" -A "admin1,admin2"

Remove the values in username and password from the vault passwords and item root and remove role:webserver from the encrypted clients.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -S "role:webserver"

Remove the values in username and password from the vault passwords and item root and remove client1 & client2 from the encrypted clients.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -C "client1,client2"

Remove the values in username and password from the vault passwords and item root and remove admin1 & admin2 from the encrypted admins.

    knife vault remove passwords root '{"username": "root", "password": "mypassword"}' -A "admin1,admin2"

Remove admin1 & admin2 from encrypted admins and role:webserver, client1 & client2 from encrypted clients for the vault passwords and item root.

    knife vault remove passwords root -S "role:webserver" -C "client1,client2" -A "admin1,admin2"

Remove admin1 & admin2 from encrypted admins and role:webserver from encrypted clients for the vault passwords and item root.

    knife vault remove passwords root -S "role:webserver" -A "admin1,admin2"

Remove role:webserver from encrypted clients for the vault passwords and item root.

    knife vault remove passwords root -S "role:webserver"

Remove client1 & client2 from encrypted clients for the vault passwords and item root.

    knife vault remove passwords root -C "client1,client2"

Remove admin1 & admin2 from encrypted admins for the vault passwords and item root.

    knife vault remove passwords root -A "admin1,admin2"

delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Delete the item root from the vault passwords

    knife vault delete passwords root

show
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++


knife vault show VAULT [ITEM] [VALUES]
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

These are the commands that are used to decrypt a chef-vault encrypted item and show the requested values.

* ``vault`` - This is the name of the vault in which to store the encrypted item.  This is analogous to a chef data bag name
* ``item`` - The name of the item going in to the vault.  This is analogous to a chef data bag item id
* ``values`` - This is a comma list of values to decrypt from the vault item.  This is analogous to a list of hash keys.

Show the items in a vault

    knife vault show passwords

Show the entire root item in the passwords vault and print in JSON format.

    knife vault show passwords root -Fjson

Show the entire root item in the passwords vault and print in JSON format, including the search query, clients, and admins.

    knife vault show passwords root -Fjson -p all

Show the username and password for the item root in the vault passwords.

    knife vault show passwords root "username, password"

Show the contents for the item user_pem in the vault certs.

    knife vault show certs user_pem "contents"

edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

knife vault edit VAULT ITEM

These are the commands that are used to edit a chef-vault encrypted item.

* Vault - This is the name of the vault in which to store the encrypted item.  This is analogous to a chef data bag name
* Item - The name of the item going in to the vault.  This is analogous to a chef data bag item id

Decrypt the entire root item in the passwords vault and open it in json format in your $EDITOR.  Writing and exiting out the editor will save and encrypt the vault item.

    knife vault edit passwords root

download
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Decrypt and download an encrypted file to the specified path.

    knife vault download certs user_pem ~/downloaded_user_pem

rotate keys
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Rotate the shared key for the vault passwords and item root. The shared key is that which is used for the chef encrypted data bag item.

    knife vault rotate keys passwords root

To remove clients which have been deleted from Chef but not from the vault, add the --clean-unknown-clients switch:

    knife vault rotate keys passwords root --clean-unknown-clients

rotate all keys
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Rotate the shared key for all vaults and items. The shared key is that which is used for the chef encrypted data bag item.

    knife vault rotate all keys

To remove clients which have been deleted from Chef but not from the vault, add the --clean-unknown-clients switch:

    knife vault rotate keys passwords root --clean-unknown-clients

refresh
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This command reads the search_query in the vault item, performs the search, and reapplies the results.

    knife vault refresh VAULT ITEM

To remove clients which have been deleted from Chef but not from the vault, add the --clean-unknown-clients switch:

    knife vault refresh passwords root --clean-unknown-clients

isvault
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This command checks if the given item is a vault or not, and exit with a status of 0 if it is and 1 if it is not.

    knife vault isvault VAULT ITEM

itemtype
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This command outputs the type of the data bag item: normal, encrypted or vault

    knife vault itemtype VAULT ITEM

global options
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Short | Long | Description | Default | Valid Values | Sub-Commands
------|------|-------------|---------|--------------|-------------
-M MODE | --mode MODE | Chef mode to run in. Can be set in knife.rb | solo | solo, client | all
-S SEARCH | --search SEARCH | Chef Server SOLR Search Of Nodes | | | create, remove , update
-A ADMINS | --admins ADMINS | Chef clients or users to be vault admins, can be comma list | | | create, remove, update
-J FILE | --json FILE | JSON file to be used for values, will be merged with VALUES if VALUES is passed | | | create, update
| --file FILE | File that chef-vault should encrypt.  It adds "file-content" & "file-name" keys to the vault item | | | create, update
-p DATA | --print DATA | Print extra vault data | | search, clients, admins, all | show
-F FORMAT | --format FORMAT | Format for decrypted output | summary | summary, json, yaml, pp | show
| --clean-unknown-clients | Remove unknown clients during key rotation | | | refresh, remove, rotate



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

## USAGE IN RECIPES

To use this gem in a recipe to decrypt data you must first install the gem
via a chef_gem resource. Once the gem is installed require the gem and then
you can create a new instance of ChefVault.

NOTE: chef-vault 1.0 style decryption is supported, however it has been
deprecated and chef-vault 2.0 decryption should be used instead

### Example Code

    chef_gem 'chef-vault' do
      compile_time true if respond_to?(:compile_time)
    end

    require 'chef-vault'

    item = ChefVault::Item.load("passwords", "root")
    item["password"]

Note that in this case, the gem needs to be installed at compile time
because the require statement is at the top-level of the recipe.  If
you move the require of chef-vault and the call to `::load` to
library or provider code, you can install the gem in the converge phase
instead.

### Specifying an alternate node name or client key path

Normally, the value of `Chef::Config[:node_name]` is used to find the
per-node encrypted secret in the keys data bag item, and the value of
`Chef::Config[:client_key]` is used to locate the private key to decrypt
this secret.

These can be overridden by passing a hash with the keys `:node_name` or
`:client_key_path` to `ChefVault::Item.load`:

    item = ChefVault::Item.load(
      'passwords', 'root',
      node_name: 'service_foo',
      client_key_path: '/secure/place/service_foo.pem'
    )
    item['password']

The above example assumes that you have transferred
`/secure/place/service_foo.pem` to your system via a secure channel.

This usage allows you to decrypt a vault using a key shared among several
nodes, which can be helpful when working in cloud environments or other
configurations where nodes are created dynamically.

### chef_vault_item helper

The [chef-vault cookbook](https://supermarket.chef.io/cookbooks/chef-vault)
contains a recipe to install the chef-vault gem and a helper method
`chef_vault_helper` which makes it easier to test cookbooks that use
chef-vault using Test Kitchen.

## DETERMINING IF AN ITEM IS A VAULT

ChefVault provides a helper method to determine if a data bag item is a vault,
which can be helpful if you produce a recipe for community consumption and want
to support both normal data bags and vaults:

    if ChefVault::Item.vault?('passwords', 'root')
      item = ChefVault::Item.load('passwords', 'root')
    else
      item = Chef::DataBagItem.load('passwords', 'root')
    end

This functionality is also available from the command line as `knife vault isvault VAULT ITEM`.

## DETERMINING THE TYPE OF A DATA BAG ITEM

ChefVault provides a helper method to determine the type of a data bag item.
It returns one of the symbols :normal, :encrypted or :vault

    case ChefVault::Item.data_bag_item_type('passwords', 'root')
    when :normal
      ...
    when :encrypted
      ...
    when :vault
      ...
    end

This functionality is also available from the command line as `knife vault itemtype VAULT ITEM`.

## USAGE STAND ALONE

`chef-vault` can be used as a stand alone binary to decrypt values stored in
Chef. It requires that Chef is installed on the system and that you have a
valid knife.rb. This is useful if you want to mix `chef-vault` into non-Chef
recipe code, for example some other script where you want to protect a
password.

It does still require that the data bag has been encrypted for the user's or
client's pem and pushed to the Chef server. It mixes Chef into the gem and
uses it to go grab the data bag.

Use `chef-vault --help` to see all all available options

### Example usage (password)

    chef-vault -v passwords -i root -a password -k /etc/chef/knife.rb

## TESTING

To stub vault items in ChefSpec, use the
[chef-vault-testfixtures](https://rubygems.org/gems/chef-vault-testfixtures)
gem.

To fall back to unencrypted JSON files in Test Kitchen, use the
`chef_vault_item` helper in the aforementioned chef-vault cookbook.

For more information ...
=====================================================
For more information about chef-vault:

* `Joshua Timberman's blog post <https://www.chef.io/blog/2013/09/19/managing-secrets-with-chef-vault/>`_
