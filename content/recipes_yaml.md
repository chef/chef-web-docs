+++
title = "About YAML Recipes"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = " YAML Recipes"
    identifier = "chef_infra/cookbook_reference/recipes/YAML Recipes"
    parent = "chef_infra/cookbook_reference/recipes"
    weight = 20
+++

YAML recipes provide an alternative way to define Chef Infra resources using YAML syntax instead of Ruby.
This feature was introduced to make Chef Infra recipes more accessible to users who are more comfortable with declarative YAML syntax than Ruby code.

YAML recipes provide a simplified way to define Chef resources for basic use cases. While they have significant limitations compared to Ruby recipes, they can be valuable for teams that prefer declarative YAML syntax and don't require advanced Chef DSL features. For complex scenarios involving dynamic logic, node attributes, or resource relationships, Ruby recipes remain the preferred approach.

For most production environments, a hybrid approach using both YAML recipes for simple static configurations and Ruby recipes for complex logic provides the best balance of simplicity and functionality.

## Basic Structure

YAML recipes must follow a specific structure:

```yaml
---
resources:
  - type: "resource_type"
    name: "resource_name"
    property1: value1
    property2: value2
  - type: "another_resource_type"
    name: "another_resource_name"
    property1: value1
    property2: value2
```

## File Naming and Location

YAML recipes can be placed in the same locations as Ruby recipes:

- **Standard recipe location**: `cookbooks/cookbook_name/recipes/default.yml` or `cookbooks/cookbook_name/recipes/default.yaml`
- **Named recipes**: `cookbooks/cookbook_name/recipes/web.yml` or `cookbooks/cookbook_name/recipes/database.yaml`
- **Root-level recipe alias**: `cookbooks/cookbook_name/recipe.yml` or `cookbooks/cookbook_name/recipe.yaml` (acts as default recipe)

### File Extension Support

Both `.yml` and `.yaml` extensions are supported. However, if both `default.yml` and `default.yaml` exist in the same cookbook, Chef will raise an `AmbiguousYAMLFile` error requiring you to remove one of them.

## Required Structure and Restrictions

### Top-Level Resources Hash

Every YAML recipe **must** contain a top-level `resources` key that contains an array of resource declarations:

```yaml
# ✅ CORRECT
---
resources:
  - type: "file"
    name: "/tmp/hello.txt"
    content: "Hello World"

# ❌ INCORRECT - Missing resources key
---
- type: "file"
  name: "/tmp/hello.txt"
  content: "Hello World"

# ❌ INCORRECT - Wrong structure
---
files:
  - type: "file"
    name: "/tmp/hello.txt"
    content: "Hello World"
```

### Resource Declaration Format

Each resource in the array must have:

- **`type`**: The Chef resource type (string)
- **`name`**: The resource name/identifier (string)
- **Additional properties**: Resource-specific properties as key-value pairs

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

### Single Document Limitation

YAML recipes support only **one YAML document** in each file. Multiple documents separated by `---` aren't allowed:

```yaml
# ❌ INCORRECT - Multiple documents not supported
---
resources:
  - type: "file"
    name: "/tmp/file1.txt"
---
resources:
  - type: "file"
    name: "/tmp/file2.txt"
```

## YAML recipe limitations

### No Ruby Code Blocks

YAML recipes can't contain Ruby code blocks, which significantly limits their functionality compared to Ruby recipes:

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

### No Conditional Logic

YAML recipes can't include conditional logic like `if`, `unless`, `only_if`, or `not_if` with Ruby expressions:

```yaml
# ❌ Cannot include complex conditionals
resources:
  - type: "package"
    name: "nginx"
    # Cannot do: only_if { node['platform'] == 'ubuntu' }
```

### No Node Attribute Access

YAML recipes can't directly access node attributes or perform Ruby evaluations:

```yaml
# ❌ Cannot access node attributes dynamically
resources:
  - type: "user"
    name: "webapp"
    # Cannot do: home "/home/#{node['webapp']['user']}"
    home: "/home/webapp"  # Must be static
```

### No Resource Notifications

Complex resource relationships and notifications can't be expressed:

```yaml
# ❌ Cannot express notifications between resources
resources:
  - type: "template"
    name: "/etc/nginx/nginx.conf"
    source: "nginx.conf.erb"
    # Cannot do: notifies :restart, "service[nginx]", :delayed
```

### No Include/Require Functionality

YAML recipes can't include other recipes or libraries:

```yaml
# ❌ Cannot include other recipes
# include_recipe "cookbook::other_recipe"
```

## Examples

### Basic File Management

```yaml
---
resources:
  - type: "directory"
    name: "/opt/myapp"
    owner: "myapp"
    group: "myapp"
    mode: "0755"
    recursive: true

  - type: "file"
    name: "/opt/myapp/config.txt"
    content: "This is a configuration file"
    owner: "myapp"
    group: "myapp"
    mode: "0644"
```

### Package and Service Management

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

### User Management

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

### Template with Static Variables

```yaml
---
resources:
  - type: "template"
    name: "/etc/myapp/config.yml"
    source: "config.yml.erb"
    owner: "root"
    group: "root"
    mode: "0644"
    # Note: Variables must be static, can't use node attributes
```

## Working with YAML Recipes

### Converting Between Ruby and YAML

Chef provides a `knife yaml convert` command to convert YAML recipes to Ruby:

```powershell
knife yaml convert recipes/default.yml recipes/default.rb
```

**Note**: Converting from Ruby to YAML isn't supported due to the limitations of YAML format.

### File Processing

YAML recipes are processed by the `from_yaml_file` method in the `Chef::Recipe` class, which:

1. Validates the file exists and is readable
2. Checks for single document requirement
3. Parses YAML using safe loading
4. Validates the required `resources` structure
5. Converts to internal hash representation
6. Creates Chef resources using `declare_resource`

## Best Practices

### When to Use YAML Recipes

YAML recipes are best suited for:

- **Simple, static configurations**
- **Declarative resource management**
- **Teams preferring YAML over Ruby**
- **Basic infrastructure as code**

### When NOT to Use YAML Recipes

Avoid YAML recipes when you need:

- **Dynamic node attribute access**
- **Conditional logic**
- **Resource notifications**
- **Complex data transformations**
- **Integration with Ruby libraries**
- **Advanced Chef DSL features**

### Migration Strategy

1. Start with simple, static resources in YAML
2. Use Ruby recipes for complex logic
3. Consider hybrid approach: YAML for simple resources, Ruby for complex ones
4. Use `knife yaml convert` to understand Ruby equivalents

## Troubleshooting

Common errors when working with YAML recipes:

### Missing Resources Key

```text
ArgumentError: YAML recipe 'recipes/default.yml' must contain a top-level 'resources' hash (YAML sequence), i.e. 'resources:'
```

### Multiple Documents

```text
ArgumentError: YAML recipe 'recipes/default.yml' contains multiple documents, only one is supported
```

### Ambiguous File Extensions

```text
Chef::Exceptions::AmbiguousYAMLFile: Found both default.yml and default.yaml in cookbook, update the cookbook to remove one
```
