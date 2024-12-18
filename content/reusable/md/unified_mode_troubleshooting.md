
## Troubleshooting Unified Mode

Unified mode changes the execution of a custom resource to run in one phase, in the order that the code is written, from the first line of the code to the last. Custom resources designed to use two phases may need modification. These fall into three general types:

- Resources with changes to internal sub-resources
- Resources with actions on later resources
- Resources that rely on the out-of-order execution

When designing a custom resource for unified mode:

- Declare a resource first and then declare actions on it
- Write resources in run-time order

### Resources with changes to internal sub-resources

Some custom resources are designed to create and edit other sub-resources as part of the resource declaration. In unified mode, Chef Infra Client parses a resource code block that creates or edits a sub-resource and immediately tries to apply that change, even though the sub-resource doesn't yet exist. This results in the execution of an incomplete resource.

For example, with Unified Mode enabled, this code from the dhcp cookbook is designed to create and edit a shared `dhcp_subnet` resource, but it won't work as expected:

```ruby
# 'edit_resource' results in an incomplete subresource
sr = edit_resource(:dhcp_subnet, "#{new_resource.name}_sharedsubnet_#{subnet}") do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true
end

properties.each do |property, value|
  sr.send(property, value)
end
```

To correct custom resources that change sub-resources during their declaration, you can:

- Apply properties in the code block (preferred)
- Run the resource explicitly (not preferred)

#### Apply properties in the code block

This pattern declares the sub-resource in one code block and then changes it in the next code block. This is the preferred pattern in Unified Mode because all resources execute in order at compile time.

```ruby
dhcp_subnet "#{new_resource.name}_sharedsubnet_#{subnet}" do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true

  properties.each do |property, value|
    send(property, value)
  end
end
```

#### Run the resource explicitly

Another solution is to continue saving the resource as a variable, declare `action :nothing` within the codeblock, and then explicitly run the action in another code block.

The pattern of saving a resource as a variable and then forcing it to run at compile time with an explicit `run_action` works as it has in the past, but it's not a preferred pattern. Unified mode forces resource execution to compile time by default, which makes this pattern redundant.

```ruby
sr = edit_resource(:dhcp_subnet, "#{new_resource.name}_sharedsubnet_#{subnet}") do
  owner new_resource.owner
  group new_resource.group
  mode new_resource.mode

  ip_version new_resource.ip_version
  conf_dir new_resource.conf_dir
  shared_network true

  action :nothing
end

properties.each do |property, value|
  sr.send(property, value)
end

# Run the action explicitly
sr.run_action(:create)
```
