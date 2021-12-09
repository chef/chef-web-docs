+++
title = "Custom Resource Guide"
gh_repo = "chef-web-docs"
aliases = ["/custom_resources.html"]

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "Custom Resource Guide"
    identifier = "chef_infra/resources/custom_resources/custom_resources.md Custom Resources"
    parent = "chef_infra/resources/custom_resources"
    weight = 10
+++

Chef Infra Client ships with over 150 built-in resources for managing system configuration such as `directory`, `remote_file`, and `windows_firewall`. With Custom Resources you can extend the built-in capabilities of Chef Infra Client to create reusable resources for use anywhere in your infrastructure.

- Ship directly in cookbooks
- Leverage Chef Infra Client built-in resources and any additional custom Ruby code (if needed)
- Behave the same as existing built-in resoures in your recipes

## Syntax

The layout for a custom resource is:

```ruby
provides :resource_name

property :property_name, RubyType, default: 'value'

action :action_a do
 # a mix of built-in Chef Infra resources and Ruby
end

action :action_b do
 # a mix of built-in Chef Infra resources and Ruby
end
```

The first action listed is the default action.

## Write a Custom Resource

You'll write the code for a custom resource in a Ruby file and located in a cookbook's `/resources` directory (you need to generate the resource first). This code:

- Declares the properties of the custom resource
- Loads current state of properties for existing resources
- Defines each action the custom resource may take

### Generate a Custom Resource

{{% chef_generate_resource %}}

### Example Resource

This example `site` uses Chef Infra's built-in `file`, `service` and `package` resources, and includes `:create` and `:delete` actions. It also assumes the existence of a [custom httpd template]({{< relref "templates.md" >}}). The code in this custom resource is similar to a typical recipe because it uses built-in Chef Infra Client resources, with the addition of the property and actions definitions for this custom resource.

```ruby
provides :site

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

- `site` is the name of the custom resource. The `provides` statement makes the custom resource available for use recipes.
- `homepage` sets the default HTML for the `index.html` file with a default value of `'<h1>Hello world!</h1>'`
- the `action` block uses the built-in collection of resources to tell Chef Infra Client how to install Apache, start the service, and then create the contents of the file located at `/var/www/html/index.html`
- `action :create` is the default resource (because it is listed first); `action :delete` must be called specifically (because it is not the default action)

Once written, you can use a custom resource may be used in a recipe with the same syntax as Chef Infra Client built-in resources.

### Syntax

Call a resource in a recipe by its `resource_name`. For example:

## Learn More

Learn Chef interactive tutorial: [Extending Chef Infra: Custom Resources](https://learn.chef.io/courses/course-v1:chef+Infra201+Perpetual/about)

See the [Custom Resources Glossary](/glossary_resources) for a description of available methods.
