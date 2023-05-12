+++
title = "Chef Infra Language: Reading Data Bags"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Reading Data Bags"
    identifier = "chef_infra/infra_language/reading_data_bags.md Reading Data Bags"
    parent = "chef_infra/infra_language"
+++

## data_bag

{{< readfile file="content/reusable/md/data_bag.md" >}}

Use the `data_bag` method to get a list of the contents of a data bag.

The syntax for the `data_bag` method is as follows:

```ruby
data_bag(bag_name)
```

### Examples

The following example shows how the `data_bag` method can be used in a recipe.

#### Get a data bag, and then iterate through each data bag item

{{< readfile file="content/reusable/md/infra_lang_data_bag.md" >}}

## data_bag_item

{{< readfile file="content/reusable/md/data_bag.md" >}}

The `data_bag_item` method can be used in a recipe to get the contents of a data bag item.

The syntax for the `data_bag_item` method is as follows:

```ruby
data_bag_item(bag_name, item, secret)
```

where `secret` is the secret used to load an encrypted data bag. If `secret` is not specified, Chef Infra Client looks for a secret at the path specified by the `encrypted_data_bag_secret` setting in the `client.rb` file.

### Examples

The following examples show how the `data_bag_item` method can be used in a recipe.

#### Get a data bag, and then iterate through each data bag item

{{< readfile file="content/reusable/md/infra_lang_data_bag.md" >}}

#### Use the contents of a data bag in a recipe

The following example shows how to use the `data_bag` and `data_bag_item` methods in a recipe, also using a data bag named `sea-power`):

```ruby
package 'sea-power' do
  action :install
end

directory node['sea-power']['base_path'] do
  # attributes for owner, group, mode
end

gale_warnings = data_bag('sea-power').map do |viking_north|
  data_bag_item('sea-power', viking_north)['source']
end

template '/etc/seattle/power.list' do
  source 'seattle-power.erb'
  # attributes for owner, group, mode
  variables(
    :base_path => node['sea-power']['base_path'],
    # more variables
    :repo_location => gale_warnings
  )
end
```
