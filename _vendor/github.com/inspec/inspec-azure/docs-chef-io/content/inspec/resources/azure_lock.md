+++
title = "azure_lock Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_lock"
identifier = "inspec/resources/azure/azure_lock Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_lock` InSpec audit resource to test the properties and configuration of a Management Lock.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

The Management Lock resources do not follow the common `resouce_group` and `name` patterns for identification. As a result, the `resource_id` must be given as a parameter to the `azure_lock` resource.

The [`azure_locks`]({{< relref "azure_locks.md" >}}) resource can be used for gathering the Management Lock resource IDs to be tested within the desired level, such as subscription, resource group, or individual resource.

```ruby
describe azure_lock(resource_id: '/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{parentResourcePath}/{resourceType}/{resourceName}/providers/Microsoft.Authorization/locks/{lockName}') do
  it { should exist }
end
```

## Parameters

`resource_id`
: The unique resource ID.

## Properties

`properties.level`
: The level of the lock. Possible values are: `NotSpecified`, `CanNotDelete`, and `ReadOnly`. For more see [here](https://docs.microsoft.com/en-us/rest/api/resources/managementlocks/getatresourcelevel#locklevel).

`properties.notes`
: Notes about the lock. Maximum of 512 characters.

`properties.owners`
: A list of the owners of the lock with [these](https://docs.microsoft.com/en-us/rest/api/resources/managementlocks/getatresourcelevel#managementlockowner) properties.

Please note that the properties can vary depending on the `api_version` used for the lookup.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/managementlocks/getatresourcelevel#managementlockobject) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a 'ReadOnly' Management Lock exists in a specific resource group

```ruby
azure_locks(resource_group: 'EXAMPLE-GROUP').ids.each do |id|
  describe azure_lock(resource_id: id) do
    its('properties.level') { should_not cmp `ReadOnly` }
  end
end
```

### Test if Management Locks on a specific resource contain a certain String

```ruby
azure_locks(resouce_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/{vmName}').ids.each do |lock_id|
  describe azure_lock(resource_id: lock_id) do
    it('properties.notes') { should include 'contact jdoe@chef.io' }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If we expect a resource to always exist.

describe azure_lock(resource_id: '/subscriptions/..{lockName}') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_lock(resource_id: '/subscriptions/..{lockName}') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
