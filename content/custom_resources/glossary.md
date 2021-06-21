+++
title = "Custom Resources Glossary"
gh_repo = "chef-web-docs"
aliases = ["/custom_resource_glossary.html"]

[menu]
  [menu.infra]
    title = "Glossary"
    identifier = "chef_infra/cookbook_reference/custom_resources/glossary"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 100
+++

## Chef Infra Client Custom Resources Glossary

The following __Domain Specific Language (DSL)__ methods are available when writing Custom Resources.

For further information about how to write custom resources please see [about custom resources](/custom_resources/about)

## action_class

`action_class` makes methods available to all actions within a single custom resource.

### Example

You have a template that requires `'yes'` or `'no'` written as a String, but you would like the user to use `true` or `false` for convenience. To allow both the `:add` and `:remove` actions to have access to this method, place the method in the `action_class` block.

```ruby
property :example, [true, false], default: true

action :add do
  template "file.conf" do
    source 'file.conf.erb'
    variables(
      chocolate: bool_to_string(new_resource.example)
    )
    action :create
  end
end

action :remove do
  template "file.conf" do
    source 'file.conf.erb'
    variables(
      chocolate: bool_to_string(new_resource.example)
    )
    action :delete
  end
end

action_class do
  def bool_to_string(b)
    b ? 'yes' : 'false'
  end
end
```

## converge_if_changed

Use the `converge_if_changed` method inside an `action` block in a
custom resource to compare the desired property values against the
current property values (as loaded by the `load_current_value` method).
Use the `converge_if_changed` method to ensure that updates only occur
when property values on the system are not the desired property values
and to otherwise prevent a resource from being converged.

To use the `converge_if_changed` method, wrap it around the part of a
recipe or custom resource that should only be converged when the current
state is not the desired state:

```ruby
action :some_action do
  converge_if_changed do
    # some property
  end
end
```

The `converge_if_changed` method may be used multiple times. The
following example shows how to use the `converge_if_changed` method to
compare the multiple desired property values against the current
property values (as loaded by the `load_current_value` method).

```ruby
property :path, String
property :content, String
property :mode, String

# Load the current value for content and mode
load_current_value do |new_resource|
  if ::File.exist?(new_resource.path)
    content IO.read(new_resource.path)
    mode ::File.stat(new_resource.path).mode
  end
end

action :create do

  # If the value of content has changed
  # write file
  converge_if_changed :content do
    IO.write(new_resource.path, new_resource.content)
  end

  # If the value of mode has changed then
  # chmod file
  converge_if_changed :mode do
    ::File.chmod(new_resource.mode, new_resource.path)
  end
end
```

Chef Infra Client will only update the property values that require
updates and will not make changes when the property values are already
in the desired state.

## default_action

The default action in a custom resource is, by default, the first action
listed in the custom resource. For example, action `aaaaa` is the
default resource:

```ruby
property :property_name, RubyType, default: 'value'

...

action :aaaaa do
 # the first action listed in the custom resource
end

action :bbbbb do
 # the second action listed in the custom resource
end
```

The `default_action` method may also be used to specify the default
action. For example:

```ruby
property :property_name, RubyType, default: 'value'

# Define bbbbb aas the default action
default_action :bbbbb

action :aaaaa do
 # the first action listed in the custom resource
end

action :bbbbb do
 # the second action listed in the custom resource
end
```

## load_current_value

Use the `load_current_value` method to load the specified property
values from the node, and then use those values when the resource is
converged. This method may take a block argument.

```ruby
property :path, String
property :content, String
property :mode, String

load_current_value do |new_resource|
  if ::File.exist?(new_resource.path)
    content IO.read(new_resource.path)
    mode ::File.stat(new_resource.path).mode
  end
end
```

Use the `load_current_value` method to guard against property value being replaced. For example:

```ruby
property :homepage, String
property :page_not_found, String

load_current_value do
  if ::File.exist?('/var/www/html/index.html')
    homepage IO.read('/var/www/html/index.html')
  end

  if ::File.exist?('/var/www/html/404.html')
    page_not_found IO.read('/var/www/html/404.html')
  end
end
```

This ensures the values for `homepage` and `page_not_found` are not
changed to the default values when Chef Infra Client configures the
node.

## current_value_does_not_exist!

When using the `load_current_value` block, use `current_value_does_not_exist!` to indicate that the value does not exist and that `current_resource` should therefore be `nil`.

```ruby
load_current_value do
  current_value_does_not_exist!
end
```

## new_resource.property

Custom resources are designed to use core resources that are built into Chef Infra. In some cases, it may be necessary to specify a property in the
custom resource that is the same as a property in a core resource, for the purpose of overriding that property when used with the custom
resource. It is still consider good practise to use `new_resource.property_name` to access the correct value.

For example:

```ruby
property :command, String, name_property: true
property :version, String

# Useful properties from the `execute` resource
property :cwd, String
property :environment, Hash, default: {}
property :user, [String, Integer]
property :sensitive, [true, false], default: false

prefix = '/opt/languages/node'

load_current_value do
  current_value_does_not_exist! if node.run_state['nodejs'].nil?
  version node.run_state['nodejs'][:version]
end

action :run do
  execute 'execute-node' do
    cwd cwd
    environment environment
    user user
    sensitive sensitive
    # gsub replaces 10+ spaces at the beginning of the line with nothing
    command <<-CODE.gsub(/^ {10}/, '')
      #{prefix}/#{new_resource.version}/#{command}
    CODE
  end
end
```

The following properties are identical to the properties in the execute resource, which we are embededing in the custom resource.

- `property :cwd`
- `property :environment`
- `property :user`
- `property :sensitive`

Because both the custom properties and the **execute** properties are identical, this
will result in an error message similar to:

```ruby
ArgumentError
-------------
wrong number of arguments (0 for 1)
```

To prevent this behavior, use `new_resource.` to tell Chef Infra Client
to process the properties from the core resource instead of the
properties in the custom resource. For example:

```ruby
property :command, String, name_property: true
property :version, String

# Useful properties from the `execute` resource
property :cwd, String
property :environment, Hash, default: {}
property :user, [String, Integer]
property :sensitive, [true, false], default: false

prefix = '/opt/languages/node'

load_current_value do
  current_value_does_not_exist! if node.run_state['nodejs'].nil?
  version node.run_state['nodejs'][:version]
end

action :run do
  execute 'execute-node' do
    cwd new_resource.cwd
    environment new_resource.environment
    user new_resource.user
    sensitive new_resource.sensitive
    # gsub replaces 10+ spaces at the beginning of the line with nothing
    command <<-CODE.gsub(/^ {10}/, '')
      #{prefix}/#{new_resource.version}/#{new_resource.command}
    CODE
  end
end
```

where:

- `cwd new_resource.cwd`
- `environment new_resource.environment`
- `user new_resource.user`
- `sensitive new_resource.sensitive`

correctly use the properties of the **execute** resource and not the identically-named override properties of the custom resource.

## property

Use the `property` method to define properties for the custom resource.
The syntax is:

```ruby
property :property_name, ruby_type, default: 'value', parameter: 'value'
```

where

- `:property_name` is the name of the property
- `ruby_type` is the optional Ruby type or array of types, such as
  `String`, `Integer`, `true`, or `false`
- `default: 'value'` is the optional default value loaded into the
  resource
- `parameter: 'value'` optional parameters

For example, the following properties define `username` and `password`
properties with no default values specified:

```ruby
property :username, String
property :password, String
```

## ruby_type

The property ruby_type is a positional parameter.

Use to ensure a property value is of a particular ruby class, such as:

- `true`
- `false`
- `nil`
- `String`
- `Array`
- `Hash`
- `Integer`
- `Symbol`

Use an array of Ruby classes to allow a value to be of more than one type. For example:

```ruby
property :aaaa, String
property :bbbb, Integer
property :cccc, Hash
property :dddd, [true, false]
property :eeee, [String, nil]
property :ffff, [Class, String, Symbol]
property :gggg, [Array, Hash]
```

## sensitive


A property can be marked sensitive by specifying `sensitive: true` on
the property. This prevents the contents of the property from being
exported to data collection and sent to an Automate server.

## validators

{{ dsl/property_validation_parameter }}

## desired_state

Add `desired_state:` to set the desired state property for a resource.

| Allowed values | Default |
| -------------- | ------- |
| `true` `false` | `true`  |

- When `true`, the state of the property is determined by the state of
  the system
- When `false`, the value of the property impacts how the resource
  executes, but it is not determined by the state of the system.

For example, if you were to write a resource to create volumes on a
cloud provider you would need define properties such as `volume_name`,
`volume_size`, and `volume_region`. The state of these properties would
determine if your resource needed to converge or not. For the resource
to function you would also need to define properties such as
`cloud_login` and `cloud_password`. These are necessary properties for
interacting with the cloud provider, but their state has no impact on
decision to converge the resource or not, so you would set
`desired_state` to `false` for these properties.

```ruby
property :volume_name, String
property :volume_size, Integer
property :volume_region, String
property :cloud_login, String, desired_state: false
property :cloud_password, String, desired_state: false
```

## identity

{{< note >}}

The `identity` setting is kept for backwards compatability. It is no longer used.

{{< /note >}}

The identity setting is used for reporting purposes.

- When `true`, data for that property is returned as part of the resource data set and may be available to external applications, such as reporting
- When `false`, no data for that property is returned.

If no properties are marked `true`, the property that defaults to the `name` of the resource is marked `true`.

For example, the following properties define `username` and `password` properties with no default values specified, but with `identity` set to `true` for the user name:

```ruby
provides :user

property :username, String, identity: true
property :password, String
```

```ruby
user 'chef' do
  password '12345'
end
```

## run_context

Chef loads and tracks the current run in the run context object.

root

## property_is_set?

Use the `property_is_set?` method to check if the value for a property is set. The syntax is:

```ruby
property_is_set?(:property_name)
```

The `property_is_set?` method will return `true` if the property is set.

For example, the following custom resource creates and/or updates user
properties, but not their password. The `property_is_set?` method checks
if the user has specified a password and then tells Chef Infra Client
what to do if the password is not identical:

```ruby
action :create do
  converge_if_changed do
    shell_out!("rabbitmqctl create_or_update_user #{username} --prop1 #{prop1} ... ")
  end

  if property_is_set?(:password)
    if shell_out("rabbitmqctl authenticate_user #{username} #{password}").error?
      converge_by "Updating password for user #{username} ..." do
        shell_out!("rabbitmqctl update_user #{username} --password #{password}")
      end
    end
  end
end
```

## provides

### Introduced

Chef Infra Client <!-- TODO:  -->

Use the `provides` method to associate multiple custom resource files with the same resources name
For example:

```ruby
# Provide my_custom_resource to Redhat 7 and above
provides :my_custom_resource, platform: 'redhat' do |node|
  node['platform_version'].to_i >= 7
end

# Provide my_custom_resource to all Redhat platforms
provides :my_custom_resource, platform: 'redhat'

# Provide my_custom_resource to the RedHat platform family
provides :my_custom_resource, platform_family: 'rhel'

# Provide my_custom_resource to all linux machines
provides :my_custom_resource, os: 'linux'

# Provide my_custom_resource, useful if your resource file is not named the same as the resource you want to provide
provides :my_custom_resource
```

This allows you to use multiple custom resources files that provide the
same resource to the user, but for different operating systems or
operation system versions. With this you can eliminate the need for
platform or platform version logic within your resources.

### Presidence

Use the `provides` method to associate a custom resource with the Recipe
DSL on different operating systems. When multiple custom resources use
the same DSL, specificity rules are applied to determine the priority,
from highest to lowest:

1. provides :my_custom_resource, platform_version: '0.1.2'
2. provides :my_custom_resource, platform: 'platform_name'
3. provides :my_custom_resource, platform_family: 'platform_family'
4. provides :my_custom_resource, os: 'operating_system'
5. provides :my_custom_resource

## reset_property

Use the `reset_property` method to clear the value for a property as if
it had never been set, and then use the default value. For example, to
clear the value for a property named `password`:

```ruby
reset_property(:password)
```

## coerce

`coerce` is used to transform user input into a canonical form. The
value is passed in, and the transformed value returned as output. Lazy
values will **not** be passed to this method until after they are
evaluated.

`coerce` is run in the context of the instance, which gives it access to
other properties.

Here we transform,`true`/`false` in to `yes`, `no` for a template later on.

```ruby
property :browseable,
        [true, false, String],
        default: true,
        coerce: proc { |p| p ? 'yes' : 'no' },
```

If you are modifying the properties type, you will also need to accept that Ruby type as an input.

## resource_name

{{< note >}}

The `resource_name` setting is necessary for backwards compatibility with Chef Infra Client 12 through 15. It's use is no longer recommended, please use the [`provides`](#provides) method instead.

{{< /note >}}

Introduced: 12.5
Updated: 16.0

Use the `resource_name` method at the top of a custom resource to
declare a custom name for that resource. For example:

```ruby
resource_name :my_resource_name
```

The `resource_name` is only used as a fallback name for display purposes.

The `provides` statement is the prefered method of specificying the resources name.

In Chef Infra Client 16 and later, the first `provides` in a resource declaration also sets the fallback `resource_name`, so we do not recommend that users set the `resource_name` at all.

## deprecated

## Deprecating entire resources

Introduced in: Chef Infra Client 14.x <!-- TODO: >

Deprecate resources that you no longer wish to maintain.
This allows you make breaking changes to enterprise or community cookbooks with friendly notifications to downstream cookbook consumers directly in the Chef Infra Client run.

Deprecate the `foo_bar` resource in a cookbook

```ruby
deprecated 'The foo_bar resource has been deprecated and will be removed in the next major release of this cookbook scheduled for 25/01/2021!'

property :thing, String, name_property: true

action :create do
 # Chef resource code
end
```

## Deprecating a property

Deprecate the `badly_named` property in a resource:

```ruby
property :badly_named, String, deprecated: 'The badly_named property has been deprecated and will be removed in the next major release of this cookbook scheduled for 12/25/2021!'
```

## Deprecate and alias

Rename a property with a deprecation warning for users of the old property name:

```ruby
deprecated_property_alias 'badly_named', 'really_well_named', 'The badly_named property was renamed really_well_named in the 2.0 release of this cookbook. Please update your cookbooks to use the new property name.'
```

## unified_mode

<!-- TODO: partial for unified_mode -->
