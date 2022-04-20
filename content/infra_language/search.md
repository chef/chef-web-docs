+++
title = "Chef Infra Language: Search"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Search"
    identifier = "chef_infra/infra_language/search.md Search"
    parent = "chef_infra/infra_language"
+++

## search

{{% search %}}

Use the `search` method to perform a search query against the Chef Infra Server from within a recipe.

The syntax for the `search` method is as follows:

```ruby
search(:index, 'query')
```

where:

- `:index` is of name of the index on the Chef Infra Server against which the search query will run: `:client`, `:data_bag_name`, `:environment`, `:node`, and `:role`
- `'query'` is a valid search query against an object on the Chef Infra Server (see below for more information about how to build the query)

For example, using the results of a search query within a variable:

```ruby
webservers = search(:node, 'role:webserver')
```

and then using the results of that query to populate a template:

```ruby
template '/tmp/list_of_webservers' do
  source 'list_of_webservers.erb'
  variables(:webservers => webservers)
end
```

### :filter_result

{{% infra_lang_method_search_filter_result %}}

### Query Syntax

{{% search_query_syntax %}}

#### Keys

{{% search_key %}}

#### Nested Fields

{{% search_key_nested %}}

#### Patterns

{{% search_pattern %}}

#### Exact Match

{{% search_pattern_exact %}}

#### Wildcard Match

{{% search_pattern_wildcard %}}

#### Range Match

{{% search_pattern_range %}}

#### Fuzzy Match

{{% search_pattern_fuzzy %}}

#### Operators

{{% search_boolean_operators %}}

#### Special Characters

{{% search_special_characters %}}

### Examples

The following examples show how the `search` method can be used in a recipe.

#### Use the search helper to find users

The following example shows how to use the `search` method in the Recipe
DSL to search for users:

```ruby
#  the following code sample comes from the openvpn cookbook: https://github.com/chef-cookbooks/openvpn

search("users", "*:*") do |u|
  execute "generate-openvpn-#{u['id']}" do
    command "./pkitool #{u['id']}"
    cwd '/etc/openvpn/easy-rsa'
    environment(
      'EASY_RSA' => '/etc/openvpn/easy-rsa',
      'KEY_CONFIG' => '/etc/openvpn/easy-rsa/openssl.cnf',
      'KEY_DIR' => node['openvpn']['key_dir'],
      'CA_EXPIRE' => node['openvpn']['key']['ca_expire'].to_s,
      'KEY_EXPIRE' => node['openvpn']['key']['expire'].to_s,
      'KEY_SIZE' => node['openvpn']['key']['size'].to_s,
      'KEY_COUNTRY' => node['openvpn']['key']['country'],
      'KEY_PROVINCE' => node['openvpn']['key']['province'],
      'KEY_CITY' => node['openvpn']['key']['city'],
      'KEY_ORG' => node['openvpn']['key']['org'],
      'KEY_EMAIL' => node['openvpn']['key']['email']
    )
    not_if { File.exist?("#{node['openvpn']['key_dir']}/#{u['id']}.crt") }
  end

  %w{ conf ovpn }.each do |ext|
    template "#{node['openvpn']['key_dir']}/#{u['id']}.#{ext}" do
      source 'client.conf.erb'
      variables :username => u['id']
    end
  end

  execute "create-openvpn-tar-#{u['id']}" do
    cwd node['openvpn']['key_dir']
    command <<-EOH
      tar zcf #{u['id']}.tar.gz \
      ca.crt #{u['id']}.crt #{u['id']}.key \
      #{u['id']}.conf #{u['id']}.ovpn \
    EOH
    not_if { File.exist?("#{node['openvpn']['key_dir']}/#{u['id']}.tar.gz") }
  end
end
```

where

- the search will use both of the **execute** resources, unless the
    condition specified by the `not_if` commands are met
- the `environments` property in the first **execute** resource is
    being used to define values that appear as variables in the OpenVPN
    configuration
- the **template** resource tells Chef Infra Client which template to
    use

