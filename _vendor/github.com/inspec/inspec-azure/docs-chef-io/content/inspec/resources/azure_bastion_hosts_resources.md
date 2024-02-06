+++
title = "azure_bastion_hosts_resources Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_bastion_hosts_resources"
identifier = "inspec/resources/azure/azure_bastion_hosts_resources Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_bastion_hosts_resources` InSpec audit resource to test the properties of Azure Bastion hosts for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_bastion_hosts_resource` resource block returns all Azure Bastion hosts within a resource group (if provided).

```ruby
describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  ..
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`name`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of Bastion hosts IDs.

: **Field**: `id`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`provisioning_states`
: State of Bastion hosts creation.

: **Field**: `provisioningState`

`types`
: Types of all the Bastion hosts.

: **Field**: `type`

`properties`
: Properties of all the Bastion hosts.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Test to ensure that the Bastion hosts resource is from the same type

```ruby
describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  its('type') { should eq 'Microsoft.Network/bastionHosts' }
end
```

### Test to ensure that the Bastion hosts resource is in a successful state

```ruby
describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  its('provisioning_states') { should include('Succeeded') }
end
```

### Test to ensure that the Bastion hosts resource is from the same location

```ruby
describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  its('location') { should include df_location }
end
```

### Test if any Bastion hosts exist in the resource group

```ruby
describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no Bastion hots are in the resource group.

describe azure_bastion_hosts_resources(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
