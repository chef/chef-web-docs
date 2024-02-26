+++
title = "azure_container_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_container_groups"
identifier = "inspec/resources/azure/azure_container_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_container_groups` InSpec audit resource to test the properties related to all Azure container groups within a subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_container_groups` resource block returns all Azure container groups within a subscription.

```ruby
describe azure_container_groups do
  #...
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names for all the resources.

: **Field**: `name`

`types`
: A list of types for all the resources.

: **Field**: `type`

`locations`
: A list of the resource location for all the resources.

: **Field**: `location`

`tags`
: A list of tags for all the resources.

: **Field**: `tags`

`properties`
: A list of properties all the resources.

: **Field**: `properties`

`containers`
: A list of containers within the container group.

: **Field**: `containers`

`init_containers`
: A list of init containers for a container group.

: **Field**: `init_containers`

`image_registry_credentials`
: A list of image registry credentials through which the container group is created.

: **Field**: `image_registry_credentials`

`ip_address`
: A list of IP address type of the container group.

: **Field**: `ip_address`

`os_types`
: A list of operating system types required by the containers in the container group.

: **Field**: `os_type`

`provisioning_states`
: A list of provisioning states of the container group.

: **Field**: `provisioning_state`

`volumes`
: A list of volumes that can be mounted by containers in this container group.

: **Field**: `volumes`

`skus`
: A list SKUs for a container group.

: **Field**: `sku`

`restart_policies`
: A list of restart policies for all containers within the container group.

: **Field**: `restart_policy`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test to loop through container groups by their names

```ruby
azure_container_groups.names.each do |name|
  describe azure_container_group(resource_group: 'RESOURCE_GROUP_NAME', name: 'CONTAINER_GROUP_NAME') do
    it { should exist }
  end
end
```

### Test to ensure there are container groups with valid name

```ruby
describe azure_container_groups.where(name: 'CONTAINER_GROUP_NAME') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no container groups are present in the subscription.

describe azure_container_groups do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one container group in the subscription.

describe azure_container_groups do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
