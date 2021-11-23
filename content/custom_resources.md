+++
title = "About Custom Resources"
gh_repo = "chef-web-docs"
aliases = ["/custom_resources.html"]

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "Custom Resources"
    identifier = "chef_infra/resources/custom_resources/custom_resources.md Custom Resources"
    parent = "chef_infra/resources/custom_resources"
    weight = 10
+++

A custom resource:

- Extends Chef Infra Client with your own resources
- Runs as part of a cookbook
- Leverages Chef Infra Client resources and and additional custom Ruby code (if needed)
- Is reusable in the same way as resources that are built into Chef Infra Client

For example, Chef Infra Client includes built-in resources to manage files, packages, templates, and services, but it does not include a resource that manages websites.

## Syntax

A custom resource is defined as a Ruby file and is located in a cookbook's `/resources` directory. This file:

- Declares the properties of the custom resource
- Loads current state of properties, if the resource already exists
- Defines each action the custom resource may take

The layout for a custom resource is:

```ruby
property :property_name, RubyType, default: 'value'

action :action_a do
 # a mix of built-in Chef Infra resources and Ruby
end

action :action_b do
 # a mix of built-in Chef Infra resources and Ruby
end
```

The first action listed is the default action.

### Example Resource

This example `site` utilizes Chef Infra's built-in `file`, `service` and `package` resources, and includes `:create` and `:delete` actions. Since it uses built-in Chef Infra Client resources, besides defining the property and actions, the code is similar to that of a recipe.

```ruby
property :homepage, String, default: '<h1>Hello world!</h1>'

action :create do
  package 'httpd'

  service 'httpd' do
    action [:enable, :start]
  end

  file '/var/www/html/index.html' do
    content new_resource.homepage
  end
end

action :delete do
  package 'httpd' do
    action :remove
  end

  file '/var/www/html/index.html' do
    action :delete
  end
end
```

where

- the `homepage` sets the default HTML for the `index.html` file with a default value of `'<h1>Hello world!</h1>'`
- the `action` block uses the built-in collection of resources to tell Chef Infra Client how to install Apache, start the service, and then create the contents of the file located at `/var/www/html/index.html`
- the `action :create` is the default resource (because it is listed first); `action :delete` must be called specifically (because it is not the default action)

Once written, the custom resource may be used in a recipe just like any of the resources that are built into Chef Infra Client.

### Syntax

The name of a custom resource is derived from the cookbook name and the custom resource filename.

```rb
<cookbook name>_<filename>
```

For example, a cookbook named `exampleco` with a custom resource named `site.rb` is used in a recipe like this:

```ruby
exampleco_site 'httpd' do
  homepage '<h1>Welcome to the Example Co. website!</h1>'
end
```

This example uses the `delete` action from the custom resource `site.rb` in the `exampleco`:

```ruby
exampleco_site 'httpd' do
  action :delete
end
```

## Additional resources

Learn Chef interactive tutorial: [Extending Chef Infra: Custom Resources](https://learn.chef.io/courses/course-v1:chef+Infra201+Perpetual/about)

See the [Custom Resources Glossary](/glossary_resources) for a description of available methods.
