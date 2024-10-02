+++
title = "Custom resource guide"
gh_repo = "chef-web-docs"
aliases = ["/custom_resources.html"]

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "Custom resource guide"
    identifier = "chef_infra/resources/custom_resources/custom_resources.md custom resources"
    parent = "chef_infra/resources/custom_resources"
    weight = 10
+++

Chef Infra Client ships with over 150 [built-in resources](/resources/) for managing system configuration such as `directory`, `remote_file`, and `windows_firewall`.
With custom resources you can extend the built-in capabilities of Chef Infra Client to create reusable resources for use anywhere in your infrastructure.

Custom resources:

- Ship directly in cookbooks.
- Leverage Chef Infra Client built-in resources and any additional custom Ruby code (if needed).
- Behave the same as existing built-in resources in your recipes.

## Write a custom resource

Custom resources are written in Ruby and defined in a cookbook's `/resources` directory.

The custom resource code:

- Declares the properties of the custom resource.
- Loads the current state of properties for existing resources.
- Defines each action that the custom resource may take.

Follow these steps to create a new custom resource:

1. Generate a new custom resource.

    The `resources` directory does not exist by default in a cookbook.
    Generate the `resources` directory and a resource file from the `chef-repo/cookbooks` directory with the command:

    ```bash
    chef generate resource <PATH_TO_COOKBOOK> <RESOURCE_NAME>
    ```

    For example, this command generates a `site` custom resource in the `custom_web` cookbook:

    ```bash
    chef generate resource cookbooks/custom_web site
    ```

    The `custom_web` cookbook directory with a custom resource has the following structure:

    ```text
    . cookbooks
    └── custom_web
        ├── CHANGELOG.md
        ├── LICENSE
        ├── Policyfile.rb
        ├── README.md
        ├── chefignore
        ├── kitchen.yml
        ├── metadata.rb
        ├── recipes
        │   └── default.rb
        ├── resources
        │   └── site.rb
        └── test
            └── integration
                └── default
                    └── default_test.rb
    ```

1. Define the custom resources.

    The layout for a custom resource is:

    ```ruby
    provides :resource_name

    property :property_name, RubyType, default: 'value'

    action :an_action_name do
    # a mix of built-in Chef Infra resources and Ruby
    end

    action :another_action_name do
    # a mix of built-in Chef Infra resources and Ruby
    end
    ```

    The first action listed is the default action.

    For more details on the contents of a custom resource, see the [custom resource glossary]({{< relref "custom_resource_glossary" >}}).

1. Add the custom resource to a recipe.

    Call a resource in a recipe by its resource name. For example:

    ```ruby
    resource_name 'foo'
    ```

## Example custom resource

This example creates a custom resource called `site`, which uses Chef Infra's built-in `file`, `service` and `package` resources, and includes `:create` and `:delete` actions.
It also assumes the existence of a [custom httpd template]({{< relref "templates.md" >}}).
The code in this custom resource is similar to a typical recipe because it uses built-in Chef Infra Client resources, with the addition of the property and actions definitions for this custom resource.

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

where:

- `site` is the name of the custom resource. The `provides` statement makes the custom resource available for use recipes.
- `homepage` sets the default HTML for the `index.html` file with a default value of `'<h1>Hello world!</h1>'`
- the `action` block uses the built-in collection of resources to tell Chef Infra Client how to install Apache, start the service, and then create the contents of the file located at `/var/www/html/index.html`
- `action :create` is the default resource (because it is listed first); `action :delete` must be called specifically (because it is not the default action)

Once written, you can use a custom resource in a recipe with the same syntax as Chef Infra Client built-in resources.

### Syntax

To add a custom resource to a recipe, call it by its resource name. For example, this adds a the `site` resource:

```ruby
site 'foo'
```

## Learn more

See these resources to learn more about custom resources:

- See the LearnChef interactive tutorial: [Extending Chef Infra: Custom Resources](https://www.chef.io/training/tutorials).
- For a description of available methods, see the [custom resources glossary]({{< relref "custom_resource_glossary" >}}).
- For running resources in Unified Mode, see the [Unified Mode documentation]({{< relref "unified_mode" >}}).
