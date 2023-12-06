+++
title = "About Data Bags"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/data_bags.html", "/secrets.html", "/secrets/", "/essentials_data_bags.html"]
product = ["client", "server"]

[menu]
  [menu.infra]
    title = "Data Bags"
    identifier = "chef_infra/policyfiles/data_bags.md Data Bags"
    parent = "chef_infra/policyfiles"
    weight = 40
+++

{{< readfile file="content/reusable/md/data_bag.md" >}}

## Create a data bag

You can create a data bag in two ways: using knife or manually.
We recommend using knife, but as long as you create the data bag folders and item JSON files correctly,
either method is safe and effective.

### Create a data bag with knife

Use the `knife data bag create` command to create data bags and data bag items.
For example:

```bash
knife data bag create DATA_BAG_NAME (DATA_BAG_ITEM)
```

Use the `from file` arguement to update data bag items:

```bash
knife data bag from file BAG_NAME ITEM_NAME.json
```

As long as a file is in the correct directory structure, knife will be
able to find the data bag and data bag item with only the name of the
data bag and data bag item. For example:

```bash
knife data bag from file BAG_NAME ITEM_NAME.json
```

will load the following file:

```plain
data_bags/BAG_NAME/ITEM_NAME.json
```

Continuing the example above, if you are in the "admins" directory and
make changes to the file charlie.json, then to upload that change to the
Chef Infra Server use the following command:

```bash
knife data bag from file admins charlie.json
```

In some cases, such as when knife is not being run from the root
directory for the chef-repo, the full path to the data bag item may be
required. For example:

```bash
knife data bag from file BAG_NAME /path/to/file/ITEM_NAME.json
```

### Manually

One or more data bags and data bag items can be created manually under
the `data_bags` directory in the chef-repo. Any method can be used to
create the data bag folders and data bag item JSON files. For example:

```bash
mkdir data_bags/admins
```

would create a data bag folder named "admins". The equivalent command
for using knife is:

```bash
knife data bag create admins
```

A data bag item can be created manually in the same way as the data bag,
but by also specifying the file name for the data bag item (this example
is using vi, a visual editor for UNIX):

```bash
vi data_bags/admins/charlie.json
```

would create a data bag item named "charlie.json" under the "admins"
sub-directory in the `data_bags` directory of the chef-repo. The
equivalent command for using knife is:

```bash
knife data bag create admins charlie
```

## Store data in a data bag

When the chef-repo is cloned from GitHub, the following occurs:

- A directory named `data_bags` is created.
- For each data bag, a sub-directory is created that has the same name
    as the data bag.
- For each data bag item, a JSON file is created and placed in the
    appropriate sub-directory.

The `data_bags` directory can be placed under version source control.

When deploying from a private repository using a data bag, use the
`deploy_key` option to ensure the private key is present:

```ruby
{
  'id': 'my_app',
  ... (truncated) ...
  'deploy_key': 'ssh_private_key'
}
```

where `ssh_private_key` is the same SSH private key as used with a
private git repository and the new lines converted to `\n`.

### Directory structure

All data bags are stored in the `data_bags` directory of the chef-repo.
This directory structure is understood by knife so that the full path
does not need to be entered when working with data bags from the command
line. An example of the `data_bags` directory structure:

```text
. chef-repo
└── data_bags
    ├── README.md
    ├─── admins
    │    ├── README.md
    │    ├── charlie.json
    │    ├── bob.json
    │    └── tom.json
    ├─── db_users
    │    ├── README.md
    │    ├── charlie.json
    │    ├── bob.json
    │    └── sarah.json
    └─── db_config
         ├── README.md
         ├── small.json
         ├── medium.json
         └── large.json
```

where `admins`, `db_users`, and `db_config` are the names of individual
data bags and all the files that end with `.json` are the individual
data bag items.

### Data bag items

{{< readfile file="content/reusable/md/data_bag_item.md" >}}

## Encrypt a data bag item

{{< readfile file="content/reusable/md/data_bag_encryption.md" >}}

### Encryption versions

The manner by which a data bag item is encrypted depends on the Chef
Infra Client version used. See the following:

|Infra Client version|Encryption v0|Encryption v1|Encryption v2|Encryption v3|
|:--|:---:|:---:|:---:|:---:|
|10.x|`R` `W`||||
|11.0+|`R`|`R` `W`|||
|11.6+|`R` `D`|`R` `D`|`R` `W`||
|13.0|`R` `D`|`R` `D`|`R` `D`|`R` `W`|

`R` = read
`W` = write
`D` = disable

#### Version 0

Chef Infra Client 0.10+

- Uses YAML serialization format to encrypt data bag items
- Uses Base64 encoding to preserve special characters
- Uses AES-256-CBC encryption, as defined by the OpenSSL package in the Ruby Standard Library
- [Shared secret encryption](https://en.wikipedia.org/wiki/Symmetric-key_algorithm); an encrypted file can only be decrypted by a node or a user with the same shared secret
- Recipes load encrypted data with access to the shared secret in a file on the node or from a URI path
- Decrypts only data bag item values. Keys are encrypted but searchable
- Data bag `id` value is unencrypted for tracking data bag items

#### Version 1

Chef Infra Client 11.0+

- Version 0
- Uses JSON serialization format _instead of_ YAML to encrypt data bag items
- Adds random initialization vector encryption for each value to protect against cryptanalysis

#### Version 2

Chef Infra Client 11.6+

- Version 1
- Option to disable versions 0 and 1
- Adds Encrypt-then-MAC(EtM) protection

#### Version 3

Chef Infra Client 13.0+

- Option to  disable version 0, 1, and 2

### Knife options

knife can encrypt and decrypt data bag items when the `knife data bag`
subcommand is run with the `create`, `edit`, `from file`, or `show`
arguments and the following options:

| Option             | Description                                                   |
|--------------------|-------------------------------------------------------------|
| `--secret SECRET`    | The encryption key that's used for values contained within a data bag item. If `secret` is not specified, Chef Infra Client looks for a secret at the path specified by the `encrypted_data_bag_secret` setting in the client.rb file. |
| `--secret-file FILE` | The path to the file that contains the encryption key.           |

### Secret keys

{{< readfile file="content/reusable/md/data_bag_encryption_secret_key.md" >}}

### Encrypt

A data bag item is encrypted using a knife command similar to:

```bash
knife data bag create passwords mysql --secret-file /tmp/my_data_bag_key
```

where "passwords" is the name of the data bag, "mysql" is the name of
the data bag item, and "/tmp/my_data_bag_key" is the path to the
location in which the file that contains the secret-key is located.
knife will ask for user credentials before the encrypted data bag item
is saved.

### Verify encryption

When the contents of a data bag item are encrypted, they will not be
readable until they are decrypted. Encryption can be verified with a
knife command similar to:

```bash
knife data bag show passwords mysql
```

where "passwords" is the name of the data bag and "mysql" is the name of
the data bag item. This will return something similar to:

```bash
id:   mysql
pass:
cipher:         aes-256-cbc
encrypted_data: JZtwXpuq4Hf5ICcepJ1PGQohIyqjNX6JBc2DGpnL2WApzjAUG9SkSdv75TfKSjX4
iv:             VYY2qx9b4r3j0qZ7+RkKHg==
version:        1
user:
cipher:         aes-256-cbc
encrypted_data: 10BVoNb/plkvkrzVdybPgFFII5GThZ3Op9LNkwVeKpA=
iv:             uIqKHZ9skJlN2gpJoml6rQ==
version:        1
```

### Decrypt

An encrypted data bag item is decrypted with a knife command similar to:

```bash
knife data bag show --secret-file /tmp/my_data_bag_key passwords mysql
```

that will return JSON output similar to:

```json
{
  "id": "mysql",
  "pass": "thesecret123",
  "user": "fred"
}
```

## Edit a data bag item

A data bag can be edited in two ways: using knife or by using the Chef
management console.

### Edit a data bag with knife

{{< readfile file="content/workstation/reusable/md/knife_data_bag_edit.md" >}}

{{< readfile file="content/workstation/reusable/md/knife_data_bag_edit_item.md" >}}

## Use data bags

Data bags can be accessed in the following ways:

### Search

{{< readfile file="content/reusable/md/data_bag.md" >}}

{{< readfile file="content/reusable/md/search_data_bag.md" >}}

### Environments

Values that are stored in a data bag are global to the organization and
are available to any environment. There are two main strategies that can
be used to store shared environment data within a data bag: by using a
top-level key that corresponds to the environment or by using separate
items for each environment.

A data bag stores a top-level key for an environment might look
something like this:

```json
{
  "id": "some_data_bag_item",
  "production" : {
    # Hash with all your data here
  },
  "testing" : {
    # Hash with all your data here
  }
}
```

When using the data bag in a recipe, that data can be accessed from a
recipe using code similar to:

```ruby
data_bag_item[node.chef_environment]['some_other_key']
```

The other approach is to use separate items for each environment.
Depending on the amount of data, it may all fit nicely within a single
item. If this is the case, then creating different items for each
environment may be a simple approach to providing shared environment values
within a data bag. However, this approach is more time-consuming and may
not scale to large environments or when the data must be stored in
many data bag items.

### Recipes

Data bags can be accessed by a recipe in the following ways:

- Loaded by name when using the Chef Infra Language. Use this approach when a
    only single, known data bag item is required.
- Accessed through the search indexes. Use this approach when more
    than one data bag item is required or when the contents of a data
    bag are looped through. The search indexes will bulk-load all of the
    data bag items, which will result in a lower overhead than if each
    data bag item were loaded by name.

#### Load with Chef Infra Language

The Chef Infra Language provides access to data bags and data bag items
(including encrypted data bag items) with the following methods:

- `data_bag(bag)`, where `bag` is the name of the data bag.
- `data_bag_item('bag_name', 'item', 'secret')`, where `bag` is the
    name of the data bag and `item` is the name of the data bag item. If
    `'secret'` is not specified, Chef Infra Client will look for a
    secret at the path specified by the `encrypted_data_bag_secret`
    setting in the client.rb file.

The `data_bag` method returns an array with a key for each of the data
bag items that are found in the data bag.

Some examples:

To load the secret from a file:

```ruby
data_bag_item('bag', 'item', IO.read('secret_file'))
```

To load a single data bag item named `admins`:

```ruby
data_bag('admins')
```

The contents of a data bag item named `justin`:

```ruby
data_bag_item('admins', 'justin')
```

will return something similar to:

```ruby
# => {'comment'=>'Justin Currie', 'gid'=>1005, 'id'=>'justin', 'uid'=>1005, 'shell'=>'/bin/zsh'}
```

If `item` is encrypted, `data_bag_item` will automatically decrypt it
using the key specified above, or (if none is specified) by the
`Chef::Config[:encrypted_data_bag_secret]` method, which defaults to
`/etc/chef/encrypted_data_bag_secret`.

#### Create and edit

Creating and editing the contents of a data bag or a data bag item from
a recipe is not recommended. The recommended method of updating a data
bag or a data bag item is to use knife and the `knife data bag`
subcommand. If this action must be done from a recipe, please note the
following:

- If two operations concurrently attempt to update the contents of a
    data bag, the last-written attempt will be the operation to update
    the contents of the data bag. This situation can lead to data loss,
    so organizations should take steps to ensure that only one Chef
    Infra Client is making updates to a data bag at a time.
- Altering data bags from the node when using the open source Chef
    Infra Server requires the node's API client to be granted admin
    privileges. In most cases, this is not advisable.

and then take steps to ensure that any subsequent actions are done
carefully. The following examples show how a recipe can be used to
create and edit the contents of a data bag or a data bag item using the
`Chef::DataBag` and `Chef::DataBagItem` objects.

To create a data bag from a recipe:

```ruby
users = Chef::DataBag.new
users.name('users')
users.create
```

To create a data bag item from a recipe:

```ruby
sam = {
  'id' => 'sam',
  'Full Name' => 'Sammy',
  'shell' => '/bin/zsh',
}
databag_item = Chef::DataBagItem.new
databag_item.data_bag('users')
databag_item.raw_data = sam
databag_item.save
```

To edit the contents of a data bag item from a recipe:

```ruby
sam = data_bag_item('users', 'sam')
sam['Full Name'] = 'Samantha'
sam.save
```

#### Create users

Chef Infra Client can create users on systems based on the contents of a
data bag. For example, a data bag named "admins" can contain a data bag
item for each of the administrators that will manage the various systems
that each Chef Infra Client is maintaining. A recipe can load the data
bag items and then create user accounts on the target system with code
similar to the following:

```ruby
# Load the keys of the items in the 'admins' data bag
admins = data_bag('admins')

admins.each do |login|
  # This causes a round-trip to the server for each admin in the data bag
  admin = data_bag_item('admins', login)
  homedir = '/home/#{login}'

  # for each admin in the data bag, make a user resource
  # to ensure they exist
  user(login) do
    uid admin['uid']
    gid admin['gid']
    shell admin['shell']
    comment admin['comment']
    home homedir
    manage_home true
  end
end

# Create an "admins" group on the system
# You might use this group in the /etc/sudoers file
# to provide sudo access to the admins
group 'admins' do
  gid '999'
  members 'admins'
end
```

### `chef-solo`

chef-solo can load data from a data bag as long as the contents of that
data bag are accessible from a directory structure that exists on the
same machine as chef-solo. The location of this directory is
configurable using the `data_bag_path` option in the solo.rb file. The
name of each sub-directory corresponds to a data bag and each JSON file
within a sub-directory corresponds to a data bag item. Search is not
available in recipes when they are run with chef-solo; use the
`data_bag()` and `data_bag_item()` functions to access data bags and
data bag items.

{{< note >}}

Use the `chef-solo-search` cookbook library (developed by Chef community
member "edelight" and available from GitHub) to add data bag search
capabilities to a chef-solo environment:
<https://github.com/edelight/chef-solo-search>.

{{< /note >}}
