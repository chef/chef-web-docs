+++
title = "azure_resource_health_emerging_issue Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_health_emerging_issue"
identifier = "inspec/resources/azure/azure_resource_health_emerging_issue Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_health_emerging_issue` InSpec audit resource to test properties related to a Azure Resource Health Emerging issue.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`name` is a required parameter.

```ruby
describe azure_resource_health_emerging_issue(name: 'EMERGING_ISSUE_NAME') do
  it                                      { should exist }
  its('properties.statusActiveEvents') { should be_empty }
end
```

```ruby
describe azure_resource_health_emerging_issue(name: 'EMERGING_ISSUE_NAME') do
  it  { should exist }
end
```

## Parameters

`name`
: Name of the Azure Resource Health emerging issue to test.


## Properties

`id`
: Fully qualified resource ID for the resource.

`name`
: The name of the resource.

`type`
: The type of the resource.

`properties.statusActiveEvents`
: The list of emerging issues of active event type.

`properties.statusBanners`
: The list of emerging issues of banner type.

`properties.refreshTimestamp`
: Timestamp for when last time refreshed for ongoing emerging issue.


For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resourcehealth/emerging-issues/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test that there are emerging issues with an active event type.**

```ruby
describe azure_resource_health_emerging_issue(name: 'default') do
  its('properties.statusActiveEvents') { should_not be_empty }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a emerging issue is found, it will exist
describe azure_resource_health_emerging_issue(name: 'default') do
  it { should exist }
end
# If no emerging issues are found, it will not exist
describe azure_resource_health_emerging_issue(name: 'default') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
