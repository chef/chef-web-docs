+++
title = "Converting Definitions to Custom Resources"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Migrating from Definitions"
    identifier = "chef_infra/cookbook_reference/custom_resources/definitions"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 40
+++

## Migrating from Definitions to Custom Resources

The definitions feature in Chef Infra has been deprecated and will be removed in a future release. Please migrate existing definitions to Custom Resources.

This guide describes how to migrate from an existing Definition to a Custom Resource.

If you are creating a Custom Resource from scratch please see the [Custom Resource Getting Started Guide](getting-started.md) instead.

## Definitions

A definition behaved like a compile-time macro that was reusable across
recipes. A definition was typically created by wrapping arbitrary code
around Chef Infra resources that were declared as if they were in a
recipe. A definition was then used in one (or more) actual recipes as if
the definition were a resource.

Though a definition looks like a resource, and at first glance seems
like it could be used interchangeably, some important differences exist.
Definitions:

- Are not true resources
- Are processed when resource collection is compiled, not when a node
  is converged
- Do not support common resource properties, such as `notifies`, `compile_time`,
  `subscribes`, `only_if`, `not_if`, and `sensitive`
- Do not support input validation in passed arguments, unlike a
  resource which supports validation with properties
- Do not support `why-run` mode
- Cannot report to Chef Automate
- Cannot be tested with ChefSpec
- Some Definition parameters have known bugs, and will not be fixed

## Syntax

A definition had four components:

- A resource name
- Zero or more arguments that define parameters and their default values;
  if a default value was not specified, it was assumed to be `nil`
- A hash that could have been used within a definition's body to
  provide access to parameters and their values
- The body of the definition

The basic syntax of a definition was:

```ruby
define :my_definition_name do
  body
end
```

More commonly, the usage incorporated arguments to the definition:

```ruby
define :my_definition_name, parameter: :argument, parameter: :argument do
  body(likely referencing the params hash)
end
```

The following simple example shows a definition with no arguments (a
parameterless macro in the truest sense):

```ruby
define :prime_myfile do
  file '/etc/myfile' do
    content 'some content'
  end
end
```

An example showing the use of parameters, with a parameter named `port`
that defaults to `4000` rendered into a **template** resource, would
look like:

```ruby
define :prime_myfile, port: 4000 do
   template '/etc/myfile' do
     source 'myfile.erb'
     variables({
       port: params[:port],
     })
   end
end
```

Or the following definition, which looks like a resource when used in a
recipe, but also contained **directory** and **file** resources that
were repeated, but with slightly different parameters:

```ruby
define :host_porter, port: 4000, hostname: nil do
  params[:hostname] ||= params[:name]

  directory '/etc/#{params[:hostname]}' do
    recursive true
  end

  file '/etc/#{params[:hostname]}/#{params[:port]}' do
    content 'some content'
  end
end
```

which was then used in a recipe like this:

```ruby
host_porter node['hostname'] do
  port 4000
end

host_porter 'www1' do
  port 4001
end
```

## Migrating to Custom Resources

We highly recommend migrating existing definitions to custom resources
to unlock the full feature set of Chef Infra resources. The following
example shows a definition and that same definition rewritten as a
custom resource.

### Initial Definition Code

The following definition processes unique hostnames and ports, passed on
as parameters:

```ruby
define :host_porter, port: 4000, hostname: nil do
  params[:hostname] ||= params[:name]

  directory '/etc/#{params[:hostname]}' do
    recursive true
  end

  file '/etc/#{params[:hostname]}/#{params[:port]}' do
    content 'some content'
  end
end
```

### Migrated to a Custom Resource

The definition is improved by rewriting it as a custom resource. This
uses properties to accept input and has a single `:create` action:

```ruby
property :port, Integer, default: 4000
property :hostname, String, name_property: true

action :create do
  directory "/etc/#{hostname}" do
    recursive true
  end

  file "/etc/#{hostname}/#{port}" do
    content 'some content'
  end
end
```

Once written, a custom resource may be used in a recipe just like any
resource that is built into Chef Infra. A custom resource gets its name
from the cookbook and the name of its file in the `/resources` directory
with an underscore (`_`) separating them. For example, a cookbook named
`host` with a custom resource file named `porter.rb` in the `/resources`
directory would be called `host_porter`. Use it in a recipe like this:

```ruby
host_porter node['hostname'] do
  port 4000
end
```

or:

```ruby
host_porter 'www1' do
  port 4001
end
```
