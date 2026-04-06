+++
title = "About Roles"
draft = false

[menu]
  [menu.policy]
    title = "Roles"
    identifier = "policy/roles.md Roles"
    parent = "policy"
    weight = 70
+++
<!-- markdownlint-disable-file MD033 -->
{{< readfile file="content/reusable/md/role.md" >}}

## Role Attributes

{{< note >}}

{{< readfile file="content/reusable/md/notes_see_attributes_overview.md" >}}

{{< /note >}}

{{< readfile file="content/reusable/md/role_attribute.md" >}}

### Attribute types

There are two types of attributes that can be used with roles:

`default`
: {{< readfile file="content/reusable/md/node_attribute_type_default.md" >}}

`override`
: {{< readfile file="content/reusable/md/node_attribute_type_override.md" >}}

## Role formats

Role data is stored in two formats: as a Ruby file that contains
domain-specific language or as JSON data.

### Chef Language

{{< readfile file="content/reusable/md/ruby_summary.md" >}}

Domain-specific Ruby attributes:

`default_attributes`
: Optional. A set of attributes to be applied to all nodes, assuming the node doesn't already have a value for the attribute. This is useful for setting global defaults that can then be overridden for specific nodes. If more than one role attempts to set a default value for the same attribute, the last role applied is the role to set the attribute value. When nested attributes are present, they're preserved. For example, to specify that a node that has the attribute `apache2` should listen on ports 80 and 443 (unless ports are already specified):

  ```ruby
  default_attributes 'apache2' => {
    'listen_ports' => [ '80', '443' ]
  }
  ```

`description`
: A description of the functionality that's covered. For example:

  ```ruby
  description 'The base role for systems that serve HTTP traffic'
  ```

`env_run_lists`
: Optional. A list of environments, each specifying a recipe or a role to be applied to that environment. This setting must specify the `_default` environment. If the `_default` environment is set to `[]` or `nil`, then the run-list is empty. For example:

  ```ruby
  env_run_lists 'prod' => ['recipe[apache2]'],
                'staging' => ['recipe[apache2::staging]'
  ```

  {{< warning >}}

  Using `env_run_lists` with roles is discouraged as it can be difficult to maintain over time. Instead, consider using multiple roles to define the required behavior.

  {{< /warning >}}

`name`
: A unique name within the organization. Each name must be made up of letters (uppercase and lowercase), numbers, underscores, and hyphens: Spaces aren't allowed. For example:

  ```ruby
  name 'dev01-24'
  ```

`override_attributes`
: Optional. A set of attributes to be applied to all nodes, even if the node already has a value for an attribute. This is useful for ensuring that certain attributes always have specific values. If more than one role attempts to set an override value for the same attribute, the last role applied wins. When nested attributes are present, they're preserved. For example:

  ```ruby
  override_attributes 'apache2' => {
    'max_children' => '50'
  }
  ```

  The parameters in a Ruby file are Ruby method calls, so parentheses can be used to provide clarity when specifying numerous or deeply-nested attributes. For example:

  ```ruby
  override_attributes(
    :apache2 => {
      :prefork => { :min_spareservers => '5' }
    }
  )
  ```

  Or:

  ```ruby
  override_attributes(
    :apache2 => {
      :prefork => { :min_spareservers => '5' }
    },
    :tomcat => {
      :worker_threads => '100'
    }
  )
  ```

`run_list`
: A list of recipes and/or roles to be applied and the order in which they're to be applied. For example, the following run-list:

  ```ruby
  run_list 'recipe[apache2]',
           'recipe[apache2::mod_ssl]',
           'role[monitor]'
  ```

  would apply the `apache2` recipe first, then the `apache2::mod_ssl` recipe, and then the `role[monitor]` recipe.

Each role must be saved as a Ruby file in the `roles/` subdirectory of
the chef-repo. (If the repository doesn't have this subdirectory, then
create it using knife.) Each Ruby file should have the `.rb` suffix. A
complete role has the following syntax:

```ruby
name "role_name"
description "role_description"
run_list "recipe[name]", "recipe[name::attribute]", "recipe[name::attribute]"
env_run_lists "name" => ["recipe[name]"], "environment_name" => ["recipe[name::attribute]"]
default_attributes "node" => { "attribute" => [ "value", "value", "etc." ] }
override_attributes "node" => { "attribute" => [ "value", "value", "etc." ] }
```

where both default and override attributes are optional and at least one
run-list (with at least one run-list item) is specified. For example, a
role named `webserver` that has a run-list that defines actions for
three different roles, and for certain roles takes extra steps (such as
the `apache2` role listening on ports 80 and 443):

```ruby
name "webserver"
description "The base role for systems that serve HTTP traffic"
run_list "recipe[apache2]", "recipe[apache2::mod_ssl]", "role[monitor]"
env_run_lists "prod" => ["recipe[apache2]"], "staging" => ["recipe[apache2::staging]"], "_default" => []
default_attributes "apache2" => { "listen_ports" => [ "80", "443" ] }
override_attributes "apache2" => { "max_children" => "50" }
```

### JSON

The JSON format for roles maps directly to the domain-specific Ruby
format: same settings, attributes, and values, and a similar structure
and organization. For example:

```json
{
  "name": "webserver",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "default_attributes": {
    "apache2": {
      "listen_ports": [
        "80",
        "443"
      ]
    }
  },
  "description": "The base role for systems that serve HTTP traffic",
  "run_list": [
    "recipe[apache2]",
    "recipe[apache2::mod_ssl]",
    "role[monitor]"
  ],
  "env_run_lists" : {
    "production" : [],
    "preprod" : [],
    "dev": [
      "role[base]",
      "recipe[apache]",
      "recipe[apache::copy_dev_configs]",
    ],
    "test": [
      "role[base]",
      "recipe[apache]"
    ]
  },
  "override_attributes": {
    "apache2": {
      "max_children": "50"
    }
  }
}
```

The JSON format has two additional settings:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Setting</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>chef_type</code></td>
<td>Always set this to <code>role</code>. Use this setting for any custom process that consumes role objects outside of Ruby.</td>
</tr>
<tr>
<td><code>json_class</code></td>
<td>Always set this to <code>Chef::Role</code>. The Chef Infra Client uses this setting to auto inflate a role object. If objects are being rebuilt outside of Ruby, ignore it.</td>
</tr>
</tbody>
</table>

## Manage Roles

There are several ways to manage roles:

- knife can be used to create, edit, view, list, tag, and delete
    roles.
- The Chef Infra Client can be used to manage role data using the
    command line and JSON files (that contain a hash, the elements of
    which are added as role attributes). In addition, the `run_list`
    setting allows roles and/or recipes to be added to the role.
- The open source Chef Infra Server can be used to manage role data
    using the command line and JSON files (that contain a hash, the
    elements of which are added as role attributes). In addition, the
    `run_list` setting allows roles and/or recipes to be added to the
    role.
- The Chef Infra Server API can be used to create and manage roles
    directly, although using knife directly is the most common way to manage roles.
- The command line can also be used with JSON files and third-party
    services, such as Amazon EC2, where the JSON files can contain
    metadata for each instance stored in a file on-disk and then read by
    chef-solo or Chef Infra Client as required.

By creating and editing files using the Chef Language (Ruby) or JSON, you can dynamically generate role data. Roles created and edited
using files are compatible with all versions of Chef, including
chef-solo. Roles created and edited using files can be kept in version
source control, which also keeps a history of what changed when. When
roles are created and edited using files, they shouldn't be managed
using knife, as changes will be
overwritten.

A run-list that's associated with a role can be edited using the Chef
management console add-on. The canonical source of a role's data is
stored on Chef Infra Server, which means that keeping role data in
version source control can be challenging.

If roles are created and managed using knife and then arbitrarily updated
uploaded through JSON data, that action will overwrite the previous work with knife.
It's strongly recommended to keep to one process and not switch back and forth.

### Set Run-lists for Environments

Associating a run-list with a role and a specific environment lets you use the run-list on different nodes that share the same environment. More than one environment can be specified in a role, but each specific environment may be associated with only one run-list. If a run-list isn't specified, the default run-list will be used. For example:

```json
{
  "name": "webserver",
  "default_attributes": {
  },
  "json_class": "Chef::Role",
  "env_run_lists": {
    "production": [],
    "preprod": [],
    "test": [ "role[base]", "recipe[apache]", "recipe[apache::copy_test_configs]" ],
    "dev": [ "role[base]", "recipe[apache]", "recipe[apache::copy_dev_configs]" ]
    },
  "run_list": [ "role[base]", "recipe[apache]" ],
  "description": "The webserver role",
  "chef_type": "role",
  "override_attributes": {
  }
}
```

where:

- `webserver` is the name of the role
- `env_run_lists` is a hash of environment run-lists for
    `production`, `preprod`, `test`, and `dev`
- `production` and `preprod` use the default run-list because they do
    not have a shared environment run-list
- `run_list` defines the default run-list

### Delete from Run-list

When an environment is deleted, it will remain within a run-list for a
role until it's removed from that run-list. If a new environment is
created that has an identical name to an environment that was deleted, a
run-list that contains an old environment name will use the new one.
