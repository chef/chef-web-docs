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

{{< readFile_shortcode file="resource_execute_use_search_dsl_method.md" >}}
