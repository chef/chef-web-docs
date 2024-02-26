+++
title = "azure_cdn_profile Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_cdn_profile"
identifier = "inspec/resources/azure/azure_cdn_profile Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_cdn_profile` Chef InSpec audit resource to test the properties and configuration of an Azure CDN profile.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

Either the `resource_group` and `name`, or the `resource_id` are required .

```ruby
describe azure_cdn_profile(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

```ruby
describe azure_cdn_profile(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

`name`
: The unique name of the CDN profile name.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}`.

Provide one of the following parameter sets for a valid query:

- `resource_id`
- `resource_group` and `name`

## Properties

`properties.frontDoorId`
: The ID of the frontdoor.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

See the [Azure CDN profile documentation](https://docs.microsoft.com/en-us/rest/api/cdn/profiles/get#profile) for other available properties.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Check the resource state of a CDN profile.**

```ruby
describe azure_cdn_profile(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  its('properties.resourceState') { should eq 'Active' }
end
```

**Check the resource state of all profiles in a subscription.**

```ruby
azure_cdn_profiles.ids.each do |id|
    describe azure_cdn_profile(resource_id: id) do
      its('properties.resourceState') { should eq 'Active' }
    end
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

Use `exist` if a resource should exist.

```ruby
describe azure_cdn_profile(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

Use `should_not` for a resource that should not exist.

```ruby
describe azure_cdn_profile(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
