+++
title = "Chef Infra JSON and YAML recipes"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "JSON/YAML recipes"
    identifier = "chef_infra/cookbook_reference/recipes/YAML recipes"
    parent = "chef_infra/cookbook_reference/recipes"
    weight = 20
+++

{{< readfile file = "content/reusable/md/recipes_yaml_json_overview.md" >}}

For information about Ruby recipes, see the [Ruby recipe documentation]({{< relref "recipes" >}}).

## Support

We introduced YAML recipes in Chef Infra Client 16.0. We added support for YAML recipes with the `.yml` file extension in Infra Client 17.2.29. We added support for JSON recipes in Chef Infra Client 18.8.

## Create a JSON or YAML recipe

To create a JSON or YAML recipe, follow these steps:

1. Create a JSON or YAML file for your recipe in the same locations as Ruby recipes:

    - Standard recipe location:

      - `cookbooks/cookbook_name/recipes/default.yml`
      - `cookbooks/cookbook_name/recipes/default.yaml`
      - `cookbooks/cookbook_name/recipes/default.json`

    - Named recipes:

      - `cookbooks/cookbook_name/recipes/web.yml`
      - `cookbooks/cookbook_name/recipes/database.yaml`
      - `cookbooks/cookbook_name/recipes/app.json`

    - Root-level recipe alias (acts as the default recipe):

      - `cookbooks/cookbook_name/recipe.yml`
      - `cookbooks/cookbook_name/recipe.yaml`
      - `cookbooks/cookbook_name/recipe.json`

    {{< note >}}

    Creating more than one recipe with the same filename but different file extensions isn't supported. For example, `default.yaml` and `default.yml`.

    {{< /note >}}

1. Define your recipe with the top-level `resources` key containing an array of items where each item has the following:

    - `type`: The Chef resource type (string)
    - `name`: The resource name/identifier (string)
    - resource-specific actions and properties as key-value pairs

    For example:

    {{< foundation_tabs tabs-id="create-json-yaml-recipe-example" >}}
      {{< foundation_tab active="true" panel-link="create-yaml-recipe-example" tab-text="YAML">}}
      {{< foundation_tab panel-link="create-json-recipe-example" tab-text="JSON" >}}
    {{< /foundation_tabs >}}

    {{< foundation_tabs_panels tabs-id="create-json-yaml-recipe-example" >}}
      {{< foundation_tabs_panel active="true" panel-id="create-yaml-recipe-example" >}}

      ```yaml
      resources:
        - type: "package"
          name: "nginx"
          action: "install"
          version: "1.18.0"
        - type: "service"
          name: "nginx"
          action: ["enable", "start"]
      ```

      {{< /foundation_tabs_panel >}}

      {{< foundation_tabs_panel panel-id="create-json-recipe-example" >}}

      ```json
      {
          "resources": [
              {
                  "type": "package",
                  "name": "nginx",
                  "action": "install",
                  "version": "1.18.0"
              },
              {
                  "type": "service",
                  "name": "nginx",
                  "action": [
                      "enable",
                      "start"
                  ]
              }
          ]
      }
      ```

      {{< /foundation_tabs_panel >}}
    {{< /foundation_tabs_panels >}}

    In this example:

    - the [`package` resource]({{< relref "/resources/bundled/package/" >}}) uses the `install` action and the `version` property to install Nginx 1.18.0.
    - the [`service` resource]({{< relref "/resources/bundled/service/" >}}) uses the `enable` and `start` actions to enable and start Nginx.

## Examples

### Basic file management

Use the [`directory` resource]({{< relref "/resources/bundled/directory">}}) to create the `/opt/app_name` directory and apply owner and group permissions to the directory. Use the [`file` resource]({{< relref "/resources/bundled/">}}) to create the `/opt/app_name/config.txt` file, add text to the file, and apply file owner and group permissions to the file.

{{< foundation_tabs tabs-id="basic-file-management-json-yaml-recipe-example" >}}
  {{< foundation_tab active="true" panel-link="basic-file-management-yaml-recipe-example" tab-text="YAML">}}
  {{< foundation_tab panel-link="basic-file-management-json-recipe-example" tab-text="JSON" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="basic-file-management-json-yaml-recipe-example" >}}
{{< foundation_tabs_panel active="true" panel-id="basic-file-management-yaml-recipe-example" >}}

```yaml
---
resources:
  - type: "directory"
    name: "/opt/app_name"
    owner: "app_name"
    group: "app_name"
    mode: "0755"
    recursive: true

  - type: "file"
    name: "/opt/app_name/config.txt"
    content: "This is a configuration file"
    owner: "app_name"
    group: "app_name"
    mode: "0644"
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="basic-file-management-json-recipe-example" >}}

```json
{
    "resources": [
        {
            "type": "directory",
            "name": "/opt/app_name",
            "owner": "app_name",
            "group": "app_name",
            "mode": "0755",
            "recursive": true
        },
        {
            "type": "file",
            "name": "/opt/app_name/config.txt",
            "content": "This is a configuration file",
            "owner": "app_name",
            "group": "app_name",
            "mode": "0644"
        }
    ]
}
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

### Package and service management

Use the [`package` resource]({{< relref "/resources/bundled/package">}}) to install Nginx and curl. Then use the [`service` resource]({{< relref "/resources/bundled/service">}}) to enable and start Nginx.

{{< foundation_tabs tabs-id="package-service-management-json-yaml-recipe-example" >}}
  {{< foundation_tab active="true" panel-link="package-service-management-yaml-recipe-example" tab-text="YAML">}}
  {{< foundation_tab panel-link="package-service-management-json-recipe-example" tab-text="JSON" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="package-service-management-json-yaml-recipe-example" >}}
{{< foundation_tabs_panel active="true" panel-id="package-service-management-yaml-recipe-example" >}}

```yaml
---
resources:
  - type: "package"
    name: "nginx"
    action: "install"

  - type: "package"
    name: "curl"
    action: "install"

  - type: "service"
    name: "nginx"
    action: ["enable", "start"]
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="package-service-management-json-recipe-example" >}}

```json
{
    "resources": [
        {
            "type": "package",
            "name": "nginx",
            "action": "install"
        },
        {
            "type": "package",
            "name": "curl",
            "action": "install"
        },
        {
            "type": "service",
            "name": "nginx",
            "action": [
                "enable",
                "start"
            ]
        }
    ]
}
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

### User management

Use the [`group` resource]({{< relref "/resources/bundled/group">}}) to create a group called "developers" and the [`user` resource]({{< relref "/resources/bundled/">}}) to create a user, give them properties, and assign them to the developers group.

{{< foundation_tabs tabs-id="user-management-json-yaml-recipe-example" >}}
  {{< foundation_tab active="true" panel-link="user-management-yaml-recipe-example" tab-text="YAML">}}
  {{< foundation_tab panel-link="user-management-json-recipe-example" tab-text="JSON" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="user-management-json-yaml-recipe-example" >}}
{{< foundation_tabs_panel active="true" panel-id="user-management-yaml-recipe-example" >}}

```yaml
---
resources:
  - type: "group"
    name: "developers"
    gid: 3000

  - type: "user"
    name: "alice"
    uid: 2001
    gid: 3000
    home: "/home/alice"
    shell: "/bin/bash"
    action: "create"
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="user-management-json-recipe-example" >}}

```json
{
    "resources": [
        {
            "type": "group",
            "name": "developers",
            "gid": 3000
        },
        {
            "type": "user",
            "name": "alice",
            "uid": 2001,
            "gid": 3000,
            "home": "/home/alice",
            "shell": "/bin/bash",
            "action": "create"
        }
    ]
}
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

### Template with static variables

Use the [`template` resource]({{< relref "/resources/bundled/template">}}) create the `/etc/app_name/config.yml` file using the `config.yml.erb` template.

{{< foundation_tabs tabs-id="template-with-static-variables-json-yaml-recipe-example" >}}
  {{< foundation_tab active="true" panel-link="template-with-static-variables-yaml-recipe-example" tab-text="YAML">}}
  {{< foundation_tab panel-link="template-with-static-variables-json-recipe-example" tab-text="JSON" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="template-with-static-variables-json-yaml-recipe-example" >}}
{{< foundation_tabs_panel active="true" panel-id="template-with-static-variables-yaml-recipe-example" >}}

```yaml
---
resources:
  - type: "template"
    name: "/etc/app_name/config.yml"
    source: "config.yml.erb"
    owner: "root"
    group: "root"
    mode: "0644"
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="template-with-static-variables-json-recipe-example" >}}

```json
{
    "resources": [
        {
            "type": "template",
            "name": "/etc/app_name/config.yml",
            "source": "config.yml.erb",
            "owner": "root",
            "group": "root",
            "mode": "0644"
        }
    ]
}
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

### Guards

Some common resource functionality is also supported, as long as the value of a property can be expressed as one of the four primitive types (string, integer, boolean, array). That means it's possible to use [`only_if` or `not_if` guards]({{< relref "/resources/common_functionality/#guards" >}}) as long as they shell out to Bash or PowerShell and aren't passed a Ruby block.

For example, this is supported:

{{< foundation_tabs tabs-id="guards-json-yaml-recipe-example" >}}
  {{< foundation_tab active="true" panel-link="guards-yaml-recipe-example" tab-text="YAML">}}
  {{< foundation_tab panel-link="guards-json-recipe-example" tab-text="JSON" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="guards-json-yaml-recipe-example" >}}
{{< foundation_tabs_panel active="true" panel-id="guards-yaml-recipe-example" >}}

```yaml
resources:
- type: "directory"
  name: "/var/www/html"
  only_if: "which apache2"
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="guards-json-recipe-example" >}}

```json
{
    "resources": [
        {
            "type": "directory",
            "name": "/var/www/html",
            "only_if": "which apache2"
        }
    ]
}
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

Ruby blocks aren't supported:

```yaml
# Can't be expressed in YAML - Ruby blocks not supported
resources:
- type: "directory"
  name: "/var/www/html"
  only_if: "{ ::File.exist?('/usr/sbin/apache2') }"
```

## Convert a YAML recipe to Ruby

Use the `knife yaml convert` command to convert YAML recipes to Ruby:

```shell
knife yaml convert recipes/default.yml recipes/default.rb
```

Converting from Ruby to YAML or JSON isn't supported due to their limitations.

## YAML and JSON recipe limitations

Chef Infra YAML and JSON recipes have the following limitations.

### No Ruby code blocks

YAML and JSON recipes can't include Ruby code blocks, which limits their functionality compared to Ruby recipes:

```ruby
# Can't be expressed in YAML - Ruby blocks not supported
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  variables({
    worker_processes: node['cpu']['total']
  })
  notifies :restart, "service[nginx]", :delayed
  only_if { node['platform'] == 'ubuntu' }
end
```

### No conditional logic

YAML and JSON recipes can't include conditional logic like `if`, `unless`, `only_if`, or `not_if` with Ruby expressions:

```yaml
# Can't include complex conditionals
resources:
  - type: "package"
    name: "nginx"
    # Can't do: only_if { node['platform'] == 'ubuntu' }
```

### No node attribute access

YAML and JSON recipes can't directly access node attributes or perform Ruby evaluations:

```yaml
# Can't access node attributes dynamically
resources:
  - type: "user"
    name: "webapp"
    # Can't do: home "/home/#{node['webapp']['user']}"
    home: "/home/webapp"  # Must be static
```

### No resource notifications

YAML and JSON recipes can't express complex resource relationships and notifications:

```yaml
# Can't express notifications between resources
resources:
  - type: "template"
    name: "/etc/nginx/nginx.conf"
    source: "nginx.conf.erb"
    # Can't do: notifies :restart, "service[nginx]", :delayed
```

### No include or require functionality

YAML and JSON recipes can't include other recipes or libraries:

```yaml
# Can't include other recipes
# include_recipe "cookbook::other_recipe"
```

## Troubleshooting

### Missing `resources` key

Chef Infra Client returns this error if a recipe is missing the top-level `resources` hash.

```text
ArgumentError: YAML recipe 'recipes/default.yml' must contain a top-level 'resources' hash (YAML sequence), i.e. 'resources:'
```

### Single document limitation

YAML recipes support only one YAML document in each file. Multiple documents separated by `---` aren't allowed:

```yaml
---
resources:
  - type: "file"
    name: "/tmp/file1.txt"
---
resources:
  - type: "file"
    name: "/tmp/file2.txt"
```

Chef Infra Client returns the following error with multiple documents in one file:

```text
ArgumentError: YAML recipe 'recipes/default.yml' contains multiple documents, only one is supported
```

### Ambiguous file extensions

Chef Infra Client returns this error if two recipes have the same filename with different file extensions. For example, `default.yaml` and `default.yml`.

```text
Chef::Exceptions::AmbiguousYAMLFile: Found both default.yml and default.yaml in cookbook, update the cookbook to remove one
```
