+++
title = "About YAML recipes"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "YAML recipes"
    identifier = "chef_infra/cookbook_reference/recipes/YAML recipes"
    parent = "chef_infra/cookbook_reference/recipes"
    weight = 20
+++

YAML recipes let you define Chef Infra resources using YAML syntax instead of Ruby. This feature makes Chef Infra recipes more accessible to users who prefer declarative YAML syntax over Ruby code.

YAML recipes simplify defining Chef resources for basic use cases. While they have significant limitations compared to Ruby recipes, they're valuable for teams that prefer YAML syntax and don't need advanced Chef DSL features. For complex scenarios involving dynamic logic, node attributes, or resource relationships, use Ruby recipes.

For most production environments, use a hybrid approach: YAML recipes for simple static configurations and Ruby recipes for complex logic. This approach balances simplicity and functionality.

## Create a YAML recipe

To create a YAML recipe, follow these steps:

1. Create a YAML file for your recipe in the same locations as Ruby recipes:

    - Standard recipe location:
      - `cookbooks/cookbook_name/recipes/default.yml`
      - `cookbooks/cookbook_name/recipes/default.yaml`
    - Named recipes:
      - `cookbooks/cookbook_name/recipes/web.yml`
      - `cookbooks/cookbook_name/recipes/database.yaml`
    - Root-level recipe alias (acts as the default recipe):
      - `cookbooks/cookbook_name/recipe.yml`
      - `cookbooks/cookbook_name/recipe.yaml`

    Chef Infra supports YAML recipes with both `.yml` and `.yaml` extensions.

1. Define your recipe with a top-level `resources` key containing an array of resources where each item has the following:

    - `type`: The Chef resource type (string)
    - `name`: The resource name/identifier (string)
    - resource-specific actions and properties as key-value pairs

    For example:

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

    In this example:

    - the [`package` resource]({{< relref "/resources/package/" >}}) uses the `install` action and the `version` property to install Nginx 1.18.0.
    - the [`service` resource]({{< relref "/resources/service/" >}}) uses the `enable` and `start` actions to enable and start Nginx.

## Examples

### Basic file management

Use the [`directory` resource]({{< relref "/resources/directory">}}) to create the `/opt/app_name` directory and apply owner and group permissions to the directory. Use the [`file` resource]({{< relref "/resources/">}}) to create the `/opt/app_name/config.txt` file, add text to the file, and apply file owner and group permissions to the file.

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

### Package and service management

Use the [`package` resource]({{< relref "/resources/package">}}) to install Nginx and curl. Then use the [`service` resource]({{< relref "/resources/service">}}) to enable and start Nginx.

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

### User management

Use the [`group` resource]({{< relref "/resources/group">}}) to create a group called "developers" and the [`user` resource]({{< relref "/resources/">}}) to create a user, give them properties, and assign them to the developers group.

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

### Template with static variables

Use the [`template` resource]({{< relref "/resources/template">}}) create the `/etc/app_name/config.yml` file using the `config.yml.erb` template.

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

### Guards

Some common resource functionality is also supported, as long as the value of a property can be expressed as one of the four primitive types (string, integer, boolean, array). That means it's possible to use [`only_if` or `not_if` guards]({{< relref "/resource_common#guards" >}}) as long as they shell out to Bash or PowerShell and aren't passed a Ruby block.

For example, this is supported:

```yaml
resources:
- type: "directory"
  name: "/var/www/html"
  only_if: "which apache2"
```

Ruby blocks aren't supported:

```yaml
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

Converting from Ruby to YAML isn't supported due to YAML's limitations.

## YAML recipe limitations

Chef Infra YAML recipes have the following limitation.

### No Ruby code blocks

YAML recipes can't include Ruby code blocks, which limits their functionality compared to Ruby recipes:

```ruby
# ❌ Cannot be expressed in YAML - Ruby blocks not supported
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

YAML recipes can't include conditional logic like `if`, `unless`, `only_if`, or `not_if` with Ruby expressions:

```yaml
# ❌ Cannot include complex conditionals
resources:
  - type: "package"
    name: "nginx"
    # Cannot do: only_if { node['platform'] == 'ubuntu' }
```

### No node attribute access

YAML recipes can't directly access node attributes or perform Ruby evaluations:

```yaml
# ❌ Cannot access node attributes dynamically
resources:
  - type: "user"
    name: "webapp"
    # Cannot do: home "/home/#{node['webapp']['user']}"
    home: "/home/webapp"  # Must be static
```

### No resource notifications

YAML recipes can't express complex resource relationships and notifications:

```yaml
# ❌ Cannot express notifications between resources
resources:
  - type: "template"
    name: "/etc/nginx/nginx.conf"
    source: "nginx.conf.erb"
    # Cannot do: notifies :restart, "service[nginx]", :delayed
```

### No include or require functionality

YAML recipes can't include other recipes or libraries:

```yaml
# ❌ Cannot include other recipes
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
